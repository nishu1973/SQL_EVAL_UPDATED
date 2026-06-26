# Scoring Mechanism — Improvement Plan

> **Status: IMPLEMENTED ✅** (all 5 phases complete; 147 tests passing). This document is the
> approved plan; results are in [scoring_refinement_results.md](scoring_refinement_results.md).
> A parsing-hygiene fix (strip string literals, exclude SQL-keyword/table-name tokens, expand
> the function list) was added during Phase 5 after the new flags exposed phantom-column noise.
>
> **Inputs to this plan:**
> - Shortcomings catalogue → [scoring_method_refinement.md](scoring_method_refinement.md)
> - Worked mechanism → [working_mechanism.md](working_mechanism.md)
> - Your four scoping decisions (below)

---

## 0. Decisions locked in (your answers)

| Decision | Choice |
|---|---|
| **Scope / ambition** | **Targeted improvements** — fix confirmed bugs + high-severity design flaws; keep the regex parser and the 3-scorer architecture. |
| **LLM integration** | **Deterministic core + LLM layer** — blend all three when the LLM is available; cleanly fall back to a reproducible Prob+Near score otherwise. Validate LLM output. |
| **Schema grounding** | **Yes** — read the real schema from `wealth_management_diverse.db` and separate *validity* (does it exist) from *popularity* (how often logged). |
| **Anomaly handling** | **Worst-offender weighted** — blend mean with the worst instance so a single hallucinated column/table is visible, without hard caps. |

Out of scope by your choice: replacing the regex parser with a real AST parser (`sqlglot`),
a full calibration/threshold model. These are noted in §7 as deferred.

---

## 1. Design overview — what the scorer becomes

The three-scorer structure stays. The changes are surgical:

```
                          ┌─────────────────────────────────────┐
NEW: load_schema()  ──────│ schema map {TABLE: {col,...}}        │
(wealth_management_        └──────────────┬──────────────────────┘
 diverse.db)                              │ feeds validity checks
                                          ▼
 input SQL ─► parse_query ─► QueryInfo ─► ┌── Scorer 1 Probability ──┐
                 (alias fix)              │   validity-aware metric   │
                                          │   worst-offender agg      │──┐
                                          └───────────────────────────┘  │
                                          ┌── Scorer 2 LLM ───────────┐  │  0.45
                                          │   validated + clamped     │──┼──0.25──► consolidated
                                          └───────────────────────────┘  │  0.30   (LLM-aware,
                                          ┌── Scorer 3 Near-match ────┐  │          deterministic
                                          │   dedup + top-k robust    │──┘          fallback)
                                          └───────────────────────────┘
```

All new behavior is **additive and flag-controlled** — `--no-llm` keeps the deterministic
core byte-for-byte reproducible.

---

## 2. The changes, in detail

### Change 1 — Real-schema grounding (NEW signal)  🔴 addresses §4.1, §1.1

**New helper:** `load_schema(db_path) -> dict[str, set[str]]`, reading
`PRAGMA table_info` for each table in
[raw_data/wealth_management_diverse.db](raw_data/wealth_management_diverse.db). Result e.g.
`{"ATOM_ENTITY_PORTFOLIO_HOLDING_001": {"HOLDING_ID","INVESTOR_ID","INVESTMENT_TYPE", …}}`.

**Three-tier classification** replaces today's binary "known/unknown":

| Tier | Condition | Meaning | Effect on score |
|---|---|---|---|
| **Familiar** | in schema **and** in logs | normal, established | full credit (scaled by frequency) |
| **Valid-but-novel** | in schema, **not** in logs | legitimate, just unusual | mid credit (no longer 0 — fixes the false-negative) |
| **Invalid** | **not** in schema | hallucinated table/column | 0 + flagged as a real anomaly |

This is applied to **Table Familiarity** and **Column Coverage** (and column references in
join keys / filters). It is the cleanest fix for "popularity ≠ validity."

### Change 2 — Validity-aware relative metric (replace `_rel_score`)  🔴 addresses §1.1

Today: `min(c / max(corpus_counter), 1.0)` — unstable, corpus-skew dependent, punishes
legitimate-but-rare features.

**New `feature_score`** combines schema-validity with a *saturating* frequency curve (no
longer divides by the single most-popular feature):

```
feature_score(col, table, count):
    if col not in schema[table]:        return 0.0          # invalid / hallucinated
    if count == 0:                      return S_VALID      # valid but never logged
    return S_VALID + (1 - S_VALID) * min(count / T_SAT, 1.0)
```

- `S_VALID` — baseline credit for "exists in schema." **Proposed: 0.5** (tunable).
- `T_SAT` — occurrences at which a feature is "established" → full 1.0. **Proposed: derive
  per-table as a low percentile of that table's column-frequency distribution** (fallback
  constant ~10). Tunable.

Effect: a column used 50× and one used 500× both saturate to ~1.0 (both clearly normal);
a valid-but-unlogged column scores 0.5 instead of 0.0; a hallucinated column scores 0.0.

### Change 3 — Worst-offender aggregation (replace per-dimension mean)  🔴 addresses §1.2

Every multi-instance dimension changes from `mean(instances)` to:

```
dim_score = ALPHA * mean(instances) + (1 - ALPHA) * min(instances)
```

- `ALPHA` — **Proposed: 0.6** (tunable). At 0.6, one hallucinated column among ten valid
  ones moves a dimension from ~1.0 to ~0.6·0.9 + 0.4·0.0 = **0.54** (was 0.90) — now clearly
  visible, but normal variation isn't over-penalized.

Applied to: Column Coverage, Join Pattern, Join Key Validity, Filter Familiarity, Filter
Operator, Aggregation Pattern. (Table Familiarity stays a fraction but uses the 3-tier
weighting from Change 1.)

### Change 4 — Fix the Column-Coverage merge bug  🟠 addresses §1.3 (confirmed bug)

[score_query.py:390](scripts/score_query.py#L390): `Counter({**select, **where})` overwrites
instead of summing. Replace with proper addition:
```python
combined = s["select_cols"] + s["where_cols"]   # Counter addition sums overlapping keys
```
and hoist it **out of the per-column loop** (compute once per table). Also reconcile the
numerator to use the same combination (`cnt_sel + cnt_whr`) rather than `max(...)`.

### Change 5 — Fix the alias-as-aggregation-column artifact  🟠 addresses §1.6, §3 (parsing)

In `parse_query`, when tokenizing aggregation targets (`SUM(h.current_value)` → `H`,
`CURRENT_VALUE`), **drop tokens that are table aliases** (`info.aliases` keys) and resolve
`alias.col` to the owning table. This stops `SUM(H)` from scoring 0 and dragging the
Aggregation dimension to 0.5 (the exact artifact seen in
[working_mechanism.md](working_mechanism.md) §1.7).

### Change 6 — LLM scorer: validate, clamp, and integrate  🟠 addresses §2.1–2.4

**Hardening (`score_llm`):**
- Range-check & clamp every subscore and `overall` to `[0,100]`.
- One retry on JSON-parse failure; if still bad, return a typed "unavailable" result
  (not a silent `0`, which §2.3 showed would crater the score).
- Normalize to `[0,1]` for blending: `llm_norm = overall / 100`.

**New consolidated formula (deterministic core + LLM layer):**
```
if llm available and valid:
    consolidated = W_PROB·prob + W_NEAR·near + W_LLM·llm_norm
else:                                   # --no-llm, no API key, or LLM invalid
    consolidated = (W_PROB·prob + W_NEAR·near) / (W_PROB + W_NEAR)   # re-normalized
```

- **Proposed weights:** `W_PROB = 0.45`, `W_NEAR = 0.30`, `W_LLM = 0.25` (statistics-dominant,
  meaningful LLM voice). **Tunable — needs your sign-off (§5).**
- The fallback re-normalizes to `0.45/0.30 → 0.60/0.40`, i.e. **exactly today's behavior**, so
  `--no-llm` runs stay reproducible and unchanged.

### Change 7 — Near-match robustness (dedup + top-k)  🟠 addresses §3.1, §3.2

Two targeted changes (no embeddings — staying in "targeted" scope):
1. **Deduplicate the corpus by normalized SQL** before scoring, so 5 identical "Gold"
   queries don't all masquerade as a cluster (we saw this in the walkthrough).
2. **Blend best with a robust top-k aggregate** instead of trusting a single hit:
   ```
   near_score = BETA · best + (1 - BETA) · mean(top_k_distinct)
   ```
   - `BETA` — **Proposed: 0.7** (tunable); `k` — **Proposed: 5 distinct patterns**.
   - Rewards being near a *real cluster*, not one outlier. `best_score` still reported.

### Change 8 — Surface richer output (no math change)  🟡 addresses §4.7

Add the three-tier validity flags (invalid table/column lists) and the per-dimension
worst-instance to the report + JSON, so the consolidated scalar isn't the only thing a
reviewer sees. Cheap, high value for interpretability.

---

## 3. Shortcomings → disposition map

Every item from the analysis, and what this plan does with it:

| Ref | Shortcoming | Disposition |
|---|---|---|
| §4.1 | Real schema never used | ✅ Change 1 |
| §1.1 | `_rel_score` = popularity not validity | ✅ Change 2 |
| §1.2 | Averaging hides anomalies | ✅ Change 3 |
| §1.3 | Column-coverage merge bug | ✅ Change 4 (confirmed bug) |
| §1.6 / parsing | Alias mistaken for agg column | ✅ Change 5 |
| §1.5 | Filter-operator `0.5` default | ✅ folded into Change 2 (schema-aware default) |
| §1.4 | Table familiarity ignores frequency | ✅ Change 1 (3-tier) |
| §2.1 | LLM unused | ✅ Change 6 |
| §2.2 | LLM breaks determinism | ✅ Change 6 (deterministic fallback) |
| §2.3 | No LLM output validation | ✅ Change 6 |
| §2.4 | LLM scale mismatch | ✅ Change 6 (÷100) |
| §3.1 | Near-match ignores frequency | ✅ Change 7 (dedup) |
| §3.2 | Single-best fragility | ✅ Change 7 (top-k) |
| §4.7 | Consolidated hides signal | ✅ Change 8 |
| §1.9, §3.7, §1.7 | Magic-number weights / N/A renorm | ⚠️ Partial — all weights centralized into a tunable config block (§5); behavior unchanged pending calibration |
| §2.5–2.8 | LLM context truncation / taxonomy / cost / caching | ⏭️ Deferred (not high-severity for targeted scope) |
| §3.3–3.6 | Token order-blindness / brittle regex / semantic sim / re-parse cost | ⏭️ Deferred |
| §4.2 | Regex parser fragility (CTE/window/UNION) | ⏭️ Deferred (would be the "full redesign" path) |
| §4.3, §4.4, §4.5 | No calibration / leakage / uncertainty | ⏭️ Deferred (needs a labeled validation set — propose as a follow-up project) |

---

## 4. Implementation phases (the build order)

Each phase is independently testable; we stop and verify between phases.

- **Phase 1 — Foundation & bug fixes** (low risk): `load_schema()`, Change 4 (merge bug),
  Change 5 (alias artifact). Existing tests must stay green.
- **Phase 2 — Validity-aware scoring**: Change 1 (3-tier) + Change 2 (`feature_score`) +
  Change 3 (worst-offender). New unit tests for each.
- **Phase 3 — LLM layer**: Change 6 (validation, clamp, new consolidated formula + fallback).
  Determinism test: `--no-llm` output must be reproducible and match the re-normalized 60/40.
- **Phase 4 — Near-match robustness**: Change 7 (dedup + top-k).
- **Phase 5 — Output + docs + before/after**: Change 8, update README/REPORT, regenerate the
  18-query test report, produce a before/after delta table.

**Config block** (added in Phase 1, used throughout) centralizes every tunable:
```python
SCORING_CONFIG = {
    "S_VALID": 0.5, "T_SAT": None,       # None => per-table adaptive
    "ALPHA": 0.6,                         # worst-offender blend
    "W_PROB": 0.45, "W_NEAR": 0.30, "W_LLM": 0.25,
    "BETA": 0.7, "TOP_K": 5,              # near-match
}
```

---

## 5. What needs your sign-off before we build

The design is settled; these are **parameter values** — defaults proposed, easy to change:

1. **Consolidated weights** `W_PROB / W_NEAR / W_LLM = 0.45 / 0.30 / 0.25`. OK, or shift
   the LLM's influence up/down?
2. **Worst-offender `ALPHA = 0.6`** (higher = closer to today's mean; lower = harsher on
   outliers). OK?
3. **`S_VALID = 0.5`** (credit for "exists in schema but never logged"). OK?
4. **Near-match `BETA = 0.7`, `k = 5`**. OK?

I can also just proceed with all proposed defaults and we tune them in Phase 5 against the
before/after report — your call.

---

## 6. How we'll verify it works

- **Unit tests** (extend [tests/test_score_query.py](tests/test_score_query.py)): schema
  loading; the 3 validity tiers; `feature_score` saturation; worst-offender aggregation;
  LLM clamp/retry/fallback; near-match dedup + top-k.
- **Determinism test**: `--no-llm` must be byte-stable and equal the re-normalized 60/40.
- **Regression via the 18-query batch**
  ([tests/generate_test_results.py](tests/generate_test_results.py)): run before & after,
  produce a delta table. Acceptance criteria:
  - Known-good queries (groups 1–3) stay **high** (≥ ~0.85).
  - Anomalous queries (group 4: unknown tables, hallucinated columns) drop **further** than
    today (target ≤ ~0.40, sharper separation).
  - The "valid-but-unlogged column" case (a new test query) should **rise** vs today (no
    longer wrongly penalized).
- **The two walkthrough queries** from [working_mechanism.md](working_mechanism.md) re-scored,
  to confirm the alias artifact and the schema grounding behave as designed.

---

## 7. Explicitly deferred (candidates for a future "full redesign")

- Real SQL parser (`sqlglot`) replacing regex (§4.2, §3.4).
- Embedding/semantic near-match (§3.5) and a persisted feature index (§3.6).
- A labeled validation set + calibrated thresholds + ROC/PR metrics + uncertainty (§4.3–4.5).
- LLM caching, prompt calibration, taxonomy alignment with the 7 dimensions (§2.5–2.8).

---

_Next step: you review/approve this plan (and confirm or adjust the four parameters in §5).
On approval, we begin **Step 3 — implementation**, starting with Phase 1._
