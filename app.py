"""
app.py — Interactive SQL Query Confidence Scorer (Streamlit)

Two tabs:
  🔎 Score a query     — paste SQL, optional live LLM, full inline calculation trace.
  📊 Analysis Dashboard — interactive Plotly views of all three scores across the corpus.

Run:
    .venv/bin/streamlit run app.py
"""

from __future__ import annotations

import json
import sys
from pathlib import Path

import pandas as pd
import plotly.express as px
import streamlit as st

ROOT = Path(__file__).parent
sys.path.insert(0, str(ROOT / "scripts"))
import score_query as sq        # noqa: E402
import score_corpus             # noqa: E402

st.set_page_config(page_title="SQL Query Confidence Scorer", page_icon="🧮", layout="wide")

CORPUS_SCORES_PATH = ROOT / "reports" / "corpus_scores.json"

# ---------------------------------------------------------------------------
# Cached data
# ---------------------------------------------------------------------------

@st.cache_resource(show_spinner="Loading corpus, schema and stats…")
def load_refs():
    stats   = sq.load_stats(sq.DB_PATH)
    corpus  = sq.load_corpus(sq.DB_PATH)
    schema  = sq.load_schema()
    sections = sq.load_table_sections(sq.ANALYSIS_MD)
    raw_n = len(sq.load_corpus(sq.DB_PATH, dedup=False))
    return stats, corpus, schema, sections, raw_n


@st.cache_data(show_spinner=False)
def load_corpus_scores(_mtime: float):
    return json.loads(CORPUS_SCORES_PATH.read_text(encoding="utf-8"))


def corpus_scores():
    if not CORPUS_SCORES_PATH.exists():
        return None
    return load_corpus_scores(CORPUS_SCORES_PATH.stat().st_mtime)


STATS, CORPUS, SCHEMA, SECTIONS, RAW_N = load_refs()
CFG = sq.SCORING_CONFIG

SAMPLES = {
    "✅ Known two-table join":
        "SELECT p.investor_name, SUM(h.current_value)\n"
        "FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h\n"
        "JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id\n"
        "WHERE h.investment_type = 'Mutual Fund'\n"
        "GROUP BY p.investor_name",
    "⚠️ Unusual join (valid)":
        "SELECT g.investment_goal, COUNT(*)\n"
        "FROM ATOM_ENTITY_INVESTMENT_GOAL_001 g\n"
        "LEFT JOIN ATOM_EVENT_CASH_FLOW_001 c ON g.investor_id = c.investor_id\n"
        "WHERE c.amount > 50000\n"
        "GROUP BY g.investment_goal",
    "❌ Hallucinated column":
        "SELECT made_up_col FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE made_up_col = 1",
    "❌ Unknown tables":
        "SELECT x.foo, SUM(x.bar) FROM UNKNOWN_TABLE x "
        "JOIN ANOTHER_UNKNOWN y ON x.id = y.id WHERE x.baz = 'test'",
}


def score_color(v) -> str:
    if v is None:
        return "gray"
    return "#1a9850" if v >= 0.75 else ("#fdae61" if v >= 0.5 else "#d73027")


def bar(v):
    if v is None:
        return "—"
    n = round(v * 20)
    return "█" * n + "░" * (20 - n)


def explain(why: str, how: str, seeing: str):
    """A collapsible plain-language note under a chart, for non-technical readers."""
    with st.expander("ℹ️  What this shows & why it matters"):
        st.markdown(
            f"**Why it matters**  \n{why}\n\n"
            f"**How to read it**  \n{how}\n\n"
            f"**What this view is telling us**  \n{seeing}")


# ---------------------------------------------------------------------------
# Sidebar
# ---------------------------------------------------------------------------

if "history" not in st.session_state:
    st.session_state.history = []
if "sql_input" not in st.session_state:
    st.session_state.sql_input = SAMPLES["✅ Known two-table join"]

with st.sidebar:
    st.header("⚙️ Controls")
    use_llm = st.toggle(f"Use LLM scoring ({sq.LLM_MODEL})", value=False,
                        help="Makes a real, billable OpenAI call. Falls back to the "
                             "deterministic score if no key / invalid response.")
    st.caption(f"Schema grounding: {'✅ on' if SCHEMA else '⚠️ off'}  ·  "
               f"Corpus: {len(CORPUS)} patterns (from {RAW_N} logs)")

    st.subheader("Sample queries")
    for name, q in SAMPLES.items():
        if st.button(name, width="stretch"):
            st.session_state.sql_input = q

    with st.expander("Scoring parameters"):
        st.json({
            "consolidated_weights": {"prob": CFG["W_PROB"], "near": CFG["W_NEAR"], "llm": CFG["W_LLM"]},
            "S_VALID": CFG["S_VALID"], "ALPHA (worst-offender)": CFG["ALPHA"],
            "T_SAT_FRAC": CFG["T_SAT_FRAC"], "near β/k": [CFG["BETA"], CFG["TOP_K"]],
        })

    if st.session_state.history:
        st.subheader("📜 Session history")
        for h in reversed(st.session_state.history[-12:]):
            st.markdown(
                f"<span style='color:{score_color(h['score'])};font-weight:600'>"
                f"{h['score']:.3f}</span> · {h['sql']}", unsafe_allow_html=True)

st.title("🧮 SQL Query Confidence Scorer")

tab_score, tab_dash = st.tabs(["🔎  Score a query", "📊  Analysis Dashboard"])

# ===========================================================================
# TAB 1 — Score a single query
# ===========================================================================

with tab_score:
    st.caption("How closely does a SQL query resemble what analysts actually run? "
               "Live scoring with full, inline calculation detail.")

    sql = st.text_area("SQL query", key="sql_input", height=160)
    go = st.button("▶ Score query", type="primary")

    if not (go and sql.strip()):
        st.info("Enter a SQL query (or pick a sample from the sidebar) and click **Score query**.")
    else:
        info = sq.parse_query(sql)
        prob = sq.score_probability(info, STATS, SCHEMA)
        nm   = sq.score_near_match(sql, info, CORPUS, top_n=5)

        llm, llm_note = None, None
        if use_llm:
            import os
            if not os.environ.get("OPENAI_API_KEY"):
                llm_note = "OPENAI_API_KEY not set — LLM skipped; deterministic fallback."
            else:
                with st.spinner(f"Calling {sq.LLM_MODEL}…"):
                    try:
                        llm = sq.score_llm(sql, info, SECTIONS, STATS)
                        if llm is None:
                            llm_note = "LLM returned an invalid response — deterministic fallback."
                    except Exception as e:  # noqa: BLE001
                        llm_note = f"LLM call failed ({type(e).__name__}) — deterministic fallback."

        llm_norm = (llm.overall / 100.0) if llm else None
        consolidated = sq.consolidate(prob.overall, nm.score, llm_norm)
        flags = sq.collect_flags(info, prob, SCHEMA)

        st.session_state.history.append({
            "sql": (sql.strip().replace("\n", " ")[:60] + "…") if len(sql) > 60
                   else sql.strip().replace("\n", " "),
            "score": consolidated})

        c1, c2, c3, c4 = st.columns(4)
        c1.metric("Consolidated", f"{consolidated:.3f}")
        c2.metric("Probability", f"{prob.overall:.3f}")
        c3.metric("Near-match (robust)", f"{nm.score:.3f}")
        c4.metric("LLM", f"{llm.overall}/100" if llm else "—")
        st.markdown(
            f"<div style='height:14px;border-radius:7px;background:linear-gradient(90deg,"
            f"{score_color(consolidated)} {consolidated*100:.0f}%, #eee {consolidated*100:.0f}%)'></div>",
            unsafe_allow_html=True)

        if llm_note:
            st.info("🛈 " + llm_note)
        if flags:
            st.error("**⚑ Detected anomalies**\n\n" + "\n".join(f"- {f}" for f in flags))
        else:
            st.success("No hard anomalies detected.")

        with st.expander("① Parsed query features"):
            fc1, fc2 = st.columns(2)
            fc1.write("**Tables**"); fc1.write(info.tables or "—")
            fc1.write("**Join pairs**"); fc1.write([f"{a} + {b}" for a, b in info.join_pairs] or "—")
            fc1.write("**Join keys**"); fc1.write(dict(info.join_keys) or "—")
            fc2.write("**SELECT columns**"); fc2.write(dict(info.select_cols) or "—")
            fc2.write("**WHERE columns**"); fc2.write(dict(info.where_cols) or "—")
            fc2.write("**Aggregations**"); fc2.write([f"{fn}({c})" for fn, c in info.agg_pairs] or "—")

        st.subheader("② Probability — per-dimension calculation")
        WEIGHTS = sq.ProbabilityReport.WEIGHTS
        for name, dim in prob.dims():
            w = WEIGHTS[name]
            sval = "N/A" if dim.score is None else f"{dim.score:.3f}"
            with st.expander(f"**{dim.label}** · score `{sval}` · weight `{w:.2f}` · `{bar(dim.score)}`"):
                if dim.score is None:
                    st.write("Not applicable — excluded from the weighted overall.")
                    continue
                if dim.instances:
                    st.dataframe(dim.instances, width="stretch", hide_index=True)
                if dim.agg:
                    st.markdown(f"**Worst-offender aggregation:** `{dim.agg['formula']}` "
                                f"(α={dim.agg['alpha']}, n={dim.agg['n']})")

        rows, tw = [], 0.0
        for name, dim in prob.dims():
            if dim.score is None:
                continue
            w = WEIGHTS[name]; tw += w
            rows.append({"dimension": name, "score": round(dim.score, 3),
                         "weight": w, "contribution": round(dim.score * w, 4)})
        contrib = sum(r["contribution"] for r in rows)
        st.markdown("**Weighted overall (applicable dimensions, re-normalized):**")
        st.dataframe(rows, width="stretch", hide_index=True)
        st.markdown(f"`overall = {contrib:.4f} / {tw:.2f} = {prob.overall:.4f}`")

        st.subheader("③ Near-match")
        n1, n2, n3 = st.columns(3)
        n1.metric("Robust score (used)", f"{nm.score:.3f}")
        n2.metric("Best single hit", f"{nm.best_score:.3f}")
        n3.metric("Mean of top-5", f"{nm.mean_top5:.3f}")
        st.dataframe(
            [{"rank": i + 1, "combined": round(h.combined, 3), "struct": round(h.struct_score, 3),
              "token": round(h.token_score, 3), "sql": h.sql.strip().splitlines()[0][:90]}
             for i, h in enumerate(nm.top_hits)], width="stretch", hide_index=True)

        if llm:
            st.subheader(f"④ LLM verdict ({sq.LLM_MODEL})")
            st.metric("LLM overall", f"{llm.overall}/100")
            if llm.subscores:
                st.dataframe([{"dimension": k, "score": v} for k, v in llm.subscores.items()],
                             width="stretch", hide_index=True)
            if llm.flags:
                st.warning("**LLM flags:**\n\n" + "\n".join(f"- {f}" for f in llm.flags))
            if llm.reasoning:
                st.markdown(f"**Reasoning:** {llm.reasoning}")

        st.subheader("⑤ Consolidated")
        if llm:
            st.markdown(f"`{CFG['W_PROB']}·{prob.overall:.3f} + {CFG['W_NEAR']}·{nm.score:.3f} + "
                        f"{CFG['W_LLM']}·{llm_norm:.3f} = {consolidated:.3f}`")
        else:
            denom = CFG["W_PROB"] + CFG["W_NEAR"]
            st.markdown(f"LLM absent → re-normalized: `({CFG['W_PROB']}·{prob.overall:.3f} + "
                        f"{CFG['W_NEAR']}·{nm.score:.3f}) / {denom:.2f} = {consolidated:.3f}`")

# ===========================================================================
# TAB 2 — Analysis Dashboard
# ===========================================================================

with tab_dash:
    st.caption("Probability, Near-match and LLM scores across every logged query — "
               "and how they relate to each other and to query characteristics.")

    data = corpus_scores()

    rc1, rc2 = st.columns([3, 1])
    with rc2:
        if st.button("↻ Recompute scores", width="stretch",
                     help="Re-score the whole corpus. Includes LLM only if the sidebar "
                          "toggle is ON (otherwise Prob+Near only)."):
            prog = st.progress(0.0, text="Scoring…")
            def _cb(i, n, ncalls):
                prog.progress(i / n, text=f"Scoring {i}/{n}  ({ncalls} LLM calls)")
            payload = score_corpus.build(use_llm=use_llm, progress=_cb)
            CORPUS_SCORES_PATH.parent.mkdir(parents=True, exist_ok=True)
            CORPUS_SCORES_PATH.write_text(json.dumps(payload, indent=2), encoding="utf-8")
            st.cache_data.clear()
            st.rerun()

    if data is None:
        st.warning("No cached corpus scores yet. Generate them with:\n\n"
                   "```bash\n.venv/bin/python scripts/score_corpus.py\n```\n\n"
                   "…or click **↻ Recompute scores** above (uses the sidebar LLM toggle).")
        st.stop()

    df = pd.DataFrame(data["rows"])
    df["llm_norm"] = df["llm"] / 100.0
    df["sql_short"] = df["sql"].str.slice(0, 90)
    df["flagged"] = df["n_flags"] > 0
    has_llm = df["llm"].notna().any()
    meta = data["meta"]

    rc1.markdown(
        f"**{meta['n_rows']}** logged queries · LLM: "
        f"{'`'+meta['llm_model']+'` ('+str(meta['n_llm_calls'])+' unique calls)' if meta['llm_used'] else 'not computed'}")

    # ---- filters ----
    with st.expander("🔧 Filters", expanded=False):
        fc1, fc2, fc3 = st.columns(3)
        complexities = sorted(df["complexity"].unique())
        sel_cx = fc1.multiselect("Complexity", complexities, default=complexities)
        only_flagged = fc2.checkbox("Only flagged queries", value=False)
        rng = fc3.slider("Consolidated range", 0.0, 1.0, (0.0, 1.0), 0.05)

    dff = df[df["complexity"].isin(sel_cx) & df["consolidated"].between(*rng)]
    if only_flagged:
        dff = dff[dff["flagged"]]
    if dff.empty:
        st.warning("No queries match the current filters.")
        st.stop()

    # auto-computed values used in the plain-language notes (so they track the filters)
    def _corr(a, b):
        s = dff[[a, b]].dropna()
        if len(s) < 3 or s[a].nunique() < 2 or s[b].nunique() < 2:
            return None
        return float(s[a].corr(s[b]))

    def _fmt(x):
        return "n/a" if x is None else f"{x:.2f}"

    corr_pn = _corr("probability", "near_match")
    corr_pl = _corr("probability", "llm_norm")
    pct_high = 100 * (dff["consolidated"] >= 0.8).mean()
    pct_flag = 100 * dff["flagged"].mean()
    cx_mean = dff.groupby("complexity")["consolidated"].mean()

    # ---- KPIs ----
    k1, k2, k3, k4, k5 = st.columns(5)
    k1.metric("Queries", len(dff))
    k2.metric("Mean consolidated", f"{dff['consolidated'].mean():.3f}")
    k3.metric("Mean probability", f"{dff['probability'].mean():.3f}")
    k4.metric("% flagged", f"{100*dff['flagged'].mean():.1f}%")
    if has_llm and dff["llm_norm"].notna().sum() > 2:
        corr = dff[["probability", "llm_norm"]].corr().iloc[0, 1]
        k5.metric("corr(Prob, LLM)", f"{corr:.2f}")
    else:
        k5.metric("corr(Prob, LLM)", "—")

    # ---- 1. centerpiece scatter ----
    st.subheader("① Probability vs Near-match  (color = LLM verdict)")
    st.caption("Where the three scorers agree vs disagree. Bottom-left + red = confidently low; "
               "spread = disagreement worth inspecting. Hover for the SQL.")
    fig = px.scatter(
        dff, x="probability", y="near_match",
        color="llm" if has_llm else "consolidated",
        color_continuous_scale="RdYlGn", range_color=[0, 100] if has_llm else [0, 1],
        hover_data={"sql_short": True, "title": True, "consolidated": ":.3f",
                    "complexity": True, "probability": ":.3f", "near_match": ":.3f",
                    "llm": True, "llm_norm": False},
        labels={"probability": "Probability score", "near_match": "Near-match score",
                "llm": "LLM verdict"},
        height=560)
    fig.update_traces(marker=dict(size=7, opacity=0.6))
    st.plotly_chart(fig)
    explain(
        "It checks whether our three independent scoring methods *agree* on a query. When all "
        "three rate a query the same way we can trust the verdict; when they disagree, that "
        "query is worth a human look.",
        "Every dot is one query. Further **right** = the statistical 'probability' check is "
        "confident; **higher up** = it closely matches queries we've run before; **green** = the "
        "AI liked it, **red** = the AI didn't. The trustworthy queries sit in the green top-right.",
        f"About **{pct_high:.0f}%** of queries land in the high-confidence zone. The two "
        f"statistical scorers move together (agreement ≈ {_fmt(corr_pn)} on a −1→1 scale), but "
        f"the AI's colours are scattered fairly evenly — a sign it rates most things highly "
        f"regardless, so it adds less *discriminating* signal than the statistical checks.")

    cL, cR = st.columns(2)

    # ---- 2. distributions ----
    with cL:
        st.subheader("② Score distributions")
        melt_cols = ["probability", "near_match"] + (["llm_norm"] if has_llm else [])
        melted = dff.melt(value_vars=melt_cols, var_name="scorer", value_name="score")
        melted["scorer"] = melted["scorer"].map(
            {"probability": "Probability", "near_match": "Near-match", "llm_norm": "LLM (÷100)"})
        h = px.histogram(melted, x="score", color="scorer", barmode="overlay",
                         nbins=25, opacity=0.6, height=380)
        st.plotly_chart(h)
        explain(
            "It shows the overall *shape* of our scores — are most queries trusted, or is "
            "confidence spread all over the place?",
            "Taller bars mean more queries fall at that score. Bars toward the right (near 1.0) "
            "are high-confidence queries; a bump on the left is the low-confidence ones.",
            f"Scores bunch toward the high end (about **{pct_high:.0f}%** of queries score 0.8 "
            "or above). That's expected — these are real, previously-run queries — and the small "
            "left tail is exactly the set worth reviewing.")

    # ---- 3. correlation heatmap ----
    with cR:
        st.subheader("③ Scorer agreement (correlation)")
        cols = ["probability", "near_match", "consolidated"] + (["llm_norm"] if has_llm else [])
        corrm = dff[cols].corr().round(2)
        hm = px.imshow(corrm, text_auto=True, color_continuous_scale="RdBu",
                       zmin=-1, zmax=1, aspect="auto", height=380)
        st.plotly_chart(hm)
        explain(
            "It answers a key question: do our scorers measure the *same* thing or *different* "
            "things? If two always agree, one is redundant; if they differ, each adds a unique "
            "signal.",
            "**Blue** = the two scores move together, **red** = they move oppositely, and the "
            "number (−1 to 1) is the strength. The 1.0 diagonal is each score compared with itself.",
            f"Probability and Near-match agree moderately ({_fmt(corr_pn)}). The AI score barely "
            f"tracks them (≈ {_fmt(corr_pl)}, even slightly negative) — it judges on a different, "
            "more lenient basis. That's the evidence behind weighting the statistical scorers "
            "more heavily than the AI in the final number.")

    cL2, cR2 = st.columns(2)

    # ---- 4. mean score by complexity ----
    with cL2:
        st.subheader("④ Mean score by query complexity")
        gcols = ["probability", "near_match"] + (["llm_norm"] if has_llm else [])
        g = (dff.groupby("complexity")[gcols].mean().reset_index()
                .melt(id_vars="complexity", var_name="scorer", value_name="mean_score"))
        g["scorer"] = g["scorer"].map(
            {"probability": "Probability", "near_match": "Near-match", "llm_norm": "LLM (÷100)"})
        b = px.bar(g, x="complexity", y="mean_score", color="scorer", barmode="group",
                   height=380, category_orders={"complexity": ["single-table", "2-table join", "3+-table join"]})
        st.plotly_chart(b)
        explain(
            "It checks whether queries get harder to trust as they grow more complex (more "
            "tables joined together).",
            "Bars are grouped by query type — single-table, 2-table join, 3+-table join. Taller "
            "bars mean higher confidence for that group.",
            f"Confidence stays fairly steady across complexity (single-table ≈ "
            f"{_fmt(cx_mean.get('single-table'))}, 2-table ≈ {_fmt(cx_mean.get('2-table join'))}, "
            f"3+-table ≈ {_fmt(cx_mean.get('3+-table join'))}). The scorer isn't unfairly "
            "penalising complex queries — a reassuring sign of fairness.")

    # ---- 5. score vs runtime ----
    with cR2:
        st.subheader("⑤ Consolidated vs query runtime")
        sc = px.scatter(dff, x="duration_ms", y="consolidated", color="complexity",
                        size="rows_returned", size_max=18, opacity=0.6,
                        hover_data={"sql_short": True, "title": True}, height=380,
                        labels={"duration_ms": "Duration (ms)", "consolidated": "Consolidated"})
        st.plotly_chart(sc)
        explain(
            "A sanity check: a query's confidence should reflect whether it *looks normal*, not "
            "how long it took to run or how big its result was.",
            "Left–right = how long the query took (ms); up–down = its confidence; dot size = rows "
            "returned. We *don't* want a strong slope here.",
            f"There's essentially no link between runtime and confidence (relationship ≈ "
            f"{_fmt(_corr('duration_ms', 'consolidated'))}). Good — slow or large queries aren't "
            "being mistaken for bad ones; the score is about query *shape*, not cost.")

    # ---- 6. box & whisker (spread + outliers per score) ----
    st.subheader("⑥ Box & whisker — spread + outliers per score")
    st.caption("Box = 25–75% (IQR), line = median, ◆ = mean ± sd, whiskers = 1.5×IQR; "
               "dots beyond the whiskers are statistical outliers. Hover an outlier for its query.")
    box_map = {"probability": "Probability", "near_match": "Near-match",
               "llm_norm": "LLM (÷100)", "consolidated": "Consolidated"}
    mb = (dff.melt(id_vars=["sql_short", "title"], value_vars=list(box_map),
                   var_name="score", value_name="value")
             .dropna(subset=["value"]))
    mb["score"] = mb["score"].map(box_map)
    fig_box = px.box(mb, x="score", y="value", color="score", points="outliers",
                     hover_data={"sql_short": True, "title": True, "score": False},
                     category_orders={"score": list(box_map.values())},
                     height=420, range_y=[-0.02, 1.02],
                     labels={"value": "score", "score": ""})
    fig_box.update_traces(boxmean="sd")
    fig_box.update_layout(showlegend=False)
    st.plotly_chart(fig_box)

    # auto-computed summary under the box plot (matches the dots: Tukey 1.5×IQR, both sides)
    box_summary = []
    for col_key, label in box_map.items():
        s = dff[col_key].dropna()
        if s.empty:
            continue
        q1, q3 = s.quantile(0.25), s.quantile(0.75)
        iqr = q3 - q1
        lo, hi = q1 - 1.5 * iqr, q3 + 1.5 * iqr
        n_out = int(((s < lo) | (s > hi)).sum())
        box_summary.append({
            "score": label, "median": round(s.median(), 3),
            "mean": round(s.mean(), 3), "std": round(s.std(), 3),
            "Q1": round(q1, 3), "Q3": round(q3, 3), "IQR": round(iqr, 3),
            "# outliers": n_out, "% outliers": f"{100 * n_out / len(s):.1f}%",
        })
    st.dataframe(box_summary, width="stretch", hide_index=True)
    explain(
        "A compact 'health check' of each score: where the typical values sit and how many "
        "unusual, low-scoring queries (outliers) each method produces.",
        "The **box** holds the middle 50% of queries, the **line** is the typical (median) query, "
        "the **◆** is the average, and the **dots below** are outliers — hover one to see the query.",
        "Near-match is the steadiest scorer (tightest box, almost no outliers). The AI score is "
        "squashed at the very top with a long tail of outliers beneath it — again the "
        "'rates-everything-high' pattern. Probability has the widest box, meaning it separates "
        "strong from questionable queries the most. The table above lists the exact figures.")

    # ---- 7. per-score scatter (one plot per score) ----
    st.subheader("⑦ Per-score scatter — every query as a point")
    st.caption("One plot per score. Each dot is a query; red = flagged. The dashed line is the "
               "mean. Sorted view = a 'score profile' (how many queries sit low vs high).")
    order = st.radio("X axis", ["Sorted by score (score profile)", "Log order (query #)"],
                     horizontal=True, key="perscore_order")
    specs = [("probability", "Probability score"),
             ("near_match", "Near-match score"),
             ("llm_norm", "LLM verdict (÷100)")]
    pscols = st.columns(3)
    for (col_key, label), c in zip(specs, pscols):
        with c:
            sub = dff.dropna(subset=[col_key]).copy()
            if sub.empty:
                st.info(f"No data for {label}.")
                continue
            if order.startswith("Sorted"):
                sub = sub.sort_values(col_key).reset_index(drop=True)
                sub["x"] = range(1, len(sub) + 1)
                xlab = "query rank (low → high)"
            else:
                sub = sub.sort_values("query_num")
                sub["x"] = sub["query_num"]
                xlab = "query #"
            fig_s = px.scatter(
                sub, x="x", y=col_key, color="flagged",
                color_discrete_map={True: "#d62728", False: "#2ca02c"},
                hover_data={"sql_short": True, "title": True, "consolidated": ":.3f", "x": False},
                labels={col_key: label, "x": xlab, "flagged": "flagged"},
                height=360, title=label, range_y=[-0.02, 1.02])
            fig_s.add_hline(y=sub[col_key].mean(), line_dash="dash", line_color="gray",
                            annotation_text=f"mean {sub[col_key].mean():.2f}")
            fig_s.update_traces(marker=dict(size=5, opacity=0.6))
            st.plotly_chart(fig_s)
    explain(
        "It lays out every query's score from lowest to highest for each method, so you can see "
        "the full 'profile' and spot exactly where the weak queries begin.",
        "Each dot is a query, lined up worst (left) to best (right). **Red** dots are queries our "
        "system flagged with a concrete problem; the dashed line is the average.",
        f"The AI's line is almost flat near the top — little separation between queries. The "
        f"statistical scorers slope more, so they distinguish quality better. Flagged (red) dots "
        f"cluster at the low end, where they should. About **{pct_flag:.0f}%** of queries carry a "
        "flag.")

    # ---- 8. outliers ----
    st.subheader("⑧ Lowest-scoring queries (inspect these)")
    out_cols = ["consolidated", "probability", "near_match", "llm", "complexity", "n_flags", "sql_short"]
    st.dataframe(dff.nsmallest(15, "consolidated")[out_cols], width="stretch", hide_index=True)
    explain(
        "This is the actionable shortlist — the lowest-confidence queries, the ones a reviewer "
        "should look at first.",
        "Sorted worst-first. **n_flags** counts concrete problems we detected (e.g. a table or "
        "column that doesn't exist in the database). Hover/scroll to read each query.",
        "The very lowest scores are typically queries that reference tables or columns which "
        "don't exist — exactly the kind of mistake (including AI-generated 'hallucinations') "
        "this tool is built to catch before such a query is ever trusted.")
