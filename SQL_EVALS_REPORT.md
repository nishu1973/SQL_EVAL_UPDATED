# SQL Evaluation Framework — Project Report

**Domain:** Wealth Management (ATOM platform)  
**Goal:** Evaluate whether a generated SQL query aligns with historical usage patterns from production query logs.

---

## 1. Query Log Parsing

**Script:** `scripts/parse_query_logs.py`  
**Input:** `raw_data/wealth_mgmt_atom_query_logs.sql` — a Redshift-style query log file  
**Output:** `raw_data/parsed_query_logs.db` — SQLite database

Each log entry follows this format:
```
-- QUERY N — <title>
-- query_id=XXXXXX | userid=XX | start=YYYY-MM-DD HH:MM:SS | end=... | dur=XXXms | rows=XX
<SQL>;
```

Parsed into a `query_logs` table with fields: `query_num`, `title`, `query_id`, `userid`, `start_time`, `end_time`, `duration_ms`, `rows_returned`, `sql_query`.

---

## 2. Query Analytics

Two analytics scripts run against the parsed DB:

### 2a. Statistical Analysis

**Script:** `scripts/analyze_query_logs.py`  
**Input:** `raw_data/parsed_query_logs.db`  
**Output:** stdout — human-readable frequency report (no file written)

Produces a frequency report covering:

| Metric | What it captures |
|---|---|
| Table frequency | Which tables appear most often |
| Join combinations | Table pairs joined together (via `itertools.combinations`) |
| Filter columns + operators | WHERE clause columns, operators (`=`, `<`, `LIKE`, etc.) |
| Filter values | Equality filter values per column |
| Aggregate functions | `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `STDDEV`, `VARIANCE` usage |
| Query structure flags | `HAS_JOIN`, `HAS_GROUP_BY`, `HAS_SUBQUERY`, `HAS_CTE`, `IS_SELECT_STAR`, etc. |
| Join type distribution | `LEFT JOIN`, `INNER JOIN`, `FULL JOIN`, etc. |

### 2b. LLM Analysis

**Script:** `scripts/analyze_query_logs_llm.py`  
**Input:** `raw_data/parsed_query_logs.db`; requires `OPENAI_API_KEY`  
**Output:** `reports/query_analysis.md` — per-table narrative + cross-table executive summary

**Model:** `gpt-4o-mini` (OpenAI), temperature = 0  
Uses LangGraph to produce per-table narratives (SELECT/WHERE columns, aggregation patterns, join relationships). This file is later used as context when LLM-scoring a new query.

---

## 3. Scoring Mechanism

**Script:** `scripts/score_query.py` (all three sub-scorers)  
**Input:** SQL query string (CLI arg, `--file <path>`, or stdin)  
**Output:** terminal report (default) or JSON (`--json` flag)

A query is scored by three independent methods, then consolidated.

### 3a. Probability-Based Score (statistical, no API calls)

**Input:** `raw_data/parsed_query_logs.db` — frequency counters rebuilt at runtime  
**Output:** 7 dimension scores + weighted overall (0.0–1.0)

Compares structural features of the input query against frequency counters built from the log corpus.

**7 Dimensions:**

| Dimension | Weight | What it measures |
|---|---|---|
| Table Familiarity | 0.20 | Are the queried tables known from logs? |
| Column Coverage | 0.20 | Do SELECT + WHERE columns match historical use? |
| Join Pattern | 0.20 | Are these table-pair joins seen before? |
| Join Key Validity | 0.10 | Are ON-clause columns historical join keys? |
| Filter Familiarity | 0.15 | Are WHERE columns historically filtered? |
| Filter Operator | 0.05 | Are operators consistent with column history? |
| Aggregation Pattern | 0.10 | Are `FUNC(col)` combinations historically seen? |

**Per-dimension formula:**
```
_rel_score(count, counter) = min(count / max(counter.values()), 1.0)  if count > 0
                           = 0.0                                        otherwise
```
Each dimension averages `_rel_score` across all column/table instances in that dimension. Dimensions with nothing to evaluate (e.g., no joins) score as `NA` and are excluded from the weight normalization.

**Overall probability score:**
```
overall = Σ(dim_score[k] * weight[k]) / Σ(weight[k] for applicable dimensions only)
```

---

### 3b. LLM-Based Score

**Input:** SQL query + `reports/query_analysis.md` (per-table narrative context); requires `OPENAI_API_KEY`  
**Output:** 5 subscores (0–100), overall (0–100), flags list, reasoning narrative  
**Flags:** `--no-llm` disables this scorer

**Model:** `gpt-4o` (OpenAI), temperature = 0, response format: JSON

**5 LLM Subscores (0–100):**

| Subscore | What it judges |
|---|---|
| Table Familiarity | Are these tables known? |
| Column Relevance | Are SELECT/WHERE columns historically important? |
| Join Conformance | Do join pairs and keys match history? |
| Filter Conformance | Are WHERE conditions consistent with history? |
| Aggregation Conformance | Are aggregate functions applied to expected columns? |

Plus an **overall holistic score (0–100)** and a list of **flags** (specific anomalies, e.g., `"unseen table: UNKNOWN_TABLE"`).

**Context injected into prompt:**  
Per-table markdown section from `reports/query_analysis.md` (truncated to 1 500 chars), falling back to raw stats (top-8 SELECT cols, top-8 WHERE cols, top-5 join partners/keys, top-5 agg functions). The prompt also includes the query's tables, join pairs, WHERE cols dict, and agg pairs.

---

### 3c. Near-Match Score (corpus similarity)

**Input:** `raw_data/parsed_query_logs.db` — full corpus of historical queries loaded at runtime  
**Output:** top-N closest historical queries with struct/token/combined scores and SQL previews  
**Flags:** `--no-near` disables; `--top-n <N>` controls result count (default 5)

Compares the input query against all historical queries using two Jaccard-based similarity measures.

#### Structural Score (65% of near-match)

Decomposes each query into 6 feature sets and computes weighted Jaccard similarity:

| Feature | Weight | Content |
|---|---|---|
| `tables` | 0.35 | frozenset of table names |
| `sel_cols` | 0.20 | frozenset of `"TABLE.COL"` from SELECT |
| `whr_cols` | 0.20 | frozenset of `"TABLE.COL"` from WHERE |
| `join_pairs` | 0.15 | frozenset of `{TABLE_A, TABLE_B}` pairs |
| `agg_pairs` | 0.07 | frozenset of `"FUNC:COL"` |
| `clauses` | 0.03 | frozenset of structural flags present |

```
struct_similarity = Σ(weight[k] * jaccard(feature_a[k], feature_b[k]))

jaccard(A, B) = |A ∩ B| / |A ∪ B|    (1.0 if both empty)
```

#### Token Score (35% of near-match)

SQL is normalized (string/date/numeric literals replaced with `_STR_`, `_DATE_`, `_NUM_`, investor IDs with `_INVESTOR_`), then tokenized into a bag of identifiers (tokens > 1 char, SQL keywords excluded). Standard Jaccard on the token sets.

#### Combined Near-Match Score:
```
combined = 0.65 * struct_score + 0.35 * token_score
```

Returns **top-N closest** historical queries (default `top_n=3` in tests, `5` in CLI), each with individual struct/token/combined scores and SQL preview.

---

### 3d. Consolidated Final Score

**Input:** probability overall (3a) + near-match best score (3c)  
**Output:** single consolidated score (0.0–1.0) printed at bottom of report

```
consolidated = 0.60 * probability_overall + 0.40 * near_match_best
```

| Component | Weight |
|---|---|
| Probability (statistical) | 60% |
| Near-match (best corpus hit) | 40% |

LLM score is reported separately and does not feed into the consolidated score.

---

## 4. Test Report

**Script:** `tests/generate_test_results.py`  
**Input:** `raw_data/parsed_query_logs.db` — no LLM calls, probability + near-match only  
**Output:**
- `tests/test_results/scores_report.txt` — human-readable with bar charts
- `tests/test_results/scores_report.json` — machine-readable

**Coverage:** 18 hand-crafted SQL queries across 6 groups

**Query groups:**
1. Single-table / aggregation
2. Two-table JOIN
3. Three-table JOIN
4. Novel / suspicious queries (unknown tables, unusual patterns)
5. Filter operator patterns
6. Subqueries

**Per-query report includes:**
- All 7 probability dimension scores with ASCII bar chart
- Per-dimension detail lines (e.g., `"NEVER SEEN"`, `"1 / 5 columns known"`)
- Top-3 near-match hits with `combined`, `struct`, `token` scores + matched SQL
- Consolidated score

### Summary Results (18 queries)

A typical known-pattern query scores **0.84–0.95 consolidated**. Queries touching unknown tables or novel join patterns drop to **0.30–0.50**, correctly flagging them as anomalous.

---

## 5. File Map

```
scripts/
  parse_query_logs.py        — ETL: log file → SQLite DB
  analyze_query_logs.py      — Statistical frequency analysis
  analyze_query_logs_llm.py  — LLM narrative analysis (gpt-4o-mini)
  score_query.py             — Main scorer: probability + LLM + near-match

tests/
  generate_test_results.py   — Batch test runner (18 queries)
  test_score_query.py        — Unit tests for scoring engine
  test_results/
    scores_report.txt        — Human-readable test report
    scores_report.json       — Machine-readable test report

raw_data/
  parsed_query_logs.db       — Source corpus (SQLite)
  wealth_mgmt_atom_query_logs.sql  — Raw log file

reports/
  query_analysis.md          — Per-table LLM narrative (LLM scorer context)
```
