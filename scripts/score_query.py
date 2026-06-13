"""
score_query.py

Scores a SQL query against historical patterns from parsed_query_logs.db
and the narrative in reports/query_analysis.md.

Two score families:
  Probability-based (pure statistics, no API call):
    - table_familiarity   : are the tables known from logs?
    - column_coverage     : are selected/filtered columns historically used?
    - join_pattern        : are the table-pair joins seen before?
    - join_key_validity   : are ON-clause columns historical join keys?
    - filter_familiarity  : are WHERE columns historically filtered?
    - filter_operator     : are operators consistent with historical usage?
    - aggregation_pattern : are agg(col) combinations seen before?
    - overall_probability : weighted composite

  LLM-based (OpenAI):
    - Per-dimension 0-100 subscores with reasoning
    - Overall 0-100 with narrative diagnosis

Usage:
    uv run python scripts/score_query.py "SELECT investor_id FROM ATOM_ENTITY_INVESTOR_PROFILE_001"
    uv run python scripts/score_query.py --file my_query.sql
    uv run python scripts/score_query.py --no-llm "SELECT ..."
"""

from __future__ import annotations

import argparse
import json
import re
import sqlite3
import sys
from collections import Counter, defaultdict
from dataclasses import dataclass, field
from pathlib import Path

from dotenv import load_dotenv

load_dotenv()

DB_PATH = Path("raw_data/parsed_query_logs.db")
ANALYSIS_MD = Path("reports/query_analysis.md")

# Consolidated score weights
CONSOLIDATED_W_PROB = 0.60
CONSOLIDATED_W_NEAR = 0.40

# ---------------------------------------------------------------------------
# Regex (mirrors analyze_query_logs_llm.py)
# ---------------------------------------------------------------------------

TABLE_RE     = re.compile(r"\b(?:FROM|JOIN)\s+([A-Z_][A-Z0-9_]*)", re.IGNORECASE)
ALIAS_RE     = re.compile(r"\b(?:FROM|JOIN)\s+([A-Z_][A-Z0-9_]*)\s+(?:AS\s+)?([A-Za-z_]\w*)\b", re.IGNORECASE)
ALIASED_COL  = re.compile(r"\b([A-Za-z_]\w*)\.([A-Za-z_]\w*)\b")
AGG_COL_RE   = re.compile(r"\b(COUNT|SUM|AVG|MIN|MAX)\s*\(\s*(?:DISTINCT\s+)?([^)]+?)\s*\)", re.IGNORECASE)
SUBQUERY_RE  = re.compile(r"\(SELECT\b.+?\)", re.IGNORECASE | re.DOTALL)

CLAUSE_RE = {
    "select":  re.compile(r"\bSELECT\b(.*?)\bFROM\b",                                             re.I | re.S),
    "where":   re.compile(r"\bWHERE\b(.*?)(?=\b(?:GROUP|ORDER|HAVING|LIMIT|UNION)\b|;|$)",        re.I | re.S),
    "groupby": re.compile(r"\bGROUP\s+BY\b(.*?)(?=\b(?:ORDER|HAVING|LIMIT|UNION)\b|;|$)",         re.I | re.S),
    "on":      re.compile(r"\bON\b\s*(.+?)(?=\b(?:WHERE|JOIN|LEFT|RIGHT|INNER|FULL|GROUP|ORDER|HAVING|LIMIT)\b|;|$)", re.I | re.S),
}

FILTER_RE = re.compile(
    r"\b([A-Za-z_]\w*)\s*(=|!=|<>|>=|<=|>|<|LIKE|NOT\s+LIKE|IN|NOT\s+IN|IS\s+NOT|IS|BETWEEN)\s*",
    re.IGNORECASE,
)

SKIP = {"AND","OR","NOT","ON","AS","NULL","TRUE","FALSE","SUBQ","SELECT",
        "FROM","WHERE","JOIN","BY","THEN","ELSE","WHEN","CASE","END"}
AGG_NAMES = {"SUM","COUNT","AVG","MIN","MAX","STDDEV","COALESCE","NULLIF",
             "ROUND","ABS","JULIANDAY","NOW","DATE","LOWER","UPPER","CAST"}

# ---------------------------------------------------------------------------
# SQL parsing helpers
# ---------------------------------------------------------------------------

def _clause(sql: str, key: str) -> str:
    cleaned = SUBQUERY_RE.sub("(SUBQ)", sql)
    m = CLAUSE_RE[key].search(cleaned)
    return m.group(1).strip() if m else ""

def _tokens(text: str, exclude_agg: bool = False) -> list[str]:
    toks = re.findall(r"\b([A-Za-z_][A-Za-z0-9_]*)\b", text)
    result = [t.upper() for t in toks if t.upper() not in SKIP]
    if exclude_agg:
        result = [t for t in result if t not in AGG_NAMES]
    return result

def _table_aliases(sql: str) -> dict[str, str]:
    out: dict[str, str] = {}
    for table, alias in ALIAS_RE.findall(sql):
        a = alias.upper()
        if a not in {"ON","WHERE","JOIN","LEFT","RIGHT","INNER","OUTER","FULL","AS","SET"}:
            out[a] = table.upper()
    return out

def _aliased_cols(sql: str, aliases: dict[str, str]) -> dict[str, list[str]]:
    out: dict[str, list[str]] = defaultdict(list)
    for alias, col in ALIASED_COL.findall(sql):
        tbl = aliases.get(alias.upper())
        if tbl:
            out[tbl].append(col.upper())
    return dict(out)


@dataclass
class QueryInfo:
    tables:      list[str]
    aliases:     dict[str, str]          # alias -> table
    select_cols: dict[str, list[str]]    # table -> [col]
    where_cols:  dict[str, list[str]]    # table -> [col]
    where_ops:   list[tuple[str, str]]   # [(col, op)]
    agg_pairs:   list[tuple[str, str]]   # [(fn, col)]
    join_pairs:  list[tuple[str, str]]   # [(tableA, tableB)] ordered
    join_keys:   dict[str, list[str]]    # table -> [col]
    groupby_cols: list[str]


def parse_query(sql: str) -> QueryInfo:
    tables_raw = list(dict.fromkeys(t.upper() for t in TABLE_RE.findall(sql)))
    aliases    = _table_aliases(sql)
    rev_al     = {v: k for k, v in aliases.items()}
    al_cols    = _aliased_cols(sql, aliases)
    is_multi   = len(tables_raw) > 1

    def owns(col: str, table: str) -> bool:
        if col in al_cols.get(table, []):
            return True
        if not is_multi and col not in SKIP and col not in AGG_NAMES:
            return True
        return False

    select_cols: dict[str, list[str]] = defaultdict(list)
    where_cols:  dict[str, list[str]] = defaultdict(list)

    sel_text = _clause(sql, "select")
    whr_text = _clause(sql, "where")
    on_text  = _clause(sql, "on")
    gb_text  = _clause(sql, "groupby")

    for tbl in tables_raw:
        for tok in _tokens(sel_text, exclude_agg=True):
            if owns(tok, tbl):
                select_cols[tbl].append(tok)
        for tok in _tokens(whr_text, exclude_agg=True):
            if owns(tok, tbl):
                where_cols[tbl].append(tok)

    where_ops = [
        (col.upper(), re.sub(r"\s+", " ", op).upper())
        for col, op in FILTER_RE.findall(whr_text)
        if col.upper() not in SKIP
    ]

    agg_pairs = [(fn.upper(), col.strip().upper()) for fn, col in AGG_COL_RE.findall(sql)]

    join_keys: dict[str, list[str]] = defaultdict(list)
    for tbl in tables_raw:
        for tok in _tokens(on_text, exclude_agg=True):
            if owns(tok, tbl):
                join_keys[tbl].append(tok)

    join_pairs: list[tuple[str, str]] = []
    if is_multi:
        for i, a in enumerate(tables_raw):
            for b in tables_raw[i+1:]:
                join_pairs.append((a, b))

    groupby = [t for t in _tokens(gb_text, exclude_agg=True)]

    return QueryInfo(
        tables=tables_raw,
        aliases=aliases,
        select_cols=dict(select_cols),
        where_cols=dict(where_cols),
        where_ops=where_ops,
        agg_pairs=agg_pairs,
        join_pairs=join_pairs,
        join_keys=dict(join_keys),
        groupby_cols=groupby,
    )


# ---------------------------------------------------------------------------
# Load reference stats
# ---------------------------------------------------------------------------

def load_stats(db_path: Path) -> dict:
    """Re-compute per-table stats from the log DB."""
    # Inline the extraction to keep this script self-contained
    con = sqlite3.connect(str(db_path))
    queries = [r[0] for r in con.execute("SELECT sql_query FROM query_logs")]
    con.close()

    stats: dict = defaultdict(lambda: {
        "query_count": 0,
        "select_cols": Counter(),
        "where_cols": Counter(),
        "where_ops": Counter(),
        "where_col_ops": defaultdict(Counter),  # col -> {op: count}
        "agg_fns": Counter(),
        "agg_on_col": defaultdict(Counter),
        "groupby_cols": Counter(),
        "join_keys": Counter(),
        "join_partners": Counter(),
    })

    tbl_re  = re.compile(r"\b(?:FROM|JOIN)\s+([A-Z_][A-Z0-9_]*)", re.IGNORECASE)
    al_re   = re.compile(r"\b(?:FROM|JOIN)\s+([A-Z_][A-Z0-9_]*)\s+(?:AS\s+)?([A-Za-z_]\w*)\b", re.IGNORECASE)
    alc_re  = re.compile(r"\b([A-Za-z_]\w*)\.([A-Za-z_]\w*)\b")
    agg_re  = re.compile(r"\b(COUNT|SUM|AVG|MIN|MAX)\s*\(\s*(?:DISTINCT\s+)?([^)]+?)\s*\)", re.IGNORECASE)
    sub_re  = re.compile(r"\(SELECT\b.+?\)", re.I | re.S)
    flt_re  = re.compile(r"\b([A-Za-z_]\w*)\s*(=|!=|<>|>=|<=|>|<|LIKE|NOT\s+LIKE|IN|NOT\s+IN|IS\s+NOT|IS|BETWEEN)\s*", re.IGNORECASE)

    cl = {
        "select":  re.compile(r"\bSELECT\b(.*?)\bFROM\b", re.I | re.S),
        "where":   re.compile(r"\bWHERE\b(.*?)(?=\b(?:GROUP|ORDER|HAVING|LIMIT|UNION)\b|;|$)", re.I | re.S),
        "groupby": re.compile(r"\bGROUP\s+BY\b(.*?)(?=\b(?:ORDER|HAVING|LIMIT|UNION)\b|;|$)", re.I | re.S),
        "on":      re.compile(r"\bON\b\s*(.+?)(?=\b(?:WHERE|JOIN|LEFT|RIGHT|INNER|FULL|GROUP|ORDER|HAVING|LIMIT)\b|;|$)", re.I | re.S),
    }

    def get_clause(s, key):
        c = sub_re.sub("(SUBQ)", s)
        m = cl[key].search(c)
        return m.group(1).strip() if m else ""

    def toks(text, no_agg=False):
        ts = [t.upper() for t in re.findall(r"\b([A-Za-z_][A-Za-z0-9_]*)\b", text) if t.upper() not in SKIP]
        return [t for t in ts if not (no_agg and t in AGG_NAMES)]

    for sql in queries:
        tbls = list(dict.fromkeys(t.upper() for t in tbl_re.findall(sql)))
        if not tbls:
            continue
        al = {a.upper(): t.upper() for t, a in al_re.findall(sql)
              if a.upper() not in {"ON","WHERE","JOIN","LEFT","RIGHT","INNER","OUTER","FULL","AS","SET"}}
        alcols: dict[str, list[str]] = defaultdict(list)
        for a, c in alc_re.findall(sql):
            tbl = al.get(a.upper())
            if tbl:
                alcols[tbl].append(c.upper())
        multi = len(tbls) > 1

        sel_t = get_clause(sql, "select")
        whr_t = get_clause(sql, "where")
        on_t  = get_clause(sql, "on")
        gb_t  = get_clause(sql, "groupby")

        for tbl in tbls:
            s = stats[tbl]
            s["query_count"] += 1
            if multi:
                for other in tbls:
                    if other != tbl:
                        s["join_partners"][other] += 1

            def owns_h(col):
                if col in alcols.get(tbl, []):
                    return True
                return not multi and col not in SKIP and col not in AGG_NAMES

            for t in toks(sel_t, no_agg=True):
                if owns_h(t):
                    s["select_cols"][t] += 1
            for t in toks(whr_t, no_agg=True):
                if owns_h(t):
                    s["where_cols"][t] += 1
            for t in toks(on_t, no_agg=True):
                if owns_h(t):
                    s["join_keys"][t] += 1
            for t in toks(gb_t, no_agg=True):
                if owns_h(t):
                    s["groupby_cols"][t] += 1

            for col, op in flt_re.findall(whr_t):
                col = col.upper(); op = re.sub(r"\s+", " ", op).upper()
                if col not in SKIP and owns_h(col):
                    s["where_ops"][op] += 1
                    s["where_col_ops"][col][op] += 1

            for fn, col in agg_re.findall(sql):
                fn = fn.upper(); col = col.strip().upper()
                for ct in [c.upper() for c in re.findall(r"\b([A-Za-z_]\w*)\b", col)]:
                    if ct not in SKIP and (owns_h(ct) or ct == "*"):
                        s["agg_fns"][fn] += 1
                        s["agg_on_col"][fn][ct if ct != "*" else "(*)"] += 1

    return dict(stats)


def load_table_sections(md_path: Path) -> dict[str, str]:
    """Return {TABLE_NAME: markdown_section_text} from query_analysis.md."""
    if not md_path.exists():
        return {}
    text = md_path.read_text(encoding="utf-8")
    sections: dict[str, str] = {}
    # Match top-level ## TABLE_NAME headings
    parts = re.split(r"\n## ([A-Z_][A-Z0-9_]*)\n", text)
    for i in range(1, len(parts), 2):
        table = parts[i].strip()
        body  = parts[i+1].strip() if i+1 < len(parts) else ""
        sections[table] = body
    return sections


# ---------------------------------------------------------------------------
# Probability scoring
# ---------------------------------------------------------------------------

@dataclass
class DimScore:
    score: float | None
    label: str
    detail: list[str] = field(default_factory=list)

    def bar(self) -> str:
        if self.score is None:
            return "──────────"
        filled = round(self.score * 10)
        return "█" * filled + "░" * (10 - filled)


@dataclass
class ProbabilityReport:
    table_familiarity:   DimScore
    column_coverage:     DimScore
    join_pattern:        DimScore
    join_key_validity:   DimScore
    filter_familiarity:  DimScore
    filter_operator:     DimScore
    aggregation_pattern: DimScore
    overall:             float

    WEIGHTS = {
        "table_familiarity":   0.20,
        "column_coverage":     0.20,
        "join_pattern":        0.20,
        "join_key_validity":   0.10,
        "filter_familiarity":  0.15,
        "filter_operator":     0.05,
        "aggregation_pattern": 0.10,
    }

    def dims(self) -> list[tuple[str, DimScore]]:
        return [
            ("table_familiarity",   self.table_familiarity),
            ("column_coverage",     self.column_coverage),
            ("join_pattern",        self.join_pattern),
            ("join_key_validity",   self.join_key_validity),
            ("filter_familiarity",  self.filter_familiarity),
            ("filter_operator",     self.filter_operator),
            ("aggregation_pattern", self.aggregation_pattern),
        ]


def _rel_score(count: int, counter: Counter) -> float:
    """Score relative to the max observed frequency (0.0 if unseen)."""
    if not counter:
        return 0.0
    return min(count / max(counter.values()), 1.0) if count > 0 else 0.0


def score_probability(info: QueryInfo, stats: dict) -> ProbabilityReport:

    # 1. Table familiarity
    known = [t for t in info.tables if t in stats]
    unknown = [t for t in info.tables if t not in stats]
    tf_score = len(known) / len(info.tables) if info.tables else 1.0
    tf = DimScore(tf_score, "Table Familiarity",
                  [f"✓ {t}" for t in known] + [f"✗ UNKNOWN: {t}" for t in unknown])

    # 2. Column coverage — across select + where columns
    col_scores: list[float] = []
    col_details: list[str] = []
    for tbl in info.tables:
        if tbl not in stats:
            continue
        s = stats[tbl]
        all_ref = list(dict.fromkeys(
            info.select_cols.get(tbl, []) + info.where_cols.get(tbl, [])
        ))
        for col in all_ref:
            cnt_sel = s["select_cols"].get(col, 0)
            cnt_whr = s["where_cols"].get(col, 0)
            cnt = max(cnt_sel, cnt_whr)
            combined = Counter({**s["select_cols"], **s["where_cols"]})
            sc = _rel_score(cnt, combined)
            col_scores.append(sc)
            status = "✓" if cnt > 0 else "✗ (unseen)"
            col_details.append(f"{tbl}.{col}: {sc:.2f} {status} (seen {cnt}x)")

    cc_score = sum(col_scores) / len(col_scores) if col_scores else None
    cc = DimScore(cc_score, "Column Coverage", col_details[:12])

    # 3. Join pattern
    if not info.join_pairs:
        jp_score = None
        jp = DimScore(jp_score, "Join Pattern", ["No joins in query — N/A"])
    else:
        jp_scores: list[float] = []
        jp_details: list[str] = []
        for a, b in info.join_pairs:
            freq_a = stats.get(a, {}).get("join_partners", Counter()).get(b, 0)
            freq_b = stats.get(b, {}).get("join_partners", Counter()).get(a, 0)
            freq = max(freq_a, freq_b)
            max_freq = max(
                (max(stats[a]["join_partners"].values()) if a in stats and stats[a]["join_partners"] else 0),
                (max(stats[b]["join_partners"].values()) if b in stats and stats[b]["join_partners"] else 0),
                1,
            )
            sc = min(freq / max_freq, 1.0)
            jp_scores.append(sc)
            status = f"seen {freq}x" if freq > 0 else "NEVER SEEN — high risk"
            jp_details.append(f"{a} + {b}: {sc:.2f} ({status})")
        jp_score = sum(jp_scores) / len(jp_scores)
        jp = DimScore(jp_score, "Join Pattern", jp_details)

    # 4. Join key validity
    jk_scores: list[float] = []
    jk_details: list[str] = []
    for tbl, cols in info.join_keys.items():
        if tbl not in stats:
            continue
        jk_counter = stats[tbl]["join_keys"]
        for col in cols:
            cnt = jk_counter.get(col, 0)
            sc = _rel_score(cnt, jk_counter)
            jk_scores.append(sc)
            status = f"used as join key {cnt}x" if cnt > 0 else "never used as join key"
            jk_details.append(f"{tbl}.{col}: {sc:.2f} ({status})")

    jkv_score = sum(jk_scores) / len(jk_scores) if jk_scores else None
    jkv = DimScore(jkv_score, "Join Key Validity", jk_details)

    # 5. Filter column familiarity
    ff_scores: list[float] = []
    ff_details: list[str] = []
    for tbl in info.tables:
        if tbl not in stats:
            continue
        wc = stats[tbl]["where_cols"]
        for col in info.where_cols.get(tbl, []):
            cnt = wc.get(col, 0)
            sc = _rel_score(cnt, wc)
            ff_scores.append(sc)
            status = f"filtered {cnt}x historically" if cnt > 0 else "never filtered on — unusual"
            ff_details.append(f"{tbl}.{col}: {sc:.2f} ({status})")

    ff_score = sum(ff_scores) / len(ff_scores) if ff_scores else None
    ff = DimScore(ff_score, "Filter Familiarity", ff_details)

    # 6. Filter operator conformance
    fo_scores: list[float] = []
    fo_details: list[str] = []
    for tbl in info.tables:
        if tbl not in stats:
            continue
        col_ops = stats[tbl].get("where_col_ops", {})
        for col, op in info.where_ops:
            if col not in stats[tbl]["where_cols"]:
                continue  # handled by filter_familiarity
            op_counter = col_ops.get(col, Counter())
            cnt = op_counter.get(op, 0)
            sc = _rel_score(cnt, op_counter) if op_counter else 0.5
            fo_scores.append(sc)
            status = f"{cnt}x for {col}" if cnt > 0 else f"op '{op}' not typical for {col}"
            fo_details.append(f"{col} {op}: {sc:.2f} ({status})")

    fo_score = sum(fo_scores) / len(fo_scores) if fo_scores else None
    fo = DimScore(fo_score, "Filter Operator", fo_details)

    # 7. Aggregation pattern
    ap_scores: list[float] = []
    ap_details: list[str] = []
    for fn, raw_col in info.agg_pairs:
        col_toks = [t.upper() for t in re.findall(r"\b([A-Za-z_]\w*)\b", raw_col)
                    if t.upper() not in SKIP and t.upper() not in AGG_NAMES]
        for col in (col_toks or ["(*)"]):
            found = False
            for tbl in info.tables:
                if tbl not in stats:
                    continue
                cnt = stats[tbl]["agg_on_col"].get(fn, Counter()).get(col, 0)
                if cnt > 0:
                    max_c = max(stats[tbl]["agg_on_col"][fn].values())
                    sc = min(cnt / max_c, 1.0)
                    ap_scores.append(sc)
                    ap_details.append(f"{fn}({col}): {sc:.2f} (seen {cnt}x on {tbl})")
                    found = True
                    break
            if not found:
                ap_scores.append(0.0)
                ap_details.append(f"{fn}({col}): 0.00 — combination not seen historically")

    ap_score = sum(ap_scores) / len(ap_scores) if ap_scores else None
    ap = DimScore(ap_score, "Aggregation Pattern", ap_details)

    # Overall weighted score — only include dimensions that had data to evaluate.
    # Dimensions with nothing to check (no joins, no aggs, etc.) score as None
    # and are excluded here; weights are re-normalized over applicable dims only.
    w = ProbabilityReport.WEIGHTS
    applicable = {
        "table_familiarity":   True,
        "column_coverage":     bool(col_scores),
        "join_pattern":        bool(info.join_pairs),
        "join_key_validity":   bool(jk_scores),
        "filter_familiarity":  bool(ff_scores),
        "filter_operator":     bool(fo_scores),
        "aggregation_pattern": bool(ap_scores),
    }
    dim_scores = {
        "table_familiarity":   tf_score,
        "column_coverage":     cc_score,
        "join_pattern":        jp_score,
        "join_key_validity":   jkv_score,
        "filter_familiarity":  ff_score,
        "filter_operator":     fo_score,
        "aggregation_pattern": ap_score,
    }
    total_weight = sum(w[k] for k, app in applicable.items() if app)
    overall = (
        sum(dim_scores[k] * w[k] for k, app in applicable.items() if app) / total_weight
        if total_weight else 1.0
    )

    return ProbabilityReport(tf, cc, jp, jkv, ff, fo, ap, overall)


# ---------------------------------------------------------------------------
# LLM scoring
# ---------------------------------------------------------------------------

@dataclass
class LLMReport:
    subscores: dict[str, int]
    overall:   int
    reasoning: str
    flags:     list[str]


def score_llm(sql: str, info: QueryInfo, table_sections: dict, stats: dict) -> LLMReport:
    from openai import OpenAI
    client = OpenAI()

    # Build compact per-table context for tables in this query
    ctx_parts: list[str] = []
    for tbl in info.tables:
        section = table_sections.get(tbl)
        if section:
            # Use the markdown analysis section (truncated)
            ctx_parts.append(f"### {tbl} (from query_analysis.md)\n{section[:1500]}")
        elif tbl in stats:
            s = stats[tbl]
            ctx_parts.append(
                f"### {tbl} (raw stats)\n"
                f"Queries: {s['query_count']}\n"
                f"Top SELECT cols: {dict(s['select_cols'].most_common(8))}\n"
                f"Top WHERE cols: {dict(s['where_cols'].most_common(8))}\n"
                f"Join partners: {dict(s['join_partners'].most_common(5))}\n"
                f"Top join keys: {dict(s['join_keys'].most_common(5))}\n"
                f"Agg functions: {dict(s['agg_fns'].most_common(5))}\n"
            )
        else:
            ctx_parts.append(f"### {tbl}\n⚠️  Not found in historical query logs.")

    context = "\n\n".join(ctx_parts)

    prompt = f"""You are a SQL quality analyst. You have access to historical query pattern analysis
for a wealth management platform and must score whether a new SQL query follows established patterns.

## Historical Pattern Context
{context}

## Query to Score
```sql
{sql}
```

## Tables used: {info.tables}
## Join pairs: {info.join_pairs}
## WHERE columns: {dict(info.where_cols)}
## Aggregations: {info.agg_pairs}

Score this query on the following dimensions (0–100 each, where 100 = perfectly follows historical patterns):

1. **table_familiarity**: Are the tables used known from historical logs?
2. **column_relevance**: Are the SELECT and WHERE columns the historically important ones for these tables?
3. **join_conformance**: Do the join pairs and join keys match historical patterns?
4. **filter_conformance**: Are the WHERE conditions (columns + operators + values) consistent with history?
5. **aggregation_conformance**: Are the aggregation functions applied to the right columns?
6. **overall**: Holistic score considering all dimensions.

Return ONLY a JSON object in this exact format:
{{
  "subscores": {{
    "table_familiarity": <0-100>,
    "column_relevance": <0-100>,
    "join_conformance": <0-100>,
    "filter_conformance": <0-100>,
    "aggregation_conformance": <0-100>
  }},
  "overall": <0-100>,
  "flags": ["<specific issue 1>", "<specific issue 2>", ...],
  "reasoning": "<2-4 sentence narrative explaining the score, citing specific columns/tables/joins>"
}}"""

    resp = client.chat.completions.create(
        model="gpt-4o",
        messages=[{"role": "user", "content": prompt}],
        temperature=0,
        response_format={"type": "json_object"},
    )

    data = json.loads(resp.choices[0].message.content)
    return LLMReport(
        subscores=data.get("subscores", {}),
        overall=data.get("overall", 0),
        reasoning=data.get("reasoning", ""),
        flags=data.get("flags", []),
    )


# ---------------------------------------------------------------------------
# Near-match scoring  (pure Python, no API call)
# ---------------------------------------------------------------------------

@dataclass
class MatchHit:
    query_num:    int
    query_id:     int
    title:        str
    start_time:   str
    sql:          str
    struct_score: float   # structural Jaccard
    token_score:  float   # token Jaccard on normalised SQL
    combined:     float   # weighted combination


@dataclass
class NearMatchReport:
    top_hits:      list[MatchHit]
    best_score:    float
    mean_top5:     float


def _normalize_sql(sql: str) -> str:
    """Strip literals so INV-001 and INV-002 look the same structurally."""
    s = re.sub(r"'[^']*'", "_STR_", sql)          # string literals
    s = re.sub(r"\bINV-\d+\b", "_INVESTOR_", s)   # investor IDs
    s = re.sub(r"\b\d{4}-\d{2}-\d{2}\b", "_DATE_", s)  # date literals
    s = re.sub(r"\b\d+(\.\d+)?\b", "_NUM_", s)    # numeric literals
    return s.upper()


def _sql_token_set(sql: str) -> frozenset[str]:
    """Bag-of-words token set from normalised SQL (excludes punctuation)."""
    norm = _normalize_sql(sql)
    tokens = re.findall(r"\b([A-Z_][A-Z0-9_]{1,})\b", norm)
    # Drop very short noise tokens
    return frozenset(t for t in tokens if len(t) > 1)


def _structural_features(info: QueryInfo) -> dict[str, frozenset]:
    """Extract feature sets used for structural Jaccard comparison."""
    tables = frozenset(info.tables)

    sel_cols = frozenset(
        f"{tbl}.{col}"
        for tbl, cols in info.select_cols.items()
        for col in cols
    )
    whr_cols = frozenset(
        f"{tbl}.{col}"
        for tbl, cols in info.where_cols.items()
        for col in cols
    )
    join_pairs = frozenset(frozenset(p) for p in info.join_pairs)
    agg_pairs  = frozenset(f"{fn}:{col}" for fn, col in info.agg_pairs)
    clauses    = frozenset(filter(None, [
        "HAS_JOIN"    if info.join_pairs  else "",
        "HAS_WHERE"   if info.where_cols  else "",
        "HAS_GROUPBY" if info.groupby_cols else "",
        "HAS_AGG"     if info.agg_pairs   else "",
    ]))

    return {
        "tables":     tables,
        "sel_cols":   sel_cols,
        "whr_cols":   whr_cols,
        "join_pairs": join_pairs,
        "agg_pairs":  agg_pairs,
        "clauses":    clauses,
    }


def _jaccard(a: frozenset, b: frozenset) -> float:
    if not a and not b:
        return 1.0
    union = a | b
    return len(a & b) / len(union) if union else 1.0


# Weights for the structural Jaccard sub-dimensions
_STRUCT_WEIGHTS = {
    "tables":     0.35,
    "sel_cols":   0.20,
    "whr_cols":   0.20,
    "join_pairs": 0.15,
    "agg_pairs":  0.07,
    "clauses":    0.03,
}


def _struct_similarity(fa: dict, fb: dict) -> float:
    return sum(
        _STRUCT_WEIGHTS[k] * _jaccard(fa[k], fb[k])
        for k in _STRUCT_WEIGHTS
    )


def load_corpus(db_path: Path) -> list[dict]:
    """Load all historical queries with pre-computed features."""
    con = sqlite3.connect(str(db_path))
    rows = con.execute(
        "SELECT query_num, query_id, title, start_time, sql_query FROM query_logs ORDER BY query_num"
    ).fetchall()
    con.close()

    corpus: list[dict] = []
    for query_num, query_id, title, start_time, sql in rows:
        info = parse_query(sql)
        corpus.append({
            "query_num":  query_num,
            "query_id":   query_id,
            "title":      title or "",
            "start_time": start_time or "",
            "sql":        sql,
            "features":   _structural_features(info),
            "token_set":  _sql_token_set(sql),
        })
    return corpus


def score_near_match(
    sql: str,
    info: QueryInfo,
    corpus: list[dict],
    top_n: int = 5,
) -> NearMatchReport:
    input_features  = _structural_features(info)
    input_token_set = _sql_token_set(sql)

    hits: list[MatchHit] = []
    for entry in corpus:
        struct_sc = _struct_similarity(input_features, entry["features"])
        token_sc  = _jaccard(input_token_set, entry["token_set"])
        combined  = 0.65 * struct_sc + 0.35 * token_sc
        hits.append(MatchHit(
            query_num=entry["query_num"],
            query_id=entry["query_id"],
            title=entry["title"],
            start_time=entry["start_time"],
            sql=entry["sql"],
            struct_score=struct_sc,
            token_score=token_sc,
            combined=combined,
        ))

    hits.sort(key=lambda h: h.combined, reverse=True)
    top = hits[:top_n]
    best = top[0].combined if top else 0.0
    mean5 = sum(h.combined for h in top) / len(top) if top else 0.0

    return NearMatchReport(top_hits=top, best_score=best, mean_top5=mean5)


# ---------------------------------------------------------------------------
# Report rendering
# ---------------------------------------------------------------------------

def render(sql: str, prob: ProbabilityReport, llm: LLMReport | None,
           nm: NearMatchReport | None = None,
           consolidated: float | None = None) -> str:
    lines: list[str] = []
    SEP = "=" * 66

    lines.append(SEP)
    lines.append("  SQL QUERY CONFIDENCE SCORER")
    lines.append(SEP)
    lines.append("\nInput Query:")
    for line in sql.strip().splitlines():
        lines.append(f"  {line}")

    lines.append(f"\n{'─'*66}")
    lines.append("  PROBABILITY-BASED SCORES  (statistical, no LLM)")
    lines.append(f"{'─'*66}")
    lines.append(f"  {'Dimension':<26} {'Score':>6}  {'Bar':<12}  Notes")
    lines.append(f"  {'─'*62}")

    for name, dim in prob.dims():
        pct = f"{dim.score:.2f}" if dim.score is not None else "  N/A"
        lines.append(f"  {dim.label:<26} {pct:>6}  {dim.bar():<12}")
        for detail in dim.detail[:5]:
            lines.append(f"         {detail}")

    lines.append(f"\n  {'Overall Probability Score':<26} {prob.overall:.2f}  {DimScore(prob.overall,'').bar()}")

    if llm:
        lines.append(f"\n{'─'*66}")
        lines.append("  LLM-BASED SCORE  (OpenAI gpt-4o)")
        lines.append(f"{'─'*66}")
        lines.append(f"  {'Dimension':<30} {'Score':>6}")
        lines.append(f"  {'─'*38}")
        for dim, sc in llm.subscores.items():
            bar = "█" * (sc // 10) + "░" * (10 - sc // 10)
            lines.append(f"  {dim:<30} {sc:>5}/100  {bar}")
        lines.append(f"\n  Overall LLM Score:  {llm.overall}/100")

        if llm.flags:
            lines.append("\n  Flags:")
            for f in llm.flags:
                lines.append(f"    ⚑  {f}")

        lines.append(f"\n  Reasoning:\n  {llm.reasoning}")

    if nm:
        lines.append(f"\n{'─'*66}")
        lines.append("  NEAR-MATCH SCORE  (structural + token Jaccard vs 1 000 historical queries)")
        lines.append(f"{'─'*66}")
        best_bar = "█" * round(nm.best_score * 10) + "░" * (10 - round(nm.best_score * 10))
        lines.append(f"  Best match score : {nm.best_score:.3f}  {best_bar}")
        lines.append(f"  Mean of top-5    : {nm.mean_top5:.3f}")
        lines.append(f"\n  Top {len(nm.top_hits)} closest historical queries:")
        lines.append(f"  {'#':<5} {'Combined':>8}  {'Struct':>6}  {'Token':>6}  Title / Query")
        lines.append(f"  {'─'*62}")
        for i, h in enumerate(nm.top_hits, 1):
            title_trunc = (h.title[:45] + "…") if len(h.title) > 46 else h.title
            lines.append(
                f"  {i:<5} {h.combined:>8.3f}  {h.struct_score:>6.3f}  {h.token_score:>6.3f}"
                f"  [{h.query_id}] {title_trunc}"
            )
            # Show the matching SQL (first line only)
            sql_preview = h.sql.strip().splitlines()[0][:80]
            lines.append(f"        SQL: {sql_preview}")

    if consolidated is not None:
        lines.append(f"\n{'═'*66}")
        lines.append("  CONSOLIDATED SCORE  (60% probability + 40% near-match)")
        lines.append(f"{'═'*66}")
        bar = "█" * round(consolidated * 12) + "░" * (12 - round(consolidated * 12))
        lines.append(f"  {'Overall':26} {consolidated:.3f}  {bar}")
        lines.append(f"    Components:  probability={prob.overall:.3f}  near-match={nm.best_score:.3f}" if nm else "")

    lines.append(f"\n{SEP}")
    return "\n".join(lines)


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description="Score a SQL query against historical patterns")
    p.add_argument("query",      nargs="?",  help="SQL query string")
    p.add_argument("--file",     type=Path,  help="Read SQL from file instead")
    p.add_argument("--db",       type=Path,  default=DB_PATH)
    p.add_argument("--md",       type=Path,  default=ANALYSIS_MD)
    p.add_argument("--no-llm",   action="store_true", help="Skip LLM scoring")
    p.add_argument("--no-near",  action="store_true", help="Skip near-match scoring")
    p.add_argument("--top-n",    type=int,   default=5, help="Top-N near matches to show")
    p.add_argument("--json",     action="store_true", help="Output raw JSON scores")
    return p.parse_args()


def main() -> None:
    args = parse_args()

    if args.file:
        sql = args.file.read_text(encoding="utf-8").strip()
    elif args.query:
        sql = args.query.strip()
    else:
        sql = sys.stdin.read().strip()

    if not sql:
        sys.exit("Error: no SQL query provided.")

    print("Loading reference stats...", flush=True)
    stats = load_stats(args.db)
    table_sections = load_table_sections(args.md)

    print("Parsing query...", flush=True)
    info = parse_query(sql)

    print("Computing probability scores...", flush=True)
    prob = score_probability(info, stats)

    llm_report = None
    if not args.no_llm:
        import os
        if not os.environ.get("OPENAI_API_KEY"):
            print("Warning: OPENAI_API_KEY not set — skipping LLM score.", flush=True)
        else:
            print("Calling OpenAI for LLM score...", flush=True)
            llm_report = score_llm(sql, info, table_sections, stats)

    nm_report = None
    if not args.no_near:
        print(f"Computing near-match scores against {args.db}...", flush=True)
        corpus = load_corpus(args.db)
        nm_report = score_near_match(sql, info, corpus, top_n=args.top_n)

    consolidated: float | None = None
    if nm_report is not None:
        consolidated = (
            CONSOLIDATED_W_PROB * prob.overall +
            CONSOLIDATED_W_NEAR * nm_report.best_score
        )

    if args.json:
        out = {
            "probability": {
                name: {"score": round(dim.score, 4) if dim.score is not None else None, "detail": dim.detail}
                for name, dim in prob.dims()
            },
            "probability_overall": round(prob.overall, 4),
            "llm": {
                "subscores": llm_report.subscores,
                "overall":   llm_report.overall,
                "flags":     llm_report.flags,
                "reasoning": llm_report.reasoning,
            } if llm_report else None,
            "near_match": {
                "best_score":  round(nm_report.best_score, 4),
                "mean_top5":   round(nm_report.mean_top5, 4),
                "top_hits": [
                    {
                        "rank":         i + 1,
                        "query_num":    h.query_num,
                        "query_id":     h.query_id,
                        "title":        h.title,
                        "start_time":   h.start_time,
                        "combined":     round(h.combined, 4),
                        "struct_score": round(h.struct_score, 4),
                        "token_score":  round(h.token_score, 4),
                        "sql":          h.sql,
                    }
                    for i, h in enumerate(nm_report.top_hits)
                ],
            } if nm_report else None,
            "consolidated_overall": round(consolidated, 4) if consolidated is not None else None,
        }
        print(json.dumps(out, indent=2))
    else:
        print(render(sql, prob, llm_report, nm_report, consolidated))


if __name__ == "__main__":
    main()
