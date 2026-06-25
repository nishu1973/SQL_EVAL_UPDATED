# Scoring Mechanism — Shortcomings Analysis

> **Purpose of this document:** a deep, critical audit of the current SQL query
> scoring mechanism in [scripts/score_query.py](scripts/score_query.py), to surface
> *every* shortcoming before we design refinements.
>
> **Status:** Step 1 of 3 — _Analysis_. (Next: a prioritized improvement plan; then
> implementation.) This file is intentionally **diagnosis only** — no fixes proposed yet.
>
> **Scope reminder — what exists today:**
> - **Scorer 1 — Probability** (statistical, 7 dimensions) → feeds 60% of consolidated
> - **Scorer 2 — LLM** (`gpt-4o`, 5 subscores) → computed but **0% weight** (unused)
> - **Scorer 3 — Near-match** (structural 65% + token 35% Jaccard) → feeds 40% of consolidated
> - `consolidated = 0.60·prob_overall + 0.40·near_match_best`

---

## 0. Executive summary — the headline problems

| # | Shortcoming | Severity | Where |
|---|---|---|---|
| A | **The real database schema is never consulted** — validity is approximated by *log popularity* only | 🔴 Critical | whole design |
| B | **`_rel_score` measures popularity, not validity** — a legitimate-but-rare column scores near 0 | 🔴 Critical | [L360](scripts/score_query.py#L360) |
| C | **Averaging dilutes anomalies** — one hallucinated column among ten valid ones barely dents the score | 🔴 Critical | all dimensions |
| D | **Column-coverage merge bug** — `Counter({**a, **b})` overwrites instead of summing select+where counts | 🟠 Bug | [L390](scripts/score_query.py#L390) |
| E | **LLM score is wasted** (0% weight) and, if used, breaks determinism with no output validation | 🟠 High | [L545](scripts/score_query.py#L545) |
| F | **Near-match uses unweighted Jaccard + single best hit** — matching one rare/weird query scores as high as matching the dominant pattern | 🟠 High | [L748](scripts/score_query.py#L748) |
| G | **Regex parsing is the shared, fragile foundation** — CTEs, windows, UNION, nested subqueries mis-parse and corrupt *all three* scorers | 🟠 High | [L54-L75](scripts/score_query.py#L54) |
| H | **No calibration, thresholds, or validation set** — score bands (0.84–0.95 "good") are anecdotal, not measured | 🟠 High | — |
| I | **Magic-number weights everywhere** — dimension & feature weights are hand-picked with no empirical basis | 🟡 Medium | [L338](scripts/score_query.py#L338), [L708](scripts/score_query.py#L708) |
| J | **N/A re-normalization rewards trivial queries** — the less a query does, the easier a high score | 🟡 Medium | [L505](scripts/score_query.py#L505) |

Detail for each follows, grouped by scorer.

---

## 1. Scorer 1 — Probability-based (statistical)

### 1.1 `_rel_score` conflates *popularity* with *validity* 🔴
[score_query.py:360](scripts/score_query.py#L360)

```
rel_score(c, C) = min(c / max(C), 1.0)   if c > 0  else  0.0
```

The denominator is the count of the **single most popular** feature in the category.
Consequences:

- A perfectly valid, legitimately-used column that simply isn't the *most* popular is
  punished. If `INVESTOR_ID` was filtered 500×, a column filtered 50× scores `50/500 = 0.10`
  — even though 50 occurrences clearly means "this is a known, normal column."
- The metric answers *"how close to the most popular feature is this?"* — **not** the
  question we actually care about: *"is this feature normal / known / valid?"*
- It's **brittle to corpus skew**: one dominant column drags every other column's score down.

This is the single most pervasive flaw — it underlies Column Coverage, Join Key Validity,
Filter Familiarity, Filter Operator, and Aggregation Pattern.

### 1.2 Averaging across instances hides anomalies 🔴
Every multi-instance dimension takes the **arithmetic mean** of per-instance scores
(e.g. Column Coverage at [L396](scripts/score_query.py#L396)). For *anomaly detection* this
is the wrong aggregator:

- A query selecting 9 known columns + 1 hallucinated column scores `(9·1.0 + 0)/10 = 0.90`
  — barely distinguishable from a clean query. The one red flag is averaged away.
- We almost certainly want the **worst offender to dominate** (a min, a penalty, or a
  noisy-OR), not be smoothed out.

### 1.3 Column-coverage merge bug 🟠
[score_query.py:390](scripts/score_query.py#L390)

```python
combined = Counter({**s["select_cols"], **s["where_cols"]})
```

Dict unpacking **overwrites** overlapping keys — it does **not** sum. If a column appears
in `select_cols` 90× and `where_cols` 40×, the merged counter records **40**, silently
discarding the 90. The clear intent was to combine frequencies (`select + where`).
Additionally:

- The numerator uses `cnt = max(cnt_sel, cnt_whr)` ([L389](scripts/score_query.py#L389)) —
  also not a sum — so numerator and denominator use inconsistent combination logic.
- `combined` is **rebuilt inside the per-column loop**, so it's recomputed once per column
  (O(cols × table_vocabulary)) — needless work.

### 1.4 Table Familiarity ignores frequency and is binary 🟡
[score_query.py:372](scripts/score_query.py#L372) — `score = known/total`. A table seen
**once** in 1000 queries counts identically to one seen 500×. No notion of how
*established* a table is; a barely-used table gets full marks.

### 1.5 Filter-Operator `0.5` default is arbitrary 🟡
[score_query.py:468](scripts/score_query.py#L468) — when a column has no operator history,
the op scores a hardcoded `0.5`. Unjustified midpoint. Also this dimension only scores ops
for columns *already in* `where_cols` ([L464](scripts/score_query.py#L464)), creating a
coverage gap with Filter Familiarity (the two dimensions partition the work in a way that's
easy to get wrong).

### 1.6 Aggregation pattern: first-table `break` mis-attributes 🟡
[score_query.py:494](scripts/score_query.py#L494) — for `FUNC(col)` it credits the *first*
table in `info.tables` that has the combination and `break`s. In multi-table queries the
agg may belong to a different table; the early break can both over- and under-credit.

### 1.7 N/A re-normalization systematically favors trivial queries 🟡
[score_query.py:505](scripts/score_query.py#L505) — inapplicable dimensions are dropped and
weights re-normalized. A bare `SELECT col FROM known_table` is evaluated on just 2–3
dimensions, all trivially ≈1.0, so it scores ≈1.0. **The less a query does, the easier a
near-perfect score.** Complexity is effectively rewarded with *more chances to lose points*,
which is backwards for "confidence."

### 1.8 Single-table column ownership is a blunt heuristic 🟡
[score_query.py:130-135](scripts/score_query.py#L130) — for single-table queries, *every*
bare token in SELECT/WHERE is attributed to that table unless in `SKIP`/`AGG_NAMES`. Any
unlisted function name, keyword, or alias leaks into the column lists, polluting stats and
scores.

### 1.9 Weights are unvalidated magic numbers 🟡
[score_query.py:338](scripts/score_query.py#L338) — `0.20/0.20/0.20/0.10/0.15/0.05/0.10`.
No empirical or theoretical justification; never tuned against labeled outcomes.

---

## 2. Scorer 2 — LLM-based (`gpt-4o`)

### 2.1 Currently contributes 0% — pure waste 🟠
[score_query.py:545](scripts/score_query.py#L545) + consolidation at
[L919](scripts/score_query.py#L919). It is computed (cost + latency) but never used in the
headline number. (This is the change the project now wants — but see the tradeoffs below.)

### 2.2 Folding it in sacrifices determinism 🟠
`temperature=0` reduces but does **not** eliminate variance, and model/version drift means
the same query can score differently next month. The consolidated score is currently
fully reproducible offline; including the LLM forfeits that. **This tension must be a
first-class decision in the plan**, not an afterthought.

### 2.3 No output validation or schema enforcement 🟠
[score_query.py:618-624](scripts/score_query.py#L618) — `data.get("overall", 0)` and
`data.get("subscores", {})`. If the model returns a malformed/missing field, the code
**silently defaults to 0**, which would crater the consolidated score. No range check
(subscores ∈ [0,100]), no retry, no fallback.

### 2.4 Scale mismatch (0–100 vs 0–1) 🟡
LLM is 0–100; Prob and Near-match are 0–1. Any blend must normalize, or the LLM will
dominate by sheer magnitude.

### 2.5 Context truncation may drop the relevant evidence 🟡
[score_query.py:555](scripts/score_query.py#L555) — per-table narrative truncated to 1500
chars with no awareness of *what* is being cut; the discriminating detail might be in the
tail.

### 2.6 Taxonomy mismatch with the statistical scorer 🟡
LLM returns **5** dimensions ([L599-L605](scripts/score_query.py#L599)); probability uses
**7**. Different names, different granularity → cross-scorer comparison and any
"agreement" logic is semantically muddy.

### 2.7 Cost, latency, no caching 🟡
One `gpt-4o` call per query. Batch scoring at scale is slow and expensive; identical queries
re-pay the cost (no memoization/cache).

### 2.8 Prompt susceptible to anchoring/leniency 🟡
The model is shown the historical patterns then asked "does this conform" — a framing prone
to confirmation bias. No calibration examples, no adversarial "find what's wrong" framing.

---

## 3. Scorer 3 — Near-match (corpus similarity)

### 3.1 Jaccard ignores corpus frequency entirely 🟠
[score_query.py:700](scripts/score_query.py#L700) + corpus load at
[L725](scripts/score_query.py#L725). Every historical query is weighted equally. Matching a
**one-off, possibly-anomalous** historical query scores exactly as high as matching the
pattern that appears 800×. The corpus is neither deduplicated nor frequency-weighted, so
"near a real example" can mean "near a single weird example."

### 3.2 Using only the single best hit is fragile 🟠
[score_query.py:761-775](scripts/score_query.py#L761) — `near_match_best = max(combined)`.
An input that happens to nearly-duplicate **one** outlier query gets a high score. A
density / k-NN-average / centroid approach would be far more robust. (`mean_top5` is even
computed but then ignored by the consolidation.)

### 3.3 Token similarity is order- and count-blind 🟡
[score_query.py:659](scripts/score_query.py#L659) — bag-of-identifiers set Jaccard. Repeated
tokens collapse; clause order is ignored; `SELECT a` vs `SELECT a,b,c,d` can look similar.

### 3.4 Normalization regexes are brittle and domain-hardcoded 🟡
[score_query.py:650](scripts/score_query.py#L650) — `_INVESTOR_` only matches `INV-\d+`;
dates only match `YYYY-MM-DD`. Any other ID/date format escapes normalization and inflates
token differences, distorting similarity.

### 3.5 Purely lexical/structural — no semantic similarity 🟡
Two semantically identical queries (reordered joins, different aliases, synonymous columns)
score low; lexically similar but semantically different queries score high. No embeddings,
no canonicalization.

### 3.6 Re-parses the entire corpus on every invocation 🟡
[score_query.py:725](scripts/score_query.py#L725) — `load_corpus` re-parses all 1000
queries each run; O(N) scan, no persisted feature index. Won't scale to large corpora (no
ANN/embedding index, no precomputation).

### 3.7 Structural feature weights are magic numbers 🟡
[score_query.py:708](scripts/score_query.py#L708) — `0.35/0.20/0.20/0.15/0.07/0.03`,
unvalidated.

---

## 4. Cross-cutting / systemic shortcomings

### 4.1 The actual schema is never used 🔴
The real database [raw_data/wealth_management_diverse.db](raw_data/wealth_management_diverse.db)
contains the true 8 tables and their real columns — but **nothing in the scorer consults
it**. Validity is proxied entirely by *log frequency*. Two consequences:

- **False negatives:** a genuinely valid table/column that was simply never logged is
  penalized as "unseen / unusual" even though it's structurally correct.
- **Missed ground truth:** we have an authoritative source of "what is structurally legal"
  and ignore it. Schema validation (does this column exist on this table?) is orthogonal to,
  and stronger than, popularity — and currently absent.

### 4.2 Regex parsing is a shared single point of failure 🟠
[score_query.py:54-75](scripts/score_query.py#L54) — the same regex extraction feeds all
three scorers. It does not robustly handle CTEs (`WITH`), window functions, `UNION`, nested
subqueries (collapsed to `(SUBQ)`), `CASE` expressions, or quoted identifiers. A parse error
**propagates identically** into Prob and Near-match (and the LLM's structured inputs). A real
SQL parser (e.g. `sqlglot`/`sqlparse`) would give a robust, shared, correct foundation.

### 4.3 No calibration, thresholds, or labeled validation 🟠
There is no labeled set of "good vs anomalous" queries, no ROC/precision-recall, no defined
accept/flag/reject cutoffs. The "0.84–0.95 = known, 0.30–0.50 = anomalous" bands in the
report are **anecdotal**. We can't currently state the scorer's accuracy.

### 4.4 Potential train/test leakage 🟡
[tests/generate_test_results.py](tests/generate_test_results.py) scores queries against the
same corpus they may overlap with; near-match scores are likely inflated. No held-out split.

### 4.5 Scores are point estimates with no uncertainty 🟡
A query over tables with very few historical samples should carry wide uncertainty, but is
reported as a confident point score. No sample-size awareness, no confidence interval.

### 4.6 No query-validity / executability gate 🟡
A syntactically broken or non-executable query can still receive a structural score. There's
no parse-validity check and no dry-run against the real schema.

### 4.7 Consolidation collapses rich signal into two scalars 🟡
[score_query.py:919](scripts/score_query.py#L919) — `prob_overall` and `near_match_best`
are the only survivors. Per-dimension detail, `mean_top5`, flags, and the entire LLM output
are discarded from the final number. The headline hides actionable structure.

### 4.8 No persistence / no incremental corpus updates 🟡
Stats and corpus are rebuilt from scratch each run; there's no way to incrementally add new
logged queries or cache derived features.

---

## 5. What is *not* broken (keep these)

To stay balanced — these design choices are sound and worth preserving:

- **Separation into independent scorers** is a genuine strength: they fail differently
  (statistical = interpretable per-dimension; near-match = "this is basically query #427";
  LLM = holistic + human-readable). Ensemble thinking is right.
- **N/A handling exists at all** — the *idea* of excluding inapplicable dimensions is correct,
  even if the re-normalization has the side effect in §1.7.
- **Literal normalization for near-match** (so `INV-001` ≈ `INV-099`) is the right instinct,
  just under-generalized (§3.4).
- **Deterministic, offline-capable core** (Prob + Near) is valuable; whatever we do with the
  LLM should preserve a deterministic fallback.
- **The structured `QueryInfo` abstraction** cleanly decouples parsing from scoring — a good
  seam to build on (e.g. swap regex for a real parser behind it).

---

## 6. Open questions to resolve before planning

These need decisions in Step 2 (the improvement plan):

1. **Determinism vs LLM:** do we accept non-reproducible headline scores, or keep a
   deterministic core and treat the LLM as an adjustable, overridable component?
2. **Validity source:** do we introduce real-schema validation from
   `wealth_management_diverse.db` as a distinct signal (recommended), separate from
   popularity?
3. **Anomaly aggregation:** switch from mean to a worst-offender / penalty / noisy-OR
   aggregation for catching outliers?
4. **Popularity metric:** replace max-normalization with something that distinguishes
   "valid/known" from "most popular" (e.g. presence + a saturating frequency curve, or a
   probability estimate)?
5. **Near-match robustness:** frequency-weight the corpus and/or move from single-best to
   k-NN density?
6. **Parsing:** adopt a real SQL parser to harden the shared foundation?
7. **Calibration:** can we build/label a validation set to set thresholds and measure
   accuracy?
8. **New consolidated formula & weights:** target blend of the three scorers, LLM scale
   normalization, and behavior when the LLM is unavailable.

---

_Next step: turn this analysis into a prioritized improvement plan (Step 2). No code changes
until that plan is reviewed and finalized._
