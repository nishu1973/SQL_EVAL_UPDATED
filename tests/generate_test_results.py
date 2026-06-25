"""
generate_test_results.py

Runs every test SQL query through the probability and near-match scorers
and writes human-readable + JSON results to tests/test_results/.

Usage:
    uv run python tests/generate_test_results.py
"""

from __future__ import annotations

import json
import sys
from pathlib import Path

# Allow importing from scripts/
sys.path.insert(0, str(Path(__file__).parent.parent / "scripts"))

from score_query import (
    _structural_features,
    _sql_token_set,
    consolidate,
    load_corpus,
    load_schema,
    load_stats,
    parse_query,
    score_near_match,
    score_probability,
)

DB_PATH   = Path("raw_data/parsed_query_logs.db")
OUT_DIR   = Path("tests/test_results")

# ---------------------------------------------------------------------------
# All test queries — organised by source test class
# ---------------------------------------------------------------------------

TEST_QUERIES: list[dict] = [
    # ── score_query: single-table patterns ─────────────────────────────────
    {
        "group": "Single-table / aggregation",
        "label": "AVG dividends by investment_type",
        "sql": (
            "SELECT investment_type, AVG(dividends) "
            "FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 "
            "WHERE investor_id = 'INV-001' "
            "GROUP BY investment_type"
        ),
    },
    {
        "group": "Single-table / aggregation",
        "label": "COUNT(*) holdings before 2022",
        "sql": (
            "SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 "
            "WHERE purchase_date < '2022-01-01'"
        ),
    },
    {
        "group": "Single-table / aggregation",
        "label": "SUM current_value by category",
        "sql": (
            "SELECT category, SUM(current_value) "
            "FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 "
            "GROUP BY category"
        ),
    },
    {
        "group": "Single-table / aggregation",
        "label": "Investor profile — no filter",
        "sql": "SELECT investor_name FROM ATOM_ENTITY_INVESTOR_PROFILE_001",
    },
    {
        "group": "Single-table / aggregation",
        "label": "Risk tolerance distribution",
        "sql": (
            "SELECT risk_tolerance, COUNT(*) "
            "FROM ATOM_ENTITY_INVESTOR_PROFILE_001 "
            "GROUP BY risk_tolerance"
        ),
    },

    # ── score_query: two-table joins ────────────────────────────────────────
    {
        "group": "Two-table JOIN (known pairs)",
        "label": "investor_name + SUM(current_value) — Gold filter",
        "sql": (
            "SELECT p.investor_name, SUM(h.current_value) "
            "FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h "
            "JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id "
            "WHERE h.investment_type = 'Mutual Fund' "
            "GROUP BY p.investor_name"
        ),
    },
    {
        "group": "Two-table JOIN (known pairs)",
        "label": "risk_tolerance + holding count",
        "sql": (
            "SELECT p.risk_tolerance, COUNT(h.holding_id) AS total_holdings "
            "FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h "
            "JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id "
            "GROUP BY p.risk_tolerance"
        ),
    },
    {
        "group": "Two-table JOIN (known pairs)",
        "label": "Cash flow SUM by investor",
        "sql": (
            "SELECT p.investor_name, SUM(c.amount) "
            "FROM ATOM_EVENT_CASH_FLOW_001 c "
            "JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON c.investor_id = p.investor_id "
            "WHERE c.type = 'Dividend' "
            "GROUP BY p.investor_name"
        ),
    },

    # ── score_query: three-table joins ──────────────────────────────────────
    {
        "group": "Three-table JOIN",
        "label": "Retirement planning across three tables",
        "sql": (
            "SELECT p.investor_name, g.investment_goal "
            "FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h "
            "JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id "
            "JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON p.investor_id = g.investor_id "
            "WHERE g.investment_goal = 'Retirement Planning'"
        ),
    },

    # ── novel / suspicious queries ──────────────────────────────────────────
    {
        "group": "Novel / suspicious patterns",
        "label": "INVESTMENT_GOAL LEFT JOIN CASH_FLOW — unseen pair",
        "sql": (
            "SELECT g.investment_goal, COUNT(*) "
            "FROM ATOM_ENTITY_INVESTMENT_GOAL_001 g "
            "LEFT JOIN ATOM_EVENT_CASH_FLOW_001 c ON g.investor_id = c.investor_id "
            "WHERE c.amount > 50000 "
            "GROUP BY g.investment_goal ORDER BY COUNT(*) DESC"
        ),
    },
    {
        "group": "Novel / suspicious patterns",
        "label": "Completely unknown tables",
        "sql": (
            "SELECT x.foo, SUM(x.bar) "
            "FROM UNKNOWN_TABLE x "
            "JOIN ANOTHER_UNKNOWN y ON x.id = y.id "
            "WHERE x.baz = 'test'"
        ),
    },
    {
        "group": "Novel / suspicious patterns",
        "label": "Unseen column on known table",
        "sql": (
            "SELECT never_used_col "
            "FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 "
            "WHERE never_used_col = 42"
        ),
    },
    {
        "group": "Novel / suspicious patterns",
        "label": "Correct table but unusual aggregation",
        "sql": (
            "SELECT STDDEV(current_value), VARIANCE(cost) "
            "FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001"
        ),
    },

    # ── analyze_query_logs test queries ────────────────────────────────────
    {
        "group": "Filter / operator patterns",
        "label": "LIKE filter on investment_name",
        "sql": (
            "SELECT COUNT(DISTINCT investor_id) "
            "FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 "
            "WHERE investment_name LIKE '%Gold%' OR investment_type LIKE '%Gold%'"
        ),
    },
    {
        "group": "Filter / operator patterns",
        "label": "BETWEEN on purchase_date",
        "sql": (
            "SELECT investment_type, SUM(cost) "
            "FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 "
            "WHERE purchase_date BETWEEN '2020-01-01' AND '2023-12-31' "
            "GROUP BY investment_type"
        ),
    },
    {
        "group": "Filter / operator patterns",
        "label": "SIP cash flows with HAVING",
        "sql": (
            "SELECT investor_id "
            "FROM ATOM_EVENT_CASH_FLOW_001 "
            "WHERE type = 'SIP' "
            "GROUP BY investor_id HAVING COUNT(*) > 3"
        ),
    },

    # ── subquery / CTE ──────────────────────────────────────────────────────
    {
        "group": "Subquery / CTE",
        "label": "Dividend cash flows last 6 months (subquery)",
        "sql": (
            "SELECT * FROM ATOM_EVENT_CASH_FLOW_001 "
            "WHERE type LIKE '%Dividend%' "
            "AND date > date((SELECT MAX(date) FROM ATOM_EVENT_CASH_FLOW_001), '-6 months')"
        ),
    },
    {
        "group": "Subquery / CTE",
        "label": "Highest avg cost investment_type (subquery)",
        "sql": (
            "SELECT investment_type "
            "FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 "
            "GROUP BY investment_type "
            "ORDER BY AVG(cost) DESC LIMIT 1"
        ),
    },
]


# ---------------------------------------------------------------------------
# Run scoring
# ---------------------------------------------------------------------------

def bar(score, width: int = 12) -> str:
    if score is None:
        return "─" * width
    filled = round(score * width)
    return "█" * filled + "░" * (width - filled)


def run_all() -> list[dict]:
    print("Loading stats and corpus…", flush=True)
    stats  = load_stats(DB_PATH)
    corpus = load_corpus(DB_PATH)
    schema = load_schema()

    results: list[dict] = []
    for entry in TEST_QUERIES:
        sql  = entry["sql"]
        info = parse_query(sql)
        prob = score_probability(info, stats, schema)
        nm   = score_near_match(sql, info, corpus, top_n=3)

        def r3(x):  # None-safe rounding (a dimension is None when not applicable)
            return round(x, 3) if x is not None else None

        # No LLM in the batch report -> deterministic re-normalized blend over robust near.
        consolidated = round(consolidate(prob.overall, nm.score, llm_norm=None), 3)
        results.append({
            "group":   entry["group"],
            "label":   entry["label"],
            "sql":     sql,
            "probability": {
                "table_familiarity":   r3(prob.table_familiarity.score),
                "column_coverage":     r3(prob.column_coverage.score),
                "join_pattern":        r3(prob.join_pattern.score),
                "join_key_validity":   r3(prob.join_key_validity.score),
                "filter_familiarity":  r3(prob.filter_familiarity.score),
                "filter_operator":     r3(prob.filter_operator.score),
                "aggregation_pattern": r3(prob.aggregation_pattern.score),
                "overall":             r3(prob.overall),
            },
            "near_match": {
                "score":      round(nm.score, 3),
                "best_score": round(nm.best_score, 3),
                "mean_top3":  round(nm.mean_top5, 3),
                "top_hits": [
                    {
                        "rank":     i + 1,
                        "combined": round(h.combined, 3),
                        "struct":   round(h.struct_score, 3),
                        "token":    round(h.token_score, 3),
                        "title":    h.title,
                        "sql":      h.sql.strip().splitlines()[0][:120],
                    }
                    for i, h in enumerate(nm.top_hits)
                ],
            },
            "consolidated_overall": consolidated,
            "detail": {
                name: dim.detail[:4]
                for name, dim in prob.dims()
            },
        })
        print(f"  ✓  {entry['label']}", flush=True)

    return results


# ---------------------------------------------------------------------------
# Format text report
# ---------------------------------------------------------------------------

def format_report(results: list[dict]) -> str:
    SEP  = "=" * 72
    TSEP = "─" * 72
    lines: list[str] = []

    lines.append(SEP)
    lines.append("  SQL QUERY SCORER — TEST RESULTS")
    lines.append(f"  {len(results)} queries  |  source: raw_data/parsed_query_logs.db")
    lines.append(SEP)

    current_group = None
    for r in results:
        if r["group"] != current_group:
            current_group = r["group"]
            lines.append(f"\n{'━'*72}")
            lines.append(f"  GROUP: {current_group}")
            lines.append(f"{'━'*72}")

        lines.append(f"\n  ▶  {r['label']}")
        lines.append(f"  SQL: {r['sql'][:100]}{'…' if len(r['sql']) > 100 else ''}")

        p = r["probability"]
        lines.append(f"\n  {'─'*68}")
        lines.append(f"  {'PROBABILITY SCORES':<35}  {'Score':>6}  Bar")
        lines.append(f"  {'─'*68}")
        dim_labels = {
            "table_familiarity":   "Table Familiarity",
            "column_coverage":     "Column Coverage",
            "join_pattern":        "Join Pattern",
            "join_key_validity":   "Join Key Validity",
            "filter_familiarity":  "Filter Familiarity",
            "filter_operator":     "Filter Operator",
            "aggregation_pattern": "Aggregation Pattern",
        }
        for key, label in dim_labels.items():
            sc = p[key]
            sc_str = f"{sc:>6.3f}" if sc is not None else f"{'N/A':>6}"
            lines.append(f"  {label:<35}  {sc_str}  {bar(sc)}")

        lines.append(f"  {'─'*68}")
        lines.append(f"  {'OVERALL':35}  {p['overall']:>6.3f}  {bar(p['overall'])}")

        # Detail lines: always show for dims below 0.5, otherwise only flagged entries
        for dim_name, details in r["detail"].items():
            dim_score = p[dim_name]
            if dim_score is not None and dim_score < 0.5:
                for d in details:
                    lines.append(f"    ⚑  [{dim_name}] {d}")
            else:
                flagged = [d for d in details if "✗" in d or "NEVER" in d or "unseen" in d.lower()]
                for d in flagged:
                    lines.append(f"    ⚑  [{dim_name}] {d}")

        nm = r["near_match"]
        lines.append(f"\n  {'─'*68}")
        lines.append(f"  NEAR-MATCH   robust={nm['score']:.3f}  {bar(nm['score'])}"
                     f"  best={nm['best_score']:.3f}  mean-top3={nm['mean_top3']:.3f}")
        for h in nm["top_hits"]:
            lines.append(
                f"    #{h['rank']}  combined={h['combined']:.3f}"
                f"  struct={h['struct']:.3f}  token={h['token']:.3f}"
            )
            lines.append(f"         SQL: {h['sql']}")

        cs = r["consolidated_overall"]
        lines.append(f"\n  {'═'*68}")
        lines.append(f"  CONSOLIDATED SCORE  (deterministic: 60% prob + 40% near, no LLM)   {cs:.3f}  {bar(cs)}")
        lines.append(f"  {'═'*68}")

    lines.append(f"\n{SEP}\n")
    return "\n".join(lines)


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

if __name__ == "__main__":
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    results = run_all()

    # Text report
    txt = format_report(results)
    txt_path = OUT_DIR / "scores_report.txt"
    txt_path.write_text(txt, encoding="utf-8")
    print(txt)

    # JSON report
    json_path = OUT_DIR / "scores_report.json"
    json_path.write_text(json.dumps(results, indent=2), encoding="utf-8")

    print(f"\nSaved:\n  {txt_path}\n  {json_path}")
