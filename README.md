# sql_evals — SQL Query Confidence Scorer

An **evaluation model for SQL queries** built from production query logs. Given a SQL
query, it answers a single question:

> *"How closely does this query resemble the SQL that analysts actually run against
> this database?"*

A query that touches familiar tables, selects/filters on historically-used columns,
joins on known relationships, and aggregates the way the corpus does will score **high**.
A query touching unknown tables, novel join pairs, or unseen columns scores **low** and is
flagged as anomalous. This is useful for vetting LLM-generated SQL, catching hallucinated
schema references, and ranking candidate queries by how "in-distribution" they are.

The domain is a synthetic **Wealth Management** platform (the *ATOM* schema). All data is
fabricated — no real client, account, or advisor information is present.

---

## Table of Contents

1. [How it works (the big picture)](#how-it-works-the-big-picture)
2. [The data](#the-data)
3. [The pipeline, stage by stage](#the-pipeline-stage-by-stage)
4. [Scoring methodology](#scoring-methodology)
5. [Installation](#installation)
6. [Usage](#usage)
7. [Testing](#testing)
8. [Repository layout](#repository-layout)
9. [FAQ / notes](#faq--notes)

---

## How it works (the big picture)

```
 ground_truth_wealth_management_diverse.db   (1000 NL-question → SQL pairs)
                 │
                 ▼  generate_query_logs.py
 wealth_mgmt_atom_query_logs.sql             (synthetic Redshift-style log file)
                 │
                 ▼  parse_query_logs.py
 parsed_query_logs.db                         (1000 rows in a query_logs table)
                 │
        ┌────────┴───────────────────────────────┐
        ▼                                         ▼
 analyze_query_logs.py                    analyze_query_logs_llm.py
 (statistical frequency report,           (LangGraph + OpenAI per-table
  printed to stdout)                        narrative → reports/query_analysis.md)
        │                                         │
        └────────────────┬────────────────────────┘
                         ▼
                 score_query.py                ◀── a NEW SQL query
                         │
        ┌────────────────┼────────────────────┐
        ▼                ▼                      ▼
  Probability       LLM score             Near-match
  (statistical)     (gpt-4o)              (corpus similarity)
        └────────────────┴────────────────────┘
                         ▼
              Consolidated confidence score (0.0–1.0)
```

The **corpus** is a set of 1000 historical queries. Everything downstream — the
statistics, the narrative, and all three scorers — is derived from that corpus. A new
query is never judged against a fixed rulebook; it is judged against *what the logs
actually contain*.

---

## The data

All data lives in [raw_data/](raw_data/).

| File | What it is |
|---|---|
| `ground_truth_wealth_management_diverse.db` | Source of truth: 1000 rows of `(question, sql_query, execution_result)` in a `query_results` table. The seed corpus. |
| `wealth_management_diverse.db` | The actual wealth-management database the queries run against (8 ATOM tables — see below). |
| `wealth_mgmt_atom_query_logs.sql` | Synthetic Redshift/`STL_QUERY`-style **log file** generated from the ground-truth DB (1000 entries). |
| `parsed_query_logs.db` | The log file parsed into a structured SQLite `query_logs` table. **This is the corpus every scorer reads.** |
| `wealth_mgmt_redshift_query_logs.sql` / `.db` | An alternate/earlier log variant kept for reference. |

> Note: `*.db` files are listed in [.gitignore](.gitignore) (`*.db`), so depending on how
> you obtained the repo you may need to regenerate them — see [Usage](#usage).

### The ATOM schema (8 tables)

The queries operate over a wealth-management star-ish schema:

- `ATOM_ENTITY_INVESTOR_PROFILE_001` — investors (risk tolerance, time horizon, sector focus…)
- `ATOM_ENTITY_PORTFOLIO_HOLDING_001` — individual holdings (current value, cost, dividends, investment type…)
- `ATOM_ENTITY_INVESTMENT_GOAL_001` — investor goals (retirement planning, etc.)
- `ATOM_ENTITY_PORTFOLIO_HEALTH_001` — portfolio health metrics (liquidity score…)
- `ATOM_ENTITY_SECTOR_ALLOCATION_001` — sector allocations
- `ATOM_EVENT_CASH_FLOW_001` — cash-flow events (dividends, SIP contributions…)
- `ATOM_EVENT_REBALANCING_ACTION_001` — rebalancing actions
- `ATOM_EVENT_SCENARIO_REBALANCING_001` — scenario rebalancing

Most tables join through `investor_id`.

### `query_logs` table schema (the corpus)

Produced by `parse_query_logs.py`:

| Column | Type | Meaning |
|---|---|---|
| `id` | INTEGER PK | autoincrement |
| `query_num` | INTEGER | sequential N from the log |
| `title` | TEXT | the original natural-language question |
| `query_id` | INTEGER | Redshift-style query id |
| `userid` | INTEGER | synthetic analyst id |
| `start_time` / `end_time` | TEXT | ISO timestamps |
| `duration_ms` | INTEGER | (synthetic) runtime |
| `rows_returned` | INTEGER | (synthetic) result size |
| `sql_query` | TEXT | the SQL itself |

---

## The pipeline, stage by stage

All scripts live in [scripts/](scripts/) and accept `--help`.

### 1. Generate logs — [scripts/generate_query_logs.py](scripts/generate_query_logs.py)

Reads `(question, sql_query)` pairs from `ground_truth_wealth_management_diverse.db`
and emits a synthetic Redshift query-log file. It fabricates realistic-looking metadata:
random weekday business-hours timestamps, an analyst `userid` from a fixed pool, and
heuristic `duration_ms` / `rows_returned` (more joins/CTEs/GROUP BYs ⇒ longer runtime;
aggregations/LIMIT ⇒ fewer rows). Use `--seed` for reproducibility.

### 2. Parse logs → DB — [scripts/parse_query_logs.py](scripts/parse_query_logs.py)

Regex-parses each `-- QUERY N — title` / `-- query_id=… | userid=… | …` / `<SQL>;`
block into a row of the `query_logs` table. The `DELETE FROM query_logs` on each run makes
it **idempotent** — re-running won't duplicate rows.

### 3a. Statistical analysis — [scripts/analyze_query_logs.py](scripts/analyze_query_logs.py)

Prints a human-readable frequency report to stdout (no file written). Covers: most-queried
tables, table-pair join combinations (`itertools.combinations`), WHERE filter columns &
operators, top filter values per column, join-type distribution, aggregate-function usage,
and a query-structure breakdown (`HAS_JOIN`, `HAS_GROUP_BY`, `HAS_SUBQUERY`, `IS_SELECT_STAR`, …).

### 3b. LLM narrative analysis — [scripts/analyze_query_logs_llm.py](scripts/analyze_query_logs_llm.py)

Uses **LangGraph + OpenAI (`gpt-4o-mini`, temperature 0)** to walk every table and write a
detailed narrative (purpose, key columns, aggregation patterns, filter patterns, join
behaviour, query-intent summary), then a cross-table executive summary. Output →
[reports/query_analysis.md](reports/query_analysis.md). This file is later injected as
context for the LLM scorer. **Requires `OPENAI_API_KEY`.**

The LangGraph state machine is: `extract → analyze_table (loop over each table) → synthesize → END`.

### 4. Score a query — [scripts/score_query.py](scripts/score_query.py)

The heart of the project. Parses an input query into a `QueryInfo` structure (tables,
aliases, select/where columns, where operators, agg pairs, join pairs, join keys, group-by)
and runs **three independent scorers**, then a consolidated score. See next section.


## Scoring methodology

`score_query.py` produces three families of scores. Two are pure Python (no API calls);
one calls OpenAI.

> **Note — this scorer was refined in a multi-phase pass.** The methodology below reflects
> the current behavior. For the rationale, design decisions, and a before/after benchmark,
> see [scoring_method_refinement.md](scoring_method_refinement.md) (analysis),
> [scoring_improvement_plan.md](scoring_improvement_plan.md) (plan), and
> [scoring_refinement_results.md](scoring_refinement_results.md) (results). Headline changes:
> **(1)** validity is grounded in the real schema (`wealth_management_diverse.db`), separating
> "doesn't exist" from "just rare"; **(2)** per-dimension aggregation is worst-offender, not a
> mean, so a single hallucinated column is visible; **(3)** the LLM score now contributes to
> the consolidated number (with a deterministic fallback); **(4)** the near-match corpus is
> deduplicated and the score is a robust best/top-k blend; **(5)** anomalies are surfaced as
> explicit flags.

### A. Probability-based score (statistical, no API)

Rebuilds frequency counters from `parsed_query_logs.db` at runtime and compares the input
query's features against them across **7 weighted dimensions**:

| Dimension | Weight | Measures |
|---|---|---|
| Table Familiarity | 0.20 | Are the queried tables known from logs? |
| Column Coverage | 0.20 | Do SELECT + WHERE columns match historical use? |
| Join Pattern | 0.20 | Are these table-pair joins seen before? |
| Join Key Validity | 0.10 | Are ON-clause columns historical join keys? |
| Filter Familiarity | 0.15 | Are WHERE columns historically filtered? |
| Filter Operator | 0.05 | Are operators consistent with each column's history? |
| Aggregation Pattern | 0.10 | Are `FUNC(col)` combinations historically seen? |

Per-instance score is **validity-aware and saturating** (`feature_score`): a column/table
that doesn't exist in the real schema scores 0; one that exists but was never logged gets a
baseline `S_VALID` (0.5); one that's logged earns `S_VALID` plus a saturating frequency bonus
that reaches 1.0 once it's *reasonably* common (not necessarily the single most common):

```
feature_score = 0.0                                  if not in schema (hallucinated)
              = S_VALID                              if valid but never logged
              = S_VALID + (1-S_VALID)·min(count/T,1) if valid and logged   (T = adaptive)
```

Each dimension aggregates its instances with **worst-offender weighting** (so one anomalous
column isn't averaged away):

```
dim_score = α·mean(instances) + (1-α)·min(instances)        (α = 0.6)
```

Dimensions with nothing to evaluate (e.g. a query with no joins) score **N/A** and are
*excluded* — weights are re-normalized over only the applicable dimensions:

```
overall = Σ(dim_score[k] · weight[k]) / Σ(weight[k] for applicable k)
```

### B. LLM-based score (`gpt-4o`, temperature 0, JSON mode)

Builds a compact per-table context (preferring the `query_analysis.md` narrative, truncated
to 1500 chars, falling back to raw counters) and asks the model to score 5 subscores
(0–100) — table familiarity, column relevance, join conformance, filter conformance,
aggregation conformance — plus a holistic **overall (0–100)**, a list of **flags** (e.g.
`"unseen table: UNKNOWN_TABLE"`), and a reasoning narrative. The response is validated and
clamped (range-checked, one retry, no silent zero). Disabled with `--no-llm` or if
`OPENAI_API_KEY` is unset. **When available it now contributes 25% of the consolidated score;
when absent the consolidated score falls back deterministically to probability + near-match.**

### C. Near-match score (corpus similarity, no API)

Compares the input against the **deduplicated** corpus of historical query *patterns* (the
raw 1000 logs collapse to ~190 distinct normalized templates, so literal-only variants don't
form a false cluster) with two Jaccard measures and returns the top-N closest.

**Structural similarity (65%)** — weighted Jaccard over 6 feature sets:

| Feature | Weight | Content |
|---|---|---|
| `tables` | 0.35 | table names |
| `sel_cols` | 0.20 | `TABLE.COL` from SELECT |
| `whr_cols` | 0.20 | `TABLE.COL` from WHERE |
| `join_pairs` | 0.15 | `{TABLE_A, TABLE_B}` pairs |
| `agg_pairs` | 0.07 | `FUNC:COL` |
| `clauses` | 0.03 | structural flags present |

**Token similarity (35%)** — SQL is normalized (string/date/numeric literals and investor
IDs replaced with `_STR_`/`_DATE_`/`_NUM_`/`_INVESTOR_`), tokenized into a bag of
identifiers, then plain Jaccard. This makes `INV-001` and `INV-099` look identical.

```
combined(per hit) = 0.65 · struct_similarity + 0.35 · token_similarity
```

The single value fed downstream is a **robust blend** of the best hit and the cluster around
it (so one lucky match can't inflate the score):

```
near_score = β · best + (1-β) · mean(top-k distinct)        (β = 0.7, k = 5)
```

### D. Consolidated final score

```
LLM available:  consolidated = 0.45·probability + 0.30·near_score + 0.25·(llm/100)
LLM absent:     consolidated = re-normalize(0.45·prob + 0.30·near)  ≡  0.60·prob + 0.40·near
```

When the LLM is unavailable (`--no-llm`, no key, or an invalid response) the prob/near
weights re-normalize over themselves — reducing to the original **60/40** blend, so the
deterministic path stays fully reproducible.

Alongside the score, the report lists **detected anomalies** (hallucinated tables/columns
vs. the real schema, never-seen joins) so the consolidated scalar is never the only signal.

**Rough interpretation:** known-pattern queries land high (≈0.85–0.99); queries touching
unknown tables or hallucinated columns drop sharply and are flagged. See
[scoring_refinement_results.md](scoring_refinement_results.md) for a before/after benchmark.

A full write-up with worked formulas lives in [SQL_EVALS_REPORT.md](SQL_EVALS_REPORT.md).

---

## Installation

Requires **Python ≥ 3.11**. The project uses [`uv`](https://github.com/astral-sh/uv).

```bash
# install dependencies into a local .venv from pyproject.toml / uv.lock
uv sync

# the LLM scripts need an OpenAI key
cp .env.example .env
# then edit .env and set OPENAI_API_KEY=sk-...
```

Dependencies: `langchain-openai`, `langgraph`, `openai`, `python-dotenv` (runtime);
`pytest` (dev). The statistical and near-match scorers depend only on the Python standard
library — `OPENAI_API_KEY` is needed **only** for the LLM narrative and the LLM scorer.

---

## Usage

Run everything from the project root (paths are relative).

### Regenerate the corpus (only if the `.db`/log files are missing)

```bash
uv run python scripts/generate_query_logs.py            # ground-truth DB → log file
uv run python scripts/parse_query_logs.py               # log file → parsed_query_logs.db
```

### Analyze the corpus

```bash
uv run python scripts/analyze_query_logs.py --top 15    # statistical report → stdout
uv run python scripts/analyze_query_logs_llm.py         # narrative → reports/query_analysis.md  (needs OPENAI_API_KEY)
```

### Interactive app (Streamlit) — recommended

A live UI to score a query and inspect the **entire calculation flow** (parsed features,
per-dimension math with formulas substituted, near-match hits, the LLM verdict, anomaly
flags, and the consolidated arithmetic), with an LLM on/off toggle and session history.

```bash
pip install -r requirements-app.txt          # or: uv sync
streamlit run app.py                          # -> http://localhost:8501
```

Enable the **"Use LLM scoring"** toggle in the sidebar to add the live `gpt-4o` verdict
(requires `OPENAI_API_KEY` in `.env`; makes a real, billable call). With it off, scoring is
fully deterministic and offline.

### Score a query (CLI)

```bash
# inline string (runs all 3 scorers if OPENAI_API_KEY is set)
uv run python scripts/score_query.py "SELECT investor_name FROM ATOM_ENTITY_INVESTOR_PROFILE_001"

# from a file
uv run python scripts/score_query.py --file my_query.sql

# statistics only — no API calls, fully offline
uv run python scripts/score_query.py --no-llm "SELECT ..."

# skip the corpus near-match pass
uv run python scripts/score_query.py --no-near "SELECT ..."

# machine-readable output
uv run python scripts/score_query.py --no-llm --json "SELECT ..."

# from stdin
echo "SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001" | uv run python scripts/score_query.py --no-llm
```

Key flags: `--no-llm`, `--no-near`, `--top-n <N>` (default 5), `--json`, `--db <path>`, `--md <path>`, `--schema-db <path>` (real-schema DB for validity grounding; popularity-only if absent).

The default (terminal) output renders the 7 probability dimensions with ASCII bar charts,
the LLM subscores + flags + reasoning (if enabled), the top-N near matches with
struct/token/combined scores and SQL previews, and the consolidated score.

---

## Testing

```bash
uv run pytest tests/ -v
```

(Also recorded in [notes.txt](notes.txt).) The suite covers:

- [tests/test_parse_query_logs.py](tests/test_parse_query_logs.py) — log parsing & DB round-trip (idempotency, multi-line SQL, metadata extraction).
- [tests/test_analyze_query_logs.py](tests/test_analyze_query_logs.py) — the extraction helpers (tables, joins, filters, values, aggregates, flags).
- [tests/test_score_query.py](tests/test_score_query.py) — SQL normalization, tokenization, Jaccard helpers, `parse_query`, structural features, probability scoring (against a hand-crafted stats fixture) and near-match scoring.

### Batch evaluation report

[tests/generate_test_results.py](tests/generate_test_results.py) runs **18 hand-crafted
queries** across 6 groups (single-table/aggregation, two-table JOIN, three-table JOIN,
novel/suspicious, filter-operator patterns, subquery/CTE) through the probability +
near-match scorers (no LLM) and writes:

- [tests/test_results/scores_report.txt](tests/test_results/scores_report.txt) — human-readable with bar charts and flagged anomalies
- [tests/test_results/scores_report.json](tests/test_results/scores_report.json) — machine-readable

```bash
uv run python tests/generate_test_results.py
```

This is the quickest way to see the scorer separate known-good queries from anomalous ones.

---

## Repository layout

```
sql_evals/
├── README.md                       — this file
├── SQL_EVALS_REPORT.md             — detailed methodology write-up with formulas
├── pyproject.toml / uv.lock        — dependencies (Python ≥ 3.11, managed by uv)
├── .env.example                    — template for OPENAI_API_KEY
│
├── scripts/
│   ├── generate_query_logs.py      — ground-truth DB → synthetic log file
│   ├── parse_query_logs.py         — log file → parsed_query_logs.db (the corpus)
│   ├── analyze_query_logs.py       — statistical frequency report (stdout)
│   ├── analyze_query_logs_llm.py   — LangGraph + gpt-4o-mini narrative → reports/query_analysis.md
│   └── score_query.py              — main scorer: probability + LLM + near-match + consolidated
│
├── raw_data/
│   ├── ground_truth_wealth_management_diverse.db  — 1000 question→SQL seed pairs
│   ├── wealth_management_diverse.db               — the 8-table ATOM database
│   ├── wealth_mgmt_atom_query_logs.sql            — generated log file
│   ├── parsed_query_logs.db                       — parsed corpus (read by scorers)
│   └── wealth_mgmt_redshift_query_logs.{sql,db}   — alternate log variant
│
├── reports/
│   └── query_analysis.md           — LLM per-table narrative (LLM-scorer context)
│
└── tests/
    ├── test_parse_query_logs.py
    ├── test_analyze_query_logs.py
    ├── test_score_query.py
    ├── generate_test_results.py    — 18-query batch evaluation runner
    └── test_results/
        ├── scores_report.txt
        └── scores_report.json
```

---

## FAQ / notes

- **Why three scorers?** They fail differently. The probability scorer is fast and
  interpretable per-dimension; near-match catches "this is basically query #427 with a
  different literal"; the LLM scorer adds holistic judgment and human-readable flags. The
  consolidated score deliberately uses only the two deterministic scorers.

- **Why is the LLM score excluded from the consolidated number?** To keep the headline
  score reproducible and runnable with no API key or network access.

- **SQL parsing is regex-based, not a full parser.** It is tuned for the ATOM-style
  uppercase table names (`[A-Z_][A-Z0-9_]*`) and the query shapes in this corpus. Very
  exotic SQL may be mis-parsed; the extraction logic is intentionally mirrored across
  `analyze_query_logs_llm.py` and `score_query.py` so stats and scores stay consistent.

- **Everything is synthetic.** No real client, account, or advisor data is present anywhere
  in this repository.
