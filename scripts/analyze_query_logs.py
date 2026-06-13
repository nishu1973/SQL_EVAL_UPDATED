"""
analyze_query_logs.py

Analyzes sql_query entries in raw_data/parsed_query_logs.db and prints a
structured report covering:
  - Most frequently queried tables
  - Most common table-pair join combinations
  - Most common WHERE filter columns and their operators
  - Most common filter values per column
  - Join type distribution
  - Aggregate function usage
  - Query structure breakdown (GROUP BY, ORDER BY, HAVING, LIMIT, subquery)

Usage:
    python3 scripts/analyze_query_logs.py
    python3 scripts/analyze_query_logs.py --db raw_data/parsed_query_logs.db --top 15
"""

import argparse
import re
import sqlite3
from collections import Counter, defaultdict
from itertools import combinations
from pathlib import Path

DB_PATH = Path("raw_data/parsed_query_logs.db")

# ---------------------------------------------------------------------------
# Regex patterns
# ---------------------------------------------------------------------------

# Capture table names after FROM / JOIN (ignore aliases)
TABLE_RE = re.compile(
    r"\b(?:FROM|JOIN)\s+([A-Z_][A-Z0-9_]*)", re.IGNORECASE
)

# Match explicit join types
JOIN_TYPE_RE = re.compile(
    r"\b(LEFT\s+(?:OUTER\s+)?JOIN"
    r"|RIGHT\s+(?:OUTER\s+)?JOIN"
    r"|FULL\s+(?:OUTER\s+)?JOIN"
    r"|INNER\s+JOIN"
    r"|CROSS\s+JOIN"
    r"|JOIN)\b",
    re.IGNORECASE,
)

# Strip a subquery from WHERE so we only look at direct filter expressions
SUBQUERY_RE = re.compile(r"\(SELECT.*?\)", re.IGNORECASE | re.DOTALL)

# Isolate WHERE clause (stops at GROUP / ORDER / HAVING / LIMIT / semicolon)
WHERE_CLAUSE_RE = re.compile(
    r"\bWHERE\b\s*(.+?)(?=\b(?:GROUP|ORDER|HAVING|LIMIT|UNION)\b|;|$)",
    re.IGNORECASE | re.DOTALL,
)

# Individual filter token:  <col>  <op>
FILTER_RE = re.compile(
    r"\b([a-zA-Z_][a-zA-Z0-9_]*)\s*(=|!=|<>|>=|<=|>|<|LIKE|NOT LIKE|IN|NOT IN|IS NOT|IS|BETWEEN)\s*",
    re.IGNORECASE,
)

# Filter value (string literal, number, or keyword literal)
VALUE_RE = re.compile(
    r"=\s*'([^']+)'|=\s*([\w\.\-]+)",
    re.IGNORECASE,
)

# Aggregate functions
AGG_RE = re.compile(
    r"\b(COUNT|SUM|AVG|MIN|MAX|STDDEV|VARIANCE)\s*\(",
    re.IGNORECASE,
)

# SELECT columns (simple, before FROM)
SELECT_COL_RE = re.compile(
    r"\bSELECT\b\s+(DISTINCT\s+)?(.*?)\s+\bFROM\b",
    re.IGNORECASE | re.DOTALL,
)

# ---------------------------------------------------------------------------
# Per-query extraction
# ---------------------------------------------------------------------------

def extract_tables(sql: str) -> list[str]:
    return [t.upper() for t in TABLE_RE.findall(sql)]


def extract_join_types(sql: str) -> list[str]:
    return [" ".join(j.upper().split()) for j in JOIN_TYPE_RE.findall(sql)]


def extract_filters(sql: str):
    """Return list of (column, operator) from the WHERE clause."""
    # Remove subqueries before scanning WHERE
    cleaned = SUBQUERY_RE.sub("(SUBQ)", sql)
    m = WHERE_CLAUSE_RE.search(cleaned)
    if not m:
        return []
    where_body = m.group(1)
    return [
        (col.upper(), op.upper())
        for col, op in FILTER_RE.findall(where_body)
        if col.upper() not in {"AND", "OR", "NOT", "ON", "AS", "NULL", "TRUE", "FALSE"}
    ]


def extract_filter_values(sql: str) -> list[tuple[str, str]]:
    """Return list of (column, value) for equality filters in the WHERE clause."""
    cleaned = SUBQUERY_RE.sub("(SUBQ)", sql)
    m = WHERE_CLAUSE_RE.search(cleaned)
    if not m:
        return []
    where_body = m.group(1)
    # Match: column = 'string'  OR  column = bare_word
    pattern = re.compile(
        r"\b([a-zA-Z_][a-zA-Z0-9_]*)\s*=\s*(?:'([^']*)'|([A-Za-z0-9_\-\.]+))",
    )
    skip = {"AND", "OR", "NOT", "ON", "AS", "NULL", "TRUE", "FALSE", "SUBQ"}
    pairs = []
    for col, str_val, bare_val in pattern.findall(where_body):
        col = col.upper()
        if col in skip:
            continue
        val = str_val if str_val else bare_val
        if val and val.upper() not in skip:
            pairs.append((col, val))
    return pairs


def extract_aggregates(sql: str) -> list[str]:
    return [a.upper() for a in AGG_RE.findall(sql)]


def query_flags(sql: str) -> dict[str, bool]:
    su = sql.upper()
    return {
        "has_join":      bool(re.search(r"\bJOIN\b", su)),
        "has_where":     bool(re.search(r"\bWHERE\b", su)),
        "has_group_by":  bool(re.search(r"\bGROUP\s+BY\b", su)),
        "has_order_by":  bool(re.search(r"\bORDER\s+BY\b", su)),
        "has_having":    bool(re.search(r"\bHAVING\b", su)),
        "has_limit":     bool(re.search(r"\bLIMIT\b", su)),
        "has_subquery":  bool(re.search(r"\bSELECT\b.+\bSELECT\b", su, re.DOTALL)),
        "has_cte":       bool(re.search(r"^\s*WITH\b", su)),
        "has_distinct":  bool(re.search(r"\bDISTINCT\b", su)),
        "is_select_star":bool(re.search(r"SELECT\s+\*", su)),
    }


# ---------------------------------------------------------------------------
# Report helpers
# ---------------------------------------------------------------------------

def section(title: str) -> str:
    bar = "=" * 60
    return f"\n{bar}\n  {title}\n{bar}"


def ranked_table(counter: Counter, top: int, col1="Item", col2="Count") -> str:
    total = sum(counter.values())
    lines = [f"  {'Rank':<5} {col1:<45} {col2:>7}  {'%':>6}"]
    lines.append("  " + "-" * 70)
    for rank, (item, count) in enumerate(counter.most_common(top), 1):
        pct = 100.0 * count / total if total else 0
        lines.append(f"  {rank:<5} {str(item):<45} {count:>7}  {pct:>5.1f}%")
    return "\n".join(lines)


# ---------------------------------------------------------------------------
# Main analysis
# ---------------------------------------------------------------------------

def analyze(db_path: Path, top: int) -> str:
    con = sqlite3.connect(db_path)
    queries = [row[0] for row in con.execute("SELECT sql_query FROM query_logs")]
    con.close()

    total = len(queries)

    table_freq: Counter = Counter()
    pair_freq: Counter = Counter()
    join_type_freq: Counter = Counter()
    filter_col_freq: Counter = Counter()
    filter_op_freq: Counter = Counter()
    filter_col_op_freq: Counter = Counter()
    filter_val_freq: defaultdict = defaultdict(Counter)
    agg_freq: Counter = Counter()
    flag_counts: Counter = Counter()

    for sql in queries:
        tables = extract_tables(sql)
        unique_tables = list(dict.fromkeys(tables))  # dedupe, preserve order

        table_freq.update(unique_tables)

        # Table-pair combinations within one query
        pair_freq.update(combinations(sorted(set(unique_tables)), 2))

        join_type_freq.update(extract_join_types(sql))
        agg_freq.update(extract_aggregates(sql))

        for col, op in extract_filters(sql):
            filter_col_freq[col] += 1
            filter_op_freq[op] += 1
            filter_col_op_freq[f"{col}  {op}"] += 1

        for col, val in extract_filter_values(sql):
            filter_val_freq[col][val] += 1

        for flag, val in query_flags(sql).items():
            if val:
                flag_counts[flag] += 1

    # Build report
    out = [f"SQL QUERY LOG ANALYSIS  ({total} queries, DB: {db_path})"]

    # 1. Table frequency
    out.append(section("1. MOST FREQUENTLY QUERIED TABLES"))
    out.append(ranked_table(table_freq, top, "Table", "Appearances"))

    # 2. Table-pair join combinations
    out.append(section("2. MOST COMMON TABLE-PAIR COMBINATIONS"))
    pair_display = Counter({f"{a}  +  {b}": v for (a, b), v in pair_freq.items()})
    out.append(ranked_table(pair_display, top, "Table Pair", "Queries"))

    # 3. Filter columns
    out.append(section("3. MOST COMMON WHERE FILTER COLUMNS"))
    out.append(ranked_table(filter_col_freq, top, "Column", "Occurrences"))

    # 4. Column + operator
    out.append(section("4. MOST COMMON FILTER COLUMN + OPERATOR"))
    out.append(ranked_table(filter_col_op_freq, top, "Column  Operator", "Occurrences"))

    # 5. Filter operator distribution
    out.append(section("5. FILTER OPERATOR DISTRIBUTION"))
    out.append(ranked_table(filter_op_freq, top, "Operator", "Occurrences"))

    # 6. Top filter values per high-frequency column
    out.append(section("6. TOP FILTER VALUES PER COLUMN (equality filters)"))
    top_filter_cols = [col for col, _ in filter_col_freq.most_common(8)]
    for col in top_filter_cols:
        if col in filter_val_freq:
            out.append(f"\n  Column: {col}")
            out.append(ranked_table(filter_val_freq[col], 5, "Value", "Count"))

    # 7. Join type distribution
    out.append(section("7. JOIN TYPE DISTRIBUTION"))
    out.append(ranked_table(join_type_freq, top, "Join Type", "Count"))

    # 8. Aggregate function usage
    out.append(section("8. AGGREGATE FUNCTION USAGE"))
    out.append(ranked_table(agg_freq, top, "Function", "Occurrences"))

    # 9. Query structure breakdown
    out.append(section("9. QUERY STRUCTURE BREAKDOWN"))
    flag_labels = {
        "has_join":       "Has JOIN",
        "has_where":      "Has WHERE",
        "has_group_by":   "Has GROUP BY",
        "has_order_by":   "Has ORDER BY",
        "has_having":     "Has HAVING",
        "has_limit":      "Has LIMIT",
        "has_subquery":   "Has subquery",
        "has_cte":        "Has CTE (WITH)",
        "has_distinct":   "Has DISTINCT",
        "is_select_star": "SELECT *",
    }
    lines = [f"  {'Feature':<30} {'Count':>7}  {'%':>6}"]
    lines.append("  " + "-" * 48)
    for flag, label in flag_labels.items():
        count = flag_counts[flag]
        pct = 100.0 * count / total
        lines.append(f"  {label:<30} {count:>7}  {pct:>5.1f}%")
    out.append("\n".join(lines))

    out.append("\n")
    return "\n".join(out)


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description="Analyze SQL queries in parsed_query_logs.db")
    p.add_argument("--db", type=Path, default=DB_PATH)
    p.add_argument("--top", type=int, default=10, help="Top-N rows per section")
    p.add_argument("--out", type=Path, default=None, help="Optional file to write report to")
    return p.parse_args()


if __name__ == "__main__":
    args = parse_args()
    report = analyze(args.db, args.top)
    print(report)
    if args.out:
        args.out.write_text(report, encoding="utf-8")
        print(f"Report saved → {args.out}")
