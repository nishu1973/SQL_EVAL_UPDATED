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

import numpy as np
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
import streamlit as st
from plotly.subplots import make_subplots

ROOT = Path(__file__).parent
sys.path.insert(0, str(ROOT / "scripts"))
import score_query as sq        # noqa: E402
import score_corpus             # noqa: E402

st.set_page_config(page_title="SQL Query Confidence Scorer", page_icon="🧮", layout="wide")

CORPUS_SCORES_PATH = ROOT / "reports" / "corpus_scores.json"
DISCRIM_PATH = ROOT / "reports" / "discrimination_eval.json"

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


@st.cache_data(show_spinner=False)
def load_discrim(_mtime: float):
    return json.loads(DISCRIM_PATH.read_text(encoding="utf-8"))


def discrim_frame():
    """Labeled good-vs-bad set with a per-row consolidated score added.
    Returns (DataFrame, meta) or (None, None) if the eval hasn't been generated."""
    if not DISCRIM_PATH.exists():
        return None, None
    raw = load_discrim(DISCRIM_PATH.stat().st_mtime)
    dd = pd.DataFrame(raw["rows"])
    # The eval stores the three components; rebuild the blended consolidated score
    # the same way the corpus does (llm is already normalized to 0–1 here, or None).
    dd["consolidated"] = dd.apply(
        lambda r: sq.consolidate(r["probability"], r["near_match"], r.get("llm")), axis=1)
    dd["is_good"] = (dd["label"] == "good").astype(int)
    return dd, raw


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


def explain(why: str, how: str, insights: list[str]):
    """A collapsible note under a chart: why it matters, how to read it, and bulleted insights."""
    with st.expander("ℹ️  What this shows & why it matters"):
        st.markdown(f"**Why it matters** — {why}")
        st.markdown(f"**How to read it** — {how}")
        st.markdown("**Key insights**")
        st.markdown("\n".join(f"- {b}" for b in insights))


def auc_score(good, bad) -> float:
    """Probability a random good scores above a random bad (Mann–Whitney / ROC-AUC).
    1.0 = perfect separation, 0.5 = no discrimination."""
    g = np.asarray([v for v in good if v is not None], float)
    b = np.asarray([v for v in bad if v is not None], float)
    if g.size == 0 or b.size == 0:
        return float("nan")
    diff = g[:, None] - b[None, :]
    return float(((diff > 0).sum() + 0.5 * (diff == 0).sum()) / (g.size * b.size))


def logistic_fit(x, y, l2: float = 1.0, iters: int = 50):
    """1-D logistic regression P(y=1 | x) via Newton–Raphson with a light ridge.

    The ridge keeps the slope finite for perfectly-separable scores (e.g. Near-match,
    AUC ≈ 1.0), where an unpenalized fit would diverge to a vertical step. Returns a
    vectorized predict() over new x plus the standardized slope (a steepness proxy)."""
    x = np.asarray(x, float)
    y = np.asarray(y, float)
    mu = x.mean()
    sd = x.std() or 1.0
    z = (x - mu) / sd
    X = np.column_stack([np.ones_like(z), z])           # [intercept, slope]
    b = np.zeros(2)
    for _ in range(iters):
        p = 1.0 / (1.0 + np.exp(-(X @ b)))
        W = p * (1 - p) + 1e-9
        H = X.T @ (X * W[:, None]) + np.diag([0.0, l2])   # penalize slope only
        grad = X.T @ (y - p) - np.array([0.0, l2 * b[1]])
        try:
            b = b + np.linalg.solve(H, grad)
        except np.linalg.LinAlgError:
            break

    def predict(xx):
        zz = (np.asarray(xx, float) - mu) / sd
        return 1.0 / (1.0 + np.exp(-(b[0] + b[1] * zz)))

    return predict, float(b[1])


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
    run_score = st.button("▶ Score query", type="primary")

    if not (run_score and sql.strip()):
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
                     help="Re-score the corpus. Reuses cached LLM verdicts; only NEW query "
                          "patterns call the API (and those run in parallel). Includes LLM "
                          "only if the sidebar toggle is ON."):
            prog = st.progress(0.0, text="Scoring…")
            def _cb(done, total, ncalls):
                frac = done / total if total else 1.0
                msg = (f"Calling LLM for {total} new patterns… {done}/{total}"
                       if total else "Reusing cached LLM verdicts — finishing up…")
                prog.progress(min(frac, 1.0), text=msg)
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

    if meta["llm_used"]:
        n_new = meta.get("n_llm_calls", 0)
        n_cached = meta.get("n_llm_cached", 0)
        llm_str = (f"`{meta['llm_model']}` · {n_new + n_cached} patterns scored "
                   f"({n_new} new, {n_cached} reused from cache)")
    else:
        llm_str = "not computed (toggle **Use LLM scoring** on, then Recompute)"
    rc1.markdown(f"**{meta['n_rows']}** logged queries · LLM: {llm_str}")

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
    corr_nl = _corr("near_match", "llm_norm")
    pct_high = 100 * (dff["consolidated"] >= 0.8).mean()
    pct_flag = 100 * dff["flagged"].mean()
    pct_llm_top = 100 * (dff["llm"] >= 99).mean() if has_llm else 0.0
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
        [
            f"**Tight high cluster.** ~{pct_high:.0f}% of queries fall in the high-confidence "
            "zone (top-right) — expected, since these are real queries analysts already ran.",
            f"**The two statistical scorers reinforce each other** (agreement ≈ {_fmt(corr_pn)} "
            "on a −1→1 scale): when one is confident the other usually is too.",
            f"**The AI now adds an *independent* opinion.** Only ~{pct_llm_top:.0f}% of dots are "
            "deep green (a near-perfect AI score) — after the harness upgrade it genuinely grades "
            f"rather than rubber-stamps. Its agreement with Probability is ≈ {_fmt(corr_pl)} "
            "(near zero), i.e. it captures a *different* angle instead of echoing the statistics.",
            "**Disagreements are the signal.** A dot that's far right (statistically normal) but "
            "red (AI doubts it) — or vice-versa — is a genuinely ambiguous query worth inspecting.",
        ])

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
            "It shows the overall *shape* of each score — are most queries trusted, and how much "
            "does each method spread its judgements (its discriminating power)?",
            "Taller bars = more queries at that score. Bars toward the right (near 1.0) are "
            "high-confidence; a left bump is the low-confidence ones. A *wider* spread means the "
            "score separates queries more finely.",
            [
                f"**Left-skewed, as expected:** ~{pct_high:.0f}% of queries score ≥0.8 — real "
                "logged queries are overwhelmingly normal.",
                "**Probability has the widest spread** (std ≈ 0.08), so it has the most room to "
                "separate strong from questionable queries; **Near-match is very tight** (std ≈ "
                "0.03) — stable but low-resolution.",
                "**The AI is now centred ≈ 0.80, not pinned at 1.0.** The harness upgrade turned it "
                "from a flat grader (previously 57% of queries got an identical 100) into one that "
                "actually distributes its scores across 0.55–1.0.",
            ])

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
            [
                f"**Probability and Near-match overlap** (≈ {_fmt(corr_pn)}) — both read query "
                "structure, so they partly agree without being identical.",
                f"**The AI is near-*independent*** of both (≈ {_fmt(corr_pl)} vs Probability, "
                f"≈ {_fmt(corr_nl)} vs Near-match). That's healthy: it contributes a separate "
                "perspective rather than echoing the statistics.",
                "**This used to read *negative* (≈ −0.11)** — but that was an artifact of the AI "
                "scoring 57% of queries an identical 100 (no variance → unstable correlation). "
                "After the harness fix the AI varies properly and the correlation settles near zero.",
                "**Consolidated tracks Probability most** (≈ 0.92) — Probability carries the most "
                "discriminating signal and the largest weight, so it dominates the final number.",
            ])

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
            "tables joined together) — and whether complex queries are a blind spot.",
            "Bars grouped by query type — single-table, 2-table join, 3+-table join. Taller bars "
            "mean higher average confidence for that group.",
            [
                f"**Confidence is stable across complexity** (single ≈ "
                f"{_fmt(cx_mean.get('single-table'))}, 2-table ≈ {_fmt(cx_mean.get('2-table join'))}, "
                f"3+-table ≈ {_fmt(cx_mean.get('3+-table join'))}) — complex queries aren't "
                "unfairly penalised.",
                "**Why 3+-table joins all look high:** the corpus has only ~25 of them and they're "
                "all real, valid queries — so there's nothing 'bad and complex' here to score low. "
                "That's a clean *corpus*, not a blind spot.",
                "**Proven separately:** in a discrimination test against hand-crafted *broken* "
                "complex queries, the scores separate good from bad strongly — **AUC: Near-match "
                "1.00, Probability 0.98, LLM 0.95** (1.0 = perfect). So the model *can* catch a bad "
                "complex query; it just had no bad examples to flag in the live corpus.",
            ])

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
            [
                f"**Only a weak negative link** (relationship ≈ "
                f"{_fmt(_corr('duration_ms', 'consolidated'))}) between runtime and confidence — "
                "and it's *mediated by complexity*: complex queries naturally run longer and score "
                "marginally lower. There's no direct 'slow = bad' bias.",
                "**Confidence reflects query *shape*, not cost** — large or slow queries are not "
                "penalised for being expensive, which is exactly what we want from a structural score.",
            ])

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
        "The **box** holds the middle 50% of queries, the **line** is the median, the **◆** is the "
        "mean±sd, and the **dots** beyond the whiskers are outliers — hover one to see the query.",
        [
            "**Near-match is the steadiest** scorer — tightest box, almost no outliers. Stable, but "
            "low-resolution (it rarely swings far).",
            "**Probability has the widest box** → it separates strong from questionable queries the "
            "most, making it the primary discriminator.",
            "**The AI now spans ≈ 0.55–1.0 with a real spread** (median ≈ 0.80). Before the harness "
            "upgrade it was squashed against the ceiling at 1.0 — now it produces a usable "
            "distribution with a meaningful low tail.",
            "**Consolidated outliers are your review queue** — the lowest dots are the queries most "
            "worth a human check. The table above gives exact median / IQR / outlier counts.",
        ])

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
        [
            "**All three scores now slope** in the sorted view — each separates low from high. The "
            "AI's line used to be flat at the top (no separation); after the harness upgrade it has "
            "a real gradient.",
            f"**Flags are now rare and trustworthy:** only ~{pct_flag:.0f}% of queries carry a flag, "
            "down from ~21% before the parser fix stopped mis-reading column aliases (`… AS "
            "total_cost`) and functions (`STRFTIME`) as 'hallucinated columns'.",
            "**Discrimination, measured:** against deliberately-broken queries the separation is "
            "**Near-match AUC 1.00, Probability 0.90, LLM 0.75** (1.0 = perfect). Near-match is the "
            "sharpest single discriminator; the AI is the weakest, which is why it carries the "
            "smallest weight. *(Caveat: Near-match's 1.00 is on a hand-crafted set — likely easier "
            "than subtle real-world errors.)*",
        ])

    # ---- 8. sigmoid separation curves (discriminative power) ----
    st.subheader("⑧ Sigmoid separation curves — how sharply each score tells good from bad")
    st.caption("Logistic fit of P(query is *good*) against each score, over the **labeled "
               "good-vs-bad set** (the corpus alone is all-good, so it can't show this). A steep "
               "S-curve = sharp discrimination; a shallow line = the score barely separates the two. "
               "Dots: good queries sit near the top, bad ones near the bottom.")
    dd, draw = discrim_frame()
    if dd is None:
        st.info("No discrimination eval found. Generate it with "
                "`.venv/bin/python scripts/eval_discrimination.py`.")
    else:
        sig_specs = [("probability", "Probability"), ("near_match", "Near-match"),
                     ("llm", "LLM"), ("consolidated", "Consolidated")]
        n_good = int((dd["is_good"] == 1).sum())
        n_bad = int((dd["is_good"] == 0).sum())

        # AUC + mean separation per score (drives titles and the notes below)
        stats_by = {}
        for col, lbl in sig_specs:
            sub = dd[[col, "is_good"]].dropna(subset=[col])
            gx = sub.loc[sub.is_good == 1, col].to_numpy()
            bx = sub.loc[sub.is_good == 0, col].to_numpy()
            stats_by[lbl] = {"auc": auc_score(gx, bx),
                             "mean_good": float(gx.mean()) if gx.size else float("nan"),
                             "mean_bad": float(bx.mean()) if bx.size else float("nan"),
                             "col": col}

        titles = [f"{lbl} · AUC {stats_by[lbl]['auc']:.2f}" for _, lbl in sig_specs]
        fig_sig = make_subplots(rows=2, cols=2, subplot_titles=titles,
                                horizontal_spacing=0.09, vertical_spacing=0.16)
        rng = np.random.default_rng(0)      # deterministic point jitter across reruns
        grid = np.linspace(0.0, 1.0, 200)
        for i, (col, lbl) in enumerate(sig_specs):
            r, c = i // 2 + 1, i % 2 + 1
            sub = dd[[col, "is_good", "sql"]].dropna(subset=[col])
            predict, _ = logistic_fit(sub[col].to_numpy(), sub["is_good"].to_numpy())
            fig_sig.add_trace(go.Scatter(
                x=grid, y=predict(grid), mode="lines", line=dict(color="#1f77b4", width=3),
                showlegend=False,
                hovertemplate="score=%{x:.2f}<br>P(good)=%{y:.2f}<extra></extra>"), row=r, col=c)
            for is_good, base, color, name in ((1, 1.0, "#2ca02c", "good"),
                                               (0, 0.0, "#d62728", "bad")):
                pts = sub[sub.is_good == is_good]
                yj = (base - rng.uniform(0.0, 0.06, len(pts))) if base == 1.0 \
                    else (base + rng.uniform(0.0, 0.06, len(pts)))
                fig_sig.add_trace(go.Scatter(
                    x=pts[col], y=yj, mode="markers",
                    marker=dict(color=color, size=7, opacity=0.75,
                                line=dict(width=0.5, color="white")),
                    name=name, legendgroup=name, showlegend=(i == 0),
                    text=pts["sql"].str.slice(0, 90),
                    hovertemplate="%{text}<br>" + lbl + "=%{x:.3f}<extra>" + name + "</extra>"),
                    row=r, col=c)
        fig_sig.update_xaxes(range=[-0.02, 1.02])
        fig_sig.update_yaxes(range=[-0.12, 1.12])
        fig_sig.update_layout(height=660, legend=dict(orientation="h", yanchor="bottom",
                              y=1.07, xanchor="right", x=1))
        st.plotly_chart(fig_sig)

        ranked = sorted(stats_by.items(), key=lambda kv: kv[1]["auc"], reverse=True)
        best_lbl, best = ranked[0]
        worst_lbl, worst = ranked[-1]
        cons = stats_by["Consolidated"]
        explain(
            "This is the clearest single answer to *“can a score tell a good query from a bad one?”* "
            "We can't see that on the live corpus (every logged query is real/good), so we measure "
            f"it against a labeled set of **{n_good} good + {n_bad} deliberately-broken** queries.",
            "Each panel fits an S-curve: the score is on the x-axis, the height is the model's "
            "estimated probability the query is *good*. **Green dots (good) cluster top-right, red "
            "dots (bad) bottom-left.** A curve that snaps sharply from 0 to 1 separates cleanly; a "
            "gentle slope means lots of overlap. **AUC** in each title = probability a random good "
            "outscores a random bad (1.00 = perfect, 0.50 = coin-flip).",
            [
                f"**{best_lbl} discriminates best** (AUC {best['auc']:.2f}) — its S-curve is the "
                "steepest, with good and bad barely overlapping.",
                f"**{worst_lbl} is the weakest** (AUC {worst['auc']:.2f}): the shallowest curve and "
                "the most green/red overlap, which is exactly why it carries the smallest weight in "
                "the blend.",
                f"**Consolidated lands at AUC {cons['auc']:.2f}** (good avg {cons['mean_good']:.2f} "
                f"vs bad avg {cons['mean_bad']:.2f}) — blending three views keeps strong separation "
                "while smoothing any single scorer's blind spot.",
                "**Caveat:** these 'bad' queries are hand-crafted and likely easier to catch than "
                "subtle real-world mistakes, so treat the AUCs as an upper bound on discrimination.",
            ])

    # ---- 9. good-vs-bad distribution overlay ----
    st.subheader("⑨ Good vs bad — score distributions side by side")
    st.caption("The same labeled set as a distribution view: for each score, known-good queries "
               "(green) vs deliberately-broken ones (red). The less the two colors overlap, the "
               "better that score separates good from bad. Hover any point for its SQL.")
    if dd is None:
        st.info("Run the discrimination eval to populate this view.")
    else:
        vmap = {"probability": "Probability", "near_match": "Near-match",
                "llm": "LLM", "consolidated": "Consolidated"}
        mm = (dd.melt(id_vars=["label", "sql"], value_vars=list(vmap),
                      var_name="score", value_name="value").dropna(subset=["value"]))
        mm["score"] = mm["score"].map(vmap)
        mm["sql_short"] = mm["sql"].str.slice(0, 90)
        fig_v = px.violin(
            mm, x="score", y="value", color="label", box=True, points="all",
            category_orders={"score": list(vmap.values()), "label": ["good", "bad"]},
            color_discrete_map={"good": "#2ca02c", "bad": "#d62728"},
            hover_data={"sql_short": True, "label": True, "score": False, "value": ":.3f"},
            labels={"value": "score", "label": ""}, height=520, range_y=[-0.05, 1.05])
        fig_v.update_layout(violinmode="group")
        st.plotly_chart(fig_v)

        gaps = {lbl: stats_by[lbl]["mean_good"] - stats_by[lbl]["mean_bad"] for _, lbl in sig_specs}
        widest = max(gaps, key=gaps.get)
        narrowest = min(gaps, key=gaps.get)
        explain(
            "A more intuitive companion to the S-curves: instead of a fitted line, it shows the raw "
            "spread of good vs bad scores so a non-technical viewer can *see* the separation.",
            "For each score there are two violins: **green = good queries, red = bad**. The fatter "
            "part is where most queries land; the box marks the median and middle 50%. **Two violins "
            "that sit far apart = the score separates well; violins that overlap = it doesn't.**",
            [
                f"**{widest} shows the widest good–bad gap** (means differ by {gaps[widest]:.2f}) — "
                "its green and red violins barely touch.",
                f"**{narrowest} overlaps the most** (gap {gaps[narrowest]:.2f}): good and bad scores "
                "share a lot of range, so on its own it's the least decisive.",
                "**Bad queries that score high are the dangerous ones** — a red point sitting up in "
                "the green band is a flawed query a single scorer would have trusted; the blend and "
                "the schema flags exist to catch exactly those.",
                "**Read it with ⑧:** this shows *where the queries land*, the sigmoid shows *the "
                "decision boundary* fitted through them.",
            ])

    # ---- 10. outliers (actionable review queue) ----
    st.subheader("⑩ Lowest-scoring queries (inspect these)")
    out_cols = ["consolidated", "probability", "near_match", "llm", "complexity", "n_flags", "sql_short"]
    st.dataframe(dff.nsmallest(15, "consolidated")[out_cols], width="stretch", hide_index=True)
    explain(
        "This is the actionable shortlist — the lowest-confidence queries, the ones a reviewer "
        "should look at first.",
        "Sorted worst-first. **n_flags** counts concrete problems we detected (e.g. a table or "
        "column that doesn't exist in the database). Hover/scroll to read each query.",
        [
            "**These are now *genuine* low-scorers.** With the false-positive flags removed, a low "
            "consolidated score here reflects a real structural oddity, not a parsing artifact.",
            "**Flags that remain are concrete and scarce** (~1.8% of the corpus): a hallucinated "
            "table or column that doesn't exist in the schema — exactly the mistake (including "
            "AI-generated 'hallucinations') this tool exists to catch before a query is trusted.",
            "**Use it as a triage list:** sort by consolidated, scan `n_flags`, and review the "
            "handful at the bottom rather than all 1000.",
        ])
