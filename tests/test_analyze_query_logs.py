"""
Tests for scripts/analyze_query_logs.py

Covers:
  - extract_tables()
  - extract_join_types()
  - extract_filters()
  - extract_filter_values()
  - extract_aggregates()
  - query_flags()
"""

import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).parent.parent / "scripts"))

from analyze_query_logs import (
    extract_aggregates,
    extract_filter_values,
    extract_filters,
    extract_join_types,
    extract_tables,
    query_flags,
)


# ---------------------------------------------------------------------------
# extract_tables
# ---------------------------------------------------------------------------

class TestExtractTables:
    def test_single_from(self):
        sql = "SELECT x FROM ATOM_ENTITY_INVESTOR_PROFILE_001"
        assert extract_tables(sql) == ["ATOM_ENTITY_INVESTOR_PROFILE_001"]

    def test_join_adds_second_table(self):
        sql = (
            "SELECT h.x, p.y "
            "FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h "
            "JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id"
        )
        tables = extract_tables(sql)
        assert "ATOM_ENTITY_PORTFOLIO_HOLDING_001" in tables
        assert "ATOM_ENTITY_INVESTOR_PROFILE_001" in tables

    def test_three_tables(self):
        sql = (
            "SELECT * FROM A "
            "JOIN B ON A.id = B.id "
            "JOIN C ON B.id = C.id"
        )
        assert len(extract_tables(sql)) == 3

    def test_case_insensitive_from(self):
        sql = "select x from MYTABLE"
        assert "MYTABLE" in extract_tables(sql)

    def test_no_tables_returns_empty(self):
        assert extract_tables("SELECT 1 + 1") == []


# ---------------------------------------------------------------------------
# extract_join_types
# ---------------------------------------------------------------------------

class TestExtractJoinTypes:
    def test_plain_join(self):
        sql = "SELECT * FROM A JOIN B ON A.id = B.id"
        assert "JOIN" in extract_join_types(sql)

    def test_left_join(self):
        sql = "SELECT * FROM A LEFT JOIN B ON A.id = B.id"
        result = extract_join_types(sql)
        assert any("LEFT" in j for j in result)

    def test_inner_join(self):
        sql = "SELECT * FROM A INNER JOIN B ON A.id = B.id"
        result = extract_join_types(sql)
        assert any("INNER" in j for j in result)

    def test_no_join(self):
        sql = "SELECT x FROM T WHERE y = 1"
        assert extract_join_types(sql) == []

    def test_multiple_joins(self):
        sql = "SELECT * FROM A JOIN B ON A.id = B.id JOIN C ON B.id = C.id"
        assert len(extract_join_types(sql)) == 2


# ---------------------------------------------------------------------------
# extract_filters
# ---------------------------------------------------------------------------

class TestExtractFilters:
    def test_equality_filter(self):
        sql = "SELECT x FROM T WHERE investor_id = 'INV-001'"
        filters = extract_filters(sql)
        cols = [col for col, _ in filters]
        assert "INVESTOR_ID" in cols

    def test_multiple_filters(self):
        # Use column names that don't start with SQL operator keywords (IN, IS, LIKE…)
        # to avoid regex false-positive matches inside identifier names.
        sql = "SELECT x FROM T WHERE risk_tolerance = 'Aggressive' AND purchase_date < '2022-01-01'"
        filters = extract_filters(sql)
        cols = [col for col, _ in filters]
        assert "RISK_TOLERANCE" in cols
        assert "PURCHASE_DATE" in cols

    def test_operator_captured(self):
        sql = "SELECT x FROM T WHERE purchase_date < '2022-01-01'"
        filters = extract_filters(sql)
        ops = [op for _, op in filters]
        assert "<" in ops

    def test_like_operator(self):
        sql = "SELECT x FROM T WHERE investment_name LIKE '%Gold%'"
        filters = extract_filters(sql)
        ops = [op for _, op in filters]
        assert "LIKE" in ops

    def test_no_where_returns_empty(self):
        sql = "SELECT x FROM T GROUP BY x"
        assert extract_filters(sql) == []

    def test_subquery_in_where_not_confused(self):
        sql = (
            "SELECT x FROM T "
            "WHERE date > (SELECT MAX(date) FROM T2)"
        )
        filters = extract_filters(sql)
        cols = [col for col, _ in filters]
        # 'date' should be captured; MAX, SELECT etc. should not
        assert "DATE" in cols
        assert "SELECT" not in cols


# ---------------------------------------------------------------------------
# extract_filter_values
# ---------------------------------------------------------------------------

class TestExtractFilterValues:
    def test_string_value_extracted(self):
        sql = "SELECT x FROM T WHERE risk_tolerance = 'Aggressive'"
        vals = extract_filter_values(sql)
        assert ("RISK_TOLERANCE", "Aggressive") in vals

    def test_multiple_equality_values(self):
        sql = "SELECT x FROM T WHERE type = 'Dividend' AND investor_id = 'INV-003'"
        vals = extract_filter_values(sql)
        cols = [c for c, _ in vals]
        assert "TYPE" in cols
        assert "INVESTOR_ID" in cols

    def test_non_equality_operators_excluded(self):
        sql = "SELECT x FROM T WHERE amount > 1000"
        vals = extract_filter_values(sql)
        # '>' is not equality, should not appear
        assert not any(c == "AMOUNT" for c, _ in vals)

    def test_no_where_returns_empty(self):
        sql = "SELECT COUNT(*) FROM T"
        assert extract_filter_values(sql) == []


# ---------------------------------------------------------------------------
# extract_aggregates
# ---------------------------------------------------------------------------

class TestExtractAggregates:
    def test_sum_detected(self):
        sql = "SELECT SUM(current_value) FROM T"
        assert "SUM" in extract_aggregates(sql)

    def test_count_star_detected(self):
        sql = "SELECT COUNT(*) FROM T"
        assert "COUNT" in extract_aggregates(sql)

    def test_avg_detected(self):
        sql = "SELECT AVG(dividends) FROM T GROUP BY category"
        assert "AVG" in extract_aggregates(sql)

    def test_multiple_aggregates(self):
        sql = "SELECT SUM(cost), AVG(dividends), COUNT(holding_id) FROM T"
        aggs = extract_aggregates(sql)
        assert "SUM" in aggs
        assert "AVG" in aggs
        assert "COUNT" in aggs

    def test_no_aggregates(self):
        sql = "SELECT investor_id FROM T WHERE risk_tolerance = 'Moderate'"
        assert extract_aggregates(sql) == []

    def test_min_max_detected(self):
        sql = "SELECT MIN(purchase_date), MAX(current_value) FROM T"
        aggs = extract_aggregates(sql)
        assert "MIN" in aggs
        assert "MAX" in aggs


# ---------------------------------------------------------------------------
# query_flags
# ---------------------------------------------------------------------------

class TestQueryFlags:
    def test_has_join(self):
        sql = "SELECT * FROM A JOIN B ON A.id = B.id"
        assert query_flags(sql)["has_join"] is True

    def test_no_join(self):
        sql = "SELECT * FROM A WHERE x = 1"
        assert query_flags(sql)["has_join"] is False

    def test_has_where(self):
        sql = "SELECT * FROM A WHERE x = 1"
        assert query_flags(sql)["has_where"] is True

    def test_no_where(self):
        sql = "SELECT COUNT(*) FROM A"
        assert query_flags(sql)["has_where"] is False

    def test_has_group_by(self):
        sql = "SELECT x, COUNT(*) FROM A GROUP BY x"
        assert query_flags(sql)["has_group_by"] is True

    def test_has_order_by(self):
        sql = "SELECT x FROM A ORDER BY x DESC"
        assert query_flags(sql)["has_order_by"] is True

    def test_has_having(self):
        sql = "SELECT x, COUNT(*) FROM A GROUP BY x HAVING COUNT(*) > 3"
        assert query_flags(sql)["has_having"] is True

    def test_has_limit(self):
        sql = "SELECT x FROM A LIMIT 10"
        assert query_flags(sql)["has_limit"] is True

    def test_has_subquery(self):
        sql = "SELECT x FROM A WHERE y = (SELECT MAX(y) FROM A)"
        assert query_flags(sql)["has_subquery"] is True

    def test_has_distinct(self):
        sql = "SELECT DISTINCT investor_id FROM T"
        assert query_flags(sql)["has_distinct"] is True

    def test_select_star(self):
        sql = "SELECT * FROM T"
        assert query_flags(sql)["is_select_star"] is True

    def test_no_flags_on_simple_query(self):
        sql = "SELECT investor_id FROM ATOM_ENTITY_INVESTOR_PROFILE_001"
        flags = query_flags(sql)
        assert flags["has_join"] is False
        assert flags["has_group_by"] is False
        assert flags["has_having"] is False
        assert flags["has_limit"] is False
