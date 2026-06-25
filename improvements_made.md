# SQL Evaluation Scorer — Improvements Made

**Author's note (for the walkthrough):** this document explains every change made to the SQL
query scorer ([scripts/score_query.py](scripts/score_query.py)), *why* it was made, the exact
formula/code involved, and a concrete SQL example showing the before → after for each. It is
meant to be read top-to-bottom while demoing the tool.

All numbers below were measured by actually running the scorer against the real corpus
(`raw_data/parsed_query_logs.db`, 1000 logged queries) and the real schema
(`raw_data/wealth_management_diverse.db`, 8 tables). The full test suite (**147 tests**) is
green, and a per-query before/after benchmark is in
[scoring_refinement_results.md](scoring_refinement_results.md).

---

## 0. The one-paragraph summary

The scorer judges how closely a SQL query resembles queries analysts actually run. It was
working, but it had three classes of weakness: **(a) plain bugs** (data lost in a counter
merge, query aliases miscounted as columns), **(b) a flawed core metric** that confused
"rare" with "invalid" and averaged away anomalies, and **(c) unused/!brittle signals** (the
LLM score was computed but ignored; the near-match corpus double-counted duplicate queries).
We fixed all three, **grounded validity in the real database schema**, and made the output
**explain itself** with anomaly flags. Net effect: legitimate queries score higher, genuinely
broken queries score low *and say why*, and the headline number is now defensible.

### Change index

| # | Change | Type | Headline effect |
|---|---|---|---|
| 1 | Column-coverage counter merge | Bug fix | Stops silently discarding SELECT frequencies |
| 2 | Alias-as-aggregation-column | Bug fix | `SUM(h.x)` no longer invents a fake column `H` |
| 3 | Parsing hygiene (literals/keywords/tables) | Bug fix | Stops literal/keyword fragments scoring as columns |
| 4 | Real-schema validity grounding | New capability | Separates "doesn't exist" from "just rare" |
| 5 | Validity-aware saturating metric | Methodology | A legitimate-but-rare column is no longer punished |
| 6 | Worst-offender aggregation | Methodology | One hallucinated column is now *visible* |
| 7 | LLM score put to use | Methodology | LLM now contributes 25% (with safe fallback) |
| 8 | Near-match dedup + robust blend | Methodology | A pattern can't be inflated by duplicate logs |
| 9 | Anomaly flags | New capability | The score now says *what* looked wrong |

---

## 1. Bug fix — Column-coverage counter merge lost data

**The problem.** The "Column Coverage" dimension compares each queried column against how
often that column appears historically. To build the reference, it merged the SELECT and
WHERE frequency counters with:

```python
combined = Counter({**s["select_cols"], **s["where_cols"]})   # BUG
```

In Python, `{**a, **b}` **overwrites** keys that appear in both — it does not add them. So a
column used 90× in SELECT and 40× in WHERE was recorded as **40**, silently throwing away the
90.

**Why it matters.** The reference frequencies drive every column score; corrupting them
quietly skews the whole dimension.

**The fix.** A per-column **max-merge** (consistent with the numerator, which already used
`max(cnt_sel, cnt_whr)`), computed once per table instead of rebuilt inside the loop:

```python
combined = Counter()
for src in (s["select_cols"], s["where_cols"]):
    for c, v in src.items():
        if v > combined[c]:
            combined[c] = v
```

**Example.** `SELECT investor_name FROM ATOM_ENTITY_INVESTOR_PROFILE_001` — `investor_name`
is the most-selected column. Under the bug, if a *different* column happened to be filtered
heavily, the denominator was distorted and `investor_name` could score < 1.0. After the fix
it correctly scores **1.0** (it is the most-used column of its kind). A regression test
(`test_top_column_high_coverage`) now locks this in.

---

## 2. Bug fix — A table alias was counted as an aggregation column

**The problem.** Aggregations were parsed by splitting the inside of `SUM(...)` into tokens:

```python
agg_pairs = [(fn.upper(), col.strip().upper()) for fn, col in AGG_COL_RE.findall(sql)]
# SUM(h.current_value)  ->  ("SUM", "H.CURRENT_VALUE")  ->  tokens: H, CURRENT_VALUE
```

The alias `h` was treated as if it were a column named `H`. Since no table has a column `H`,
`SUM(H)` scored 0.0, and because the dimension *averaged* its instances, it dragged a perfect aggregation down.

**The fix.** Resolve the aggregation target to its bare column, dropping alias prefixes and
wrapper functions (`_clean_agg_col`):

```python
SUM(h.current_value)   -> CURRENT_VALUE
AVG(ABS(c.amount))     -> AMOUNT
COUNT(*)               -> (*)
```

**Example — measured.** Query A:
```sql
SELECT p.investor_name, SUM(h.current_value)
FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h
JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id
WHERE h.investment_type = 'Mutual Fund'
GROUP BY p.investor_name
```
| Metric | Before | After |
|---|---|---|
| Aggregation Pattern dimension | 0.50 (`SUM(H)`=0.0, `SUM(CURRENT_VALUE)`=1.0, averaged) | **1.00** |
| Probability overall | 0.9076 | **0.9576** |

A textbook-correct query now scores like one.

---

## 3. Bug fix — Parsing hygiene: literals, keywords, and table names masquerading as columns

**The problem.** For single-table queries the regex parser attributed *every* bare token to
the table. That swept in:

- **string-literal fragments** — `'INV-001'` → token `INV`; `'%Gold%'` → token `GOLD`
- **SQL keywords** — `DISTINCT`, `LIKE`, `BETWEEN`, …
- **function names** — `VARIANCE(cost)` → token `VARIANCE`
- **leaked table names** — a subquery `(SELECT MAX(date) FROM ATOM_EVENT_CASH_FLOW_001)`
  leaked the table name as a "column" (the subquery-stripping regex doesn't handle nested
  parentheses)

These phantom "columns" were harmless under the old averaging, but once Changes 5–6 below
made the scorer schema-aware and worst-offender-based, **each phantom scored 0 and dragged
legitimate queries down** — and worse, falsely flagged them as hallucinations.

**The fix.** Three targeted, principled filters in both `parse_query` and the corpus builder
`load_stats`:
1. Strip string literals before tokenizing: `re.sub(r"'[^']*'", " ", text)`
2. Expand the keyword stop-list (`DISTINCT, LIKE, IN, IS, BETWEEN, ASC, DESC, …`) and the
   function list (`VARIANCE, DATEDIFF, TRIM, …`)
3. A token equal to a table name is never a column: `if col in table_set: return False`

**Example — measured.**
```sql
SELECT investment_type, AVG(dividends)
FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001
WHERE investor_id = 'INV-001'
GROUP BY investment_type
```
| | Before fix | After fix |
|---|---|---|
| Parsed WHERE columns | `INVESTOR_ID`, **`INV`** (phantom) | `INVESTOR_ID` |
| Flags | ⚑ *hallucinated column: …`INV`* (false alarm) | none |
| Consolidated | 0.729 (penalized) | **0.914** |

This single fix produced the largest gains in the benchmark — the **Filter/operator** group
rose **+0.161** and **Subquery/CTE** rose **+0.153**, because those query shapes (`LIKE '...'`,
subqueries) were the ones most polluted by phantom tokens.

---

## 4. New capability — Validity grounded in the real database schema

**The problem.** The scorer judged a column/table purely by *how often it was logged*. So a
**legitimate column that simply was never logged** looked identical to a **hallucinated
column that doesn't exist** — both scored 0. We were ignoring an authoritative source of
truth: the actual database (`wealth_management_diverse.db`) and its real columns.

**The fix.** A new `load_schema()` reads the real `{TABLE: {columns}}` map, and every
column/table is classified into **three tiers**:

| Tier | Condition | Meaning |
|---|---|---|
| Familiar | in schema **and** logged | normal |
| Valid-but-novel | in schema, never logged | legitimate, just unusual → partial credit |
| Invalid | **not** in schema | hallucinated → 0 + flagged |

(When the schema DB is absent, the scorer degrades gracefully to popularity-only.)

**Example — measured.**
```sql
SELECT made_up_col FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE made_up_col = 1
```
`made_up_col` is **not** a real column → Column Coverage = **0.00**, consolidated **0.448**,
and the report prints `⚑ hallucinated column (not in schema): …MADE_UP_COL`. Conversely
`taxes_paid` (a real column that the logs rarely touch) is no longer cratered to ~0 — it gets
the valid-but-novel baseline instead of being mistaken for an error.

---

## 5. Methodology — Validity-aware, saturating metric (replacing max-normalization)

**The problem.** The old per-instance metric divided by the *most popular* feature:

```python
_rel_score(count, counter) = min(count / max(counter.values()), 1.0)   # popularity, not validity
```

This answers "how close to the single most popular feature is this?" — **not** "is this
normal/valid?" A column used 50× when some other column was used 500× scored **0.10**, even
though 50 uses clearly means "normal."

**The fix.** `feature_score` combines schema-validity with a **saturating** frequency curve.
A feature need only be *reasonably* common (a fraction of the max, adaptive threshold `T`) to
earn full credit:

```
feature_score = 0.0                                  if not in schema      (hallucinated)
              = S_VALID                              if valid, never logged (S_VALID = 0.5)
              = S_VALID + (1-S_VALID)·min(count/T,1) if valid and logged    (T ≈ 0.25·max)
```

**Example — measured.** Query B filters on `ATOM_EVENT_CASH_FLOW_001.amount`, which is a real
column but is filtered only **5×** in the corpus (the most-filtered column there is used
140×):

| Metric | Old (`_rel_score`) | New (`feature_score`) |
|---|---|---|
| Filter familiarity for `amount` | 5/140 = **0.036** | 0.5 + 0.5·min(5/35,1) = **0.571** |

The old scorer treated a perfectly valid filter as nearly anomalous; the new one recognizes
it as "valid, just uncommon."

---

## 6. Methodology — Worst-offender aggregation (replacing the mean)

**The problem.** Each dimension *averaged* its per-instance scores. For anomaly detection
that's the wrong operator: 9 valid columns + 1 hallucinated column averaged to
`(9·1.0 + 0)/10 = 0.90` — the single red flag was smoothed away.

**The fix.** Blend the mean with the worst instance so one bad apple is visible, without a
hard cap:

```
dim_score = α·mean(instances) + (1-α)·min(instances)        (α = 0.6)
```

**Example — measured.**
```sql
SELECT investor_name, made_up_col FROM ATOM_ENTITY_INVESTOR_PROFILE_001
```
| | Old mean | New worst-offender |
|---|---|---|
| Column Coverage (`investor_name`=1.0, `made_up_col`=0.0) | 0.50 | 0.6·0.5 + 0.4·0.0 = **0.30** |

The hallucinated column now clearly pulls the dimension down instead of hiding behind the
valid one. (This pairs with Change 9: it's also flagged by name.)

---

## 7. Methodology — The LLM score is now actually used

**The problem.** The scorer made a `gpt-4o` call, computed a 0–100 score, and then **threw it
away** — it contributed 0% to the final number. Worse, the parsing was unsafe:
`data.get("overall", 0)` meant a malformed model response silently became **0**, which would
crater the score.

**The fix.** Two parts.

1. **Validate + clamp** (`validate_llm_payload`): every subscore/overall is coerced into
   `[0,100]`; a missing/garbage `overall` returns `None` (treated as "unavailable") instead
   of a fake 0; `score_llm` retries once on a bad response.
2. **A new consolidated formula** that uses the LLM when present, with a deterministic
   fallback:

```
LLM available:  consolidated = 0.45·prob + 0.30·near + 0.25·(llm/100)
LLM absent:     consolidated = renormalize(0.45·prob + 0.30·near)  ≡  0.60·prob + 0.40·near
```

The fallback re-normalizes the two deterministic weights so an offline run reproduces the
**exact** original 60/40 number — reproducibility is preserved, the LLM only changes things
when it's genuinely available.

**Example — measured (LLM verdict simulated, since the live call needs a key).** Query B
(`prob=0.708`, `near=0.506`). If the LLM reviews it and returns `overall = 45` (flagging the
unusual join):

| | Consolidated |
|---|---|
| No LLM (deterministic) | 0.6273 |
| With LLM verdict 45 | **0.5829** |

A skeptical LLM correctly drags a questionable query down; an unavailable LLM changes nothing.

---

## 8. Methodology — Near-match: corpus dedup + robust best/top-k blend

**The problem.** Near-match compared the query against all 1000 logged queries with Jaccard
similarity, then used the **single best** hit as the score. Two issues: (a) the corpus is
full of the *same template* run with different literal values, so identical patterns
double-counted; (b) trusting one best hit means a query that happens to nearly-duplicate a
single outlier scores as high as one matching a genuine cluster.

**The fix.**
1. **Deduplicate** the corpus by normalized SQL (literals replaced) so a template counts once.
2. **Robust blend** of the best hit with the surrounding cluster:

```
near_score = β·best + (1-β)·mean(top-k distinct)        (β = 0.7, k = 5)
```

**Example — measured.** The corpus collapses from **1000 → 189 distinct patterns** (811 were
literal-only variants — e.g. the "list investors holding *Gold*" query logged dozens of times
with different investment types). For Query A:

| Metric | Value |
|---|---|
| Best single hit | 1.000 |
| Robust near score (fed into consolidated) | **0.927** |

The exact match is still recognized, but the score can't be inflated purely by one lucky
hit — it reflects proximity to a real cluster.

---

## 9. New capability — The score now explains itself (anomaly flags)

**The problem.** The output was a single number. A query scoring 0.45 told you *that* it was
suspicious, not *why*.

**The fix.** `collect_flags` derives concrete, deterministic anomaly flags from the schema and
the join history and surfaces them in both the report (`⚑ DETECTED ANOMALIES`) and JSON:

- `hallucinated table (not in schema): UNKNOWN_TABLE`
- `hallucinated column (not in schema): TABLE.MADE_UP_COL`
- `never-seen join: TABLE_A + TABLE_B`

**Example — measured.**
```sql
SELECT x.foo, SUM(x.bar) FROM UNKNOWN_TABLE x JOIN ANOTHER_UNKNOWN y ON x.id = y.id WHERE x.baz = 'test'
```
→ consolidated **0.061**, with flags `hallucinated table: UNKNOWN_TABLE, ANOTHER_UNKNOWN`.
The number says "bad"; the flags say "because these tables don't exist."

Importantly, flags are conservative — a *valid but unusual* query (Query B) produces **no**
false flags; its lower-but-reasonable score comes from the dimensions, not an alarm.

---

## 10. The overall before/after (18-query benchmark)

| Group | Old avg | New avg | Δ |
|---|---:|---:|---:|
| Single-table / aggregation | 0.839 | 0.904 | **+0.064** |
| Two-table JOIN (known pairs) | 0.849 | 0.892 | **+0.042** |
| Three-table JOIN | 0.864 | 0.817 | −0.046 *(uncommon sub-join flagged — intended)* |
| Novel / suspicious | 0.439 | 0.490 | +0.052 *(true anomalies stay low **and flagged**)* |
| Filter / operator | 0.769 | 0.930 | **+0.161** |
| Subquery / CTE | 0.788 | 0.941 | **+0.153** |

**How to read this:** legitimate queries rose (they were being unfairly penalized);
genuinely broken queries stayed low **and now carry an explanation**; and the scorer now
*distinguishes* "invalid" (hallucinated table/column → low + flag) from "valid but unusual"
(rare join/aggregation → moderate, no flag). Validity and popularity are finally separate
concepts.

---

## 11. What we deliberately did *not* change (and why)

To keep the work targeted and low-risk, these were scoped out (candidates for a future pass):

- **Replacing the regex parser with a real SQL parser** (e.g. `sqlglot`). We hardened the
  regex (Change 3) but did not replace it; exotic SQL (deeply nested subqueries, window
  functions, CTEs) can still be mis-parsed.
- **A calibrated/labeled validation set** with formal accept/reject thresholds and accuracy
  metrics. The before/after here is a benchmark, not a calibration.
- **Semantic (embedding-based) near-match** and a persisted feature index for scale.

---

## 12. How to reproduce / demo

```bash
# score a clean query (deterministic, no API key needed)
python3 scripts/score_query.py --no-llm \
  "SELECT category, SUM(current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category"

# score a hallucinated query and see the flags
python3 scripts/score_query.py --no-llm \
  "SELECT made_up_col FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE made_up_col = 1"

# machine-readable output (per-dimension scores, near-match, flags, consolidated)
python3 scripts/score_query.py --no-llm --json "SELECT ..."

# the full 18-query before/after benchmark
python3 tests/generate_test_results.py        # -> tests/test_results/scores_report.{txt,json}

# the test suite
pytest tests/ -v                               # 147 tests
```

Supporting documents: [scoring_method_refinement.md](scoring_method_refinement.md) (the
original shortcomings analysis), [scoring_improvement_plan.md](scoring_improvement_plan.md)
(the approved plan), and [scoring_refinement_results.md](scoring_refinement_results.md) (the
per-query before/after).
