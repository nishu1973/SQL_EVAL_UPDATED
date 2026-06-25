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
SCHEMA_DB_PATH = Path("raw_data/wealth_management_diverse.db")

# OpenAI model used by the LLM scorer. gpt-4o-mini is the cheaper/faster option.
LLM_MODEL = "gpt-4o-mini"

# Consolidated score weights (legacy two-scorer blend; kept for the --no-llm fallback
# path and for backward-compatible imports). The LLM-aware blend lives in SCORING_CONFIG.
CONSOLIDATED_W_PROB = 0.60
CONSOLIDATED_W_NEAR = 0.40

# ---------------------------------------------------------------------------
# Tunable scoring parameters — centralized (see scoring_improvement_plan.md §5).
# All values here are knobs; behavior is wired up across Phases 2–4.
# ---------------------------------------------------------------------------
SCORING_CONFIG = {
    "S_VALID":    0.5,   # credit for a table/column that EXISTS in schema but was never logged
    "T_SAT":      None,  # fixed saturation count; None => per-counter adaptive (T_SAT_FRAC * max)
    "T_SAT_FRAC": 0.25,  # adaptive saturation = this fraction of the most-popular feature's count
    "MIN_SAT":    3,     # floor for the adaptive saturation threshold
    "ALPHA":      0.6,   # worst-offender blend:  alpha*mean + (1-alpha)*min
    "W_PROB":  0.45,   # consolidated weight: probability
    "W_NEAR":  0.30,   # consolidated weight: near-match
    "W_LLM":   0.25,   # consolidated weight: LLM (only when available; else re-normalized)
    "BETA":    0.7,    # near-match:  beta*best + (1-beta)*mean(top_k_distinct)
    "TOP_K":   5,      # near-match: number of distinct patterns to average
}

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
        "FROM","WHERE","JOIN","BY","THEN","ELSE","WHEN","CASE","END",
        # SQL keywords/operators that otherwise leak in as phantom "columns"
        "DISTINCT","LIKE","IN","IS","BETWEEN","EXISTS","ALL","ANY","UNION",
        "ASC","DESC","GROUP","ORDER","HAVING","LIMIT","OFFSET","USING","INTO",
        "LEFT","RIGHT","INNER","OUTER","FULL","CROSS"}
AGG_NAMES = {"SUM","COUNT","AVG","MIN","MAX","STDDEV","VARIANCE","COALESCE","NULLIF",
             "ROUND","ABS","JULIANDAY","NOW","DATE","DATEADD","DATEDIFF","LOWER","UPPER",
             "TRIM","LENGTH","SUBSTR","CAST","CONVERT","IIF","ISNULL"}

# ---------------------------------------------------------------------------
# SQL parsing helpers
# ---------------------------------------------------------------------------

def _clause(sql: str, key: str) -> str:
    cleaned = SUBQUERY_RE.sub("(SUBQ)", sql)
    m = CLAUSE_RE[key].search(cleaned)
    return m.group(1).strip() if m else ""

def _clean_clause_text(text: str) -> str:
    """Remove things that are NOT base columns before column tokenization:
      - string literals            'INV-001'        -> (gone)
      - output aliases / cast types `… AS total_cost`, `CAST(x AS INTEGER)` -> drop the alias/type
      - function-call NAMES         `STRFTIME(`, `COUNT(` -> drop the name, keep the args
    Without this, alias names (`total_cost`, `holding_count`) and functions (`STRFTIME`) get
    mistaken for real columns — and schema-grounding then false-flags them as hallucinations.
    """
    text = re.sub(r"'[^']*'", " ", text)                       # string literals
    text = re.sub(r"\bAS\s+[A-Za-z_]\w*", " ", text, flags=re.I)  # AS <alias> / AS <type>
    text = re.sub(r"\b[A-Za-z_]\w*\s*\(", " (", text)          # function name before "("
    return text


def _tokens(text: str, exclude_agg: bool = False) -> list[str]:
    text = _clean_clause_text(text)
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

    table_set = set(tables_raw)

    def owns(col: str, table: str) -> bool:
        if col in table_set:                       # a table name is never a column (subquery leak)
            return False
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

    def _clean_agg_col(raw: str) -> str:
        """Resolve an aggregation target to its bare column.

        Drops table-alias prefixes (so SUM(h.current_value) -> CURRENT_VALUE, not the
        spurious token 'H') and wrapping function names (so AVG(ABS(c.amount)) -> AMOUNT).
        """
        toks = [
            t.upper()
            for t in re.findall(r"\b([A-Za-z_]\w*)\b", raw)
            if t.upper() not in SKIP
            and t.upper() not in AGG_NAMES
            and t.upper() not in aliases          # alias names are not columns
        ]
        if toks:
            return toks[-1]                       # the real column after funcs/aliases
        return "(*)" if "*" in raw else ""

    agg_pairs = [(fn.upper(), _clean_agg_col(col)) for fn, col in AGG_COL_RE.findall(sql)]

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
        text = _clean_clause_text(text)  # strip literals, AS-aliases, function-call names
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

            tbl_set = set(tbls)

            def owns_h(col, _tbl_set=tbl_set):
                if col in _tbl_set:                # a table name is never a column
                    return False
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


def load_schema(db_path: Path = SCHEMA_DB_PATH) -> dict[str, set[str]]:
    """Return {TABLE_NAME: {COLUMN, ...}} from the real wealth-management database.

    This is the *ground-truth* schema, used to separate VALIDITY (does this
    table/column actually exist?) from POPULARITY (how often was it logged?).
    Returns {} when the DB is absent so callers degrade gracefully to
    popularity-only scoring (Phases 2+ consume this).
    """
    if not db_path.exists():
        return {}
    con = sqlite3.connect(str(db_path))
    try:
        tables = [
            r[0] for r in con.execute(
                "SELECT name FROM sqlite_master WHERE type='table'"
            )
        ]
        schema: dict[str, set[str]] = {}
        for tbl in tables:
            cols = {row[1].upper() for row in con.execute(f'PRAGMA table_info("{tbl}")')}
            schema[tbl.upper()] = cols
    finally:
        con.close()
    return schema


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
    # Structured calculation trace for the UI (Change: explain layer). Each instance is a
    # dict {label, count, valid, t_sat, formula, score}; `agg` records the worst-offender step.
    instances: list[dict] = field(default_factory=list)
    agg: dict | None = None

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


def _t_sat(counter: Counter, cfg: dict) -> float:
    """Saturation threshold: occurrences at which a feature earns full frequency credit.

    Adaptive default = a fraction of the most-popular feature's count (floored at MIN_SAT),
    so a feature need only be *reasonably common* — not THE most common — to saturate. This
    deliberately replaces the old max-normalization that punished legitimate-but-rare
    features (the §1.1 flaw).
    """
    if cfg.get("T_SAT") is not None:
        return cfg["T_SAT"]
    m = max(counter.values()) if counter else 1
    return max(cfg.get("MIN_SAT", 3), cfg.get("T_SAT_FRAC", 0.25) * m)


def feature_score(count: int, valid: bool | None, cfg: dict, t_sat: float) -> float:
    """Validity-aware familiarity score in [0, 1].

      valid is True  -> confirmed in the real schema: S_VALID baseline + saturating freq bonus
      valid is False -> NOT in the real schema (hallucinated): 0.0
      valid is None  -> no schema available (degrade): popularity-only saturating curve
    """
    if valid is False:
        return 0.0
    sat = min(count / t_sat, 1.0) if (count > 0 and t_sat > 0) else 0.0
    if valid is True:
        s_valid = cfg["S_VALID"]
        return s_valid + (1.0 - s_valid) * sat        # in [S_VALID, 1]
    return sat                                         # valid is None: frequency only


def _aggregate(scores: list[float], cfg: dict) -> float | None:
    """Worst-offender weighted aggregation: alpha*mean + (1-alpha)*min.

    A single anomalous instance (e.g. a hallucinated column scoring 0) visibly drags the
    dimension down instead of being averaged away — without a hard cap (§1.2).
    """
    if not scores:
        return None
    a = cfg["ALPHA"]
    return a * (sum(scores) / len(scores)) + (1.0 - a) * min(scores)


def _col_valid(col: str, table: str, schema: dict) -> bool | None:
    """True if `col` is a real column of `table`; False if not; None if schema unavailable."""
    if not schema:
        return None
    return col in schema.get(table, set())


def _feature_explain(label: str, count: int, valid: bool | None,
                     cfg: dict, t_sat: float) -> tuple[float, dict]:
    """Score one feature AND return a human-readable record of the calculation."""
    sc = feature_score(count, valid, cfg, t_sat)
    sv = cfg["S_VALID"]
    if valid is False:
        formula = "not in schema → 0.0"
    elif valid is True:
        if count == 0:
            formula = f"valid but never logged → S_VALID = {sv}"
        else:
            ratio = min(count / t_sat, 1.0)
            formula = (f"{sv} + {round(1 - sv, 3)}·min({count}/{round(t_sat, 1)}, 1) "
                       f"= {sv} + {round(1 - sv, 3)}·{round(ratio, 3)} = {round(sc, 3)}")
    else:  # valid is None (no schema → popularity only)
        if count == 0:
            formula = "no schema info, never seen → 0.0"
        else:
            ratio = min(count / t_sat, 1.0)
            formula = f"min({count}/{round(t_sat, 1)}, 1) = {round(sc, 3)}"
    rec = {"label": label, "count": count, "valid": valid,
           "t_sat": round(t_sat, 2), "formula": formula, "score": round(sc, 3)}
    return sc, rec


def _agg_explain(scores: list[float], cfg: dict) -> tuple[float | None, dict | None]:
    """Aggregate instance scores (worst-offender) AND return the calculation record."""
    sc = _aggregate(scores, cfg)
    if sc is None:
        return None, None
    a = cfg["ALPHA"]
    mean = sum(scores) / len(scores)
    mn = min(scores)
    meta = {"alpha": a, "n": len(scores), "mean": round(mean, 3), "min": round(mn, 3),
            "formula": (f"{a}·mean({round(mean, 3)}) + {round(1 - a, 3)}·min({round(mn, 3)}) "
                        f"= {round(sc, 3)}"),
            "score": round(sc, 3)}
    return sc, meta


def consolidate(prob_overall: float, near_best: float,
                llm_norm: float | None, cfg: dict = SCORING_CONFIG) -> float:
    """Blend the scorers into a single 0–1 confidence.

    With a valid LLM score:  W_PROB*prob + W_NEAR*near + W_LLM*llm
    Without one (--no-llm, no key, or invalid response): the probability/near weights are
    RE-NORMALIZED over themselves, so the deterministic path is reproducible and — with the
    default 0.45/0.30 — reduces to exactly the legacy 0.60/0.40 blend.
    """
    wP, wN, wL = cfg["W_PROB"], cfg["W_NEAR"], cfg["W_LLM"]
    if llm_norm is None:
        denom = wP + wN
        return (wP * prob_overall + wN * near_best) / denom if denom else 0.0
    return wP * prob_overall + wN * near_best + wL * llm_norm


def collect_flags(info: QueryInfo, prob: "ProbabilityReport", schema: dict) -> list[str]:
    """Deterministic anomaly flags surfaced alongside the score (Change 8).

    Makes the headline scalar actionable: lists exactly *what* looked wrong (hallucinated
    tables/columns from the real schema, never-before-seen joins) instead of hiding it.
    """
    flags: list[str] = []
    refs: dict[str, list[str]] = defaultdict(list)
    for d in (info.select_cols, info.where_cols, info.join_keys):
        for tbl, cols in d.items():
            refs[tbl].extend(cols)

    if schema:
        for t in info.tables:
            if t not in schema:
                flags.append(f"hallucinated table (not in schema): {t}")
        for tbl, cols in refs.items():
            if tbl in schema:
                for c in dict.fromkeys(cols):
                    if c not in schema[tbl]:
                        flags.append(f"hallucinated column (not in schema): {tbl}.{c}")

    for d in prob.join_pattern.detail:
        if "NEVER SEEN" in d:
            flags.append(f"never-seen join: {d.split(':')[0].strip()}")

    return list(dict.fromkeys(flags))


def score_probability(
    info: QueryInfo,
    stats: dict,
    schema: dict | None = None,
    cfg: dict = SCORING_CONFIG,
) -> ProbabilityReport:
    schema = schema or {}

    # 1. Table familiarity — 3-tier: familiar / valid-but-novel / invalid
    tf_scores: list[float] = []
    tf_details: list[str] = []
    tf_recs: list[dict] = []
    for t in info.tables:
        in_log = t in stats
        in_schema = (t in schema) if schema else None
        if in_log:
            sc, tag, tier = 1.0, f"✓ familiar: {t}", "familiar (in schema + logged)"
        elif in_schema is True:
            sc, tag, tier = cfg["S_VALID"], f"~ valid but never logged: {t}", "valid but never logged"
        elif in_schema is False:
            sc, tag, tier = 0.0, f"✗ INVALID (not in schema): {t}", "INVALID — not in schema"
        else:
            sc, tag, tier = 0.0, f"✗ UNKNOWN: {t}", "unknown (no schema, never logged)"
        tf_scores.append(sc)
        tf_details.append(tag)
        tf_recs.append({"label": t, "tier": tier, "score": round(sc, 3)})
    tf_score, tf_agg = _agg_explain(tf_scores, cfg) if info.tables else (1.0, None)
    tf = DimScore(tf_score, "Table Familiarity", tf_details, instances=tf_recs, agg=tf_agg)

    # 2. Column coverage — validity-aware, across SELECT + WHERE columns
    cc_scores: list[float] = []
    cc_details: list[str] = []
    cc_recs: list[dict] = []
    for tbl in info.tables:
        s = stats.get(tbl, {})
        sel = s.get("select_cols", Counter())
        whr = s.get("where_cols", Counter())
        combined: Counter = Counter()
        for src in (sel, whr):
            for c, v in src.items():
                if v > combined[c]:
                    combined[c] = v
        tsat = _t_sat(combined, cfg)
        all_ref = list(dict.fromkeys(
            info.select_cols.get(tbl, []) + info.where_cols.get(tbl, [])
        ))
        for col in all_ref:
            cnt = combined.get(col, 0)
            valid = _col_valid(col, tbl, schema)
            sc, rec = _feature_explain(f"{tbl}.{col}", cnt, valid, cfg, tsat)
            cc_scores.append(sc)
            cc_recs.append(rec)
            tag = ("✓" if cnt > 0 else
                   "~valid/novel" if valid is True else
                   "✗ INVALID" if valid is False else "✗ unseen")
            cc_details.append(f"{tbl}.{col}: {sc:.2f} {tag} (seen {cnt}x)")
    cc_score, cc_agg = _agg_explain(cc_scores, cfg)
    cc = DimScore(cc_score, "Column Coverage", cc_details[:12], instances=cc_recs, agg=cc_agg)

    # 3. Join pattern — popularity of the table-pair (unusual joins are a soft flag)
    if not info.join_pairs:
        jp_score = None
        jp = DimScore(jp_score, "Join Pattern", ["No joins in query — N/A"])
    else:
        jp_scores: list[float] = []
        jp_details: list[str] = []
        jp_recs: list[dict] = []
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
            jp_recs.append({"label": f"{a} + {b}", "count": freq, "max_freq": max_freq,
                            "formula": f"min({freq}/{max_freq}, 1) = {round(sc, 3)}",
                            "score": round(sc, 3)})
        jp_score, jp_agg = _agg_explain(jp_scores, cfg)
        jp = DimScore(jp_score, "Join Pattern", jp_details, instances=jp_recs, agg=jp_agg)

    # 4. Join key validity
    jk_scores: list[float] = []
    jk_details: list[str] = []
    jk_recs: list[dict] = []
    for tbl, cols in info.join_keys.items():
        jk_counter = stats.get(tbl, {}).get("join_keys", Counter())
        tsat = _t_sat(jk_counter, cfg)
        for col in cols:
            cnt = jk_counter.get(col, 0)
            valid = _col_valid(col, tbl, schema)
            sc, rec = _feature_explain(f"{tbl}.{col}", cnt, valid, cfg, tsat)
            jk_scores.append(sc)
            jk_recs.append(rec)
            status = (f"used as join key {cnt}x" if cnt > 0 else
                      "valid key, never used historically" if valid is True else
                      "✗ INVALID column" if valid is False else "never used as join key")
            jk_details.append(f"{tbl}.{col}: {sc:.2f} ({status})")
    jkv_score, jk_agg = _agg_explain(jk_scores, cfg)
    jkv = DimScore(jkv_score, "Join Key Validity", jk_details, instances=jk_recs, agg=jk_agg)

    # 5. Filter column familiarity
    ff_scores: list[float] = []
    ff_details: list[str] = []
    ff_recs: list[dict] = []
    for tbl in info.tables:
        wc = stats.get(tbl, {}).get("where_cols", Counter())
        tsat = _t_sat(wc, cfg)
        for col in info.where_cols.get(tbl, []):
            cnt = wc.get(col, 0)
            valid = _col_valid(col, tbl, schema)
            sc, rec = _feature_explain(f"{tbl}.{col}", cnt, valid, cfg, tsat)
            ff_scores.append(sc)
            ff_recs.append(rec)
            status = (f"filtered {cnt}x historically" if cnt > 0 else
                      "valid column, never filtered on" if valid is True else
                      "✗ INVALID column" if valid is False else "never filtered on — unusual")
            ff_details.append(f"{tbl}.{col}: {sc:.2f} ({status})")
    ff_score, ff_agg = _agg_explain(ff_scores, cfg)
    ff = DimScore(ff_score, "Filter Familiarity", ff_details, instances=ff_recs, agg=ff_agg)

    # 6. Filter operator conformance (operators have no schema validity -> popularity only)
    fo_scores: list[float] = []
    fo_details: list[str] = []
    fo_recs: list[dict] = []
    for tbl in info.tables:
        col_ops = stats.get(tbl, {}).get("where_col_ops", {})
        wc = stats.get(tbl, {}).get("where_cols", Counter())
        for col, op in info.where_ops:
            if col not in wc:
                continue  # handled by filter_familiarity
            op_counter = col_ops.get(col, Counter())
            cnt = op_counter.get(op, 0)
            if op_counter:
                tsat = _t_sat(op_counter, cfg)
                sc, rec = _feature_explain(f"{col} {op}", cnt, None, cfg, tsat)
            else:
                sc = 0.5
                rec = {"label": f"{col} {op}", "count": 0, "valid": None, "t_sat": None,
                       "formula": "no operator history → default 0.5", "score": 0.5}
            fo_scores.append(sc)
            fo_recs.append(rec)
            status = f"{cnt}x for {col}" if cnt > 0 else f"op '{op}' not typical for {col}"
            fo_details.append(f"{col} {op}: {sc:.2f} ({status})")
    fo_score, fo_agg = _agg_explain(fo_scores, cfg)
    fo = DimScore(fo_score, "Filter Operator", fo_details, instances=fo_recs, agg=fo_agg)

    # 7. Aggregation pattern — FUNC(col) combinations (col already alias-resolved in parse)
    ap_scores: list[float] = []
    ap_details: list[str] = []
    ap_recs: list[dict] = []
    for fn, col in info.agg_pairs:
        col = col or "(*)"
        best_cnt, best_tbl, best_counter = 0, None, Counter()
        for tbl in info.tables:
            counter = stats.get(tbl, {}).get("agg_on_col", {}).get(fn, Counter())
            c = counter.get(col, 0)
            if c > best_cnt:
                best_cnt, best_tbl, best_counter = c, tbl, counter
        if col == "(*)":
            valid: bool | None = True
        else:
            votes = [_col_valid(col, t, schema) for t in info.tables]
            valid = (True if any(v is True for v in votes)
                     else False if votes and all(v is False for v in votes)
                     else None)
        tsat = _t_sat(best_counter, cfg) if best_counter else cfg.get("MIN_SAT", 3)
        sc, rec = _feature_explain(f"{fn}({col})", best_cnt, valid, cfg, tsat)
        ap_scores.append(sc)
        ap_recs.append(rec)
        if best_cnt > 0:
            ap_details.append(f"{fn}({col}): {sc:.2f} (seen {best_cnt}x on {best_tbl})")
        elif valid is True:
            ap_details.append(f"{fn}({col}): {sc:.2f} (valid column, novel aggregation)")
        elif valid is False:
            ap_details.append(f"{fn}({col}): {sc:.2f} — ✗ INVALID column")
        else:
            ap_details.append(f"{fn}({col}): {sc:.2f} — combination not seen historically")
    ap_score, ap_agg = _agg_explain(ap_scores, cfg)
    ap = DimScore(ap_score, "Aggregation Pattern", ap_details, instances=ap_recs, agg=ap_agg)

    # Overall weighted score — only include dimensions that had data to evaluate.
    # Dimensions with nothing to check (no joins, no aggs, etc.) score as None
    # and are excluded here; weights are re-normalized over applicable dims only.
    w = ProbabilityReport.WEIGHTS
    dim_scores = {
        "table_familiarity":   tf_score,
        "column_coverage":     cc_score,
        "join_pattern":        jp_score,
        "join_key_validity":   jkv_score,
        "filter_familiarity":  ff_score,
        "filter_operator":     fo_score,
        "aggregation_pattern": ap_score,
    }
    # A dimension is applicable when it produced a score (None == nothing to evaluate).
    applicable = {k: v is not None for k, v in dim_scores.items()}
    total_weight = sum(w[k] for k, app in applicable.items() if app)
    overall = (
        sum(dim_scores[k] * w[k] for k, app in applicable.items() if app) / total_weight
        if total_weight else 1.0
    )

    return ProbabilityReport(tf, cc, jp, jkv, ff, fo, ap, overall)


# ---------------------------------------------------------------------------
# LLM scoring
# ---------------------------------------------------------------------------

LLM_SUBSCORE_KEYS = (
    "table_familiarity", "column_relevance", "join_conformance",
    "filter_conformance", "aggregation_conformance",
)


@dataclass
class LLMReport:
    subscores: dict[str, int]
    overall:   int
    reasoning: str
    flags:     list[str]


def _clamp_0_100(v) -> int | None:
    """Coerce a value to an int in [0, 100]; return None if it isn't a number."""
    try:
        return max(0, min(100, int(round(float(v)))))
    except (TypeError, ValueError):
        return None


def validate_llm_payload(data: dict) -> LLMReport | None:
    """Validate + clamp a parsed LLM response into an LLMReport.

    Returns None if the payload is unusable (missing/garbage `overall`). This replaces
    the old `data.get("overall", 0)` which silently defaulted a broken response to 0 and
    would have cratered the consolidated score (§2.3).
    """
    if not isinstance(data, dict):
        return None
    overall = _clamp_0_100(data.get("overall"))
    if overall is None:
        return None  # no usable headline score -> treat as unavailable, do not invent 0
    raw_sub = data.get("subscores") or {}
    subscores = {k: c for k in LLM_SUBSCORE_KEYS
                 if (c := _clamp_0_100(raw_sub.get(k))) is not None}
    flags = data.get("flags") or []
    if not isinstance(flags, list):
        flags = [str(flags)]
    return LLMReport(
        subscores=subscores,
        overall=overall,
        reasoning=str(data.get("reasoning", "")),
        flags=[str(f) for f in flags],
    )


def score_llm(sql: str, info: QueryInfo, table_sections: dict, stats: dict,
              retries: int = 1) -> LLMReport | None:
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

    for _ in range(retries + 1):
        try:
            resp = client.chat.completions.create(
                model=LLM_MODEL,
                messages=[{"role": "user", "content": prompt}],
                temperature=0,
                response_format={"type": "json_object"},
            )
            data = json.loads(resp.choices[0].message.content)
            report = validate_llm_payload(data)
            if report is not None:
                return report
        except (json.JSONDecodeError, KeyError, AttributeError, ValueError):
            pass  # fall through to retry
    return None  # exhausted retries with no valid response -> caller treats as unavailable


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
    best_score:    float   # raw single closest hit (still reported for transparency)
    mean_top5:     float   # mean over the displayed top-N hits
    score:         float   # robust blend used downstream: BETA*best + (1-BETA)*mean(top_k)


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


def load_corpus(db_path: Path, dedup: bool = True) -> list[dict]:
    """Load historical queries with pre-computed features.

    With dedup=True (default) queries that NORMALIZE to the same SQL collapse to a single
    entry (carrying a `dup_count`). This stops N identical logged queries from masquerading
    as a dense cluster in near-match scoring (§3.1) — e.g. the same template run with many
    different literal values.
    """
    con = sqlite3.connect(str(db_path))
    rows = con.execute(
        "SELECT query_num, query_id, title, start_time, sql_query FROM query_logs ORDER BY query_num"
    ).fetchall()
    con.close()

    corpus: list[dict] = []
    by_norm: dict[str, dict] = {}
    for query_num, query_id, title, start_time, sql in rows:
        if dedup:
            key = _normalize_sql(sql)
            if key in by_norm:
                by_norm[key]["dup_count"] += 1
                continue
        info = parse_query(sql)
        entry = {
            "query_num":  query_num,
            "query_id":   query_id,
            "title":      title or "",
            "start_time": start_time or "",
            "sql":        sql,
            "features":   _structural_features(info),
            "token_set":  _sql_token_set(sql),
            "dup_count":  1,
        }
        corpus.append(entry)
        if dedup:
            by_norm[_normalize_sql(sql)] = entry
    return corpus


def score_near_match(
    sql: str,
    info: QueryInfo,
    corpus: list[dict],
    top_n: int = 5,
    cfg: dict = SCORING_CONFIG,
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

    best = hits[0].combined if hits else 0.0
    # Robust blend: temper the single best hit with the mean of the top-k DISTINCT matches,
    # so being near one outlier scores lower than being near a genuine cluster (§3.2).
    k = cfg.get("TOP_K", 5)
    topk = hits[:k]
    mean_topk = sum(h.combined for h in topk) / len(topk) if topk else 0.0
    beta = cfg.get("BETA", 0.7)
    score = beta * best + (1.0 - beta) * mean_topk

    display = hits[:top_n]
    mean_disp = sum(h.combined for h in display) / len(display) if display else 0.0

    return NearMatchReport(top_hits=display, best_score=best, mean_top5=mean_disp, score=score)


# ---------------------------------------------------------------------------
# Report rendering
# ---------------------------------------------------------------------------

def render(sql: str, prob: ProbabilityReport, llm: LLMReport | None,
           nm: NearMatchReport | None = None,
           consolidated: float | None = None,
           flags: list[str] | None = None) -> str:
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
        lines.append(f"  LLM-BASED SCORE  (OpenAI {LLM_MODEL})")
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
        lines.append("  NEAR-MATCH SCORE  (structural + token Jaccard vs deduped corpus)")
        lines.append(f"{'─'*66}")
        score_bar = "█" * round(nm.score * 10) + "░" * (10 - round(nm.score * 10))
        lines.append(f"  Robust near score: {nm.score:.3f}  {score_bar}  (feeds consolidated)")
        lines.append(f"  Best single hit  : {nm.best_score:.3f}")
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

    if flags:
        lines.append(f"\n{'─'*66}")
        lines.append("  ⚑ DETECTED ANOMALIES")
        lines.append(f"{'─'*66}")
        for f in flags:
            lines.append(f"    ⚑  {f}")

    if consolidated is not None:
        cfg = SCORING_CONFIG
        lines.append(f"\n{'═'*66}")
        if llm is not None:
            wP = cfg["W_PROB"]; wN = cfg["W_NEAR"]; wL = cfg["W_LLM"]
            header = f"  CONSOLIDATED SCORE  ({wP:.0%} prob + {wN:.0%} near + {wL:.0%} LLM)"
        else:
            denom = cfg["W_PROB"] + cfg["W_NEAR"]
            header = (f"  CONSOLIDATED SCORE  ({cfg['W_PROB']/denom:.0%} prob + "
                      f"{cfg['W_NEAR']/denom:.0%} near — deterministic, LLM absent)")
        lines.append(header)
        lines.append(f"{'═'*66}")
        bar = "█" * round(consolidated * 12) + "░" * (12 - round(consolidated * 12))
        lines.append(f"  {'Overall':26} {consolidated:.3f}  {bar}")
        if nm:
            comp = f"    Components:  probability={prob.overall:.3f}  near-match={nm.score:.3f}"
            if llm is not None:
                comp += f"  llm={llm.overall/100:.3f}"
            lines.append(comp)

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
    p.add_argument("--schema-db", type=Path, default=SCHEMA_DB_PATH,
                   help="Real schema DB for validity grounding (popularity-only if absent)")
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
    schema = load_schema(args.schema_db)
    if not schema:
        print("Warning: schema DB not found — scoring on log popularity only.", flush=True)

    print("Parsing query...", flush=True)
    info = parse_query(sql)

    print("Computing probability scores...", flush=True)
    prob = score_probability(info, stats, schema)

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

    flags = collect_flags(info, prob, schema)

    consolidated: float | None = None
    if nm_report is not None:
        llm_norm = (llm_report.overall / 100.0) if llm_report else None
        consolidated = consolidate(prob.overall, nm_report.score, llm_norm)

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
                "score":       round(nm_report.score, 4),
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
            "flags": flags,
            "consolidated_overall": round(consolidated, 4) if consolidated is not None else None,
        }
        print(json.dumps(out, indent=2))
    else:
        print(render(sql, prob, llm_report, nm_report, consolidated, flags))


if __name__ == "__main__":
    main()
