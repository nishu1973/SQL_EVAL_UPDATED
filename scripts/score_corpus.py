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
from concurrent.futures import ThreadPoolExecutor  # noqa: E402

OUT_PATH = Path("reports/corpus_scores.json")
LLM_CACHE_PATH = Path("reports/llm_cache.json")
MAX_WORKERS = 12


def load_llm_cache(model: str) -> dict[str, int]:
    """Persistent LLM verdicts keyed by normalized SQL. Invalidated if the model changed,
    so we never reuse a different model's scores."""
    if not LLM_CACHE_PATH.exists():
        return {}
    try:
        data = json.loads(LLM_CACHE_PATH.read_text(encoding="utf-8"))
    except (json.JSONDecodeError, OSError):
        return {}
    if data.get("llm_model") != model:
        return {}                                # model changed -> stale, recompute
    return {k: v for k, v in data.get("verdicts", {}).items() if v is not None}


def save_llm_cache(verdicts: dict[str, int], model: str) -> None:
    LLM_CACHE_PATH.parent.mkdir(parents=True, exist_ok=True)
    LLM_CACHE_PATH.write_text(
        json.dumps({"llm_model": model, "verdicts": verdicts}, indent=2), encoding="utf-8")


def build(use_llm: bool = True, limit: int | None = None, progress=None,
          use_cache: bool = True) -> dict:
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

    # 1) Fast pass: parse + probability + near-match for every row (no API).
    parsed = []
    for (qnum, qid, uid, start, dur, nrows, title, sql) in rows:
        info = sq.parse_query(sql)
        parsed.append({
            "info": info,
            "prob": sq.score_probability(info, stats, schema),
            "nm":   sq.score_near_match(sql, info, ref_corpus, top_n=5),
            "key":  sq._normalize_sql(sql),
            "raw":  (qnum, qid, uid, start, dur, nrows, title, sql),
        })

    # 2) LLM pass: reuse the persistent cache; call the API ONLY for unseen patterns,
    #    and run those misses in parallel.
    verdicts: dict[str, int] = load_llm_cache(sq.LLM_MODEL) if (api_ok and use_cache) else {}
    n_new_calls = 0
    if api_ok:
        misses = {}                                       # key -> (sql, info)  (unique only)
        for p in parsed:
            if p["key"] not in verdicts and p["key"] not in misses:
                misses[p["key"]] = (p["raw"][7], p["info"])

        def _call(item):
            key, (sql, info) = item
            try:
                rep = sq.score_llm(sql, info, sections, stats)
                return key, (rep.overall if rep else None)
            except Exception:                              # noqa: BLE001
                return key, None

        total = len(misses)
        if total == 0 and progress is not None:
            progress(1, 1, 0)                              # all cached -> instant
        done = 0
        with ThreadPoolExecutor(max_workers=MAX_WORKERS) as ex:
            for key, overall in ex.map(_call, list(misses.items())):
                done += 1
                if overall is not None:
                    verdicts[key] = overall
                    n_new_calls += 1
                if progress is not None:
                    progress(done, total, n_new_calls)
                elif done % 25 == 0 or done == total:
                    print(f"  LLM {done}/{total} new calls…", flush=True)
        if use_cache:
            save_llm_cache(verdicts, sq.LLM_MODEL)

    # 3) Assemble rows (LLM verdict looked up from cache by normalized SQL).
    out: list[dict] = []
    for p in parsed:
        (qnum, qid, uid, start, dur, nrows, title, sql) = p["raw"]
        info, prob, nm = p["info"], p["prob"], p["nm"]
        llm_overall = verdicts.get(p["key"]) if api_ok else None
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

    return {
        "meta": {
            "n_rows": len(out),
            "n_llm_calls": n_new_calls,                    # NEW API calls this run (cache hits excluded)
            "n_llm_cached": (len(verdicts) - n_new_calls) if api_ok else 0,
            "llm_used": api_ok,
            "llm_model": sq.LLM_MODEL,
        },
        "rows": out,
    }


def main() -> None:
    p = argparse.ArgumentParser(description="Precompute corpus scores for the dashboard")
    p.add_argument("--no-llm", action="store_true", help="Skip LLM scoring")
    p.add_argument("--no-cache", action="store_true", help="Ignore the persistent LLM cache (force fresh calls)")
    p.add_argument("--limit", type=int, default=None, help="Only score the first N queries")
    p.add_argument("--out", type=Path, default=OUT_PATH)
    args = p.parse_args()

    print(f"Scoring corpus (llm={'off' if args.no_llm else 'on'}, "
          f"cache={'off' if args.no_cache else 'on'})…", flush=True)
    data = build(use_llm=not args.no_llm, limit=args.limit, use_cache=not args.no_cache)
    args.out.parent.mkdir(parents=True, exist_ok=True)
    args.out.write_text(json.dumps(data, indent=2), encoding="utf-8")
    m = data["meta"]
    print(f"Wrote {m['n_rows']} rows → {args.out}  "
          f"({m['n_llm_calls']} new LLM calls, {m['n_llm_cached']} reused from cache, "
          f"model={m['llm_model']})")


if __name__ == "__main__":
    main()
