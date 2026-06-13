"""
Tests for scripts/parse_query_logs.py

Covers:
  - parse_log() metadata and SQL extraction
  - load_to_db() round-trip persistence
"""

import sqlite3
import sys
import tempfile
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).parent.parent / "scripts"))

from parse_query_logs import load_to_db, parse_log


# ---------------------------------------------------------------------------
# Fixtures
# ---------------------------------------------------------------------------

SAMPLE_LOG = """\
-- =============================================================================
-- SYNTHETIC REDSHIFT QUERY LOGS
-- =============================================================================
--
-- LOG FORMAT:
--   query_id | userid | starttime | endtime | duration_ms | rows_returned | query_text
--

-- QUERY 1 — What is the investment time horizon for investor INV002
-- query_id=200001 | userid=95 | start=2026-01-01 07:17:25 | end=2026-01-01 07:17:25 | dur=563ms | rows=183
SELECT time_horizon FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id = 'INV-002';

-- QUERY 2 — Please provide the liquidity score for investor INV003
-- query_id=200002 | userid=42 | start=2026-01-02 09:05:10 | end=2026-01-02 09:05:11 | dur=1240ms | rows=1
SELECT liquidity_score FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 WHERE investor_id = 'INV-003';

-- QUERY 3 — Total portfolio value by investment type
-- query_id=200003 | userid=30 | start=2026-01-03 14:30:00 | end=2026-01-03 14:30:04 | dur=3820ms | rows=6
SELECT investment_type, SUM(current_value)
FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001
GROUP BY investment_type
ORDER BY SUM(current_value) DESC;
"""


@pytest.fixture
def log_file(tmp_path: Path) -> Path:
    p = tmp_path / "test_log.sql"
    p.write_text(SAMPLE_LOG, encoding="utf-8")
    return p


@pytest.fixture
def parsed_records(log_file: Path) -> list[dict]:
    return parse_log(log_file)


# ---------------------------------------------------------------------------
# parse_log
# ---------------------------------------------------------------------------

class TestParseLog:
    def test_correct_record_count(self, parsed_records):
        assert len(parsed_records) == 3

    def test_query_nums_sequential(self, parsed_records):
        nums = [r["query_num"] for r in parsed_records]
        assert nums == [1, 2, 3]

    def test_query_ids_extracted(self, parsed_records):
        ids = [r["query_id"] for r in parsed_records]
        assert ids == [200001, 200002, 200003]

    def test_userids_extracted(self, parsed_records):
        uids = [r["userid"] for r in parsed_records]
        assert uids == [95, 42, 30]

    def test_start_times_extracted(self, parsed_records):
        assert parsed_records[0]["start_time"] == "2026-01-01 07:17:25"
        assert parsed_records[1]["start_time"] == "2026-01-02 09:05:10"

    def test_end_times_extracted(self, parsed_records):
        assert parsed_records[0]["end_time"] == "2026-01-01 07:17:25"

    def test_durations_extracted(self, parsed_records):
        assert parsed_records[0]["duration_ms"] == 563
        assert parsed_records[1]["duration_ms"] == 1240
        assert parsed_records[2]["duration_ms"] == 3820

    def test_rows_returned_extracted(self, parsed_records):
        assert parsed_records[0]["rows_returned"] == 183
        assert parsed_records[1]["rows_returned"] == 1

    def test_titles_extracted(self, parsed_records):
        assert "investment time horizon" in parsed_records[0]["title"].lower()
        assert "liquidity score" in parsed_records[1]["title"].lower()

    def test_sql_query_extracted(self, parsed_records):
        assert "ATOM_ENTITY_INVESTOR_PROFILE_001" in parsed_records[0]["sql_query"]
        assert "SELECT time_horizon" in parsed_records[0]["sql_query"]

    def test_sql_no_trailing_semicolon(self, parsed_records):
        for r in parsed_records:
            assert not r["sql_query"].rstrip().endswith(";")

    def test_multiline_sql_preserved(self, parsed_records):
        # Query 3 spans multiple lines
        sql = parsed_records[2]["sql_query"]
        assert "SUM(current_value)" in sql
        assert "GROUP BY" in sql

    def test_empty_file_returns_empty(self, tmp_path: Path):
        empty = tmp_path / "empty.sql"
        empty.write_text("", encoding="utf-8")
        assert parse_log(empty) == []

    def test_header_only_returns_empty(self, tmp_path: Path):
        header_only = tmp_path / "header.sql"
        header_only.write_text(
            "-- ===========\n-- HEADER\n-- ===========\n", encoding="utf-8"
        )
        assert parse_log(header_only) == []


# ---------------------------------------------------------------------------
# load_to_db
# ---------------------------------------------------------------------------

class TestLoadToDb:
    def test_records_written(self, parsed_records, tmp_path: Path):
        db = tmp_path / "out.db"
        load_to_db(parsed_records, db)
        con = sqlite3.connect(str(db))
        count = con.execute("SELECT COUNT(*) FROM query_logs").fetchone()[0]
        con.close()
        assert count == 3

    def test_schema_has_expected_columns(self, parsed_records, tmp_path: Path):
        db = tmp_path / "out.db"
        load_to_db(parsed_records, db)
        con = sqlite3.connect(str(db))
        cols = {row[1] for row in con.execute("PRAGMA table_info(query_logs)")}
        con.close()
        expected = {
            "id", "query_num", "title", "query_id", "userid",
            "start_time", "end_time", "duration_ms", "rows_returned", "sql_query",
        }
        assert expected.issubset(cols)

    def test_values_round_trip(self, parsed_records, tmp_path: Path):
        db = tmp_path / "out.db"
        load_to_db(parsed_records, db)
        con = sqlite3.connect(str(db))
        row = con.execute(
            "SELECT query_num, query_id, userid, duration_ms, rows_returned "
            "FROM query_logs WHERE query_num = 1"
        ).fetchone()
        con.close()
        assert row == (1, 200001, 95, 563, 183)

    def test_idempotent_rerun(self, parsed_records, tmp_path: Path):
        db = tmp_path / "out.db"
        load_to_db(parsed_records, db)
        load_to_db(parsed_records, db)  # second run should not duplicate
        con = sqlite3.connect(str(db))
        count = con.execute("SELECT COUNT(*) FROM query_logs").fetchone()[0]
        con.close()
        assert count == 3

    def test_sql_query_stored_correctly(self, parsed_records, tmp_path: Path):
        db = tmp_path / "out.db"
        load_to_db(parsed_records, db)
        con = sqlite3.connect(str(db))
        sql = con.execute(
            "SELECT sql_query FROM query_logs WHERE query_num = 1"
        ).fetchone()[0]
        con.close()
        assert "ATOM_ENTITY_INVESTOR_PROFILE_001" in sql

    def test_creates_db_file(self, parsed_records, tmp_path: Path):
        db = tmp_path / "subdir" / "new.db"
        db.parent.mkdir(parents=True, exist_ok=True)
        load_to_db(parsed_records, db)
        assert db.exists()
