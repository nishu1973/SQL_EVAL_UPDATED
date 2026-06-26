# Scoring Mechanism — Fully Worked Walkthrough

> **Purpose:** understand the *current* scoring mechanism end-to-end by tracing it, by hand,
> on two concrete queries. Every number below was produced by actually running
> [scripts/score_query.py](scripts/score_query.py) `--no-llm --json` against the real corpus
> ([raw_data/parsed_query_logs.db](raw_data/parsed_query_logs.db), 1000 queries) and then
> reconciled against the formulas. Nothing here is invented — you can reproduce it.
>
> Reproduce:
> ```bash
> python3 scripts/score_query.py --no-llm --json "<query>"
> ```
>
> The two queries are deliberately chosen for contrast:
> - **Query A — "known / in-distribution":** a textbook two-table join+aggregate+filter.
> - **Query B — "anomalous":** valid tables, but a join pair the corpus almost never uses.
>
> Both exercise all 7 probability dimensions, so you see the full machinery twice.

---

## The two queries

**Query A** (known pattern):
```sql
SELECT p.investor_name, SUM(h.current_value)
FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h
JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id
WHERE h.investment_type = 'Mutual Fund'
GROUP BY p.investor_name
```

**Query B** (anomalous join):
```sql
SELECT g.investment_goal, COUNT(*)
FROM ATOM_ENTITY_INVESTMENT_GOAL_001 g
LEFT JOIN ATOM_EVENT_CASH_FLOW_001 c ON g.investor_id = c.investor_id
WHERE c.amount > 50000
GROUP BY g.investment_goal
```

**Final results up front** (so you know where we're heading):

| | Probability | Near-match (best) | **Consolidated** | LLM |
|---|---|---|---|---|
| **Query A** | 0.9076 | 1.000 | **0.9446** | (n/a — skipped) |
| **Query B** | 0.5526 | 0.5063 | **0.5341** | (n/a — skipped) |

The mechanism correctly separates the in-distribution query (~0.94) from the anomalous one
(~0.53). The rest of this doc explains *exactly how* those two numbers were built.

---

## Step 0 — Parse the query into features (`parse_query`)

Before any scoring, the SQL is regex-decomposed into a `QueryInfo` struct.

**Query A → QueryInfo:**
| Field | Value |
|---|---|
| `tables` | `[HOLDING, PROFILE]` |
| `aliases` | `{H: HOLDING, P: PROFILE}` |
| `select_cols` | `{PROFILE: [INVESTOR_NAME], HOLDING: [CURRENT_VALUE]}` |
| `where_cols` | `{HOLDING: [INVESTMENT_TYPE]}` |
| `where_ops` | `[(INVESTMENT_TYPE, =)]` |
| `agg_pairs` | `[(SUM, H.CURRENT_VALUE)]`  ← parsed as two tokens: `H` and `CURRENT_VALUE` |
| `join_pairs` | `[(HOLDING, PROFILE)]` |
| `join_keys` | `{HOLDING: [INVESTOR_ID], PROFILE: [INVESTOR_ID]}` |

*(Table names abbreviated: `HOLDING` = `ATOM_ENTITY_PORTFOLIO_HOLDING_001`, `PROFILE` =
`ATOM_ENTITY_INVESTOR_PROFILE_001`, `GOAL` = `ATOM_ENTITY_INVESTMENT_GOAL_001`, `CASH_FLOW`
= `ATOM_EVENT_CASH_FLOW_001`.)*

⚠️ **Already a quirk to notice:** `SUM(h.current_value)` is split into the tokens `H` and
`CURRENT_VALUE`. The alias `H` is treated as if it were an aggregation target column. This
will cost Query A points in the Aggregation dimension — see §1.7.

**Query B → QueryInfo:**
| Field | Value |
|---|---|
| `tables` | `[GOAL, CASH_FLOW]` |
| `select_cols` | `{GOAL: [INVESTMENT_GOAL]}` (the `COUNT(*)` contributes no column) |
| `where_cols` | `{CASH_FLOW: [AMOUNT]}` |
| `where_ops` | `[(AMOUNT, >)]` |
| `agg_pairs` | `[(COUNT, *)]` |
| `join_pairs` | `[(GOAL, CASH_FLOW)]` |
| `join_keys` | `{GOAL: [INVESTOR_ID], CASH_FLOW: [INVESTOR_ID]}` |

---

## Step 0.5 — The corpus counters these scores compare against

`load_stats()` rebuilds per-table frequency `Counter`s from all 1000 logged queries. Here
are the exact numbers used below (pulled live from the corpus):

**HOLDING** (`query_count=500`)
- combined select+where, top: `INVESTOR_ID:90, INVESTMENT_TYPE(select):80, INVESTMENT_TYPE(where):69` → **max = 90**
- where_cols, top: `INVESTOR_ID:90` → **max = 90**
- join_partners: `PROFILE:110, GOAL:10, REBALANCING:10` → **max = 110**
- join_keys: `INVESTOR_ID:210` → **max = 210**
- agg `SUM` targets: `CURRENT_VALUE:105, COST:55, DIVIDENDS:35` → **max = 105**
- where_col_ops `INVESTMENT_TYPE`: `{=: 24}`

**PROFILE** (`query_count=260`)
- combined select+where: `INVESTOR_NAME:85, RISK_TOLERANCE:80` → **max = 85**
- join_keys: `INVESTOR_ID:425` → **max = 425**

**GOAL** (`query_count=90`)
- combined select+where: `INVESTMENT_GOAL:40` → **max = 40**
- join_partners: `PROFILE:45, HEALTH:15, HOLDING:10` → **max = 45**; partner `CASH_FLOW: 5`

**CASH_FLOW** (`query_count=195`)
- combined select+where: `TYPE:140, INVESTOR_ID:60` → **max = 140**
- where_cols: `TYPE:140` → **max = 140**; `AMOUNT` filtered **5×**
- join_partners: `PROFILE:10, HEALTH:10, GOAL:5` → **max = 10**; partner `GOAL: 5`
- join_keys: `INVESTOR_ID:30`

Keep `_rel_score` in mind throughout — it's the engine of almost every dimension:
```
rel_score(c, C) = min( c / max(C), 1.0 )   if c > 0  else  0.0
```

---

## Scorer 1 — Probability (statistical). Query A, dimension by dimension

### 1.1 Table Familiarity — `score = known/total`
Both tables exist in the corpus → `2/2 = ` **1.000**.

### 1.2 Column Coverage — average of `rel_score` over SELECT+WHERE cols
Columns: `HOLDING.CURRENT_VALUE`, `HOLDING.INVESTMENT_TYPE`, `PROFILE.INVESTOR_NAME`.
Each is normalized against its own table's combined max.

| Column | count (`max(sel,whr)`) | table combined max | rel_score |
|---|---|---|---|
| HOLDING.CURRENT_VALUE | 90 | 90 | `90/90 =` 1.00 |
| HOLDING.INVESTMENT_TYPE | 80 | 90 | `80/90 =` 0.89 |
| PROFILE.INVESTOR_NAME | 85 | 85 | `85/85 =` 1.00 |

`column_coverage = (1.00 + 0.89 + 1.00) / 3 = ` **0.963**.

### 1.3 Join Pattern — `min(freq / max_partner_freq, 1.0)` per pair
Pair `(HOLDING, PROFILE)`: they were joined **110×**. `max_partner_freq` = max over both
tables' top partner counts = `max(110, 110) = 110`.
`110/110 = ` **1.000**.

### 1.4 Join Key Validity — `rel_score` of each ON-clause column vs join-key counter
- `HOLDING.INVESTOR_ID`: `210/210 = 1.00`
- `PROFILE.INVESTOR_ID`: `425/425 = 1.00`

`join_key_validity = ` **1.000**.

### 1.5 Filter Familiarity — `rel_score` of each WHERE col vs that table's where_cols counter
- `HOLDING.INVESTMENT_TYPE`: filtered **69×**, HOLDING where max = **90** → `69/90 = ` **0.767**.

### 1.6 Filter Operator — `rel_score` of the op within that column's op-history
- `INVESTMENT_TYPE =`: op counter is `{=: 24}`, max = 24 → `24/24 = ` **1.000**.

### 1.7 Aggregation Pattern — average over `FUNC(col)` tokens
Recall `SUM(h.current_value)` parsed into **two** tokens: `H` and `CURRENT_VALUE`.

| `FUNC(token)` | seen on a table? | score |
|---|---|---|
| `SUM(H)` | no (`H` is an alias, not a column) | 0.00 |
| `SUM(CURRENT_VALUE)` | yes, 105× on HOLDING (max 105) | `105/105 =` 1.00 |

`aggregation_pattern = (0.00 + 1.00)/2 = ` **0.500**.

👉 **This is a textbook example of two flaws compounding:** a *parsing* artifact (the alias
`H` mistaken for a column) and the *averaging* aggregator together drag a perfectly valid
`SUM(current_value)` down to 0.5.

### 1.8 Weighted overall (all 7 dimensions applicable here, weights sum to 1.0)

| Dimension | score | weight | contribution |
|---|---|---|---|
| Table Familiarity | 1.000 | 0.20 | 0.2000 |
| Column Coverage | 0.963 | 0.20 | 0.1926 |
| Join Pattern | 1.000 | 0.20 | 0.2000 |
| Join Key Validity | 1.000 | 0.10 | 0.1000 |
| Filter Familiarity | 0.767 | 0.15 | 0.1150 |
| Filter Operator | 1.000 | 0.05 | 0.0500 |
| Aggregation Pattern | 0.500 | 0.10 | 0.0500 |
| **Overall** | | **1.00** | **0.9076** |

```
prob_overall(A) = 0.9076
```

---

## Scorer 1 — Probability. Query B (the anomalous one), compact trace

| Dimension | computation | score |
|---|---|---|
| Table Familiarity | both tables known → 2/2 | 1.000 |
| Column Coverage | `INVESTMENT_GOAL 40/40=1.00`; `AMOUNT 105/140=0.75` → avg | 0.875 |
| **Join Pattern** | pair `(GOAL, CASH_FLOW)` seen only **5×**; max_partner_freq = `max(45, 10) = 45` → `5/45` | **0.111** |
| Join Key Validity | `GOAL.INVESTOR_ID 130/130=1.0`; `CASH_FLOW.INVESTOR_ID 30/30=1.0` | 1.000 |
| **Filter Familiarity** | `CASH_FLOW.AMOUNT` filtered **5×**, table where max = **140** → `5/140` | **0.036** |
| Filter Operator | `AMOUNT >` seen 5× (only op) → `5/5` | 1.000 |
| **Aggregation Pattern** | `COUNT(*)` never recorded for these tables | **0.000** |

Weighted overall (all 7 applicable):
```
0.20(1.0) + 0.20(0.875) + 0.20(0.111) + 0.10(1.0)
+ 0.15(0.036) + 0.05(1.0) + 0.10(0.0)
= 0.2 + 0.175 + 0.0222 + 0.1 + 0.0054 + 0.05 + 0.0
prob_overall(B) = 0.5526
```

**What dragged B down:** the *Join Pattern* (0.111 — GOAL and CASH_FLOW are rarely joined),
*Filter Familiarity* (0.036 — almost nobody filters CASH_FLOW on `amount`), and
*Aggregation* (0.0 — bare `COUNT(*)` unseen for these tables). The mechanism is doing its
job: this query uses real tables in an unusual *combination*.

---

## Scorer 2 — LLM (`gpt-4o`). Conceptual (not run here — `--no-llm`)

This scorer is **computed but contributes 0%** to the consolidated score, and we skipped it
above (no API call). For completeness, here is what it *would* do for either query:

1. **Build context:** for each table in the query, pull its narrative section from
   [reports/query_analysis.md](reports/query_analysis.md) (truncated to 1500 chars). If the
   table has no narrative, fall back to raw counters (top-8 SELECT/WHERE cols, top-5 join
   partners/keys, top-5 agg fns). If a table isn't in the logs at all, inject a "⚠️ Not
   found" warning.
2. **Prompt `gpt-4o`** (temperature 0, JSON mode) with that context + the query's parsed
   tables/joins/where-cols/aggs, asking for:
   - 5 subscores **0–100**: `table_familiarity`, `column_relevance`, `join_conformance`,
     `filter_conformance`, `aggregation_conformance`
   - an `overall` **0–100**
   - a list of `flags` (e.g. for Query B it would likely flag *"unusual join: INVESTMENT_GOAL
     ⋈ CASH_FLOW rarely co-occur"*)
   - a `reasoning` narrative
3. **Output is displayed only** — it is *not* blended into the consolidated number today.
   (Changing that is the upcoming refinement.)

The key mechanical difference from Scorers 1 & 3: there is **no formula** — the number is the
model's judgment, and it is non-deterministic across model versions.

---

## Scorer 3 — Near-match (corpus similarity). Query A

This compares the input against **all 1000 historical queries** and keeps the closest.
Each comparison blends two Jaccard measures.

### 3.1 The structural feature sets for Query A
```
tables     = {HOLDING, PROFILE}
sel_cols   = {PROFILE.INVESTOR_NAME, HOLDING.CURRENT_VALUE}
whr_cols   = {HOLDING.INVESTMENT_TYPE}
join_pairs = { {HOLDING, PROFILE} }
agg_pairs  = {SUM:H, SUM:CURRENT_VALUE}
clauses    = {HAS_JOIN, HAS_WHERE, HAS_GROUPBY, HAS_AGG}
```

### 3.2 The best historical match (corpus query #241)
```sql
SELECT p.investor_name, SUM(h.current_value)
FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h
JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id
WHERE h.investment_type = 'Gold'        -- the ONLY difference: 'Gold' vs 'Mutual Fund'
GROUP BY p.investor_name
```

**Structural similarity** — every one of the 6 feature sets is *identical* (the literal value
isn't part of any structural set), so every per-feature Jaccard = 1.0:
```
struct = 0.35(1) + 0.20(1) + 0.20(1) + 0.15(1) + 0.07(1) + 0.03(1) = 1.000
```

**Token similarity** — the SQL is normalized first: `'Mutual Fund'` and `'Gold'` both become
`_STR_`. After that the two queries are character-for-character identical, so their token
sets are equal → Jaccard = **1.000**.

**Combined:**
```
combined = 0.65(1.000) + 0.35(1.000) = 1.000
```
`near_match_best(A) = ` **1.000**. (And in fact 5 corpus queries tie at 1.0 — the "Gold"
question was logged many times.)

---

## Scorer 3 — Near-match. Query B (a real, illustrative partial match)

Best match is corpus query #146:
```sql
SELECT AVG(ABS(c.amount))
FROM ATOM_EVENT_CASH_FLOW_001 c
JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON c.investor_id = g.investor_id
WHERE c.type = 'Withdrawal' AND g.progress_pct >= 1.0
```

**Structural similarity, feature by feature** (this is the instructive part):

| Feature | input B | match #146 | Jaccard | weight | contribution |
|---|---|---|---|---|---|
| `tables` | {GOAL, CASH_FLOW} | {CASH_FLOW, GOAL} | 1.00 | 0.35 | 0.3500 |
| `sel_cols` | {GOAL.INVESTMENT_GOAL} | {CASH_FLOW.AMOUNT} | 0.00 | 0.20 | 0.0000 |
| `whr_cols` | {CASH_FLOW.AMOUNT} | {CASH_FLOW.TYPE, GOAL.PROGRESS_PCT} | 0.00 | 0.20 | 0.0000 |
| `join_pairs` | {{GOAL,CASH_FLOW}} | {{CASH_FLOW,GOAL}} | 1.00 | 0.15 | 0.1500 |
| `agg_pairs` | {COUNT:*} | {AVG:ABS(...)} | 0.00 | 0.07 | 0.0000 |
| `clauses` | {JOIN,WHERE,GROUPBY,AGG} | {JOIN,WHERE,AGG} | 3/4 = 0.75 | 0.03 | 0.0225 |
| **struct** | | | | | **0.5225** |

So the two queries share the *same two tables joined the same way* (that's the 0.35 + 0.15),
but disagree on what they select, filter, and aggregate (the three 0.00 rows). That's a
faithful structural picture: "same skeleton, different flesh."

**Token similarity** (measured): **0.4762** — moderate lexical overlap (`CASH_FLOW`, `GOAL`,
`INVESTOR_ID`, `JOIN`, `WHERE`, `AMOUNT`, `SELECT`…) but many differing identifiers.

**Combined:**
```
combined = 0.65(0.5225) + 0.35(0.4762) = 0.3396 + 0.1667 = 0.5063
```
`near_match_best(B) = ` **0.5063**.

---

## Step Final — Consolidation

```
consolidated = 0.60 · prob_overall + 0.40 · near_match_best
```

**Query A:**
```
0.60(0.9076) + 0.40(1.000) = 0.5446 + 0.4000 = 0.9446   ✅
```

**Query B:**
```
0.60(0.5526) + 0.40(0.5063) = 0.3316 + 0.2025 = 0.5341   ✅
```

(The LLM score, even if computed, would not appear in these lines today.)

---

## Side-by-side summary

| Signal | Query A (known) | Query B (anomalous) |
|---|---|---|
| Table Familiarity | 1.000 | 1.000 |
| Column Coverage | 0.963 | 0.875 |
| Join Pattern | 1.000 | **0.111** |
| Join Key Validity | 1.000 | 1.000 |
| Filter Familiarity | 0.767 | **0.036** |
| Filter Operator | 1.000 | 1.000 |
| Aggregation Pattern | **0.500** | **0.000** |
| **Probability overall** | **0.9076** | **0.5526** |
| Near-match best | 1.000 | 0.5063 |
| **Consolidated** | **0.9446** | **0.5341** |

---

## What this walkthrough teaches about the *mechanism* (not yet fixes)

1. **Everything is a frequency-ratio against the corpus.** `_rel_score` (each feature ÷ the
   most popular feature of its kind) is the single recurring engine; Table Familiarity and
   Join Pattern are minor variations on it.
2. **The averaging is visible and consequential.** Query A's Aggregation dimension fell to
   0.500 purely because one of two tokens (`SUM(H)`) scored 0 — the mean let one artifact
   halve the dimension. The same averaging is what *prevents* Query B's three weak dimensions
   from collapsing the whole probability score (it still lands at 0.55, not near 0).
3. **Parsing artifacts flow straight into scores.** The alias `H` being mistaken for an
   aggregation column (§1.7) is not a scoring decision — it's a regex-parsing side effect that
   the scorer can't tell apart from a genuine anomaly.
4. **Near-match's structural Jaccard is interpretable per-feature.** Query B's 0.5225 cleanly
   decomposes into "same tables + same join (0.50), nothing else in common (0.0225 from a
   partial clause overlap)." This is the most transparent part of the system.
5. **Literal normalization is doing real work.** Query A scored a perfect 1.0 near-match only
   because `'Mutual Fund'` and `'Gold'` both normalize to `_STR_` — otherwise the token score
   would have dropped below 1.0.
6. **The consolidated number hides all of the above** — two rich, per-dimension vectors are
   collapsed into a single scalar via a fixed 60/40 blend, with the LLM sitting unused on the
   side.

> Cross-reference: the *problems* hinted at here (averaging dilution, popularity≠validity,
> alias mis-parsing, unused LLM, single-best near-match) are catalogued with severities in
> [scoring_method_refinement.md](scoring_method_refinement.md). This file is the
> "how it works"; that file is the "what's wrong with it."
