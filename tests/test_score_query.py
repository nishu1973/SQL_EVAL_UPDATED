"""
Tests for scripts/score_query.py

Covers:
  - SQL normalisation and tokenisation
  - parse_query() structural extraction
  - Jaccard similarity helpers
  - _structural_features()
  - score_probability() with a hand-crafted stats dict
  - score_near_match() corpus comparison
"""

import sys
from collections import Counter
from pathlib import Path

import pytest

# Allow importing scripts as modules
sys.path.insert(0, str(Path(__file__).parent.parent / "scripts"))

from score_query import (
    QueryInfo,
    NearMatchReport,
    _jaccard,
    _normalize_sql,
    _sql_token_set,
    _struct_similarity,
    _structural_features,
    parse_query,
    score_near_match,
    score_probability,
)


# ---------------------------------------------------------------------------
# Fixtures
# ---------------------------------------------------------------------------

SINGLE_TABLE_SQL = (
    "SELECT investment_type, AVG(dividends) "
    "FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 "
    "WHERE investor_id = 'INV-001' "
    "GROUP BY investment_type"
)

JOIN_SQL = (
    "SELECT p.investor_name, SUM(h.current_value) "
    "FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h "
    "JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id "
    "WHERE h.investment_type = 'Mutual Fund' "
    "GROUP BY p.investor_name"
)

THREE_TABLE_SQL = (
    "SELECT p.investor_name, g.investment_goal "
    "FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h "
    "JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id "
    "JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON p.investor_id = g.investor_id "
    "WHERE g.investment_goal = 'Retirement Planning'"
)

COUNT_STAR_SQL = (
    "SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 "
    "WHERE purchase_date < '2022-01-01'"
)


@pytest.fixture
def minimal_stats():
    """Hand-crafted per-table stats that mirror real-world shapes."""
    return {
        "ATOM_ENTITY_PORTFOLIO_HOLDING_001": {
            "query_count": 500,
            "select_cols": Counter({
                "CURRENT_VALUE": 90, "INVESTMENT_TYPE": 80,
                "INVESTMENT_NAME": 70, "COST": 60,
                "INVESTOR_ID": 60, "DIVIDENDS": 45,
            }),
            "where_cols": Counter({
                "INVESTOR_ID": 90, "INVESTMENT_TYPE": 24,
                "PURCHASE_DATE": 45, "CATEGORY": 30,
            }),
            "where_ops": Counter({"=": 160, "LIKE": 40, "<": 15}),
            "where_col_ops": {
                "INVESTOR_ID":     Counter({"=": 90}),
                "INVESTMENT_TYPE": Counter({"=": 24}),
                "PURCHASE_DATE":   Counter({"<": 15, "BETWEEN": 10}),
            },
            "agg_fns": Counter({"SUM": 230, "AVG": 95, "COUNT": 20}),
            "agg_on_col": {
                "SUM": Counter({"CURRENT_VALUE": 105, "COST": 55, "DIVIDENDS": 35}),
                "AVG": Counter({"TAXES_PAID": 30, "DIVIDENDS": 15}),
                "COUNT": Counter({"HOLDING_ID": 5}),
            },
            "groupby_cols": Counter({"INVESTMENT_TYPE": 70, "INVESTOR_ID": 65}),
            "join_keys":    Counter({"INVESTOR_ID": 210}),
            "join_partners": Counter({"ATOM_ENTITY_INVESTOR_PROFILE_001": 110}),
        },
        "ATOM_ENTITY_INVESTOR_PROFILE_001": {
            "query_count": 260,
            "select_cols": Counter({
                "INVESTOR_NAME": 85, "RISK_TOLERANCE": 40,
                "SECTOR_FOCUS": 25, "INVESTOR_ID": 15,
            }),
            "where_cols": Counter({
                "RISK_TOLERANCE": 80, "INVESTOR_ID": 20,
            }),
            "where_ops": Counter({"=": 120}),
            "where_col_ops": {
                "RISK_TOLERANCE": Counter({"=": 80}),
                "INVESTOR_ID":    Counter({"=": 20}),
            },
            "agg_fns": Counter({"COUNT": 5, "AVG": 5}),
            "agg_on_col": {
                "COUNT": Counter({"INVESTOR_ID": 5}),
                "AVG":   Counter({"TIME_HORIZON": 5}),
            },
            "groupby_cols": Counter({"RISK_TOLERANCE": 25, "INVESTOR_ID": 20}),
            "join_keys":    Counter({"INVESTOR_ID": 425}),
            "join_partners": Counter({"ATOM_ENTITY_PORTFOLIO_HOLDING_001": 110}),
        },
    }


# ---------------------------------------------------------------------------
# _normalize_sql
# ---------------------------------------------------------------------------

class TestNormalizeSql:
    def test_string_literals_replaced(self):
        out = _normalize_sql("WHERE investor_id = 'INV-001'")
        assert "'INV-001'" not in out
        assert "_STR_" in out

    def test_investor_ids_replaced(self):
        out = _normalize_sql("WHERE investor_id = 'INV-042'")
        assert "INV-042" not in out

    def test_date_literals_replaced(self):
        # Quoted dates are absorbed by the _STR_ pass (runs first).
        # Bare dates in numeric context get _DATE_.
        out_quoted = _normalize_sql("WHERE purchase_date < '2022-01-01'")
        assert "2022-01-01" not in out_quoted
        assert "_STR_" in out_quoted          # quoted date -> _STR_

        out_bare = _normalize_sql("WHERE year > 2022-01-01")
        assert "2022" not in out_bare         # bare date fragments -> _DATE_ or _NUM_

    def test_numeric_literals_replaced(self):
        out = _normalize_sql("WHERE amount > 50000")
        assert "50000" not in out
        assert "_NUM_" in out

    def test_table_names_preserved(self):
        out = _normalize_sql("FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001")
        assert "ATOM_ENTITY_PORTFOLIO_HOLDING_001" in out

    def test_column_names_preserved(self):
        out = _normalize_sql("SELECT investor_id, current_value")
        assert "INVESTOR_ID" in out
        assert "CURRENT_VALUE" in out


# ---------------------------------------------------------------------------
# _sql_token_set
# ---------------------------------------------------------------------------

class TestSqlTokenSet:
    def test_returns_frozenset(self):
        result = _sql_token_set(SINGLE_TABLE_SQL)
        assert isinstance(result, frozenset)

    def test_table_name_in_tokens(self):
        tokens = _sql_token_set(SINGLE_TABLE_SQL)
        assert "ATOM_ENTITY_PORTFOLIO_HOLDING_001" in tokens

    def test_literals_normalised_away(self):
        t1 = _sql_token_set("SELECT * FROM T WHERE x = 'INV-001'")
        t2 = _sql_token_set("SELECT * FROM T WHERE x = 'INV-099'")
        assert t1 == t2

    def test_identical_queries_full_overlap(self):
        s = _sql_token_set(SINGLE_TABLE_SQL)
        assert _jaccard(s, s) == 1.0

    def test_different_queries_partial_overlap(self):
        s1 = _sql_token_set(SINGLE_TABLE_SQL)
        s2 = _sql_token_set(JOIN_SQL)
        j = _jaccard(s1, s2)
        assert 0.0 < j < 1.0


# ---------------------------------------------------------------------------
# _jaccard
# ---------------------------------------------------------------------------

class TestJaccard:
    def test_identical_sets(self):
        s = frozenset(["a", "b", "c"])
        assert _jaccard(s, s) == 1.0

    def test_disjoint_sets(self):
        a = frozenset(["a", "b"])
        b = frozenset(["c", "d"])
        assert _jaccard(a, b) == 0.0

    def test_partial_overlap(self):
        a = frozenset(["a", "b", "c"])
        b = frozenset(["b", "c", "d"])
        assert _jaccard(a, b) == pytest.approx(2 / 4)

    def test_both_empty(self):
        assert _jaccard(frozenset(), frozenset()) == 1.0

    def test_one_empty(self):
        a = frozenset(["x"])
        assert _jaccard(a, frozenset()) == 0.0


# ---------------------------------------------------------------------------
# parse_query
# ---------------------------------------------------------------------------

class TestParseQuery:
    def test_single_table_detected(self):
        info = parse_query(SINGLE_TABLE_SQL)
        assert "ATOM_ENTITY_PORTFOLIO_HOLDING_001" in info.tables
        assert len(info.tables) == 1

    def test_two_tables_detected(self):
        info = parse_query(JOIN_SQL)
        assert len(info.tables) == 2
        assert "ATOM_ENTITY_PORTFOLIO_HOLDING_001" in info.tables
        assert "ATOM_ENTITY_INVESTOR_PROFILE_001" in info.tables

    def test_three_tables_detected(self):
        info = parse_query(THREE_TABLE_SQL)
        assert len(info.tables) == 3

    def test_join_pair_extracted(self):
        info = parse_query(JOIN_SQL)
        assert len(info.join_pairs) == 1
        pair = set(info.join_pairs[0])
        assert "ATOM_ENTITY_PORTFOLIO_HOLDING_001" in pair
        assert "ATOM_ENTITY_INVESTOR_PROFILE_001" in pair

    def test_three_table_join_pairs(self):
        info = parse_query(THREE_TABLE_SQL)
        assert len(info.join_pairs) == 3  # C(3,2)

    def test_aggregation_extracted(self):
        info = parse_query(JOIN_SQL)
        fns = [fn for fn, _ in info.agg_pairs]
        assert "SUM" in fns

    def test_agg_column_extracted(self):
        info = parse_query(JOIN_SQL)
        cols = [col for _, col in info.agg_pairs]
        assert any("CURRENT_VALUE" in c for c in cols)

    def test_groupby_cols_extracted(self):
        info = parse_query(SINGLE_TABLE_SQL)
        assert "INVESTMENT_TYPE" in info.groupby_cols

    def test_aliases_mapped(self):
        info = parse_query(JOIN_SQL)
        # h -> HOLDING, p -> PROFILE
        assert "H" in info.aliases or "ATOM_ENTITY_PORTFOLIO_HOLDING_001" in info.aliases.values()

    def test_aliased_select_cols_attributed(self):
        info = parse_query(JOIN_SQL)
        profile_cols = info.select_cols.get("ATOM_ENTITY_INVESTOR_PROFILE_001", [])
        assert "INVESTOR_NAME" in profile_cols

    def test_where_cols_single_table(self):
        info = parse_query(SINGLE_TABLE_SQL)
        holding_cols = info.where_cols.get("ATOM_ENTITY_PORTFOLIO_HOLDING_001", [])
        assert "INVESTOR_ID" in holding_cols

    def test_where_ops_extracted(self):
        info = parse_query(SINGLE_TABLE_SQL)
        ops = [op for _, op in info.where_ops]
        assert "=" in ops

    def test_join_keys_extracted(self):
        info = parse_query(JOIN_SQL)
        holding_keys = info.join_keys.get("ATOM_ENTITY_PORTFOLIO_HOLDING_001", [])
        assert "INVESTOR_ID" in holding_keys

    def test_count_star_no_crash(self):
        info = parse_query(COUNT_STAR_SQL)
        assert "ATOM_ENTITY_PORTFOLIO_HOLDING_001" in info.tables


# ---------------------------------------------------------------------------
# _structural_features
# ---------------------------------------------------------------------------

class TestStructuralFeatures:
    def test_tables_in_features(self):
        info = parse_query(JOIN_SQL)
        feats = _structural_features(info)
        assert "ATOM_ENTITY_PORTFOLIO_HOLDING_001" in feats["tables"]
        assert "ATOM_ENTITY_INVESTOR_PROFILE_001" in feats["tables"]

    def test_join_pair_in_features(self):
        info = parse_query(JOIN_SQL)
        feats = _structural_features(info)
        expected = frozenset(["ATOM_ENTITY_PORTFOLIO_HOLDING_001",
                               "ATOM_ENTITY_INVESTOR_PROFILE_001"])
        assert expected in feats["join_pairs"]

    def test_agg_pair_in_features(self):
        info = parse_query(JOIN_SQL)
        feats = _structural_features(info)
        assert any("SUM" in s for s in feats["agg_pairs"])

    def test_has_join_clause_flag(self):
        info = parse_query(JOIN_SQL)
        feats = _structural_features(info)
        assert "HAS_JOIN" in feats["clauses"]

    def test_no_join_flag_for_single_table(self):
        info = parse_query(SINGLE_TABLE_SQL)
        feats = _structural_features(info)
        assert "HAS_JOIN" not in feats["clauses"]

    def test_identical_queries_score_1(self):
        fa = _structural_features(parse_query(JOIN_SQL))
        fb = _structural_features(parse_query(JOIN_SQL))
        assert _struct_similarity(fa, fb) == pytest.approx(1.0)

    def test_disjoint_tables_score_low(self):
        sql_a = "SELECT x FROM TABLE_A WHERE y = 1"
        sql_b = "SELECT p FROM TABLE_B WHERE q = 2"
        fa = _structural_features(parse_query(sql_a))
        fb = _structural_features(parse_query(sql_b))
        assert _struct_similarity(fa, fb) < 0.5


# ---------------------------------------------------------------------------
# score_probability
# ---------------------------------------------------------------------------

class TestScoreProbability:
    def test_known_query_high_table_score(self, minimal_stats):
        info = parse_query(JOIN_SQL)
        report = score_probability(info, minimal_stats)
        assert report.table_familiarity.score == pytest.approx(1.0)

    def test_unknown_table_zero_familiarity(self, minimal_stats):
        info = parse_query("SELECT x FROM TOTALLY_UNKNOWN_TABLE WHERE y = 1")
        report = score_probability(info, minimal_stats)
        assert report.table_familiarity.score == pytest.approx(0.0)

    def test_known_join_high_score(self, minimal_stats):
        info = parse_query(JOIN_SQL)
        report = score_probability(info, minimal_stats)
        assert report.join_pattern.score == pytest.approx(1.0)

    def test_unknown_join_zero_score(self, minimal_stats):
        sql = (
            "SELECT x FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h "
            "JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON h.investor_id = g.investor_id"
        )
        info = parse_query(sql)
        report = score_probability(info, minimal_stats)
        # INVESTMENT_GOAL_001 not in minimal_stats join_partners
        assert report.join_pattern.score < 0.5

    def test_no_joins_full_join_score(self, minimal_stats):
        info = parse_query(SINGLE_TABLE_SQL)
        report = score_probability(info, minimal_stats)
        assert report.join_pattern.score == pytest.approx(1.0)

    def test_top_column_high_coverage(self, minimal_stats):
        # Use no alias so the alias token doesn't pollute the column list.
        sql = "SELECT investor_name FROM ATOM_ENTITY_INVESTOR_PROFILE_001"
        info = parse_query(sql)
        report = score_probability(info, minimal_stats)
        assert report.column_coverage.score == pytest.approx(1.0)

    def test_unseen_column_lowers_coverage(self, minimal_stats):
        sql = (
            "SELECT never_used_col "
            "FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 "
            "WHERE never_used_col = 'x'"
        )
        info = parse_query(sql)
        report = score_probability(info, minimal_stats)
        assert report.column_coverage.score < 0.5

    def test_known_filter_col_high_score(self, minimal_stats):
        # Use a numeric value so no extra identifier tokens leak from the literal.
        sql = (
            "SELECT investment_type "
            "FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 "
            "WHERE investor_id = 42"
        )
        info = parse_query(sql)
        report = score_probability(info, minimal_stats)
        assert report.filter_familiarity.score == pytest.approx(1.0)

    def test_known_agg_high_score(self, minimal_stats):
        sql = (
            "SELECT SUM(current_value) "
            "FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001"
        )
        info = parse_query(sql)
        report = score_probability(info, minimal_stats)
        assert report.aggregation_pattern.score == pytest.approx(1.0)

    def test_overall_between_0_and_1(self, minimal_stats):
        info = parse_query(JOIN_SQL)
        report = score_probability(info, minimal_stats)
        assert 0.0 <= report.overall <= 1.0

    def test_detail_list_populated(self, minimal_stats):
        info = parse_query(JOIN_SQL)
        report = score_probability(info, minimal_stats)
        assert len(report.table_familiarity.detail) > 0


# ---------------------------------------------------------------------------
# score_near_match
# ---------------------------------------------------------------------------

class TestScoreNearMatch:
    def _make_corpus_entry(self, sql: str) -> dict:
        from score_query import _structural_features, _sql_token_set
        info = parse_query(sql)
        return {
            "query_num":  1,
            "query_id":   100001,
            "title":      "test query",
            "start_time": "2026-01-01 09:00:00",
            "sql":        sql,
            "features":   _structural_features(info),
            "token_set":  _sql_token_set(sql),
        }

    def test_exact_match_score_1(self):
        corpus = [self._make_corpus_entry(JOIN_SQL)]
        info = parse_query(JOIN_SQL)
        report = score_near_match(JOIN_SQL, info, corpus, top_n=1)
        assert report.best_score == pytest.approx(1.0)

    def test_empty_corpus_returns_zero(self):
        info = parse_query(JOIN_SQL)
        report = score_near_match(JOIN_SQL, info, [], top_n=5)
        assert report.best_score == 0.0
        assert report.top_hits == []

    def test_top_n_respected(self):
        corpus = [self._make_corpus_entry(JOIN_SQL)] * 10
        info = parse_query(JOIN_SQL)
        report = score_near_match(JOIN_SQL, info, corpus, top_n=3)
        assert len(report.top_hits) == 3

    def test_hits_sorted_descending(self):
        corpus = [
            self._make_corpus_entry(JOIN_SQL),
            self._make_corpus_entry(COUNT_STAR_SQL),
            self._make_corpus_entry(SINGLE_TABLE_SQL),
        ]
        info = parse_query(JOIN_SQL)
        report = score_near_match(JOIN_SQL, info, corpus, top_n=3)
        scores = [h.combined for h in report.top_hits]
        assert scores == sorted(scores, reverse=True)

    def test_value_change_same_structure_still_high(self):
        # Only the WHERE value differs — structural score should be 1.0
        sql_a = "SELECT x FROM T WHERE investor_id = 'INV-001'"
        sql_b = "SELECT x FROM T WHERE investor_id = 'INV-099'"
        corpus = [self._make_corpus_entry(sql_a)]
        info = parse_query(sql_b)
        report = score_near_match(sql_b, info, corpus, top_n=1)
        assert report.top_hits[0].struct_score == pytest.approx(1.0)

    def test_completely_different_query_low_score(self):
        corpus = [self._make_corpus_entry(
            "SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 "
            "WHERE type = 'Dividend'"
        )]
        info = parse_query(
            "SELECT risk_tolerance FROM ATOM_ENTITY_INVESTOR_PROFILE_001 "
            "GROUP BY risk_tolerance"
        )
        report = score_near_match(
            "SELECT risk_tolerance FROM ATOM_ENTITY_INVESTOR_PROFILE_001 GROUP BY risk_tolerance",
            info, corpus, top_n=1,
        )
        assert report.best_score < 0.5

    def test_match_hit_fields_populated(self):
        corpus = [self._make_corpus_entry(JOIN_SQL)]
        info = parse_query(JOIN_SQL)
        report = score_near_match(JOIN_SQL, info, corpus, top_n=1)
        h = report.top_hits[0]
        assert h.query_id == 100001
        assert h.sql == JOIN_SQL
        assert 0.0 <= h.struct_score <= 1.0
        assert 0.0 <= h.token_score <= 1.0
        assert h.combined == pytest.approx(0.65 * h.struct_score + 0.35 * h.token_score)

    def test_mean_top5_equals_mean_of_scores(self):
        corpus = [self._make_corpus_entry(JOIN_SQL)] * 5
        info = parse_query(JOIN_SQL)
        report = score_near_match(JOIN_SQL, info, corpus, top_n=5)
        expected_mean = sum(h.combined for h in report.top_hits) / 5
        assert report.mean_top5 == pytest.approx(expected_mean)
