"""
analyze_query_logs_llm.py

Uses LangGraph + OpenAI to generate a detailed per-table narrative analysis
of SQL usage patterns extracted from raw_data/parsed_query_logs.db.

For each table the analysis covers:
  - Query volume and join vs. single-table breakdown
  - Most used SELECT columns and their aggregation functions
  - WHERE filter columns with operators and most common filter values
  - GROUP BY / ORDER BY columns
  - JOIN partners and join keys
  - Representative sample queries
  - A final cross-table synthesis

Usage:
    uv run python scripts/analyze_query_logs_llm.py
    uv run python scripts/analyze_query_logs_llm.py --db raw_data/parsed_query_logs.db --model gpt-4o-mini --out reports/query_analysis.md
"""

from __future__ import annotations

import argparse
import os
import re
import sqlite3
from collections import Counter, defaultdict
from pathlib import Path
from typing import TypedDict

from dotenv import load_dotenv

load_dotenv()  # loads .env from the project root

from langchain_openai import ChatOpenAI
from langgraph.graph import END, START, StateGraph

DB_PATH = Path("raw_data/parsed_query_logs.db")
DEFAULT_MODEL = "gpt-4o-mini"

# ---------------------------------------------------------------------------
# SQL extraction helpers
# ---------------------------------------------------------------------------

TABLE_RE = re.compile(r"\b(?:FROM|JOIN)\s+([A-Z_][A-Z0-9_]*)", re.IGNORECASE)
ALIAS_RE = re.compile(
    r"\b(?:FROM|JOIN)\s+([A-Z_][A-Z0-9_]*)\s+(?:AS\s+)?([A-Za-z_]\w*)\b", re.IGNORECASE
)
ALIASED_COL_RE = re.compile(r"\b([A-Za-z_]\w*)\.([A-Za-z_]\w*)\b")
AGG_COL_RE = re.compile(r"\b(COUNT|SUM|AVG|MIN|MAX)\s*\(\s*(?:DISTINCT\s+)?([^)]+?)\s*\)", re.IGNORECASE)
SUBQUERY_RE = re.compile(r"\(SELECT\b.+?\)", re.IGNORECASE | re.DOTALL)

CLAUSE_PATTERNS = {
    "select":   re.compile(r"\bSELECT\b(.*?)\bFROM\b", re.IGNORECASE | re.DOTALL),
    "where":    re.compile(r"\bWHERE\b(.*?)(?=\b(?:GROUP|ORDER|HAVING|LIMIT|UNION)\b|;|$)", re.IGNORECASE | re.DOTALL),
    "groupby":  re.compile(r"\bGROUP\s+BY\b(.*?)(?=\b(?:ORDER|HAVING|LIMIT|UNION)\b|;|$)", re.IGNORECASE | re.DOTALL),
    "orderby":  re.compile(r"\bORDER\s+BY\b(.*?)(?=\b(?:LIMIT|UNION)\b|;|$)", re.IGNORECASE | re.DOTALL),
    "on":       re.compile(r"\bON\b\s*(.+?)(?=\b(?:WHERE|JOIN|LEFT|RIGHT|INNER|FULL|GROUP|ORDER|HAVING|LIMIT)\b|;|$)", re.IGNORECASE | re.DOTALL),
}

FILTER_RE = re.compile(
    r"\b([A-Za-z_]\w*)\s*(=|!=|<>|>=|<=|>|<|LIKE|NOT\s+LIKE|IN|NOT\s+IN|IS\s+NOT|IS|BETWEEN)\s*",
    re.IGNORECASE,
)
EQ_VALUE_RE = re.compile(r"\b([A-Za-z_]\w*)\s*=\s*(?:'([^']*)'|([A-Za-z0-9_\-\.]+))")

SKIP_TOKENS = {
    "AND", "OR", "NOT", "ON", "AS", "NULL", "TRUE", "FALSE", "SUBQ",
    "SELECT", "FROM", "WHERE", "JOIN", "BY", "THEN", "ELSE", "WHEN", "CASE", "END",
}
# Aggregate / SQL function names to exclude from SELECT column lists
AGG_NAMES = {"SUM", "COUNT", "AVG", "MIN", "MAX", "STDDEV", "VARIANCE",
             "COALESCE", "NULLIF", "ROUND", "ABS", "JULIANDAY", "NOW",
             "DATE", "DATEADD", "DATEDIFF", "LOWER", "UPPER", "TRIM",
             "LENGTH", "SUBSTR", "CAST", "CONVERT", "IIF", "ISNULL"}


def _extract_clause(sql: str, clause: str) -> str:
    cleaned = SUBQUERY_RE.sub("(SUBQ)", sql)
    m = CLAUSE_PATTERNS[clause].search(cleaned)
    return m.group(1).strip() if m else ""


def _col_tokens(text: str) -> list[str]:
    """Extract bare identifiers from a clause fragment, skip SQL keywords."""
    tokens = re.findall(r"\b([A-Za-z_][A-Za-z0-9_]*)\b", text)
    return [t.upper() for t in tokens if t.upper() not in SKIP_TOKENS and not t.isdigit()]


def _table_aliases(sql: str) -> dict[str, str]:
    """Return {alias_upper: TABLE_UPPER} from FROM/JOIN clauses."""
    result: dict[str, str] = {}
    for table, alias in ALIAS_RE.findall(sql):
        alias_up = alias.upper()
        if alias_up not in {"ON", "WHERE", "JOIN", "LEFT", "RIGHT", "INNER", "OUTER", "FULL", "AS", "SET"}:
            result[alias_up] = table.upper()
    return result


def _aliased_col_map(sql: str, aliases: dict[str, str]) -> dict[str, list[str]]:
    """Return {TABLE: [col, ...]} for alias.col references."""
    result: dict[str, list[str]] = defaultdict(list)
    for alias, col in ALIASED_COL_RE.findall(sql):
        table = aliases.get(alias.upper())
        if table:
            result[table].append(col.upper())
    return dict(result)


def extract_per_table_stats(queries: list[str]) -> dict[str, dict]:
    """Build rich per-table usage statistics from all queries."""

    stats: dict[str, dict] = defaultdict(lambda: {
        "query_count": 0,
        "single_table_count": 0,
        "joined_count": 0,
        "select_cols": Counter(),
        "where_cols": Counter(),
        "where_ops": Counter(),
        "where_values": defaultdict(Counter),
        "agg_fns": Counter(),        # fn -> count across all uses
        "agg_on_col": defaultdict(Counter),  # fn -> {col: count}
        "groupby_cols": Counter(),
        "orderby_cols": Counter(),
        "join_keys": Counter(),
        "join_partners": Counter(),
        "sample_queries": [],
    })

    for sql in queries:
        tables_raw = TABLE_RE.findall(sql)
        unique_tables = list(dict.fromkeys(t.upper() for t in tables_raw))
        if not unique_tables:
            continue

        aliases = _table_aliases(sql)
        rev_aliases = {v: k for k, v in aliases.items()}  # TABLE -> alias
        aliased_cols = _aliased_col_map(sql, aliases)      # TABLE -> [cols]

        is_multi = len(unique_tables) > 1

        # Clause text
        select_text   = _extract_clause(sql, "select")
        where_text    = _extract_clause(sql, "where")
        groupby_text  = _extract_clause(sql, "groupby")
        orderby_text  = _extract_clause(sql, "orderby")
        on_text       = _extract_clause(sql, "on")

        # Aggregates with their target columns
        agg_pairs = [(fn.upper(), col.strip().upper()) for fn, col in AGG_COL_RE.findall(sql)]

        # WHERE filters (col, op)
        where_filters = [
            (col.upper(), re.sub(r"\s+", " ", op).upper())
            for col, op in FILTER_RE.findall(where_text)
            if col.upper() not in SKIP_TOKENS
        ]

        # WHERE equality values
        where_eq_vals = [
            (col.upper(), str_val if str_val else bare_val)
            for col, str_val, bare_val in EQ_VALUE_RE.findall(where_text)
            if col.upper() not in SKIP_TOKENS
        ]

        for table in unique_tables:
            s = stats[table]
            s["query_count"] += 1
            if is_multi:
                s["joined_count"] += 1
                for other in unique_tables:
                    if other != table:
                        s["join_partners"][other] += 1
            else:
                s["single_table_count"] += 1

            # Determine which columns to attribute to this table
            alias = rev_aliases.get(table)
            own_cols_from_alias: set[str] = set(aliased_cols.get(table, []))

            # For single-table queries, unaliased col refs belong to this table
            def owns(col: str) -> bool:
                if col in own_cols_from_alias:
                    return True
                if not is_multi and col not in SKIP_TOKENS:
                    return True
                return False

            # SELECT columns — exclude SQL function names and aliases
            for tok in _col_tokens(select_text):
                if owns(tok) and tok not in {"DISTINCT", "AS"} and tok not in AGG_NAMES:
                    s["select_cols"][tok] += 1

            # Aggregations
            for fn, raw_col in agg_pairs:
                col_toks = _col_tokens(raw_col)
                for col in col_toks:
                    if col == "*" or owns(col):
                        s["agg_fns"][fn] += 1
                        s["agg_on_col"][fn][col if col != "*" else "(*)"] += 1

            # WHERE filters
            for col, op in where_filters:
                if owns(col):
                    s["where_cols"][col] += 1
                    s["where_ops"][op] += 1

            # WHERE equality values
            for col, val in where_eq_vals:
                if owns(col) and val.upper() not in SKIP_TOKENS:
                    s["where_values"][col][val] += 1

            # GROUP BY
            for tok in _col_tokens(groupby_text):
                if owns(tok):
                    s["groupby_cols"][tok] += 1

            # ORDER BY
            for tok in _col_tokens(orderby_text):
                if tok not in {"ASC", "DESC"} and tok not in AGG_NAMES and owns(tok):
                    s["orderby_cols"][tok] += 1

            # JOIN keys (ON clause cols attributed to this table)
            for tok in _col_tokens(on_text):
                if owns(tok):
                    s["join_keys"][tok] += 1

            # Store up to 3 sample queries
            if len(s["sample_queries"]) < 3 and sql not in s["sample_queries"]:
                s["sample_queries"].append(sql.strip())

    return dict(stats)


def format_counter(c: Counter, top: int = 8) -> str:
    if not c:
        return "  (none)"
    return "\n".join(f"  {col}: {cnt}" for col, cnt in c.most_common(top))


def build_table_context(table: str, s: dict) -> str:
    """Serialise one table's stats into a structured text block for the LLM."""
    lines = [f"TABLE: {table}"]
    lines.append(f"Total queries: {s['query_count']}  "
                 f"(single-table: {s['single_table_count']}, joined: {s['joined_count']})")

    lines.append("\nSELECT columns (frequency):")
    lines.append(format_counter(s["select_cols"]))

    if s["agg_fns"]:
        lines.append("\nAggregate functions used:")
        lines.append(format_counter(s["agg_fns"]))
        for fn, cols in s["agg_on_col"].items():
            lines.append(f"  {fn} applied to:")
            lines.append(format_counter(cols, top=5))

    lines.append("\nWHERE filter columns (frequency):")
    lines.append(format_counter(s["where_cols"]))

    if s["where_ops"]:
        lines.append("\nFilter operators:")
        lines.append(format_counter(s["where_ops"]))

    if s["where_values"]:
        lines.append("\nMost common equality filter values:")
        for col, vals in sorted(s["where_values"].items(),
                                key=lambda x: sum(x[1].values()), reverse=True)[:6]:
            lines.append(f"  {col}:")
            for val, cnt in vals.most_common(5):
                lines.append(f"    '{val}' ({cnt}x)")

    if s["groupby_cols"]:
        lines.append("\nGROUP BY columns:")
        lines.append(format_counter(s["groupby_cols"]))

    if s["orderby_cols"]:
        lines.append("\nORDER BY columns:")
        lines.append(format_counter(s["orderby_cols"]))

    if s["join_keys"]:
        lines.append("\nJoin key columns (ON clause):")
        lines.append(format_counter(s["join_keys"]))

    if s["join_partners"]:
        lines.append("\nJoined with (frequency):")
        lines.append(format_counter(s["join_partners"]))

    if s["sample_queries"]:
        lines.append("\nSample queries:")
        for i, q in enumerate(s["sample_queries"], 1):
            lines.append(f"  [{i}] {q[:300]}")

    return "\n".join(lines)


# ---------------------------------------------------------------------------
# LangGraph state + nodes
# ---------------------------------------------------------------------------

class AnalysisState(TypedDict):
    per_table_stats: dict[str, dict]
    tables: list[str]
    current_index: int
    table_analyses: dict[str, str]
    final_report: str


def extract_node(state: AnalysisState) -> AnalysisState:
    """Load queries from DB and compute per-table stats."""
    con = sqlite3.connect(str(DB_PATH))
    queries = [r[0] for r in con.execute("SELECT sql_query FROM query_logs")]
    con.close()

    per_table_stats = extract_per_table_stats(queries)
    # Sort tables by query count descending so the most-used appear first
    tables = sorted(per_table_stats, key=lambda t: per_table_stats[t]["query_count"], reverse=True)

    print(f"[extract] Found {len(queries)} queries across {len(tables)} tables")
    return {
        **state,
        "per_table_stats": per_table_stats,
        "tables": tables,
        "current_index": 0,
        "table_analyses": {},
    }


def analyze_table_node(state: AnalysisState, llm: ChatOpenAI) -> AnalysisState:
    """Generate a detailed LLM analysis for the current table."""
    idx = state["current_index"]
    table = state["tables"][idx]
    s = state["per_table_stats"][table]
    context = build_table_context(table, s)

    print(f"[analyze] {idx + 1}/{len(state['tables'])}  {table}  ({s['query_count']} queries)")

    prompt = f"""You are a senior data analyst reviewing SQL query logs from a wealth management platform.
Below are detailed usage statistics for the database table **{table}**, extracted from {s['query_count']} queries.

{context}

Write a detailed analytical narrative for this table covering:
1. **Purpose & Usage Volume** — what this table represents and how heavily it is queried
2. **Key Columns** — which columns are most accessed in SELECT, with what frequency, and what they likely represent
3. **Aggregation Patterns** — which aggregation functions are applied to which columns and what business metrics they compute
4. **Filter Patterns** — how the table is filtered (columns, operators, most common values), and what query intents this reveals
5. **Join Behaviour** — which tables it is commonly joined with, on what keys, and what cross-table analysis this enables
6. **Grouping & Sorting** — how results are grouped or ordered and what analytical slices this implies
7. **Query Intent Summary** — a concise description of the types of business questions this table answers

Be specific and use the actual column names and values from the statistics. Format the response in clear markdown with headers."""

    response = llm.invoke(prompt)
    analyses = {**state["table_analyses"], table: response.content}

    return {
        **state,
        "current_index": idx + 1,
        "table_analyses": analyses,
    }


def synthesize_node(state: AnalysisState, llm: ChatOpenAI) -> AnalysisState:
    """Produce a cross-table executive summary."""
    print("[synthesize] Generating cross-table summary...")

    all_analyses = "\n\n---\n\n".join(
        f"### {t}\n{a}" for t, a in state["table_analyses"].items()
    )

    prompt = f"""You are a senior data analyst. Below are detailed per-table analyses of SQL usage patterns
from a wealth management platform query log (1000 queries total).

{all_analyses}

Write an **executive summary** (in markdown) that covers:
1. **Data Architecture Overview** — how the tables relate to each other and what the overall schema appears to support
2. **Most Critical Tables** — which tables are the backbone of the platform and why
3. **Core Query Patterns** — the recurring analytical workflows and business questions across the log
4. **Cross-Table Join Graph** — the key join relationships and what multi-table analyses they enable
5. **Filter & Segmentation Patterns** — the most common ways data is sliced (by investor, risk profile, goal type, etc.)
6. **Aggregation & Metric Landscape** — what business metrics are computed and how
7. **Gaps & Observations** — any notable patterns, sparse usage, or tables that seem underutilised

Be concise but comprehensive. Use the actual table and column names throughout."""

    response = llm.invoke(prompt)
    return {**state, "final_report": response.content}


def should_continue(state: AnalysisState) -> str:
    if state["current_index"] < len(state["tables"]):
        return "analyze_table"
    return "synthesize"


# ---------------------------------------------------------------------------
# Build and run the graph
# ---------------------------------------------------------------------------

def build_graph(llm: ChatOpenAI) -> object:
    graph = StateGraph(AnalysisState)

    graph.add_node("extract", extract_node)
    graph.add_node("analyze_table", lambda s: analyze_table_node(s, llm))
    graph.add_node("synthesize", lambda s: synthesize_node(s, llm))

    graph.add_edge(START, "extract")
    graph.add_edge("extract", "analyze_table")
    graph.add_conditional_edges("analyze_table", should_continue, {
        "analyze_table": "analyze_table",
        "synthesize": "synthesize",
    })
    graph.add_edge("synthesize", END)

    return graph.compile()


def run(db_path: Path, model: str, out: Path | None) -> None:
    global DB_PATH
    DB_PATH = db_path

    llm = ChatOpenAI(model=model, temperature=0)
    app = build_graph(llm)

    initial_state: AnalysisState = {
        "per_table_stats": {},
        "tables": [],
        "current_index": 0,
        "table_analyses": {},
        "final_report": "",
    }

    final_state = app.invoke(initial_state)

    # Assemble full report
    sections = ["# SQL Query Log — Detailed Analysis by Table\n"]
    for table, analysis in final_state["table_analyses"].items():
        sections.append(f"## {table}\n\n{analysis}\n")
    sections.append("---\n\n# Executive Summary\n\n" + final_state["final_report"])

    report = "\n".join(sections)

    if out:
        out.parent.mkdir(parents=True, exist_ok=True)
        out.write_text(report, encoding="utf-8")
        print(f"\nReport saved → {out}")
    else:
        print("\n" + report)


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description="LLM-powered per-table SQL analysis via LangGraph + OpenAI")
    p.add_argument("--db",    type=Path,   default=Path("raw_data/parsed_query_logs.db"))
    p.add_argument("--model", type=str,    default=DEFAULT_MODEL)
    p.add_argument("--out",   type=Path,   default=Path("reports/query_analysis.md"))
    return p.parse_args()


if __name__ == "__main__":
    if not os.environ.get("OPENAI_API_KEY"):
        raise SystemExit("Error: OPENAI_API_KEY environment variable is not set.")
    args = parse_args()
    run(args.db, args.model, args.out)
