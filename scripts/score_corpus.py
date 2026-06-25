"""
score_corpus.py

Precompute all three scores (Probability, Near-match, LLM) for every logged query and
cache them to reports/corpus_scores.json, which the Streamlit "Analysis Dashboard" reads.

The LLM verdict is computed once per DISTINCT normalized query pattern and mapped to every
logged row that shares it — literal-only variants get the same structural verdict, so this
yields all 1000 rows × 3 scores while only paying for the ~189 unique LLM calls.

Usage:
    python scripts/score_corpus.py                 # all logged queries, with LLM
    python scripts/score_corpus.py --no-llm        # probability + near only (fast, free)
    python scripts/score_corpus.py --limit 50      # quick test on the first 50
"""

from __future__ import annotations

import argparse
import json
import os
import sqlite3
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import score_query as sq  # noqa: E402

OUT_PATH = Path("reports/corpus_scores.json")


def build(use_llm: bool = True, limit: int | None = None, progress=None) -> dict:
    stats      = sq.load_stats(sq.DB_PATH)
    schema     = sq.load_schema()
    ref_corpus = sq.load_corpus(sq.DB_PATH)               # deduped reference for near-match
    sections   = sq.load_table_sections(sq.ANALYSIS_MD)

    con = sqlite3.connect(str(sq.DB_PATH))
    rows = con.execute(
        "SELECT query_num, query_id, userid, start_time, duration_ms, rows_returned, "
        "title, sql_query FROM query_logs ORDER BY query_num"
    ).fetchall()
    con.close()
    if limit:
        rows = rows[:limit]

    api_ok = use_llm and bool(os.environ.get("OPENAI_API_KEY"))
    llm_cache: dict[str, int | None] = {}                 # normalized SQL -> LLM overall
    n_llm_calls = 0
    out: list[dict] = []

    for i, (qnum, qid, uid, start, dur, nrows, title, sql) in enumerate(rows, 1):
        info = sq.parse_query(sql)
        prob = sq.score_probability(info, stats, schema)
        nm   = sq.score_near_match(sql, info, ref_corpus, top_n=5)

        llm_overall = None
        if api_ok:
            key = sq._normalize_sql(sql)
            if key not in llm_cache:
                rep = None
                try:
                    rep = sq.score_llm(sql, info, sections, stats)
                except Exception:                          # noqa: BLE001
                    rep = None
                llm_cache[key] = rep.overall if rep else None
                if rep is not None:
                    n_llm_calls += 1
            llm_overall = llm_cache[key]

        llm_norm = (llm_overall / 100.0) if llm_overall is not None else None
        consolidated = sq.consolidate(prob.overall, nm.score, llm_norm)
        flags = sq.collect_flags(info, prob, schema)

        out.append({
            "query_num": qnum, "query_id": qid, "userid": uid,
            "start_time": start, "duration_ms": dur, "rows_returned": nrows,
            "title": title or "", "sql": sql,
            "num_tables": len(info.tables),
            "num_joins":  len(info.join_pairs),
            "complexity": ("single-table" if len(info.tables) <= 1 else
                           "2-table join" if len(info.tables) == 2 else "3+-table join"),
            "has_agg": bool(info.agg_pairs),
            "has_groupby": bool(info.groupby_cols),
            "probability":  round(prob.overall, 4),
            "near_match":   round(nm.score, 4),
            "llm":          llm_overall,
            "consolidated": round(consolidated, 4),
            "n_flags": len(flags),
            "flags": flags,
        })
        if progress is not None:
            progress(i, len(rows), n_llm_calls)
        elif i % 100 == 0:
            print(f"  {i}/{len(rows)}  ({n_llm_calls} unique LLM calls)", flush=True)

    return {
        "meta": {
            "n_rows": len(out),
            "n_llm_calls": n_llm_calls,
            "llm_used": api_ok,
            "llm_model": sq.LLM_MODEL,
        },
        "rows": out,
    }


def main() -> None:
    p = argparse.ArgumentParser(description="Precompute corpus scores for the dashboard")
    p.add_argument("--no-llm", action="store_true", help="Skip LLM scoring")
    p.add_argument("--limit", type=int, default=None, help="Only score the first N queries")
    p.add_argument("--out", type=Path, default=OUT_PATH)
    args = p.parse_args()

    print(f"Scoring corpus (llm={'off' if args.no_llm else 'on'})…", flush=True)
    data = build(use_llm=not args.no_llm, limit=args.limit)
    args.out.parent.mkdir(parents=True, exist_ok=True)
    args.out.write_text(json.dumps(data, indent=2), encoding="utf-8")
    print(f"Wrote {data['meta']['n_rows']} rows → {args.out}  "
          f"({data['meta']['n_llm_calls']} unique LLM calls, model={data['meta']['llm_model']})")


if __name__ == "__main__":
    main()
