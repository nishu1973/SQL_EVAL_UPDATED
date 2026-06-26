# Sample Queries for Testing the Scorer App

Copy any query below into the app's **SQL query** box and click **▶ Score query**.
The four groups mirror the sidebar sample types. All queries are *new* (distinct from the
built-in samples and the 18-query benchmark) and are built against the real ATOM schema.

**What to expect per group** (deterministic / LLM-off scores):

| Group | Typical consolidated | Anomaly flags? |
|---|---|---|
| ✅ Known two-table join | high (~0.80–0.99) | none |
| ⚠️ Unusual join (valid) | moderate (~0.55–0.75) | maybe a `never-seen join` flag if the pair *never* co-occurs in the logs — **not** a hallucination (tables/columns are real) |
| ❌ Hallucinated column | low–mid (~0.35–0.50) | **yes** — `hallucinated column` |
| ❌ Unknown tables | very low (~0.05–0.15) | **yes** — `hallucinated table` |

> The three flag types are deliberately different in severity: `hallucinated table` and
> `hallucinated column` mean the SQL references something that **doesn't exist** (a real
> error); `never-seen join` means a join of **real** tables that analysts have simply never
> run before (unusual, worth a look, but not wrong).

> Schema reminder — the 8 real tables all join on `investor_id`:
> `ATOM_ENTITY_INVESTOR_PROFILE_001`, `ATOM_ENTITY_PORTFOLIO_HOLDING_001`,
> `ATOM_ENTITY_INVESTMENT_GOAL_001`, `ATOM_ENTITY_PORTFOLIO_HEALTH_001`,
> `ATOM_ENTITY_SECTOR_ALLOCATION_001`, `ATOM_EVENT_CASH_FLOW_001`,
> `ATOM_EVENT_REBALANCING_ACTION_001`, `ATOM_EVENT_SCENARIO_REBALANCING_001`.

---

## ✅ Known two-table join
*Real tables, real columns, and table pairs that are **commonly** joined in the logs
(e.g. HOLDING↔PROFILE seen 110×, PROFILE↔GOAL 45×, PROFILE↔HEALTH 40×). Should score high.*

```sql
-- 1. Avg return by risk tolerance
SELECT p.risk_tolerance, AVG(h.returns_pct)
FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h
JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id
GROUP BY p.risk_tolerance;
```

```sql
-- 2. Total dividends per investor
SELECT p.investor_name, SUM(h.dividends)
FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h
JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id
GROUP BY p.investor_name;
```

```sql
-- 3. Liquidity score by investor
SELECT p.investor_name, hh.liquidity_score
FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p
JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 hh ON p.investor_id = hh.investor_id;
```

```sql
-- 4. Avg diversification score by risk tolerance
SELECT p.risk_tolerance, AVG(hh.diversification_score)
FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p
JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 hh ON p.investor_id = hh.investor_id
GROUP BY p.risk_tolerance;
```

```sql
-- 5. Goal progress per investor
SELECT p.investor_name, g.investment_goal, g.progress_pct
FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p
JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON p.investor_id = g.investor_id
WHERE g.progress_pct < 0.5;
```

```sql
-- 6. Avg target amount by risk tolerance
SELECT p.risk_tolerance, AVG(g.target_amount)
FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p
JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON p.investor_id = g.investor_id
GROUP BY p.risk_tolerance;
```

```sql
-- 7. Sector allocation by investor sector focus
SELECT p.sector_focus, SUM(s.total_investment)
FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p
JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 s ON p.investor_id = s.investor_id
GROUP BY p.sector_focus;
```

```sql
-- 8. Holding count per investor
SELECT p.investor_name, COUNT(h.holding_id) AS holdings
FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h
JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id
GROUP BY p.investor_name;
```

```sql
-- 9. Aggressive investors and their risk score
SELECT p.investor_name, hh.risk_score
FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p
JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 hh ON p.investor_id = hh.investor_id
WHERE p.risk_tolerance = 'Aggressive';
```

```sql
-- 10. Total portfolio cost per investor
SELECT p.investor_name, SUM(h.cost)
FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h
JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id
GROUP BY p.investor_name;
```

---

## ⚠️ Unusual join (valid)
*All tables and columns are **real** and joinable on `investor_id`, but these pairs are
**rarely or never** joined in the logs. Expect a moderate score driven down by a low
**Join Pattern** dimension. Pairs that have **some** history (e.g. #1, #6, #8, #9) won't
flag; pairs that **never** co-occur (e.g. #2, #3, #4, #5, #7, #10) get a `never-seen join`
flag — which is the soft "unusual but valid" signal, not a hallucination.*

```sql
-- 1. Holdings joined to cash-flow events (rare pair)
SELECT h.investment_type, SUM(c.amount)
FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h
JOIN ATOM_EVENT_CASH_FLOW_001 c ON h.investor_id = c.investor_id
GROUP BY h.investment_type;
```

```sql
-- 2. Goals joined to sector allocations (unseen pair)
SELECT g.investment_goal, AVG(s.allocation_pct)
FROM ATOM_ENTITY_INVESTMENT_GOAL_001 g
JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 s ON g.investor_id = s.investor_id
GROUP BY g.investment_goal;
```

```sql
-- 3. Holdings joined to sector allocations (unseen pair)
SELECT h.sector, SUM(s.total_investment)
FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h
JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 s ON h.investor_id = s.investor_id
GROUP BY h.sector;
```

```sql
-- 4. Cash flows joined to sector allocations (unseen pair)
SELECT s.sector, SUM(c.amount)
FROM ATOM_EVENT_CASH_FLOW_001 c
JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 s ON c.investor_id = s.investor_id
GROUP BY s.sector;
```

```sql
-- 5. Portfolio health joined to rebalancing actions (unseen pair)
SELECT hh.risk_score, r.action
FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 hh
JOIN ATOM_EVENT_REBALANCING_ACTION_001 r ON hh.investor_id = r.investor_id;
```

```sql
-- 6. Goals joined to rebalancing actions (rare pair)
SELECT g.investment_goal, SUM(r.amount)
FROM ATOM_ENTITY_INVESTMENT_GOAL_001 g
JOIN ATOM_EVENT_REBALANCING_ACTION_001 r ON g.investor_id = r.investor_id
GROUP BY g.investment_goal;
```

```sql
-- 7. Holdings joined to scenario rebalancing (unseen pair)
SELECT h.investment_type, sr.scenario
FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h
JOIN ATOM_EVENT_SCENARIO_REBALANCING_001 sr ON h.investor_id = sr.investor_id;
```

```sql
-- 8. Cash flows joined to goals (rare pair)
SELECT g.investment_goal, AVG(c.amount)
FROM ATOM_EVENT_CASH_FLOW_001 c
JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON c.investor_id = g.investor_id
WHERE c.type = 'Dividend'
GROUP BY g.investment_goal;
```

```sql
-- 9. Sector allocation joined to portfolio health (rare pair)
SELECT s.sector, AVG(hh.diversification_score)
FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 s
JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 hh ON s.investor_id = hh.investor_id
GROUP BY s.sector;
```

```sql
-- 10. Cash flows joined to rebalancing actions (unseen pair)
SELECT r.action, SUM(c.amount)
FROM ATOM_EVENT_CASH_FLOW_001 c
JOIN ATOM_EVENT_REBALANCING_ACTION_001 r ON c.investor_id = r.investor_id
GROUP BY r.action;
```

---

## ❌ Hallucinated column
*The **table is real**, but at least one referenced **column does not exist** in the schema.
Expect a low–mid score and a `hallucinated column (not in schema)` flag. (Columns like
`profit_margin`, `ticker_symbol`, `pe_ratio`, `email`, `age`, `currency` are not in the ATOM
schema.)*

```sql
-- 1. profit_margin is not a real column of HOLDING
SELECT profit_margin FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE profit_margin > 10;
```

```sql
-- 2. ticker_symbol is fake (current_value is real)
SELECT ticker_symbol, current_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001;
```

```sql
-- 3. pe_ratio is fake
SELECT investment_name, pe_ratio FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE pe_ratio < 15;
```

```sql
-- 4. email is not on the investor profile
SELECT investor_name, email FROM ATOM_ENTITY_INVESTOR_PROFILE_001;
```

```sql
-- 5. age is not a real column
SELECT investor_name FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE age > 60;
```

```sql
-- 6. priority_level is fake on the goal table
SELECT investment_goal FROM ATOM_ENTITY_INVESTMENT_GOAL_001 WHERE priority_level = 'High';
```

```sql
-- 7. currency is not a cash-flow column (amount is real)
SELECT currency, SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 GROUP BY currency;
```

```sql
-- 8. credit_score is fake (health has risk_score / liquidity_score)
SELECT investor_id, credit_score FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 WHERE credit_score > 700;
```

```sql
-- 9. beta_value is fake (current_value is real)
SELECT investment_name, beta_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE beta_value > 1.2;
```

```sql
-- 10. maturity_date is fake on HOLDING
SELECT investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE maturity_date < '2030-01-01';
```

---

## ❌ Unknown tables
*The table(s) **do not exist** in the schema at all. Expect a very low score and a
`hallucinated table (not in schema)` flag.*

```sql
-- 1. ATOM_ENTITY_CUSTOMER_001 is not a real table
SELECT customer_name FROM ATOM_ENTITY_CUSTOMER_001 WHERE region = 'West';
```

```sql
-- 2. ATOM_EVENT_TRANSACTION_001 does not exist
SELECT SUM(amount) FROM ATOM_EVENT_TRANSACTION_001 WHERE status = 'COMPLETED';
```

```sql
-- 3. ATOM_ENTITY_ACCOUNT_001 does not exist
SELECT account_balance FROM ATOM_ENTITY_ACCOUNT_001 WHERE account_type = 'Savings';
```

```sql
-- 4. ATOM_ENTITY_ADVISOR_001 does not exist
SELECT advisor_name, COUNT(*) FROM ATOM_ENTITY_ADVISOR_001 GROUP BY advisor_name;
```

```sql
-- 5. plain USERS table does not exist
SELECT * FROM USERS WHERE active = 1;
```

```sql
-- 6. ATOM_EVENT_TRADE_001 does not exist
SELECT trade_id, price FROM ATOM_EVENT_TRADE_001 WHERE price > 100;
```

```sql
-- 7. both tables are unknown
SELECT a.id, b.total FROM TRANSACTIONS a JOIN PAYMENTS b ON a.id = b.txn_id;
```

```sql
-- 8. ATOM_ENTITY_MARKET_DATA_001 does not exist
SELECT ticker, market_value FROM ATOM_ENTITY_MARKET_DATA_001 WHERE ticker = 'AAPL';
```

```sql
-- 9. ATOM_ENTITY_BANK_BRANCH_001 does not exist
SELECT branch_name FROM ATOM_ENTITY_BANK_BRANCH_001 WHERE city = 'New York';
```

```sql
-- 10. ATOM_ENTITY_PORTFOLIO_RISK_001 does not exist
SELECT risk_rating, COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_RISK_001 GROUP BY risk_rating;
```
