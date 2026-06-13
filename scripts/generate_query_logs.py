"""
generate_query_logs.py

Reads sql_query rows from ground_truth_wealth_management_diverse.db and emits
a synthetic Redshift-style query log file (STL_QUERY / SVL_QLOG format).

Output: raw_data/wealth_mgmt_atom_query_logs.sql

Usage:
    python scripts/generate_query_logs.py
    python scripts/generate_query_logs.py --start-date 2026-01-01 --end-date 2026-06-12 --out raw_data/my_logs.sql
"""

import argparse
import math
import random
import re
import sqlite3
from datetime import datetime, timedelta
from pathlib import Path

# ---------------------------------------------------------------------------
# Config defaults
# ---------------------------------------------------------------------------
DB_PATH = Path("raw_data/ground_truth_wealth_management_diverse.db")
DEFAULT_OUT = Path("raw_data/wealth_mgmt_atom_query_logs.sql")
START_DATE = datetime(2026, 1, 1)
END_DATE = datetime(2026, 6, 12)

# Synthetic user pool (analyst / advisor / data-eng roles)
USER_POOL = [12, 18, 23, 30, 42, 55, 68, 74, 81, 95]

# Base query_id (Redshift-style large integers)
BASE_QUERY_ID = 200_000

# Business hours window (local exchange time)
HOUR_START = 7
HOUR_END = 20


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def count_keyword(sql: str, *keywords: str) -> int:
    pattern = r"\b(" + "|".join(keywords) + r")\b"
    return len(re.findall(pattern, sql, re.IGNORECASE))


def estimate_duration_ms(sql: str) -> int:
    """Heuristic: more joins / CTEs / GROUP BY → longer runtime."""
    base = random.randint(300, 800)
    base += count_keyword(sql, "JOIN", "LEFT JOIN", "RIGHT JOIN", "FULL JOIN") * random.randint(200, 600)
    base += count_keyword(sql, "WITH") * random.randint(400, 900)
    base += count_keyword(sql, "GROUP BY") * random.randint(150, 400)
    base += count_keyword(sql, "ORDER BY") * random.randint(80, 200)
    base += count_keyword(sql, "HAVING") * random.randint(100, 250)
    base += count_keyword(sql, "SUBQUERY", "SELECT") * random.randint(50, 150)
    # Add some noise
    jitter = random.gauss(0, base * 0.15)
    return max(100, int(base + jitter))


def estimate_rows(sql: str) -> int:
    """Heuristic: aggregations / LIMIT return fewer rows than full scans."""
    sql_upper = sql.upper()
    if re.search(r"\bLIMIT\s+(\d+)", sql_upper):
        m = re.search(r"\bLIMIT\s+(\d+)", sql_upper)
        return int(m.group(1))
    if re.search(r"\bCOUNT\s*\(|AVG\s*\(|SUM\s*\(|MAX\s*\(|MIN\s*\(", sql_upper):
        if "GROUP BY" not in sql_upper:
            return 1
        return random.randint(2, 30)
    if "GROUP BY" in sql_upper:
        return random.randint(3, 60)
    if "JOIN" in sql_upper:
        return random.randint(5, 500)
    return random.randint(1, 200)


def random_business_timestamp(start: datetime, end: datetime) -> datetime:
    """Pick a random weekday timestamp within business hours."""
    while True:
        delta = end - start
        rand_seconds = random.randint(0, int(delta.total_seconds()))
        candidate = start + timedelta(seconds=rand_seconds)
        if candidate.weekday() < 5 and HOUR_START <= candidate.hour < HOUR_END:
            return candidate.replace(microsecond=0)


def derive_title(question: str, sql: str) -> str:
    """Use the question if available; fall back to a SQL-derived summary."""
    if question and question.strip():
        # Trim to a reasonable header length
        title = question.strip().rstrip("?").strip()
        return title[:120] if len(title) > 120 else title
    # Fallback: extract first table name
    m = re.search(r"\bFROM\s+(\w+)", sql, re.IGNORECASE)
    return m.group(1) if m else "ad-hoc query"


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def generate(db_path: Path, out_path: Path, start: datetime, end: datetime) -> None:
    con = sqlite3.connect(db_path)
    rows = con.execute(
        "SELECT id, question, sql_query FROM query_results ORDER BY id"
    ).fetchall()
    con.close()

    # Sort timestamps so the log reads chronologically
    timestamps = sorted(
        [random_business_timestamp(start, end) for _ in rows]
    )

    lines: list[str] = []

    header = f"""\
-- =============================================================================
-- SYNTHETIC REDSHIFT QUERY LOGS — WEALTH MANAGEMENT (ATOM SCHEMA)
-- Generated: {datetime.now().strftime("%Y-%m-%d")}
-- Environment: NeoSapients / Wealth AI Insights Platform
-- Cluster: neos-wealth-prod-rs-01  |  Database: wealthdb
-- Source: ground_truth_wealth_management_diverse.db  ({len(rows)} queries)
-- Note: All data is synthetic. No real client, account, or advisor information.
-- =============================================================================
--
-- LOG FORMAT (emulated from STL_QUERY / SVL_QLOG):
--   query_id | userid | starttime            | endtime              | duration_ms | rows_returned | query_text
--
"""
    lines.append(header)

    for i, ((row_id, question, sql_query), ts) in enumerate(
        zip(rows, timestamps), start=1
    ):
        query_id = BASE_QUERY_ID + i
        userid = random.choice(USER_POOL)
        duration_ms = estimate_duration_ms(sql_query)
        rows_returned = estimate_rows(sql_query)
        end_ts = ts + timedelta(milliseconds=duration_ms)
        title = derive_title(question, sql_query)

        sql_clean = sql_query.strip().rstrip(";")

        block = (
            f"-- QUERY {i} — {title}\n"
            f"-- query_id={query_id}"
            f" | userid={userid}"
            f" | start={ts.strftime('%Y-%m-%d %H:%M:%S')}"
            f" | end={end_ts.strftime('%Y-%m-%d %H:%M:%S')}"
            f" | dur={duration_ms}ms"
            f" | rows={rows_returned}\n"
            f"{sql_clean};\n"
        )
        lines.append(block)

    footer = (
        "\n-- =============================================================================\n"
        f"-- END OF SYNTHETIC QUERY LOG\n"
        f"-- Total queries: {len(rows)}\n"
        "-- =============================================================================\n"
    )
    lines.append(footer)

    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text("\n".join(lines), encoding="utf-8")
    print(f"Wrote {len(rows)} query log entries → {out_path}")


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description="Generate Redshift-style query log from ground-truth DB")
    p.add_argument("--db", type=Path, default=DB_PATH)
    p.add_argument("--out", type=Path, default=DEFAULT_OUT)
    p.add_argument("--start-date", default=START_DATE.strftime("%Y-%m-%d"))
    p.add_argument("--end-date", default=END_DATE.strftime("%Y-%m-%d"))
    p.add_argument("--seed", type=int, default=42, help="Random seed for reproducibility")
    return p.parse_args()


if __name__ == "__main__":
    args = parse_args()
    random.seed(args.seed)
    generate(
        db_path=args.db,
        out_path=args.out,
        start=datetime.strptime(args.start_date, "%Y-%m-%d"),
        end=datetime.strptime(args.end_date, "%Y-%m-%d"),
    )
