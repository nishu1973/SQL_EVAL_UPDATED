"""
eval_discrimination.py

Measures whether each score (Probability, Near-match, LLM) actually SEPARATES good queries
from bad ones — the thing an all-"good" corpus can't tell us on its own.

It scores a sample of real corpus queries ("good") against a hand-crafted set of deliberately
flawed queries ("bad"), then reports, per score:
  - mean(good), mean(bad), separation = mean(good) - mean(bad)
  - AUC: P(a random good scores higher than a random bad)  [1.0 = perfect, 0.5 = useless]

Usage:
    python scripts/eval_discrimination.py                 # full (good sample + bad, with LLM)
    python scripts/eval_discrimination.py --no-llm        # deterministic scores only
    python scripts/eval_discrimination.py --good 40       # sample size of good queries
"""

from __future__ import annotations

import argparse
import json
import os
import random
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import score_query as sq  # noqa: E402

OUT_PATH = Path("reports/discrimination_eval.json")

# Deliberately flawed queries, grouped by failure mode. All reference the real ATOM schema
# except where the failure IS an unknown table.
NEGATIVE: list[dict] = [
    # --- hallucinated tables (don't exist) ---
    {"kind": "unknown_table", "sql": "SELECT customer_name FROM ATOM_ENTITY_CUSTOMER_001 WHERE region = 'West'"},
    {"kind": "unknown_table", "sql": "SELECT SUM(amount) FROM ATOM_EVENT_TRANSACTION_001 WHERE status = 'DONE'"},
    {"kind": "unknown_table", "sql": "SELECT account_balance FROM ATOM_ENTITY_ACCOUNT_001 WHERE type = 'Savings'"},
    {"kind": "unknown_table", "sql": "SELECT a.id FROM TRADES a JOIN PAYMENTS b ON a.id = b.tid"},
    # --- hallucinated columns on real tables ---
    {"kind": "hallucinated_col", "sql": "SELECT profit_margin FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE profit_margin > 10"},
    {"kind": "hallucinated_col", "sql": "SELECT ticker_symbol, current_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001"},
    {"kind": "hallucinated_col", "sql": "SELECT investor_name, email FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE email LIKE '%@x.com'"},
    {"kind": "hallucinated_col", "sql": "SELECT credit_score FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 WHERE credit_score > 700"},
    {"kind": "hallucinated_col", "sql": "SELECT pe_ratio FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE pe_ratio < 15"},
    # --- never-seen / nonsensical joins (real tables, bad pairing) ---
    {"kind": "unseen_join", "sql": "SELECT s.sector, SUM(c.amount) FROM ATOM_EVENT_CASH_FLOW_001 c JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 s ON c.investor_id = s.investor_id GROUP BY s.sector"},
    {"kind": "unseen_join", "sql": "SELECT r.action, sr.scenario FROM ATOM_EVENT_REBALANCING_ACTION_001 r JOIN ATOM_EVENT_SCENARIO_REBALANCING_001 sr ON r.investor_id = sr.investor_id"},
    {"kind": "unseen_join", "sql": "SELECT h.investment_type, sr.scenario FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_EVENT_SCENARIO_REBALANCING_001 sr ON h.investor_id = sr.investor_id"},
    # --- wrong join key (join on a non-key column) ---
    {"kind": "wrong_join_key", "sql": "SELECT h.investment_name, p.investor_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.sector = p.sector_focus"},
    {"kind": "wrong_join_key", "sql": "SELECT h.cost, g.target_amount FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON h.category = g.investment_goal"},
    # --- weird aggregation (agg applied to an odd column) ---
    {"kind": "weird_agg", "sql": "SELECT SUM(purchase_date) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001"},
    {"kind": "weird_agg", "sql": "SELECT AVG(investor_name) FROM ATOM_ENTITY_INVESTOR_PROFILE_001"},
    {"kind": "weird_agg", "sql": "SELECT MAX(risk_tolerance), MIN(sector_focus) FROM ATOM_ENTITY_INVESTOR_PROFILE_001"},
    # --- nonsense / atypical filters ---
    {"kind": "nonsense_filter", "sql": "SELECT investor_name FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_name > 5000"},
    {"kind": "nonsense_filter", "sql": "SELECT current_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE holding_id LIKE '%xyz%'"},
    # --- subtly-off COMPLEX (3+ table) queries — the discrimination gap we care about ---
    {"kind": "complex_subtle", "sql": "SELECT p.investor_name, s.sector, sr.scenario FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 s ON p.investor_id = s.investor_id JOIN ATOM_EVENT_SCENARIO_REBALANCING_001 sr ON s.sector = sr.affected_assets_sectors"},
    {"kind": "complex_subtle", "sql": "SELECT h.investment_name, c.type, r.action FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_EVENT_CASH_FLOW_001 c ON h.investor_id = c.investor_id JOIN ATOM_EVENT_REBALANCING_ACTION_001 r ON c.source = r.logic"},
    {"kind": "complex_subtle", "sql": "SELECT g.investment_goal, s.sector, hh.risk_score FROM ATOM_ENTITY_INVESTMENT_GOAL_001 g JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 s ON g.target_amount = s.total_investment JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 hh ON s.investor_id = hh.investor_id"},
]


def _auc(good: list[float], bad: list[float]) -> float:
    """P(random good > random bad); 0.5 = no separation, 1.0 = perfect."""
    g = [x for x in good if x is not None]
    b = [x for x in bad if x is not None]
    if not g or not b:
        return float("nan")
    wins = ties = 0
    for x in g:
        for y in b:
            if x > y:
                wins += 1
            elif x == y:
                ties += 1
    return (wins + 0.5 * ties) / (len(g) * len(b))


def main() -> None:
    p = argparse.ArgumentParser()
    p.add_argument("--no-llm", action="store_true")
    p.add_argument("--good", type=int, default=40, help="sample size of good corpus queries")
    p.add_argument("--seed", type=int, default=7)
    args = p.parse_args()

    stats   = sq.load_stats(sq.DB_PATH)
    schema  = sq.load_schema()
    corpus  = sq.load_corpus(sq.DB_PATH)              # deduped reference for near-match
    sections = sq.load_table_sections(sq.ANALYSIS_MD)
    api_ok  = (not args.no_llm) and bool(os.environ.get("OPENAI_API_KEY"))

    rng = random.Random(args.seed)
    good_sqls = [e["sql"] for e in rng.sample(corpus, min(args.good, len(corpus)))]
    good = [{"kind": "good", "sql": s} for s in good_sqls]

    def score(sql):
        info = sq.parse_query(sql)
        prob = sq.score_probability(info, stats, schema)
        nm   = sq.score_near_match(sql, info, corpus, top_n=5)
        llm  = None
        if api_ok:
            rep = sq.score_llm(sql, info, sections, stats)
            llm = (rep.overall / 100.0) if rep else None
        return prob.overall, nm.score, llm

    print(f"Scoring {len(good)} good + {len(NEGATIVE)} bad (llm={'on' if api_ok else 'off'})…", flush=True)
    rows = []
    for tag, items in (("good", good), ("bad", NEGATIVE)):
        for e in items:
            pr, nr, lm = score(e["sql"])
            rows.append({"label": tag, "kind": e["kind"], "sql": e["sql"],
                         "probability": pr, "near_match": nr, "llm": lm})

    gP = [r["probability"] for r in rows if r["label"] == "good"]
    bP = [r["probability"] for r in rows if r["label"] == "bad"]
    gN = [r["near_match"] for r in rows if r["label"] == "good"]
    bN = [r["near_match"] for r in rows if r["label"] == "bad"]
    gL = [r["llm"] for r in rows if r["label"] == "good"]
    bL = [r["llm"] for r in rows if r["label"] == "bad"]

    def mean(xs):
        xs = [x for x in xs if x is not None]
        return sum(xs) / len(xs) if xs else float("nan")

    summary = {
        "Probability": {"mean_good": mean(gP), "mean_bad": mean(bP), "auc": _auc(gP, bP)},
        "Near-match":  {"mean_good": mean(gN), "mean_bad": mean(bN), "auc": _auc(gN, bN)},
    }
    if api_ok:
        summary["LLM"] = {"mean_good": mean(gL), "mean_bad": mean(bL), "auc": _auc(gL, bL)}

    print(f"\n{'score':<13} {'mean_good':>10} {'mean_bad':>10} {'separation':>11} {'AUC':>7}")
    print("-" * 54)
    for name, s in summary.items():
        print(f"{name:<13} {s['mean_good']:>10.3f} {s['mean_bad']:>10.3f} "
              f"{s['mean_good']-s['mean_bad']:>11.3f} {s['auc']:>7.3f}")

    # discrimination on the hard subset: subtly-off COMPLEX queries
    print("\nAUC on 'complex_subtle' bad queries only (the 3+-table blind spot):")
    cs = [r for r in rows if r["kind"] == "complex_subtle"]
    for name, key in (("Probability", "probability"), ("Near-match", "near_match"),
                      *( [("LLM", "llm")] if api_ok else [] )):
        print(f"  {name:<13} AUC={_auc(gP if key=='probability' else gN if key=='near_match' else gL, [r[key] for r in cs]):.3f}")

    OUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    OUT_PATH.write_text(json.dumps({"summary": summary, "rows": rows,
                                    "llm_model": sq.LLM_MODEL, "llm_used": api_ok}, indent=2))
    print(f"\nWrote details → {OUT_PATH}")


if __name__ == "__main__":
    main()
