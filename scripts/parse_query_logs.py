"""
parse_query_logs.py

Parses a Redshift-style query log file and loads each entry into a SQLite DB.

Each log entry has this shape:
    -- QUERY N — <title>
    -- query_id=XXXXXX | userid=XX | start=YYYY-MM-DD HH:MM:SS | end=... | dur=XXXms | rows=XX
    <SQL text>;

Output DB schema (table: query_logs):
    id            INTEGER PRIMARY KEY
    query_num     INTEGER   -- sequential N from the log
    title         TEXT      -- human-readable description
    query_id      INTEGER
    userid        INTEGER
    start_time    TEXT      -- ISO datetime
    end_time      TEXT
    duration_ms   INTEGER
    rows_returned INTEGER
    sql_query     TEXT

Usage:
    python3 scripts/parse_query_logs.py
    python3 scripts/parse_query_logs.py --log raw_data/wealth_mgmt_atom_query_logs.sql --out raw_data/parsed_query_logs.db
"""

import argparse
import re
import sqlite3
from pathlib import Path

LOG_PATH = Path("raw_data/wealth_mgmt_atom_query_logs.sql")
DB_PATH = Path("raw_data/parsed_query_logs.db")

# -- QUERY 7 — Some title text
TITLE_RE = re.compile(r"^--\s+QUERY\s+(\d+)\s+[—\-]+\s+(.*)", re.UNICODE)

# -- query_id=200001 | userid=95 | start=... | end=... | dur=563ms | rows=183
META_RE = re.compile(
    r"query_id=(\d+)"
    r"\s*\|\s*userid=(\d+)"
    r"\s*\|\s*start=([\d\- :]+)"
    r"\s*\|\s*end=([\d\- :]+)"
    r"\s*\|\s*dur=(\d+)ms"
    r"\s*\|\s*rows=(\d+)"
)

CREATE_SQL = """
CREATE TABLE IF NOT EXISTS query_logs (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    query_num     INTEGER,
    title         TEXT,
    query_id      INTEGER,
    userid        INTEGER,
    start_time    TEXT,
    end_time      TEXT,
    duration_ms   INTEGER,
    rows_returned INTEGER,
    sql_query     TEXT
);
"""


def parse_log(log_path: Path) -> list[dict]:
    text = log_path.read_text(encoding="utf-8")
    # Split on blank lines to get blocks; filter to non-empty
    raw_blocks = re.split(r"\n{2,}", text.strip())

    records = []
    for block in raw_blocks:
        lines = block.strip().splitlines()
        if len(lines) < 3:
            continue

        title_m = TITLE_RE.match(lines[0])
        if not title_m:
            continue

        meta_m = META_RE.search(lines[1])
        if not meta_m:
            continue

        # SQL is everything after the two comment lines, joined back together
        sql_lines = [l for l in lines[2:] if not l.strip().startswith("--")]
        sql_text = "\n".join(sql_lines).strip().rstrip(";")
        if not sql_text:
            continue

        records.append({
            "query_num":     int(title_m.group(1)),
            "title":         title_m.group(2).strip(),
            "query_id":      int(meta_m.group(1)),
            "userid":        int(meta_m.group(2)),
            "start_time":    meta_m.group(3).strip(),
            "end_time":      meta_m.group(4).strip(),
            "duration_ms":   int(meta_m.group(5)),
            "rows_returned": int(meta_m.group(6)),
            "sql_query":     sql_text,
        })

    return records


def load_to_db(records: list[dict], db_path: Path) -> None:
    db_path.parent.mkdir(parents=True, exist_ok=True)
    con = sqlite3.connect(db_path)
    con.execute(CREATE_SQL)
    con.execute("DELETE FROM query_logs;")  # idempotent re-run

    con.executemany(
        """
        INSERT INTO query_logs
            (query_num, title, query_id, userid, start_time, end_time,
             duration_ms, rows_returned, sql_query)
        VALUES
            (:query_num, :title, :query_id, :userid, :start_time, :end_time,
             :duration_ms, :rows_returned, :sql_query)
        """,
        records,
    )
    con.commit()
    con.close()


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description="Parse query log file into SQLite DB")
    p.add_argument("--log", type=Path, default=LOG_PATH)
    p.add_argument("--out", type=Path, default=DB_PATH)
    return p.parse_args()


if __name__ == "__main__":
    args = parse_args()
    records = parse_log(args.log)
    load_to_db(records, args.out)
    print(f"Parsed {len(records)} entries → {args.out}")
