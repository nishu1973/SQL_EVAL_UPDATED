-- =============================================================================
-- SYNTHETIC REDSHIFT QUERY LOGS — WEALTH MANAGEMENT (ATOM SCHEMA)
-- Generated: 2026-06-13
-- Environment: NeoSapients / Wealth AI Insights Platform
-- Cluster: neos-wealth-prod-rs-01  |  Database: wealthdb
-- Source: ground_truth_wealth_management_diverse.db  (1000 queries)
-- Note: All data is synthetic. No real client, account, or advisor information.
-- =============================================================================
--
-- LOG FORMAT (emulated from STL_QUERY / SVL_QLOG):
--   query_id | userid | starttime            | endtime              | duration_ms | rows_returned | query_text
--

-- QUERY 1 — What is the investment time horizon for investor INV002
-- query_id=200001 | userid=95 | start=2026-01-01 07:17:25 | end=2026-01-01 07:17:25 | dur=563ms | rows=183
SELECT time_horizon FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id = 'INV-002';

-- QUERY 2 — Please provide the investment time horizon for investor INV002
-- query_id=200002 | userid=74 | start=2026-01-01 07:52:54 | end=2026-01-01 07:52:54 | dur=420ms | rows=17
SELECT time_horizon FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id = 'INV-002';

-- QUERY 3 — Can you tell me what the investment time horizon for investor INV002
-- query_id=200003 | userid=81 | start=2026-01-01 10:02:41 | end=2026-01-01 10:02:41 | dur=675ms | rows=45
SELECT time_horizon FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id = 'INV-002';

-- QUERY 4 — What would be the investment time horizon for investor INV002
-- query_id=200004 | userid=55 | start=2026-01-01 11:57:17 | end=2026-01-01 11:57:17 | dur=495ms | rows=127
SELECT time_horizon FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id = 'INV-002';

-- QUERY 5 — Looking at all available records, what is the investment time horizon for investor INV002
-- query_id=200005 | userid=12 | start=2026-01-01 12:28:11 | end=2026-01-01 12:28:11 | dur=523ms | rows=80
SELECT time_horizon FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id = 'INV-002';

-- QUERY 6 — What is the current liquidity score for investor INV003
-- query_id=200006 | userid=68 | start=2026-01-01 13:12:52 | end=2026-01-01 13:12:52 | dur=757ms | rows=19
SELECT liquidity_score FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 WHERE investor_id = 'INV-003';

-- QUERY 7 — Please provide the current liquidity score for investor INV003
-- query_id=200007 | userid=23 | start=2026-01-01 15:07:27 | end=2026-01-01 15:07:27 | dur=861ms | rows=200
SELECT liquidity_score FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 WHERE investor_id = 'INV-003';

-- QUERY 8 — Can you tell me what the current liquidity score for investor INV003
-- query_id=200008 | userid=81 | start=2026-01-01 16:31:26 | end=2026-01-01 16:31:26 | dur=734ms | rows=15
SELECT liquidity_score FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 WHERE investor_id = 'INV-003';

-- QUERY 9 — What would be the current liquidity score for investor INV003
-- query_id=200009 | userid=18 | start=2026-01-02 09:30:42 | end=2026-01-02 09:30:42 | dur=744ms | rows=133
SELECT liquidity_score FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 WHERE investor_id = 'INV-003';

-- QUERY 10 — Looking at all available records, what is the current liquidity score for investor INV003
-- query_id=200010 | userid=42 | start=2026-01-02 11:49:27 | end=2026-01-02 11:49:28 | dur=1112ms | rows=33
SELECT liquidity_score FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 WHERE investor_id = 'INV-003';

-- QUERY 11 — Display the allocation percentage for investor INV001 in the Financial Services sector.
-- query_id=200011 | userid=42 | start=2026-01-02 12:01:26 | end=2026-01-02 12:01:26 | dur=798ms | rows=169
SELECT allocation_pct FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 WHERE investor_id = 'INV-001' AND sector = 'Financial Services';

-- QUERY 12 — Display the allocation percentage for investor INV001 in the Financial Services sector.
-- query_id=200012 | userid=95 | start=2026-01-02 12:27:29 | end=2026-01-02 12:27:29 | dur=700ms | rows=8
SELECT allocation_pct FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 WHERE investor_id = 'INV-001' AND sector = 'Financial Services';

-- QUERY 13 — Can you display the allocation percentage for investor INV001 in the Financial Services sector.
-- query_id=200013 | userid=18 | start=2026-01-02 13:44:21 | end=2026-01-02 13:44:21 | dur=382ms | rows=8
SELECT allocation_pct FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 WHERE investor_id = 'INV-001' AND sector = 'Financial Services';

-- QUERY 14 — Across the portfolio database, display the allocation percentage for investor inv001 in the financial services sector.
-- query_id=200014 | userid=74 | start=2026-01-02 19:24:47 | end=2026-01-02 19:24:47 | dur=787ms | rows=63
SELECT allocation_pct FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 WHERE investor_id = 'INV-001' AND sector = 'Financial Services';

-- QUERY 15 — From the complete wealth management dataset, display the allocation percentage for investor inv001 in the financial serv
-- query_id=200015 | userid=68 | start=2026-01-02 19:47:42 | end=2026-01-02 19:47:42 | dur=477ms | rows=88
SELECT allocation_pct FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 WHERE investor_id = 'INV-001' AND sector = 'Financial Services';

-- QUERY 16 — List the preferred sector focus for the investor INV003.
-- query_id=200016 | userid=95 | start=2026-01-05 14:17:03 | end=2026-01-05 14:17:03 | dur=514ms | rows=34
SELECT sector_focus FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id = 'INV-003';

-- QUERY 17 — Enumerate all preferred sector focus for the investor INV003.
-- query_id=200017 | userid=55 | start=2026-01-05 17:49:50 | end=2026-01-05 17:49:50 | dur=620ms | rows=25
SELECT sector_focus FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id = 'INV-003';

-- QUERY 18 — Can you list all preferred sector focus for the investor INV003.
-- query_id=200018 | userid=12 | start=2026-01-05 19:30:46 | end=2026-01-05 19:30:46 | dur=576ms | rows=84
SELECT sector_focus FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id = 'INV-003';

-- QUERY 19 — What are all the preferred sector focus for the investor INV003.
-- query_id=200019 | userid=95 | start=2026-01-06 08:37:40 | end=2026-01-06 08:37:40 | dur=547ms | rows=128
SELECT sector_focus FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id = 'INV-003';

-- QUERY 20 — Provide a complete list of all the preferred sector focus for the investor INV003.
-- query_id=200020 | userid=12 | start=2026-01-06 11:21:48 | end=2026-01-06 11:21:48 | dur=499ms | rows=91
SELECT sector_focus FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id = 'INV-003';

-- QUERY 21 — What is the risk-adjusted performance ratio for investment goal G003
-- query_id=200021 | userid=12 | start=2026-01-06 13:45:06 | end=2026-01-06 13:45:06 | dur=294ms | rows=111
SELECT avg_annual_return_pct / avg_volatility_pct FROM ATOM_ENTITY_INVESTMENT_GOAL_001 WHERE goal_id = 'GOAL-003';

-- QUERY 22 — Please provide the risk-adjusted performance ratio for investment goal G003
-- query_id=200022 | userid=23 | start=2026-01-06 14:32:28 | end=2026-01-06 14:32:28 | dur=790ms | rows=12
SELECT avg_annual_return_pct / avg_volatility_pct FROM ATOM_ENTITY_INVESTMENT_GOAL_001 WHERE goal_id = 'GOAL-003';

-- QUERY 23 — Can you tell me what the risk-adjusted performance ratio for investment goal G003
-- query_id=200023 | userid=68 | start=2026-01-06 14:54:14 | end=2026-01-06 14:54:14 | dur=477ms | rows=196
SELECT avg_annual_return_pct / avg_volatility_pct FROM ATOM_ENTITY_INVESTMENT_GOAL_001 WHERE goal_id = 'GOAL-003';

-- QUERY 24 — What would be the risk-adjusted performance ratio for investment goal G003
-- query_id=200024 | userid=81 | start=2026-01-06 14:55:53 | end=2026-01-06 14:55:53 | dur=545ms | rows=101
SELECT avg_annual_return_pct / avg_volatility_pct FROM ATOM_ENTITY_INVESTMENT_GOAL_001 WHERE goal_id = 'GOAL-003';

-- QUERY 25 — Looking at all available records, what is the risk-adjusted performance ratio for investment goal G003
-- query_id=200025 | userid=55 | start=2026-01-06 15:15:55 | end=2026-01-06 15:15:55 | dur=686ms | rows=11
SELECT avg_annual_return_pct / avg_volatility_pct FROM ATOM_ENTITY_INVESTMENT_GOAL_001 WHERE goal_id = 'GOAL-003';

-- QUERY 26 — Group the holdings of investor INV001 by investment type and show the count for each category.
-- query_id=200026 | userid=12 | start=2026-01-06 18:51:54 | end=2026-01-06 18:51:54 | dur=608ms | rows=16
SELECT investment_type, COUNT(*) as holding_count FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-001' GROUP BY investment_type;

-- QUERY 27 — Group the holdings of investor INV001 by investment type and show the count for each category.
-- query_id=200027 | userid=23 | start=2026-01-07 08:06:45 | end=2026-01-07 08:06:45 | dur=764ms | rows=28
SELECT investment_type, COUNT(*) as holding_count FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-001' GROUP BY investment_type;

-- QUERY 28 — Can you tell me ?¢¬Ä¬î group the holdings of investor inv001 by investment type and show the count for each category.
-- query_id=200028 | userid=42 | start=2026-01-07 08:28:08 | end=2026-01-07 08:28:09 | dur=1216ms | rows=24
SELECT investment_type, COUNT(*) as holding_count FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-001' GROUP BY investment_type;

-- QUERY 29 — Across the portfolio database, group the holdings of investor inv001 by investment type and show the count for each cate
-- query_id=200029 | userid=95 | start=2026-01-07 11:29:23 | end=2026-01-07 11:29:23 | dur=832ms | rows=11
SELECT investment_type, COUNT(*) as holding_count FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-001' GROUP BY investment_type;

-- QUERY 30 — From the complete wealth management dataset, group the holdings of investor inv001 by investment type and show the count
-- query_id=200030 | userid=12 | start=2026-01-07 18:10:29 | end=2026-01-07 18:10:30 | dur=1236ms | rows=9
SELECT investment_type, COUNT(*) as holding_count FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-001' GROUP BY investment_type;

-- QUERY 31 — Show the average time horizon for investors grouped by their risk tolerance level.
-- query_id=200031 | userid=12 | start=2026-01-08 07:15:44 | end=2026-01-08 07:15:44 | dur=996ms | rows=20
SELECT risk_tolerance, AVG(time_horizon) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 GROUP BY risk_tolerance;

-- QUERY 32 — Display the average time horizon for investors grouped by their risk tolerance level.
-- query_id=200032 | userid=18 | start=2026-01-08 07:54:57 | end=2026-01-08 07:54:57 | dur=655ms | rows=24
SELECT risk_tolerance, AVG(time_horizon) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 GROUP BY risk_tolerance;

-- QUERY 33 — Could you show me the average time horizon for investors grouped by their risk tolerance level.
-- query_id=200033 | userid=30 | start=2026-01-08 10:17:29 | end=2026-01-08 10:17:29 | dur=928ms | rows=18
SELECT risk_tolerance, AVG(time_horizon) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 GROUP BY risk_tolerance;

-- QUERY 34 — What does the system show for the average time horizon for investors grouped by their risk tolerance level.
-- query_id=200034 | userid=30 | start=2026-01-08 10:30:20 | end=2026-01-08 10:30:20 | dur=728ms | rows=7
SELECT risk_tolerance, AVG(time_horizon) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 GROUP BY risk_tolerance;

-- QUERY 35 — Please display the average time horizon for investors grouped by their risk tolerance level.
-- query_id=200035 | userid=74 | start=2026-01-08 12:28:11 | end=2026-01-08 12:28:11 | dur=740ms | rows=10
SELECT risk_tolerance, AVG(time_horizon) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 GROUP BY risk_tolerance;

-- QUERY 36 — What is the total current value of holdings across the platform, broken down by asset category
-- query_id=200036 | userid=81 | start=2026-01-08 14:24:55 | end=2026-01-08 14:24:56 | dur=1028ms | rows=8
SELECT category, SUM(current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category;

-- QUERY 37 — Please provide the total current value of holdings across the platform, broken down by asset category
-- query_id=200037 | userid=74 | start=2026-01-08 15:43:21 | end=2026-01-08 15:43:21 | dur=977ms | rows=14
SELECT category, SUM(current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category;

-- QUERY 38 — Can you tell me what the total current value of holdings across the platform, broken down by asset category
-- query_id=200038 | userid=68 | start=2026-01-08 17:12:34 | end=2026-01-08 17:12:35 | dur=1333ms | rows=3
SELECT category, SUM(current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category;

-- QUERY 39 — What would be the total current value of holdings across the platform, broken down by asset category
-- query_id=200039 | userid=42 | start=2026-01-08 17:45:52 | end=2026-01-08 17:45:53 | dur=1151ms | rows=8
SELECT category, SUM(current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category;

-- QUERY 40 — Looking at all available records, what is the total current value of holdings across the platform, broken down by asset 
-- query_id=200040 | userid=81 | start=2026-01-08 17:55:24 | end=2026-01-08 17:55:24 | dur=919ms | rows=25
SELECT category, SUM(current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category;

-- QUERY 41 — Categorize all investment goals by their type and show the average progress for each.
-- query_id=200041 | userid=95 | start=2026-01-08 19:29:35 | end=2026-01-08 19:29:35 | dur=794ms | rows=15
SELECT investment_goal, AVG(progress_pct) FROM ATOM_ENTITY_INVESTMENT_GOAL_001 GROUP BY investment_goal;

-- QUERY 42 — Categorize all investment goals by their type and show the average progress for each.
-- query_id=200042 | userid=55 | start=2026-01-08 19:36:59 | end=2026-01-08 19:37:00 | dur=1001ms | rows=19
SELECT investment_goal, AVG(progress_pct) FROM ATOM_ENTITY_INVESTMENT_GOAL_001 GROUP BY investment_goal;

-- QUERY 43 — Can you tell me ?¢¬Ä¬î categorize all investment goals by their type and show the average progress for each.
-- query_id=200043 | userid=23 | start=2026-01-09 10:05:44 | end=2026-01-09 10:05:44 | dur=847ms | rows=11
SELECT investment_goal, AVG(progress_pct) FROM ATOM_ENTITY_INVESTMENT_GOAL_001 GROUP BY investment_goal;

-- QUERY 44 — Across the portfolio database, categorize all investment goals by their type and show the average progress for each.
-- query_id=200044 | userid=55 | start=2026-01-09 10:29:37 | end=2026-01-09 10:29:37 | dur=764ms | rows=20
SELECT investment_goal, AVG(progress_pct) FROM ATOM_ENTITY_INVESTMENT_GOAL_001 GROUP BY investment_goal;

-- QUERY 45 — From the complete wealth management dataset, categorize all investment goals by their type and show the average progress
-- query_id=200045 | userid=30 | start=2026-01-09 10:53:06 | end=2026-01-09 10:53:06 | dur=760ms | rows=3
SELECT investment_goal, AVG(progress_pct) FROM ATOM_ENTITY_INVESTMENT_GOAL_001 GROUP BY investment_goal;

-- QUERY 46 — Count how many portfolios fall into each health status category and calculate their average score.
-- query_id=200046 | userid=68 | start=2026-01-09 11:24:40 | end=2026-01-09 11:24:41 | dur=1307ms | rows=2
SELECT 
      CASE 
        WHEN (goal_match_pct * 0.3 + risk_score * 0.3 + liquidity_score * 0.2 + diversification_score * 0.2) >= 80 THEN 'Healthy'
        WHEN (goal_match_pct * 0.3 + risk_score * 0.3 + liquidity_score * 0.2 + diversification_score * 0.2) >= 60 THEN 'Moderate'
        WHEN (goal_match_pct * 0.3 + risk_score * 0.3 + liquidity_score * 0.2 + diversification_score * 0.2) >= 40 THEN 'At Risk'
        ELSE 'Critical'
      END AS health_status,
      COUNT(*) AS portfolio_count,
      AVG((goal_match_pct * 0.3 + risk_score * 0.3 + liquidity_score * 0.2 + diversification_score * 0.2)) AS average_score
    FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001
    GROUP BY health_status;

-- QUERY 47 — Count how many portfolios fall into each health status category and calculate their average score.
-- query_id=200047 | userid=42 | start=2026-01-09 11:37:17 | end=2026-01-09 11:37:18 | dur=1288ms | rows=17
SELECT 
      CASE 
        WHEN (goal_match_pct * 0.3 + risk_score * 0.3 + liquidity_score * 0.2 + diversification_score * 0.2) >= 80 THEN 'Healthy'
        WHEN (goal_match_pct * 0.3 + risk_score * 0.3 + liquidity_score * 0.2 + diversification_score * 0.2) >= 60 THEN 'Moderate'
        WHEN (goal_match_pct * 0.3 + risk_score * 0.3 + liquidity_score * 0.2 + diversification_score * 0.2) >= 40 THEN 'At Risk'
        ELSE 'Critical'
      END AS health_status,
      COUNT(*) AS portfolio_count,
      AVG((goal_match_pct * 0.3 + risk_score * 0.3 + liquidity_score * 0.2 + diversification_score * 0.2)) AS average_score
    FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001
    GROUP BY health_status;

-- QUERY 48 — Can you tell me ?¢¬Ä¬î count how many portfolios fall into each health status category and calculate their average score
-- query_id=200048 | userid=23 | start=2026-01-09 12:09:07 | end=2026-01-09 12:09:08 | dur=1032ms | rows=7
SELECT 
      CASE 
        WHEN (goal_match_pct * 0.3 + risk_score * 0.3 + liquidity_score * 0.2 + diversification_score * 0.2) >= 80 THEN 'Healthy'
        WHEN (goal_match_pct * 0.3 + risk_score * 0.3 + liquidity_score * 0.2 + diversification_score * 0.2) >= 60 THEN 'Moderate'
        WHEN (goal_match_pct * 0.3 + risk_score * 0.3 + liquidity_score * 0.2 + diversification_score * 0.2) >= 40 THEN 'At Risk'
        ELSE 'Critical'
      END AS health_status,
      COUNT(*) AS portfolio_count,
      AVG((goal_match_pct * 0.3 + risk_score * 0.3 + liquidity_score * 0.2 + diversification_score * 0.2)) AS average_score
    FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001
    GROUP BY health_status;

-- QUERY 49 — Across the portfolio database, count how many portfolios fall into each health status category and calculate their avera
-- query_id=200049 | userid=74 | start=2026-01-09 13:27:33 | end=2026-01-09 13:27:33 | dur=704ms | rows=7
SELECT 
      CASE 
        WHEN (goal_match_pct * 0.3 + risk_score * 0.3 + liquidity_score * 0.2 + diversification_score * 0.2) >= 80 THEN 'Healthy'
        WHEN (goal_match_pct * 0.3 + risk_score * 0.3 + liquidity_score * 0.2 + diversification_score * 0.2) >= 60 THEN 'Moderate'
        WHEN (goal_match_pct * 0.3 + risk_score * 0.3 + liquidity_score * 0.2 + diversification_score * 0.2) >= 40 THEN 'At Risk'
        ELSE 'Critical'
      END AS health_status,
      COUNT(*) AS portfolio_count,
      AVG((goal_match_pct * 0.3 + risk_score * 0.3 + liquidity_score * 0.2 + diversification_score * 0.2)) AS average_score
    FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001
    GROUP BY health_status;

-- QUERY 50 — From the complete wealth management dataset, count how many portfolios fall into each health status category and calcula
-- query_id=200050 | userid=95 | start=2026-01-09 14:37:09 | end=2026-01-09 14:37:09 | dur=990ms | rows=12
SELECT 
      CASE 
        WHEN (goal_match_pct * 0.3 + risk_score * 0.3 + liquidity_score * 0.2 + diversification_score * 0.2) >= 80 THEN 'Healthy'
        WHEN (goal_match_pct * 0.3 + risk_score * 0.3 + liquidity_score * 0.2 + diversification_score * 0.2) >= 60 THEN 'Moderate'
        WHEN (goal_match_pct * 0.3 + risk_score * 0.3 + liquidity_score * 0.2 + diversification_score * 0.2) >= 40 THEN 'At Risk'
        ELSE 'Critical'
      END AS health_status,
      COUNT(*) AS portfolio_count,
      AVG((goal_match_pct * 0.3 + risk_score * 0.3 + liquidity_score * 0.2 + diversification_score * 0.2)) AS average_score
    FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001
    GROUP BY health_status;

-- QUERY 51 — For investor INV002, what is the total transaction amount processed for each type of cash flow
-- query_id=200051 | userid=18 | start=2026-01-09 14:51:22 | end=2026-01-09 14:51:22 | dur=805ms | rows=14
SELECT type, SUM(amount) AS total_cash_flow FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-002' GROUP BY type;

-- QUERY 52 — For investor INV002, what is the total transaction amount processed for each type of cash flow
-- query_id=200052 | userid=30 | start=2026-01-09 19:19:53 | end=2026-01-09 19:19:54 | dur=1038ms | rows=25
SELECT type, SUM(amount) AS total_cash_flow FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-002' GROUP BY type;

-- QUERY 53 — Can you tell me ?¢¬Ä¬î for investor inv002, what is the total transaction amount processed for each type of cash flow
-- query_id=200053 | userid=95 | start=2026-01-09 19:39:36 | end=2026-01-09 19:39:36 | dur=553ms | rows=7
SELECT type, SUM(amount) AS total_cash_flow FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-002' GROUP BY type;

-- QUERY 54 — Across the portfolio database, for investor inv002, what is the total transaction amount processed for each type of cash
-- query_id=200054 | userid=68 | start=2026-01-12 08:33:06 | end=2026-01-12 08:33:06 | dur=997ms | rows=5
SELECT type, SUM(amount) AS total_cash_flow FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-002' GROUP BY type;

-- QUERY 55 — From the complete wealth management dataset, for investor inv002, what is the total transaction amount processed for eac
-- query_id=200055 | userid=42 | start=2026-01-12 09:15:38 | end=2026-01-12 09:15:38 | dur=433ms | rows=13
SELECT type, SUM(amount) AS total_cash_flow FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-002' GROUP BY type;

-- QUERY 56 — Show the number of rebalancing actions recorded, categorised by how much each sector deviates from its target allocation
-- query_id=200056 | userid=68 | start=2026-01-12 10:22:17 | end=2026-01-12 10:22:18 | dur=1197ms | rows=28
SELECT 
      CASE 
        WHEN current_allocation_pct > target_allocation_pct THEN 'Overweight'
        WHEN current_allocation_pct < target_allocation_pct THEN 'Underweight'
        ELSE 'On Target'
      END AS drift_direction,
      COUNT(*) AS rebalancing_action_count
    FROM ATOM_EVENT_REBALANCING_ACTION_001
    GROUP BY drift_direction;

-- QUERY 57 — Display the number of rebalancing actions recorded, categorised by how much each sector deviates from its target allocat
-- query_id=200057 | userid=30 | start=2026-01-12 13:56:00 | end=2026-01-12 13:56:00 | dur=895ms | rows=4
SELECT 
      CASE 
        WHEN current_allocation_pct > target_allocation_pct THEN 'Overweight'
        WHEN current_allocation_pct < target_allocation_pct THEN 'Underweight'
        ELSE 'On Target'
      END AS drift_direction,
      COUNT(*) AS rebalancing_action_count
    FROM ATOM_EVENT_REBALANCING_ACTION_001
    GROUP BY drift_direction;

-- QUERY 58 — Could you show me the number of rebalancing actions recorded, categorised by how much each sector deviates from its targ
-- query_id=200058 | userid=95 | start=2026-01-12 15:31:53 | end=2026-01-12 15:31:53 | dur=777ms | rows=20
SELECT 
      CASE 
        WHEN current_allocation_pct > target_allocation_pct THEN 'Overweight'
        WHEN current_allocation_pct < target_allocation_pct THEN 'Underweight'
        ELSE 'On Target'
      END AS drift_direction,
      COUNT(*) AS rebalancing_action_count
    FROM ATOM_EVENT_REBALANCING_ACTION_001
    GROUP BY drift_direction;

-- QUERY 59 — What does the system show for the number of rebalancing actions recorded, categorised by how much each sector deviates f
-- query_id=200059 | userid=81 | start=2026-01-12 16:41:36 | end=2026-01-12 16:41:36 | dur=726ms | rows=17
SELECT 
      CASE 
        WHEN current_allocation_pct > target_allocation_pct THEN 'Overweight'
        WHEN current_allocation_pct < target_allocation_pct THEN 'Underweight'
        ELSE 'On Target'
      END AS drift_direction,
      COUNT(*) AS rebalancing_action_count
    FROM ATOM_EVENT_REBALANCING_ACTION_001
    GROUP BY drift_direction;

-- QUERY 60 — Please display the number of rebalancing actions recorded, categorised by how much each sector deviates from its target 
-- query_id=200060 | userid=18 | start=2026-01-12 18:11:01 | end=2026-01-12 18:11:01 | dur=927ms | rows=18
SELECT 
      CASE 
        WHEN current_allocation_pct > target_allocation_pct THEN 'Overweight'
        WHEN current_allocation_pct < target_allocation_pct THEN 'Underweight'
        ELSE 'On Target'
      END AS drift_direction,
      COUNT(*) AS rebalancing_action_count
    FROM ATOM_EVENT_REBALANCING_ACTION_001
    GROUP BY drift_direction;

-- QUERY 61 — List all scenario-based rebalancing events grouped by whether the allocation was increased or decreased, and show the av
-- query_id=200061 | userid=68 | start=2026-01-12 18:28:31 | end=2026-01-12 18:28:32 | dur=1078ms | rows=2
SELECT 
      CASE 
        WHEN new_allocation_pct > current_allocation_pct THEN 'Increase'
        WHEN new_allocation_pct < current_allocation_pct THEN 'Decrease'
        ELSE 'No Change'
      END AS change_direction,
      COUNT(*) AS scenario_rebalance_count,
      AVG(new_allocation_pct) AS average_new_allocation_pct
    FROM ATOM_EVENT_SCENARIO_REBALANCING_001
    GROUP BY change_direction;

-- QUERY 62 — List all scenario-based rebalancing events grouped by whether the allocation was increased or decreased, and show the av
-- query_id=200062 | userid=30 | start=2026-01-12 19:28:00 | end=2026-01-12 19:28:00 | dur=988ms | rows=3
SELECT 
      CASE 
        WHEN new_allocation_pct > current_allocation_pct THEN 'Increase'
        WHEN new_allocation_pct < current_allocation_pct THEN 'Decrease'
        ELSE 'No Change'
      END AS change_direction,
      COUNT(*) AS scenario_rebalance_count,
      AVG(new_allocation_pct) AS average_new_allocation_pct
    FROM ATOM_EVENT_SCENARIO_REBALANCING_001
    GROUP BY change_direction;

-- QUERY 63 — Can you tell me ?¢¬Ä¬î list all scenario-based rebalancing events grouped by whether the allocation was increased or dec
-- query_id=200063 | userid=18 | start=2026-01-13 08:03:38 | end=2026-01-13 08:03:39 | dur=1311ms | rows=25
SELECT 
      CASE 
        WHEN new_allocation_pct > current_allocation_pct THEN 'Increase'
        WHEN new_allocation_pct < current_allocation_pct THEN 'Decrease'
        ELSE 'No Change'
      END AS change_direction,
      COUNT(*) AS scenario_rebalance_count,
      AVG(new_allocation_pct) AS average_new_allocation_pct
    FROM ATOM_EVENT_SCENARIO_REBALANCING_001
    GROUP BY change_direction;

-- QUERY 64 — Across the portfolio database, list all scenario-based rebalancing events grouped by whether the allocation was increase
-- query_id=200064 | userid=68 | start=2026-01-13 08:12:06 | end=2026-01-13 08:12:07 | dur=1116ms | rows=4
SELECT 
      CASE 
        WHEN new_allocation_pct > current_allocation_pct THEN 'Increase'
        WHEN new_allocation_pct < current_allocation_pct THEN 'Decrease'
        ELSE 'No Change'
      END AS change_direction,
      COUNT(*) AS scenario_rebalance_count,
      AVG(new_allocation_pct) AS average_new_allocation_pct
    FROM ATOM_EVENT_SCENARIO_REBALANCING_001
    GROUP BY change_direction;

-- QUERY 65 — From the complete wealth management dataset, list all scenario-based rebalancing events grouped by whether the allocatio
-- query_id=200065 | userid=81 | start=2026-01-13 10:22:56 | end=2026-01-13 10:22:56 | dur=680ms | rows=9
SELECT 
      CASE 
        WHEN new_allocation_pct > current_allocation_pct THEN 'Increase'
        WHEN new_allocation_pct < current_allocation_pct THEN 'Decrease'
        ELSE 'No Change'
      END AS change_direction,
      COUNT(*) AS scenario_rebalance_count,
      AVG(new_allocation_pct) AS average_new_allocation_pct
    FROM ATOM_EVENT_SCENARIO_REBALANCING_001
    GROUP BY change_direction;

-- QUERY 66 — Group the total number of holdings by the risk tolerance of the investors who own them.
-- query_id=200066 | userid=12 | start=2026-01-13 11:19:41 | end=2026-01-13 11:19:42 | dur=1287ms | rows=19
SELECT t2.risk_tolerance, COUNT(t1.holding_id) AS total_holdings
    FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 t1
    JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t2 ON t1.investor_id = t2.investor_id
    GROUP BY t2.risk_tolerance;

-- QUERY 67 — Group the total number of holdings by the risk tolerance of the investors who own them.
-- query_id=200067 | userid=68 | start=2026-01-13 16:31:20 | end=2026-01-13 16:31:21 | dur=1550ms | rows=26
SELECT t2.risk_tolerance, COUNT(t1.holding_id) AS total_holdings
    FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 t1
    JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t2 ON t1.investor_id = t2.investor_id
    GROUP BY t2.risk_tolerance;

-- QUERY 68 — Can you tell me ?¢¬Ä¬î group the total number of holdings by the risk tolerance of the investors who own them.
-- query_id=200068 | userid=18 | start=2026-01-13 18:06:05 | end=2026-01-13 18:06:06 | dur=1592ms | rows=8
SELECT t2.risk_tolerance, COUNT(t1.holding_id) AS total_holdings
    FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 t1
    JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t2 ON t1.investor_id = t2.investor_id
    GROUP BY t2.risk_tolerance;

-- QUERY 69 — Across the portfolio database, group the total number of holdings by the risk tolerance of the investors who own them.
-- query_id=200069 | userid=18 | start=2026-01-13 19:10:17 | end=2026-01-13 19:10:18 | dur=1189ms | rows=9
SELECT t2.risk_tolerance, COUNT(t1.holding_id) AS total_holdings
    FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 t1
    JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t2 ON t1.investor_id = t2.investor_id
    GROUP BY t2.risk_tolerance;

-- QUERY 70 — From the complete wealth management dataset, group the total number of holdings by the risk tolerance of the investors w
-- query_id=200070 | userid=81 | start=2026-01-14 07:19:57 | end=2026-01-14 07:19:58 | dur=1237ms | rows=11
SELECT t2.risk_tolerance, COUNT(t1.holding_id) AS total_holdings
    FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 t1
    JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t2 ON t1.investor_id = t2.investor_id
    GROUP BY t2.risk_tolerance;

-- QUERY 71 — Find the maximum total investment amount recorded for each sector in the sector allocation records.
-- query_id=200071 | userid=30 | start=2026-01-14 07:44:47 | end=2026-01-14 07:44:48 | dur=1000ms | rows=23
SELECT sector, MAX(total_investment) AS max_total_investment FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 GROUP BY sector;

-- QUERY 72 — Find the maximum total investment amount recorded for each sector in the sector allocation records.
-- query_id=200072 | userid=81 | start=2026-01-14 07:47:05 | end=2026-01-14 07:47:05 | dur=817ms | rows=30
SELECT sector, MAX(total_investment) AS max_total_investment FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 GROUP BY sector;

-- QUERY 73 — Can you find the maximum total investment amount recorded for each sector in the sector allocation records.
-- query_id=200073 | userid=23 | start=2026-01-14 08:35:26 | end=2026-01-14 08:35:27 | dur=1216ms | rows=27
SELECT sector, MAX(total_investment) AS max_total_investment FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 GROUP BY sector;

-- QUERY 74 — What can be found for the maximum total investment amount recorded for each sector in the sector allocation records.
-- query_id=200074 | userid=81 | start=2026-01-14 09:21:42 | end=2026-01-14 09:21:42 | dur=749ms | rows=7
SELECT sector, MAX(total_investment) AS max_total_investment FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 GROUP BY sector;

-- QUERY 75 — Search through all records to find the maximum total investment amount recorded for each sector in the sector allocation
-- query_id=200075 | userid=81 | start=2026-01-14 10:33:13 | end=2026-01-14 10:33:14 | dur=1000ms | rows=15
SELECT sector, MAX(total_investment) AS max_total_investment FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 GROUP BY sector;

-- QUERY 76 — Summarise the total cash flow amount for each month for investor INV003.
-- query_id=200076 | userid=81 | start=2026-01-14 11:31:26 | end=2026-01-14 11:31:26 | dur=788ms | rows=22
SELECT strftime('%Y-%m', date) as transaction_month, SUM(amount) as total_cash_flow FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-003' GROUP BY transaction_month;

-- QUERY 77 — Summarise the total cash flow amount for each month for investor INV003.
-- query_id=200077 | userid=18 | start=2026-01-14 12:09:01 | end=2026-01-14 12:09:02 | dur=1185ms | rows=14
SELECT strftime('%Y-%m', date) as transaction_month, SUM(amount) as total_cash_flow FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-003' GROUP BY transaction_month;

-- QUERY 78 — Can you tell me ?¢¬Ä¬î summarise the total cash flow amount for each month for investor inv003.
-- query_id=200078 | userid=95 | start=2026-01-14 12:17:29 | end=2026-01-14 12:17:29 | dur=878ms | rows=23
SELECT strftime('%Y-%m', date) as transaction_month, SUM(amount) as total_cash_flow FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-003' GROUP BY transaction_month;

-- QUERY 79 — Across the portfolio database, summarise the total cash flow amount for each month for investor inv003.
-- query_id=200079 | userid=81 | start=2026-01-14 13:20:18 | end=2026-01-14 13:20:18 | dur=893ms | rows=8
SELECT strftime('%Y-%m', date) as transaction_month, SUM(amount) as total_cash_flow FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-003' GROUP BY transaction_month;

-- QUERY 80 — From the complete wealth management dataset, summarise the total cash flow amount for each month for investor inv003.
-- query_id=200080 | userid=18 | start=2026-01-14 14:06:05 | end=2026-01-14 14:06:06 | dur=1157ms | rows=9
SELECT strftime('%Y-%m', date) as transaction_month, SUM(amount) as total_cash_flow FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-003' GROUP BY transaction_month;

-- QUERY 81 — Display a count of investors grouped by their preferred sector focus.
-- query_id=200081 | userid=81 | start=2026-01-14 18:13:09 | end=2026-01-14 18:13:09 | dur=781ms | rows=18
SELECT sector_focus, COUNT(investor_id) AS investor_count FROM ATOM_ENTITY_INVESTOR_PROFILE_001 GROUP BY sector_focus;

-- QUERY 82 — Display a count of investors grouped by their preferred sector focus.
-- query_id=200082 | userid=74 | start=2026-01-14 18:51:06 | end=2026-01-14 18:51:07 | dur=1033ms | rows=13
SELECT sector_focus, COUNT(investor_id) AS investor_count FROM ATOM_ENTITY_INVESTOR_PROFILE_001 GROUP BY sector_focus;

-- QUERY 83 — Can you display a count of investors grouped by their preferred sector focus.
-- query_id=200083 | userid=55 | start=2026-01-14 19:43:18 | end=2026-01-14 19:43:18 | dur=911ms | rows=20
SELECT sector_focus, COUNT(investor_id) AS investor_count FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE sector_focus IS NOT NULL GROUP BY sector_focus;

-- QUERY 84 — Across the portfolio database, display a count of investors grouped by their preferred sector focus.
-- query_id=200084 | userid=68 | start=2026-01-15 08:13:17 | end=2026-01-15 08:13:18 | dur=1089ms | rows=28
SELECT sector_focus, COUNT(investor_id) AS investor_count FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE sector_focus IS NOT NULL GROUP BY sector_focus;

-- QUERY 85 — From the complete wealth management dataset, display a count of investors grouped by their preferred sector focus.
-- query_id=200085 | userid=30 | start=2026-01-15 09:14:52 | end=2026-01-15 09:14:53 | dur=1042ms | rows=25
SELECT sector_focus, COUNT(investor_id) AS investor_count FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE sector_focus IS NOT NULL GROUP BY sector_focus;

-- QUERY 86 — Calculate the average target amount for investment goals, grouped by the investor's risk profile.
-- query_id=200086 | userid=74 | start=2026-01-15 09:45:12 | end=2026-01-15 09:45:13 | dur=1026ms | rows=25
SELECT t2.risk_tolerance, AVG(t1.target_amount) AS average_target_amount
    FROM ATOM_ENTITY_INVESTMENT_GOAL_001 t1
    JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t2 ON t1.investor_id = t2.investor_id
    GROUP BY t2.risk_tolerance;

-- QUERY 87 — Calculate the average target amount for investment goals, grouped by the investor's risk profile.
-- query_id=200087 | userid=81 | start=2026-01-15 12:43:29 | end=2026-01-15 12:43:30 | dur=1717ms | rows=28
SELECT t2.risk_tolerance, AVG(t1.target_amount) AS average_target_amount
    FROM ATOM_ENTITY_INVESTMENT_GOAL_001 t1
    JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t2 ON t1.investor_id = t2.investor_id
    GROUP BY t2.risk_tolerance;

-- QUERY 88 — Can you calculate the average target amount for investment goals, grouped by the investor's risk profile.
-- query_id=200088 | userid=12 | start=2026-01-15 13:43:01 | end=2026-01-15 13:43:02 | dur=1206ms | rows=24
SELECT t2.risk_tolerance, AVG(t1.target_amount) AS average_target_amount
    FROM ATOM_ENTITY_INVESTMENT_GOAL_001 t1
    JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t2 ON t1.investor_id = t2.investor_id
    GROUP BY t2.risk_tolerance;

-- QUERY 89 — What is the calculated value of the average target amount for investment goals, grouped by the investor's risk profile.
-- query_id=200089 | userid=23 | start=2026-01-15 13:49:39 | end=2026-01-15 13:49:39 | dur=781ms | rows=17
SELECT t2.risk_tolerance, AVG(t1.target_amount) AS average_target_amount
    FROM ATOM_ENTITY_INVESTMENT_GOAL_001 t1
    JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t2 ON t1.investor_id = t2.investor_id
    GROUP BY t2.risk_tolerance;

-- QUERY 90 — Based on portfolio data, calculate the average target amount for investment goals, grouped by the investor's risk profil
-- query_id=200090 | userid=74 | start=2026-01-15 14:39:42 | end=2026-01-15 14:39:42 | dur=626ms | rows=18
SELECT t2.risk_tolerance, AVG(t1.target_amount) AS average_target_amount
    FROM ATOM_ENTITY_INVESTMENT_GOAL_001 t1
    JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t2 ON t1.investor_id = t2.investor_id
    GROUP BY t2.risk_tolerance;

-- QUERY 91 — Show a count of rebalancing events for each unique market scenario recorded in the system.
-- query_id=200091 | userid=42 | start=2026-01-15 14:55:13 | end=2026-01-15 14:55:13 | dur=972ms | rows=6
SELECT scenario, COUNT(*) AS rebalance_event_count FROM ATOM_EVENT_SCENARIO_REBALANCING_001 GROUP BY scenario;

-- QUERY 92 — Display a count of rebalancing events for each unique market scenario recorded in the system.
-- query_id=200092 | userid=30 | start=2026-01-15 15:10:18 | end=2026-01-15 15:10:18 | dur=725ms | rows=27
SELECT scenario, COUNT(*) AS rebalance_event_count FROM ATOM_EVENT_SCENARIO_REBALANCING_001 GROUP BY scenario;

-- QUERY 93 — Could you show me a count of rebalancing events for each unique market scenario recorded in the system.
-- query_id=200093 | userid=68 | start=2026-01-15 15:19:08 | end=2026-01-15 15:19:08 | dur=746ms | rows=23
SELECT scenario, COUNT(*) AS rebalance_event_count FROM ATOM_EVENT_SCENARIO_REBALANCING_001 GROUP BY scenario;

-- QUERY 94 — What does the system show for a count of rebalancing events for each unique market scenario recorded in the system.
-- query_id=200094 | userid=18 | start=2026-01-15 18:10:09 | end=2026-01-15 18:10:09 | dur=884ms | rows=14
SELECT scenario, COUNT(*) AS rebalance_event_count FROM ATOM_EVENT_SCENARIO_REBALANCING_001 GROUP BY scenario;

-- QUERY 95 — Please display a count of rebalancing events for each unique market scenario recorded in the system.
-- query_id=200095 | userid=81 | start=2026-01-15 19:57:13 | end=2026-01-15 19:57:13 | dur=634ms | rows=27
SELECT scenario, COUNT(*) AS rebalance_event_count FROM ATOM_EVENT_SCENARIO_REBALANCING_001 GROUP BY scenario;

-- QUERY 96 — List the names of investors who have a 'Retirement Planning' goal with a shortfall greater than 1,000,000.
-- query_id=200096 | userid=55 | start=2026-01-16 07:02:04 | end=2026-01-16 07:02:05 | dur=1164ms | rows=113
SELECT t2.investor_name, t1.investment_name
    FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 t1
    JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t2 ON t1.investor_id = t2.investor_id
    JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t3 ON t1.investor_id = t3.investor_id
    WHERE t3.investment_goal = 'Retirement Planning';

-- QUERY 97 — Enumerate all names of investors who have a 'Retirement Planning' goal with a shortfall greater than 1,000,000.
-- query_id=200097 | userid=95 | start=2026-01-16 07:14:07 | end=2026-01-16 07:14:08 | dur=1290ms | rows=480
SELECT t2.investor_name, t1.investment_name
    FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 t1
    JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t2 ON t1.investor_id = t2.investor_id
    JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t3 ON t1.investor_id = t3.investor_id
    WHERE t3.investment_goal = 'Retirement Planning';

-- QUERY 98 — Can you list all names of investors who have a 'Retirement Planning' goal with a shortfall greater than 1,000,000.
-- query_id=200098 | userid=55 | start=2026-01-16 07:49:35 | end=2026-01-16 07:49:35 | dur=964ms | rows=158
SELECT t2.investor_name, t1.investment_name
    FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 t1
    JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t2 ON t1.investor_id = t2.investor_id
    JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t3 ON t1.investor_id = t3.investor_id
    WHERE t3.investment_goal = 'Retirement Planning';

-- QUERY 99 — What are all the names of investors who have a 'Retirement Planning' goal with a shortfall greater than 1,000,000.
-- query_id=200099 | userid=23 | start=2026-01-16 08:01:09 | end=2026-01-16 08:01:10 | dur=1516ms | rows=391
SELECT t2.investor_name, t1.investment_name
    FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 t1
    JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t2 ON t1.investor_id = t2.investor_id
    JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t3 ON t1.investor_id = t3.investor_id
    WHERE t3.investment_goal = 'Retirement Planning';

-- QUERY 100 — Provide a complete list of all the names of investors who have a 'Retirement Planning' goal with a shortfall greater tha
-- query_id=200100 | userid=23 | start=2026-01-16 09:13:07 | end=2026-01-16 09:13:08 | dur=1712ms | rows=55
SELECT t2.investor_name, t1.investment_name
    FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 t1
    JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t2 ON t1.investor_id = t2.investor_id
    JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t3 ON t1.investor_id = t3.investor_id
    WHERE t3.investment_goal = 'Retirement Planning';

-- QUERY 101 — What is the total current market value of holdings for investors with an 'Aggressive' risk profile
-- query_id=200101 | userid=68 | start=2026-01-16 11:51:27 | end=2026-01-16 11:51:27 | dur=725ms | rows=1
SELECT SUM(h.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Aggressive';

-- QUERY 102 — Please provide the total current market value of holdings for investors with an 'Aggressive' risk profile
-- query_id=200102 | userid=74 | start=2026-01-16 13:08:53 | end=2026-01-16 13:08:54 | dur=1155ms | rows=1
SELECT SUM(h.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Aggressive';

-- QUERY 103 — Can you tell me what the total current market value of holdings for investors with an 'Aggressive' risk profile
-- query_id=200103 | userid=23 | start=2026-01-16 13:20:47 | end=2026-01-16 13:20:48 | dur=1210ms | rows=1
SELECT SUM(h.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Aggressive';

-- QUERY 104 — What would be the total current market value of holdings for investors with an 'Aggressive' risk profile
-- query_id=200104 | userid=23 | start=2026-01-16 14:17:47 | end=2026-01-16 14:17:48 | dur=1078ms | rows=1
SELECT SUM(h.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Aggressive';

-- QUERY 105 — Looking at all available records, what is the total current market value of holdings for investors with an 'Aggressive' 
-- query_id=200105 | userid=55 | start=2026-01-16 14:53:10 | end=2026-01-16 14:53:10 | dur=699ms | rows=1
SELECT SUM(h.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Aggressive';

-- QUERY 106 — Show the overall portfolio health score for all investors who are not on track to meet their 'Child Education' goals.
-- query_id=200106 | userid=18 | start=2026-01-16 15:31:08 | end=2026-01-16 15:31:09 | dur=1244ms | rows=57
SELECT p.investor_name, (h.goal_match_pct * 0.3 + h.risk_score * 0.3 + h.liquidity_score * 0.2 + h.diversification_score * 0.2) as health_score FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON p.investor_id = g.investor_id WHERE g.investment_goal = 'Child Education' AND g.progress_pct < 0.5;

-- QUERY 107 — Display the overall portfolio health score for all investors who are not on track to meet their 'Child Education' goals.
-- query_id=200107 | userid=12 | start=2026-01-16 16:30:39 | end=2026-01-16 16:30:40 | dur=1392ms | rows=403
SELECT p.investor_name, (h.goal_match_pct * 0.3 + h.risk_score * 0.3 + h.liquidity_score * 0.2 + h.diversification_score * 0.2) as health_score FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON p.investor_id = g.investor_id WHERE g.investment_goal = 'Child Education' AND g.progress_pct < 0.5;

-- QUERY 108 — Could you show me the overall portfolio health score for all investors who are not on track to meet their 'Child Educati
-- query_id=200108 | userid=18 | start=2026-01-16 18:21:39 | end=2026-01-16 18:21:40 | dur=1780ms | rows=91
SELECT p.investor_name, (h.goal_match_pct * 0.3 + h.risk_score * 0.3 + h.liquidity_score * 0.2 + h.diversification_score * 0.2) as health_score FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON p.investor_id = g.investor_id WHERE g.investment_goal = 'Child Education' AND g.progress_pct < 0.5;

-- QUERY 109 — What does the system show for the overall portfolio health score for all investors who are not on track to meet their 'C
-- query_id=200109 | userid=68 | start=2026-01-16 19:49:36 | end=2026-01-16 19:49:37 | dur=1143ms | rows=220
SELECT p.investor_name, (h.goal_match_pct * 0.3 + h.risk_score * 0.3 + h.liquidity_score * 0.2 + h.diversification_score * 0.2) as health_score FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON p.investor_id = g.investor_id WHERE g.investment_goal = 'Child Education' AND g.progress_pct < 0.5;

-- QUERY 110 — Please display the overall portfolio health score for all investors who are not on track to meet their 'Child Education'
-- query_id=200110 | userid=42 | start=2026-01-19 07:35:24 | end=2026-01-19 07:35:26 | dur=2006ms | rows=325
SELECT p.investor_name, (h.goal_match_pct * 0.3 + h.risk_score * 0.3 + h.liquidity_score * 0.2 + h.diversification_score * 0.2) as health_score FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON p.investor_id = g.investor_id WHERE g.investment_goal = 'Child Education' AND g.progress_pct < 0.5;

-- QUERY 111 — Find the names of investors who made a 'SIP' type cash flow transaction in January 2024.
-- query_id=200111 | userid=74 | start=2026-01-19 08:25:46 | end=2026-01-19 08:25:47 | dur=1388ms | rows=435
SELECT DISTINCT p.investor_name FROM ATOM_EVENT_CASH_FLOW_001 c JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON c.investor_id = p.investor_id WHERE c.type = 'SIP' AND c.date LIKE '2024-01%';

-- QUERY 112 — Find the names of investors who made a 'SIP' type cash flow transaction in January 2024.
-- query_id=200112 | userid=95 | start=2026-01-19 11:07:55 | end=2026-01-19 11:07:55 | dur=956ms | rows=169
SELECT DISTINCT p.investor_name FROM ATOM_EVENT_CASH_FLOW_001 c JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON c.investor_id = p.investor_id WHERE c.type = 'SIP' AND c.date LIKE '2024-01%';

-- QUERY 113 — Can you find the names of investors who made a 'SIP' type cash flow transaction in January 2024.
-- query_id=200113 | userid=95 | start=2026-01-19 18:01:22 | end=2026-01-19 18:01:23 | dur=1615ms | rows=360
SELECT DISTINCT p.investor_name FROM ATOM_EVENT_CASH_FLOW_001 c JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON c.investor_id = p.investor_id WHERE c.type = 'SIP' AND c.date LIKE '2024-01%';

-- QUERY 114 — What can be found for the names of investors who made a 'SIP' type cash flow transaction in January 2024.
-- query_id=200114 | userid=74 | start=2026-01-19 18:43:51 | end=2026-01-19 18:43:52 | dur=1340ms | rows=423
SELECT DISTINCT p.investor_name FROM ATOM_EVENT_CASH_FLOW_001 c JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON c.investor_id = p.investor_id WHERE c.type = 'SIP' AND c.date LIKE '2024-01%';

-- QUERY 115 — Search through all records to find the names of investors who made a 'SIP' type cash flow transaction in January 2024.
-- query_id=200115 | userid=68 | start=2026-01-19 19:43:49 | end=2026-01-19 19:43:49 | dur=752ms | rows=492
SELECT DISTINCT p.investor_name FROM ATOM_EVENT_CASH_FLOW_001 c JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON c.investor_id = p.investor_id WHERE c.type = 'SIP' AND c.date LIKE '2024-01%';

-- QUERY 116 — List the names of holdings in the 'Technology' sector for investors who have a pending 'Sell' rebalancing action.
-- query_id=200116 | userid=74 | start=2026-01-20 07:01:33 | end=2026-01-20 07:01:34 | dur=1226ms | rows=40
SELECT DISTINCT h.investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_EVENT_REBALANCING_ACTION_001 r ON h.investor_id = r.investor_id WHERE h.sector = 'Technology' AND r.action LIKE  '%SelL%';

-- QUERY 117 — Enumerate all names of holdings in the 'Technology' sector for investors who have a pending 'Sell' rebalancing action.
-- query_id=200117 | userid=68 | start=2026-01-20 08:41:24 | end=2026-01-20 08:41:25 | dur=1028ms | rows=409
SELECT DISTINCT h.investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_EVENT_REBALANCING_ACTION_001 r ON h.investor_id = r.investor_id WHERE h.sector = 'Technology' AND r.action = 'Sell';

-- QUERY 118 — Can you list all names of holdings in the 'Technology' sector for investors who have a pending 'Sell' rebalancing action
-- query_id=200118 | userid=68 | start=2026-01-20 09:56:47 | end=2026-01-20 09:56:47 | dur=707ms | rows=264
SELECT DISTINCT h.investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_EVENT_REBALANCING_ACTION_001 r ON h.investor_id = r.investor_id WHERE h.sector = 'Technology' AND r.action LIKE  '%SelL%';

-- QUERY 119 — What are all the names of holdings in the 'Technology' sector for investors who have a pending 'Sell' rebalancing action
-- query_id=200119 | userid=68 | start=2026-01-20 11:43:58 | end=2026-01-20 11:43:58 | dur=884ms | rows=398
SELECT DISTINCT h.investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_EVENT_REBALANCING_ACTION_001 r ON h.investor_id = r.investor_id WHERE h.sector = 'Technology' AND r.action LIKE  '%SelL%';

-- QUERY 120 — Provide a complete list of all the names of holdings in the 'Technology' sector for investors who have a pending 'Sell' 
-- query_id=200120 | userid=30 | start=2026-01-20 12:23:51 | end=2026-01-20 12:23:52 | dur=1235ms | rows=335
SELECT DISTINCT h.investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_EVENT_REBALANCING_ACTION_001 r ON h.investor_id = r.investor_id WHERE h.sector = 'Technology' AND r.action LIKE  '%SelL%';

-- QUERY 121 — Which investors with a 'Moderate' risk profile have a total amount invested in 'Financial Services' exceeding 500,000
-- query_id=200121 | userid=68 | start=2026-01-20 12:29:08 | end=2026-01-20 12:29:09 | dur=1610ms | rows=266
SELECT p.investor_name FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 s ON p.investor_id = s.investor_id WHERE p.risk_tolerance = 'Moderate' AND s.sector = 'Financial Services' AND s.total_investment > 500000;

-- QUERY 122 — Identify the investor whos with a 'Moderate' risk profile have a total amount invested in 'Financial Services' exceeding
-- query_id=200122 | userid=81 | start=2026-01-20 14:42:02 | end=2026-01-20 14:42:03 | dur=1188ms | rows=205
SELECT p.investor_name FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 s ON p.investor_id = s.investor_id WHERE p.risk_tolerance = 'Moderate' AND s.sector = 'Financial Services' AND s.total_investment > 500000;

-- QUERY 123 — I want to know which investors with a 'Moderate' risk profile have a total amount invested in 'Financial Services' excee
-- query_id=200123 | userid=74 | start=2026-01-20 15:21:00 | end=2026-01-20 15:21:01 | dur=1566ms | rows=156
SELECT p.investor_name FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 s ON p.investor_id = s.investor_id WHERE p.risk_tolerance = 'Moderate' AND s.sector = 'Financial Services' AND s.total_investment > 500000;

-- QUERY 124 — Among all investors, which ones with a 'Moderate' risk profile have a total amount invested in 'Financial Services' exce
-- query_id=200124 | userid=68 | start=2026-01-20 18:53:40 | end=2026-01-20 18:53:41 | dur=1105ms | rows=164
SELECT p.investor_name FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 s ON p.investor_id = s.investor_id WHERE p.risk_tolerance = 'Moderate' AND s.sector = 'Financial Services' AND s.total_investment > 500000;

-- QUERY 125 — Considering all investors in the system, which investors with a 'Moderate' risk profile have a total amount invested in 
-- query_id=200125 | userid=55 | start=2026-01-21 07:28:14 | end=2026-01-21 07:28:14 | dur=706ms | rows=168
SELECT p.investor_name FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 s ON p.investor_id = s.investor_id WHERE p.risk_tolerance = 'Moderate' AND s.sector = 'Financial Services' AND s.total_investment > 500000;

-- QUERY 126 — Show the portfolio health condition for all investors who were affected by the 'Interest Rate Hike' scenario rebalancing
-- query_id=200126 | userid=18 | start=2026-01-21 11:50:48 | end=2026-01-21 11:50:49 | dur=1076ms | rows=336
SELECT p.investor_name, (h.goal_match_pct * 0.3 + h.risk_score * 0.3 + h.liquidity_score * 0.2 + h.diversification_score * 0.2) as health_score FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id JOIN ATOM_EVENT_SCENARIO_REBALANCING_001 s ON p.investor_id = s.investor_id WHERE s.scenario = 'Interest Rate Hike';

-- QUERY 127 — Display the portfolio health condition for all investors who were affected by the 'Interest Rate Hike' scenario rebalanc
-- query_id=200127 | userid=18 | start=2026-01-21 13:21:28 | end=2026-01-21 13:21:29 | dur=1122ms | rows=223
SELECT p.investor_name, (h.goal_match_pct * 0.3 + h.risk_score * 0.3 + h.liquidity_score * 0.2 + h.diversification_score * 0.2) as health_score FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id JOIN ATOM_EVENT_SCENARIO_REBALANCING_001 s ON p.investor_id = s.investor_id WHERE s.scenario = 'Interest Rate Hike';

-- QUERY 128 — Could you show me the portfolio health condition for all investors who were affected by the 'Interest Rate Hike' scenari
-- query_id=200128 | userid=74 | start=2026-01-21 15:54:37 | end=2026-01-21 15:54:38 | dur=1274ms | rows=19
SELECT p.investor_name, (h.goal_match_pct * 0.3 + h.risk_score * 0.3 + h.liquidity_score * 0.2 + h.diversification_score * 0.2) as health_score FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id JOIN ATOM_EVENT_SCENARIO_REBALANCING_001 s ON p.investor_id = s.investor_id WHERE s.scenario = 'Interest Rate Hike';

-- QUERY 129 — What does the system show for the portfolio health condition for all investors who were affected by the 'Interest Rate H
-- query_id=200129 | userid=95 | start=2026-01-21 16:43:58 | end=2026-01-21 16:43:59 | dur=1363ms | rows=390
SELECT p.investor_name, (h.goal_match_pct * 0.3 + h.risk_score * 0.3 + h.liquidity_score * 0.2 + h.diversification_score * 0.2) as health_score FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id JOIN ATOM_EVENT_SCENARIO_REBALANCING_001 s ON p.investor_id = s.investor_id WHERE s.scenario = 'Interest Rate Hike';

-- QUERY 130 — Please display the portfolio health condition for all investors who were affected by the 'Interest Rate Hike' scenario r
-- query_id=200130 | userid=18 | start=2026-01-21 17:02:24 | end=2026-01-21 17:02:25 | dur=1078ms | rows=171
SELECT p.investor_name, (h.goal_match_pct * 0.3 + h.risk_score * 0.3 + h.liquidity_score * 0.2 + h.diversification_score * 0.2) as health_score FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id JOIN ATOM_EVENT_SCENARIO_REBALANCING_001 s ON p.investor_id = s.investor_id WHERE s.scenario = 'Interest Rate Hike';

-- QUERY 131 — List the names and risk profiles of investors whose portfolios have a diversification score below 50.
-- query_id=200131 | userid=30 | start=2026-01-21 18:49:25 | end=2026-01-21 18:49:26 | dur=1024ms | rows=203
SELECT p.investor_name, p.risk_tolerance FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE h.diversification_score < 50;

-- QUERY 132 — Enumerate all names and risk profiles of investors whose portfolios have a diversification score below 50.
-- query_id=200132 | userid=95 | start=2026-01-22 07:00:07 | end=2026-01-22 07:00:08 | dur=1097ms | rows=93
SELECT p.investor_name, p.risk_tolerance FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE h.diversification_score < 50;

-- QUERY 133 — Can you list all names and risk profiles of investors whose portfolios have a diversification score below 50.
-- query_id=200133 | userid=42 | start=2026-01-22 08:17:38 | end=2026-01-22 08:17:39 | dur=1503ms | rows=98
SELECT p.investor_name, p.risk_tolerance FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE h.diversification_score < 50;

-- QUERY 134 — What are all the names and risk profiles of investors whose portfolios have a diversification score below 50.
-- query_id=200134 | userid=55 | start=2026-01-22 12:38:06 | end=2026-01-22 12:38:07 | dur=1140ms | rows=201
SELECT p.investor_name, p.risk_tolerance FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE h.diversification_score < 50;

-- QUERY 135 — Provide a complete list of all the names and risk profiles of investors whose portfolios have a diversification score be
-- query_id=200135 | userid=68 | start=2026-01-22 12:47:01 | end=2026-01-22 12:47:02 | dur=1024ms | rows=100
SELECT p.investor_name, p.risk_tolerance FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE h.diversification_score < 50;

-- QUERY 136 — Show the names of investors and the reasoning behind any 'Buy' rebalancing actions where the amount exceeds 100,000.
-- query_id=200136 | userid=55 | start=2026-01-22 14:10:05 | end=2026-01-22 14:10:06 | dur=1342ms | rows=253
SELECT p.investor_name, r.notes FROM ATOM_EVENT_REBALANCING_ACTION_001 r JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON r.investor_id = p.investor_id WHERE r.action = 'Buy' AND r.amount > 100000;

-- QUERY 137 — Display the names of investors and the reasoning behind any 'Buy' rebalancing actions where the amount exceeds 100,000.
-- query_id=200137 | userid=23 | start=2026-01-22 14:50:25 | end=2026-01-22 14:50:25 | dur=841ms | rows=435
SELECT p.investor_name, r.notes FROM ATOM_EVENT_REBALANCING_ACTION_001 r JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON r.investor_id = p.investor_id WHERE r.action = 'Buy' AND r.amount > 100000;

-- QUERY 138 — Could you show me the names of investors and the reasoning behind any 'Buy' rebalancing actions where the amount exceeds
-- query_id=200138 | userid=74 | start=2026-01-22 15:52:14 | end=2026-01-22 15:52:14 | dur=790ms | rows=21
SELECT p.investor_name, r.notes FROM ATOM_EVENT_REBALANCING_ACTION_001 r JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON r.investor_id = p.investor_id WHERE r.action = 'Buy' AND r.amount > 100000;

-- QUERY 139 — What does the system show for the names of investors and the reasoning behind any 'Buy' rebalancing actions where the am
-- query_id=200139 | userid=42 | start=2026-01-22 17:20:28 | end=2026-01-22 17:20:28 | dur=999ms | rows=286
SELECT p.investor_name, r.notes FROM ATOM_EVENT_REBALANCING_ACTION_001 r JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON r.investor_id = p.investor_id WHERE r.action = 'Buy' AND r.amount > 100000;

-- QUERY 140 — Please display the names of investors and the reasoning behind any 'Buy' rebalancing actions where the amount exceeds 10
-- query_id=200140 | userid=81 | start=2026-01-22 17:22:12 | end=2026-01-22 17:22:12 | dur=704ms | rows=282
SELECT p.investor_name, r.notes FROM ATOM_EVENT_REBALANCING_ACTION_001 r JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON r.investor_id = p.investor_id WHERE r.action = 'Buy' AND r.amount > 100000;

-- QUERY 141 — Compare the preferred sector in the investor's profile to the sector with the highest allocation percentage in their act
-- query_id=200141 | userid=12 | start=2026-01-23 07:24:15 | end=2026-01-23 07:24:16 | dur=1399ms | rows=1
SELECT p.sector_focus, s.sector FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 s ON p.investor_id = s.investor_id WHERE p.investor_id = 'INV-001' ORDER BY s.allocation_pct DESC LIMIT 1;

-- QUERY 142 — Compare the preferred sector in the investor's profile to the sector with the highest allocation percentage in their act
-- query_id=200142 | userid=30 | start=2026-01-23 08:43:47 | end=2026-01-23 08:43:47 | dur=702ms | rows=1
SELECT p.sector_focus, s.sector FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 s ON p.investor_id = s.investor_id WHERE p.investor_id = 'INV-001' ORDER BY s.allocation_pct DESC LIMIT 1;

-- QUERY 143 — Can you tell me ?¢¬Ä¬î compare the preferred sector in the investor's profile to the sector with the highest allocation 
-- query_id=200143 | userid=18 | start=2026-01-23 08:44:48 | end=2026-01-23 08:44:49 | dur=1144ms | rows=1
SELECT p.sector_focus, s.sector FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 s ON p.investor_id = s.investor_id WHERE p.investor_id = 'INV-001' ORDER BY s.allocation_pct DESC LIMIT 1;

-- QUERY 144 — Across the portfolio database, compare the preferred sector in the investor's profile to the sector with the highest all
-- query_id=200144 | userid=68 | start=2026-01-23 09:31:53 | end=2026-01-23 09:31:54 | dur=1264ms | rows=1
SELECT p.sector_focus, s.sector FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 s ON p.investor_id = s.investor_id WHERE p.investor_id = 'INV-001' ORDER BY s.allocation_pct DESC LIMIT 1;

-- QUERY 145 — From the complete wealth management dataset, compare the preferred sector in the investor's profile to the sector with t
-- query_id=200145 | userid=95 | start=2026-01-23 09:56:11 | end=2026-01-23 09:56:12 | dur=1337ms | rows=1
SELECT p.sector_focus, s.sector FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 s ON p.investor_id = s.investor_id WHERE p.investor_id = 'INV-001' ORDER BY s.allocation_pct DESC LIMIT 1;

-- QUERY 146 — Calculate the average withdrawal amount for investors who have fully completed (100% progress) any of their investment g
-- query_id=200146 | userid=95 | start=2026-01-23 10:56:54 | end=2026-01-23 10:56:54 | dur=950ms | rows=1
SELECT AVG(ABS(c.amount)) FROM ATOM_EVENT_CASH_FLOW_001 c JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON c.investor_id = g.investor_id WHERE c.type = 'Withdrawal' AND g.progress_pct >= 1.0;

-- QUERY 147 — Calculate the average withdrawal amount for investors who have fully completed (100% progress) any of their investment g
-- query_id=200147 | userid=68 | start=2026-01-23 12:14:01 | end=2026-01-23 12:14:02 | dur=1225ms | rows=1
SELECT AVG(ABS(c.amount)) FROM ATOM_EVENT_CASH_FLOW_001 c JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON c.investor_id = g.investor_id WHERE c.type = 'Withdrawal' AND g.progress_pct >= 1.0;

-- QUERY 148 — Can you calculate the average withdrawal amount for investors who have fully completed (100% progress) any of their inve
-- query_id=200148 | userid=55 | start=2026-01-23 13:09:38 | end=2026-01-23 13:09:39 | dur=1063ms | rows=1
SELECT AVG(ABS(c.amount)) FROM ATOM_EVENT_CASH_FLOW_001 c JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON c.investor_id = g.investor_id WHERE c.type = 'Withdrawal' AND g.progress_pct >= 1.0;

-- QUERY 149 — What is the calculated value of the average withdrawal amount for investors who have fully completed (100% progress) any
-- query_id=200149 | userid=23 | start=2026-01-23 15:44:57 | end=2026-01-23 15:44:58 | dur=1515ms | rows=1
SELECT AVG(ABS(c.amount)) FROM ATOM_EVENT_CASH_FLOW_001 c JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON c.investor_id = g.investor_id WHERE c.type = 'Withdrawal' AND g.progress_pct >= 1.0;

-- QUERY 150 — Based on portfolio data, calculate the average withdrawal amount for investors who have fully completed (100% progress) 
-- query_id=200150 | userid=18 | start=2026-01-23 19:25:54 | end=2026-01-23 19:25:55 | dur=1208ms | rows=1
SELECT AVG(ABS(c.amount)) FROM ATOM_EVENT_CASH_FLOW_001 c JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON c.investor_id = g.investor_id WHERE c.type = 'Withdrawal' AND g.progress_pct >= 1.0;

-- QUERY 151 — List 'Mutual Fund' holdings for investors who have never recorded a 'Redemption' type cash flow.
-- query_id=200151 | userid=74 | start=2026-01-26 09:39:49 | end=2026-01-26 09:39:49 | dur=910ms | rows=179
SELECT DISTINCT h.investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h WHERE h.investment_type = 'Mutual Fund' AND h.investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Redemption');

-- QUERY 152 — List 'Mutual Fund' holdings for investors who have never recorded a 'Redemption' type cash flow.
-- query_id=200152 | userid=55 | start=2026-01-26 09:56:13 | end=2026-01-26 09:56:13 | dur=908ms | rows=55
SELECT DISTINCT h.investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h WHERE h.investment_type = 'Mutual Fund' AND h.investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Redemption');

-- QUERY 153 — Can you tell me ?¢¬Ä¬î list 'mutual fund' holdings for investors who have never recorded a 'redemption' type cash flow.
-- query_id=200153 | userid=74 | start=2026-01-26 10:33:57 | end=2026-01-26 10:33:57 | dur=819ms | rows=88
SELECT DISTINCT h.investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h WHERE h.investment_type = 'Mutual Fund' AND h.investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Redemption');

-- QUERY 154 — Across the portfolio database, list 'mutual fund' holdings for investors who have never recorded a 'redemption' type cas
-- query_id=200154 | userid=12 | start=2026-01-26 10:43:58 | end=2026-01-26 10:43:58 | dur=518ms | rows=32
SELECT DISTINCT h.investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h WHERE h.investment_type = 'Mutual Fund' AND h.investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Redemption');

-- QUERY 155 — From the complete wealth management dataset, list 'mutual fund' holdings for investors who have never recorded a 'redemp
-- query_id=200155 | userid=23 | start=2026-01-26 12:25:24 | end=2026-01-26 12:25:25 | dur=1010ms | rows=78
SELECT DISTINCT h.investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h WHERE h.investment_type = 'Mutual Fund' AND h.investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Redemption');

-- QUERY 156 — Show how much each sector's current allocation deviates from its target for sectors where the investor has an active 'Se
-- query_id=200156 | userid=23 | start=2026-01-26 14:14:51 | end=2026-01-26 14:14:51 | dur=672ms | rows=96
SELECT r.investor_id, (r.current_allocation_pct - r.target_allocation_pct) as deviation FROM ATOM_EVENT_REBALANCING_ACTION_001 r WHERE r.action = 'Sell';

-- QUERY 157 — Display how much each sector's current allocation deviates from its target for sectors where the investor has an active 
-- query_id=200157 | userid=23 | start=2026-01-26 15:54:33 | end=2026-01-26 15:54:33 | dur=373ms | rows=1
SELECT r.investor_id, (r.current_allocation_pct - r.target_allocation_pct) as deviation FROM ATOM_EVENT_REBALANCING_ACTION_001 r WHERE r.action LIKE '%Sell%';

-- QUERY 158 — Could you show me how much each sector's current allocation deviates from its target for sectors where the investor has 
-- query_id=200158 | userid=30 | start=2026-01-26 16:37:04 | end=2026-01-26 16:37:04 | dur=548ms | rows=114
SELECT r.investor_id, (r.current_allocation_pct - r.target_allocation_pct) as deviation FROM ATOM_EVENT_REBALANCING_ACTION_001 r WHERE r.action LIKE '%Sell%';

-- QUERY 159 — What does the system show for how much each sector's current allocation deviates from its target for sectors where the i
-- query_id=200159 | userid=12 | start=2026-01-26 17:17:32 | end=2026-01-26 17:17:32 | dur=459ms | rows=99
SELECT r.investor_id, (r.current_allocation_pct - r.target_allocation_pct) as deviation FROM ATOM_EVENT_REBALANCING_ACTION_001 r WHERE r.action LIKE '%Sell%';

-- QUERY 160 — Please display how much each sector's current allocation deviates from its target for sectors where the investor has an 
-- query_id=200160 | userid=18 | start=2026-01-27 08:14:25 | end=2026-01-27 08:14:25 | dur=772ms | rows=98
SELECT r.investor_id, (r.current_allocation_pct - r.target_allocation_pct) as deviation FROM ATOM_EVENT_REBALANCING_ACTION_001 r WHERE r.action LIKE '%Sell%';

-- QUERY 161 — List the names of investors for whom the system recommended 'Reduce equity exposure' during an 'Inflation Surge' scenari
-- query_id=200161 | userid=23 | start=2026-01-27 08:24:19 | end=2026-01-27 08:24:20 | dur=1140ms | rows=184
SELECT DISTINCT p.investor_name FROM ATOM_EVENT_SCENARIO_REBALANCING_001 s JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON s.investor_id = p.investor_id WHERE s.scenario = 'Inflation Surge' AND s.triggered_action = 'Reduce equity exposure';

-- QUERY 162 — Enumerate all names of investors for whom the system recommended 'Reduce equity exposure' during an 'Inflation Surge' sc
-- query_id=200162 | userid=30 | start=2026-01-27 12:10:29 | end=2026-01-27 12:10:30 | dur=1207ms | rows=49
SELECT DISTINCT p.investor_name FROM ATOM_EVENT_SCENARIO_REBALANCING_001 s JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON s.investor_id = p.investor_id WHERE s.scenario = 'Inflation Surge' AND s.triggered_action = 'Reduce equity exposure';

-- QUERY 163 — Can you list all names of investors for whom the system recommended 'Reduce equity exposure' during an 'Inflation Surge'
-- query_id=200163 | userid=18 | start=2026-01-27 13:26:14 | end=2026-01-27 13:26:15 | dur=1183ms | rows=76
SELECT DISTINCT p.investor_name FROM ATOM_EVENT_SCENARIO_REBALANCING_001 s JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON s.investor_id = p.investor_id WHERE s.scenario = 'Inflation Surge' AND s.triggered_action = 'Reduce equity exposure';

-- QUERY 164 — What are all the names of investors for whom the system recommended 'Reduce equity exposure' during an 'Inflation Surge'
-- query_id=200164 | userid=30 | start=2026-01-27 15:33:37 | end=2026-01-27 15:33:38 | dur=1086ms | rows=486
SELECT DISTINCT p.investor_name FROM ATOM_EVENT_SCENARIO_REBALANCING_001 s JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON s.investor_id = p.investor_id WHERE s.scenario = 'Inflation Surge' AND s.triggered_action = 'Reduce equity exposure';

-- QUERY 165 — Provide a complete list of all the names of investors for whom the system recommended 'Reduce equity exposure' during an
-- query_id=200165 | userid=12 | start=2026-01-27 17:06:03 | end=2026-01-27 17:06:04 | dur=1050ms | rows=156
SELECT DISTINCT p.investor_name FROM ATOM_EVENT_SCENARIO_REBALANCING_001 s JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON s.investor_id = p.investor_id WHERE s.scenario = 'Inflation Surge' AND s.triggered_action = 'Reduce equity exposure';

-- QUERY 166 — For investors pursuing 'Growth' goals, what is the total amount currently recommended for 'Buy' rebalancing actions
-- query_id=200166 | userid=12 | start=2026-01-27 17:15:38 | end=2026-01-27 17:15:39 | dur=1119ms | rows=1
SELECT SUM(r.amount) FROM ATOM_EVENT_REBALANCING_ACTION_001 r JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON r.investor_id = g.investor_id WHERE g.investment_goal = 'Growth' AND r.action LIKE '%Buy%';

-- QUERY 167 — For investors pursuing 'Growth' goals, what is the total amount currently recommended for 'Buy' rebalancing actions
-- query_id=200167 | userid=95 | start=2026-01-27 17:42:20 | end=2026-01-27 17:42:21 | dur=1076ms | rows=1
SELECT SUM(r.amount) FROM ATOM_EVENT_REBALANCING_ACTION_001 r JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON r.investor_id = g.investor_id WHERE g.investment_goal = 'Growth' AND r.action = 'Buy';

-- QUERY 168 — Can you tell me ?¢¬Ä¬î for investors pursuing 'growth' goals, what is the total amount currently recommended for 'buy' r
-- query_id=200168 | userid=95 | start=2026-01-28 07:58:30 | end=2026-01-28 07:58:31 | dur=1280ms | rows=1
SELECT SUM(r.amount) FROM ATOM_EVENT_REBALANCING_ACTION_001 r JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON r.investor_id = g.investor_id WHERE g.investment_goal = 'Growth' AND r.action = 'Buy';

-- QUERY 169 — Across the portfolio database, for investors pursuing 'growth' goals, what is the total amount currently recommended for
-- query_id=200169 | userid=18 | start=2026-01-28 11:06:14 | end=2026-01-28 11:06:15 | dur=1141ms | rows=1
SELECT SUM(r.amount) FROM ATOM_EVENT_REBALANCING_ACTION_001 r JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON r.investor_id = g.investor_id WHERE g.investment_goal = 'Growth' AND r.action = 'Buy';

-- QUERY 170 — From the complete wealth management dataset, for investors pursuing 'growth' goals, what is the total amount currently r
-- query_id=200170 | userid=68 | start=2026-01-28 13:11:01 | end=2026-01-28 13:11:01 | dur=836ms | rows=1
SELECT SUM(r.amount) FROM ATOM_EVENT_REBALANCING_ACTION_001 r JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON r.investor_id = g.investor_id WHERE g.investment_goal = 'Growth' AND r.action = 'Buy';

-- QUERY 171 — Show the liquidity rating for investors who have allocated more than 40% of their portfolio to the 'Technology' sector.
-- query_id=200171 | userid=68 | start=2026-01-28 14:52:08 | end=2026-01-28 14:52:09 | dur=1558ms | rows=476
SELECT p.investor_name, h.liquidity_score FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 s JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 h ON s.investor_id = h.investor_id JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON s.investor_id = p.investor_id WHERE s.sector = 'Technology' AND s.allocation_pct > 40;

-- QUERY 172 — Display the liquidity rating for investors who have allocated more than 40% of their portfolio to the 'Technology' secto
-- query_id=200172 | userid=30 | start=2026-01-28 17:24:01 | end=2026-01-28 17:24:02 | dur=1532ms | rows=395
SELECT p.investor_name, h.liquidity_score FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 s JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 h ON s.investor_id = h.investor_id JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON s.investor_id = p.investor_id WHERE s.sector = 'Technology' AND s.allocation_pct > 40;

-- QUERY 173 — Could you show me the liquidity rating for investors who have allocated more than 40% of their portfolio to the 'Technol
-- query_id=200173 | userid=18 | start=2026-01-28 17:49:47 | end=2026-01-28 17:49:48 | dur=1648ms | rows=64
SELECT p.investor_name, h.liquidity_score FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 s JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 h ON s.investor_id = h.investor_id JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON s.investor_id = p.investor_id WHERE s.sector = 'Technology' AND s.allocation_pct > 40;

-- QUERY 174 — What does the system show for the liquidity rating for investors who have allocated more than 40% of their portfolio to 
-- query_id=200174 | userid=74 | start=2026-01-28 18:58:36 | end=2026-01-28 18:58:38 | dur=2279ms | rows=11
SELECT p.investor_name, h.liquidity_score FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 s JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 h ON s.investor_id = h.investor_id JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON s.investor_id = p.investor_id WHERE s.sector = 'Technology' AND s.allocation_pct > 40;

-- QUERY 175 — Please display the liquidity rating for investors who have allocated more than 40% of their portfolio to the 'Technology
-- query_id=200175 | userid=23 | start=2026-01-28 19:36:01 | end=2026-01-28 19:36:02 | dur=1243ms | rows=90
SELECT p.investor_name, h.liquidity_score FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 s JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 h ON s.investor_id = h.investor_id JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON s.investor_id = p.investor_id WHERE s.sector = 'Technology' AND s.allocation_pct > 40;

-- QUERY 176 — For investor INV001, list all holdings that match their stated preferred investment category and are linked to their 'Gr
-- query_id=200176 | userid=55 | start=2026-01-29 08:38:20 | end=2026-01-29 08:38:21 | dur=1284ms | rows=465
SELECT h.investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON h.investor_id = g.investor_id WHERE h.investor_id = 'INV-001' AND h.category = p.category AND g.investment_goal = 'Growth';

-- QUERY 177 — For investor INV001, list all holdings that match their stated preferred investment category and are linked to their 'Gr
-- query_id=200177 | userid=12 | start=2026-01-29 10:28:46 | end=2026-01-29 10:28:47 | dur=1751ms | rows=259
SELECT h.investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON h.investor_id = g.investor_id WHERE h.investor_id = 'INV-001' AND h.category = p.category AND g.investment_goal = 'Growth';

-- QUERY 178 — Can you tell me ?¢¬Ä¬î for investor inv001, list all holdings that match their stated preferred investment category and 
-- query_id=200178 | userid=74 | start=2026-01-29 14:41:40 | end=2026-01-29 14:41:41 | dur=1353ms | rows=193
SELECT h.investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON h.investor_id = g.investor_id WHERE h.investor_id = 'INV-001' AND h.category = p.category AND g.investment_goal = 'Growth';

-- QUERY 179 — Across the portfolio database, for investor inv001, list all holdings that match their stated preferred investment categ
-- query_id=200179 | userid=23 | start=2026-01-29 14:43:09 | end=2026-01-29 14:43:10 | dur=1697ms | rows=444
SELECT h.investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON h.investor_id = g.investor_id WHERE h.investor_id = 'INV-001' AND h.category = p.category AND g.investment_goal = 'Growth';

-- QUERY 180 — From the complete wealth management dataset, for investor inv001, list all holdings that match their stated preferred in
-- query_id=200180 | userid=12 | start=2026-01-29 15:39:08 | end=2026-01-29 15:39:08 | dur=932ms | rows=481
SELECT h.investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON h.investor_id = g.investor_id WHERE h.investor_id = 'INV-001' AND h.category = p.category AND g.investment_goal = 'Growth';

-- QUERY 181 — Calculate the average liquidity rating for investors whose total withdrawal transactions exceed 50,000.
-- query_id=200181 | userid=12 | start=2026-01-29 15:43:56 | end=2026-01-29 15:43:57 | dur=1243ms | rows=12
SELECT AVG(h.liquidity_score) FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h WHERE h.investor_id IN (SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Withdrawal' GROUP BY investor_id HAVING SUM(ABS(amount)) > 50000);

-- QUERY 182 — Calculate the average liquidity rating for investors whose total withdrawal transactions exceed 50,000.
-- query_id=200182 | userid=42 | start=2026-01-29 16:17:04 | end=2026-01-29 16:17:05 | dur=1956ms | rows=30
SELECT AVG(h.liquidity_score) FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h WHERE h.investor_id IN (SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Withdrawal' GROUP BY investor_id HAVING SUM(ABS(amount)) > 50000);

-- QUERY 183 — Can you calculate the average liquidity rating for investors whose total withdrawal transactions exceed 50,000.
-- query_id=200183 | userid=12 | start=2026-01-29 18:10:01 | end=2026-01-29 18:10:02 | dur=1204ms | rows=26
SELECT AVG(h.liquidity_score) FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h WHERE h.investor_id IN (SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Withdrawal' GROUP BY investor_id HAVING SUM(ABS(amount)) > 50000);

-- QUERY 184 — What is the calculated value of the average liquidity rating for investors whose total withdrawal transactions exceed 50
-- query_id=200184 | userid=42 | start=2026-01-29 19:17:08 | end=2026-01-29 19:17:08 | dur=850ms | rows=11
SELECT AVG(h.liquidity_score) FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h WHERE h.investor_id IN (SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Withdrawal' GROUP BY investor_id HAVING SUM(ABS(amount)) > 50000);

-- QUERY 185 — Based on portfolio data, calculate the average liquidity rating for investors whose total withdrawal transactions exceed
-- query_id=200185 | userid=95 | start=2026-01-30 07:03:48 | end=2026-01-30 07:03:49 | dur=1213ms | rows=26
SELECT AVG(h.liquidity_score) FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h WHERE h.investor_id IN (SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Withdrawal' GROUP BY investor_id HAVING SUM(ABS(amount)) > 50000);

-- QUERY 186 — Compare the proposed new allocation percentage from the 'Sector Rotation' scenario to the target allocation percentage i
-- query_id=200186 | userid=30 | start=2026-01-30 07:30:44 | end=2026-01-30 07:30:45 | dur=1089ms | rows=482
SELECT s.investor_id, s.new_allocation_pct, r.target_allocation_pct FROM ATOM_EVENT_SCENARIO_REBALANCING_001 s JOIN ATOM_EVENT_REBALANCING_ACTION_001 r ON s.investor_id = r.investor_id WHERE s.scenario = 'Sector Rotation';

-- QUERY 187 — Compare the proposed new allocation percentage from the 'Sector Rotation' scenario to the target allocation percentage i
-- query_id=200187 | userid=68 | start=2026-01-30 11:05:56 | end=2026-01-30 11:05:56 | dur=881ms | rows=439
SELECT s.investor_id, s.new_allocation_pct, r.target_allocation_pct FROM ATOM_EVENT_SCENARIO_REBALANCING_001 s JOIN ATOM_EVENT_REBALANCING_ACTION_001 r ON s.investor_id = r.investor_id WHERE s.scenario = 'Sector Rotation';

-- QUERY 188 — Can you tell me ?¢¬Ä¬î compare the proposed new allocation percentage from the 'sector rotation' scenario to the target 
-- query_id=200188 | userid=42 | start=2026-01-30 12:51:43 | end=2026-01-30 12:51:43 | dur=716ms | rows=77
SELECT s.investor_id, s.new_allocation_pct, r.target_allocation_pct FROM ATOM_EVENT_SCENARIO_REBALANCING_001 s JOIN ATOM_EVENT_REBALANCING_ACTION_001 r ON s.investor_id = r.investor_id WHERE s.scenario = 'Sector Rotation';

-- QUERY 189 — Across the portfolio database, compare the proposed new allocation percentage from the 'sector rotation' scenario to the
-- query_id=200189 | userid=42 | start=2026-01-30 14:09:11 | end=2026-01-30 14:09:11 | dur=641ms | rows=387
SELECT s.investor_id, s.new_allocation_pct, r.target_allocation_pct FROM ATOM_EVENT_SCENARIO_REBALANCING_001 s JOIN ATOM_EVENT_REBALANCING_ACTION_001 r ON s.investor_id = r.investor_id WHERE s.scenario = 'Sector Rotation';

-- QUERY 190 — From the complete wealth management dataset, compare the proposed new allocation percentage from the 'sector rotation' s
-- query_id=200190 | userid=18 | start=2026-01-30 15:20:56 | end=2026-01-30 15:20:56 | dur=779ms | rows=308
SELECT s.investor_id, s.new_allocation_pct, r.target_allocation_pct FROM ATOM_EVENT_SCENARIO_REBALANCING_001 s JOIN ATOM_EVENT_REBALANCING_ACTION_001 r ON s.investor_id = r.investor_id WHERE s.scenario = 'Sector Rotation';

-- QUERY 191 — List the investor names and their stated risk profiles for those with fewer than 12 months remaining to reach any active
-- query_id=200191 | userid=95 | start=2026-01-30 16:07:26 | end=2026-01-30 16:07:26 | dur=832ms | rows=415
SELECT DISTINCT p.investor_name, p.risk_tolerance FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON p.investor_id = g.investor_id WHERE g.time_to_goal_months < 12;

-- QUERY 192 — Enumerate all investor names and their stated risk profiles for those with fewer than 12 months remaining to reach any a
-- query_id=200192 | userid=68 | start=2026-01-30 16:16:57 | end=2026-01-30 16:16:58 | dur=1483ms | rows=43
SELECT DISTINCT p.investor_name, p.risk_tolerance FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON p.investor_id = g.investor_id WHERE g.time_to_goal_months < 12;

-- QUERY 193 — Can you list all investor names and their stated risk profiles for those with fewer than 12 months remaining to reach an
-- query_id=200193 | userid=30 | start=2026-01-30 16:17:31 | end=2026-01-30 16:17:32 | dur=1119ms | rows=213
SELECT DISTINCT p.investor_name, p.risk_tolerance FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON p.investor_id = g.investor_id WHERE g.time_to_goal_months < 12;

-- QUERY 194 — What are all the investor names and their stated risk profiles for those with fewer than 12 months remaining to reach an
-- query_id=200194 | userid=18 | start=2026-01-30 16:25:29 | end=2026-01-30 16:25:30 | dur=1196ms | rows=242
SELECT DISTINCT p.investor_name, p.risk_tolerance FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON p.investor_id = g.investor_id WHERE g.time_to_goal_months < 12;

-- QUERY 195 — Provide a complete list of all the investor names and their stated risk profiles for those with fewer than 12 months rem
-- query_id=200195 | userid=42 | start=2026-01-30 16:59:25 | end=2026-01-30 16:59:26 | dur=1120ms | rows=432
SELECT DISTINCT p.investor_name, p.risk_tolerance FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON p.investor_id = g.investor_id WHERE g.time_to_goal_months < 12;

-- QUERY 196 — Find the total current market value of holdings in the 'Large Cap' segment for investors whose primary objective is 'Wea
-- query_id=200196 | userid=55 | start=2026-01-30 19:04:25 | end=2026-01-30 19:04:25 | dur=706ms | rows=1
SELECT SUM(h.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE h.segment = 'Large Cap' AND p.investment_goal = 'Wealth Preservation';

-- QUERY 197 — Find the total current market value of holdings in the 'Large Cap' segment for investors whose primary objective is 'Wea
-- query_id=200197 | userid=12 | start=2026-02-02 07:03:57 | end=2026-02-02 07:03:58 | dur=1228ms | rows=1
SELECT SUM(h.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE h.segment = 'Large Cap' AND p.investment_goal = 'Wealth Preservation';

-- QUERY 198 — Can you find the total current market value of holdings in the 'Large Cap' segment for investors whose primary objective
-- query_id=200198 | userid=81 | start=2026-02-02 07:18:57 | end=2026-02-02 07:18:57 | dur=628ms | rows=1
SELECT SUM(h.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE h.segment = 'Large Cap' AND p.investment_goal = 'Wealth Preservation';

-- QUERY 199 — What can be found for the total current market value of holdings in the 'Large Cap' segment for investors whose primary 
-- query_id=200199 | userid=12 | start=2026-02-02 08:37:15 | end=2026-02-02 08:37:15 | dur=885ms | rows=1
SELECT SUM(h.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE h.segment = 'Large Cap' AND p.investment_goal = 'Wealth Preservation';

-- QUERY 200 — Search through all records to find the total current market value of holdings in the 'Large Cap' segment for investors w
-- query_id=200200 | userid=18 | start=2026-02-02 13:57:14 | end=2026-02-02 13:57:14 | dur=775ms | rows=1
SELECT SUM(h.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE h.segment = 'Large Cap' AND p.investment_goal = 'Wealth Preservation';

-- QUERY 201 — How many investors with an 'Aggressive' risk profile currently have a 'Healthy' portfolio condition
-- query_id=200201 | userid=18 | start=2026-02-02 15:33:18 | end=2026-02-02 15:33:19 | dur=1286ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Aggressive' AND (h.goal_match_pct * 0.3 + h.risk_score * 0.3 + h.liquidity_score * 0.2 + h.diversification_score * 0.2) >= 80;

-- QUERY 202 — Provide the count of investors with an 'Aggressive' risk profile currently have a 'Healthy' portfolio condition
-- query_id=200202 | userid=12 | start=2026-02-03 08:59:13 | end=2026-02-03 08:59:14 | dur=1239ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Aggressive' AND (h.goal_match_pct * 0.3 + h.risk_score * 0.3 + h.liquidity_score * 0.2 + h.diversification_score * 0.2) >= 80;

-- QUERY 203 — I need to find out how many investors with an 'Aggressive' risk profile currently have a 'Healthy' portfolio condition
-- query_id=200203 | userid=12 | start=2026-02-03 12:10:58 | end=2026-02-03 12:10:59 | dur=1088ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Aggressive' AND (h.goal_match_pct * 0.3 + h.risk_score * 0.3 + h.liquidity_score * 0.2 + h.diversification_score * 0.2) >= 80;

-- QUERY 204 — What is the total count of investors with an 'Aggressive' risk profile currently have a 'Healthy' portfolio condition
-- query_id=200204 | userid=23 | start=2026-02-03 16:33:50 | end=2026-02-03 16:33:51 | dur=1096ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Aggressive' AND (h.goal_match_pct * 0.3 + h.risk_score * 0.3 + h.liquidity_score * 0.2 + h.diversification_score * 0.2) >= 80;

-- QUERY 205 — Across the entire investor database, how many investors with an 'Aggressive' risk profile currently have a 'Healthy' por
-- query_id=200205 | userid=68 | start=2026-02-03 18:01:47 | end=2026-02-03 18:01:48 | dur=1417ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Aggressive' AND (h.goal_match_pct * 0.3 + h.risk_score * 0.3 + h.liquidity_score * 0.2 + h.diversification_score * 0.2) >= 80;

-- QUERY 206 — Which investment type has the highest total current value in the portfolio
-- query_id=200206 | userid=81 | start=2026-02-03 19:01:34 | end=2026-02-03 19:01:35 | dur=1070ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY SUM(current_value) DESC LIMIT 1;

-- QUERY 207 — Identify the investment type has the highest total current value in the portfolio
-- query_id=200207 | userid=55 | start=2026-02-04 09:07:25 | end=2026-02-04 09:07:26 | dur=1002ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY SUM(current_value) DESC LIMIT 1;

-- QUERY 208 — Do you know which investment type has the highest total current value in the portfolio
-- query_id=200208 | userid=12 | start=2026-02-04 09:33:38 | end=2026-02-04 09:33:38 | dur=964ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY SUM(current_value) DESC LIMIT 1;

-- QUERY 209 — Out of all options, which investment type has the highest total current value in the portfolio
-- query_id=200209 | userid=74 | start=2026-02-04 16:11:10 | end=2026-02-04 16:11:11 | dur=1042ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY SUM(current_value) DESC LIMIT 1;

-- QUERY 210 — Given all the data available, which investment type has the highest total current value in the portfolio
-- query_id=200210 | userid=81 | start=2026-02-04 16:34:41 | end=2026-02-04 16:34:42 | dur=1410ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY SUM(current_value) DESC LIMIT 1;

-- QUERY 211 — How many holdings of each investment type does investor INV-005 hold
-- query_id=200211 | userid=55 | start=2026-02-04 19:52:52 | end=2026-02-04 19:52:53 | dur=1010ms | rows=2
SELECT investment_type, COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-005' GROUP BY investment_type;

-- QUERY 212 — Provide the count of holdings of each investment type does investor INV-005 hold
-- query_id=200212 | userid=55 | start=2026-02-05 07:26:06 | end=2026-02-05 07:26:06 | dur=743ms | rows=19
SELECT investment_type, COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-005' GROUP BY investment_type;

-- QUERY 213 — I need to find out how many holdings of each investment type does investor INV-005 hold
-- query_id=200213 | userid=42 | start=2026-02-05 09:28:37 | end=2026-02-05 09:28:37 | dur=713ms | rows=2
SELECT investment_type, COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-005' GROUP BY investment_type;

-- QUERY 214 — What is the total count of holdings of each investment type does investor INV-005 hold
-- query_id=200214 | userid=55 | start=2026-02-05 15:06:58 | end=2026-02-05 15:06:59 | dur=1493ms | rows=7
SELECT investment_type, COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-005' GROUP BY investment_type;

-- QUERY 215 — Across the entire investor database, how many holdings of each investment type does investor INV-005 hold
-- query_id=200215 | userid=55 | start=2026-02-05 19:11:49 | end=2026-02-05 19:11:49 | dur=888ms | rows=13
SELECT investment_type, COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-005' GROUP BY investment_type;

-- QUERY 216 — What is the total cost vs total current value for Mutual Fund holdings across all investors
-- query_id=200216 | userid=18 | start=2026-02-06 08:56:45 | end=2026-02-06 08:56:45 | dur=618ms | rows=1
SELECT SUM(cost), SUM(current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_type = 'Mutual Fund';

-- QUERY 217 — Please provide the total cost vs total current value for Mutual Fund holdings across all investors
-- query_id=200217 | userid=55 | start=2026-02-06 10:11:52 | end=2026-02-06 10:11:52 | dur=708ms | rows=1
SELECT SUM(cost), SUM(current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_type = 'Mutual Fund';

-- QUERY 218 — Can you tell me what the total cost vs total current value for Mutual Fund holdings across all investors
-- query_id=200218 | userid=23 | start=2026-02-06 13:15:34 | end=2026-02-06 13:15:34 | dur=700ms | rows=1
SELECT SUM(cost), SUM(current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_type = 'Mutual Fund';

-- QUERY 219 — What would be the total cost vs total current value for Mutual Fund holdings across all investors
-- query_id=200219 | userid=95 | start=2026-02-06 15:11:01 | end=2026-02-06 15:11:01 | dur=786ms | rows=1
SELECT SUM(cost), SUM(current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_type = 'Mutual Fund';

-- QUERY 220 — Looking at all available records, what is the total cost vs total current value for Mutual Fund holdings across all inve
-- query_id=200220 | userid=95 | start=2026-02-09 12:39:00 | end=2026-02-09 12:39:00 | dur=632ms | rows=1
SELECT SUM(cost), SUM(current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_type = 'Mutual Fund';

-- QUERY 221 — Which investors hold Private Equity investments
-- query_id=200221 | userid=55 | start=2026-02-09 12:49:56 | end=2026-02-09 12:49:57 | dur=1616ms | rows=126
SELECT DISTINCT p.investor_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE h.sector = 'Private Equity';

-- QUERY 222 — Identify the investor whos hold Private Equity investments
-- query_id=200222 | userid=55 | start=2026-02-09 15:55:00 | end=2026-02-09 15:55:01 | dur=1018ms | rows=10
SELECT DISTINCT p.investor_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE h.investment_type = 'Private Equity';

-- QUERY 223 — I want to know which investors hold Private Equity investments
-- query_id=200223 | userid=42 | start=2026-02-09 16:40:50 | end=2026-02-09 16:40:50 | dur=889ms | rows=202
SELECT DISTINCT p.investor_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE h.investment_type = 'Private Equity';

-- QUERY 224 — Among all investors, which ones hold Private Equity investments
-- query_id=200224 | userid=74 | start=2026-02-10 08:21:42 | end=2026-02-10 08:21:43 | dur=1207ms | rows=456
SELECT DISTINCT p.investor_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE h.investment_type = 'Private Equity';

-- QUERY 225 — Considering all investors in the system, which investors hold Private Equity investments
-- query_id=200225 | userid=68 | start=2026-02-10 16:22:24 | end=2026-02-10 16:22:25 | dur=1266ms | rows=356
SELECT DISTINCT p.investor_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE h.investment_type = 'Private Equity';

-- QUERY 226 — What is the total number of ETF holdings and their combined current value
-- query_id=200226 | userid=30 | start=2026-02-10 19:01:39 | end=2026-02-10 19:01:39 | dur=392ms | rows=1
SELECT COUNT(*), SUM(current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_type = 'ETF';

-- QUERY 227 — Please provide the total number of ETF holdings and their combined current value
-- query_id=200227 | userid=12 | start=2026-02-10 19:31:20 | end=2026-02-10 19:31:20 | dur=570ms | rows=1
SELECT COUNT(*), SUM(current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_type = 'ETF';

-- QUERY 228 — Can you tell me what the total number of ETF holdings and their combined current value
-- query_id=200228 | userid=18 | start=2026-02-11 07:26:04 | end=2026-02-11 07:26:04 | dur=678ms | rows=1
SELECT COUNT(*), SUM(current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_type = 'ETF';

-- QUERY 229 — What would be the total number of ETF holdings and their combined current value
-- query_id=200229 | userid=12 | start=2026-02-11 09:22:15 | end=2026-02-11 09:22:15 | dur=664ms | rows=1
SELECT COUNT(*), SUM(current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_type = 'ETF';

-- QUERY 230 — Looking at all available records, what is the total number of ETF holdings and their combined current value
-- query_id=200230 | userid=30 | start=2026-02-11 11:55:14 | end=2026-02-11 11:55:14 | dur=618ms | rows=1
SELECT COUNT(*), SUM(current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_type = 'ETF';

-- QUERY 231 — Show the breakdown of investment types held by investor INV-010
-- query_id=200231 | userid=42 | start=2026-02-11 12:08:04 | end=2026-02-11 12:08:04 | dur=598ms | rows=93
SELECT investment_type, current_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-010';

-- QUERY 232 — Display the breakdown of investment types held by investor INV-010
-- query_id=200232 | userid=12 | start=2026-02-11 13:05:33 | end=2026-02-11 13:05:33 | dur=549ms | rows=25
SELECT investment_type, current_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-010';

-- QUERY 233 — Could you show me the breakdown of investment types held by investor INV-010
-- query_id=200233 | userid=12 | start=2026-02-11 14:12:36 | end=2026-02-11 14:12:36 | dur=443ms | rows=126
SELECT investment_type, current_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-010';

-- QUERY 234 — What does the system show for the breakdown of investment types held by investor INV-010
-- query_id=200234 | userid=42 | start=2026-02-11 14:24:57 | end=2026-02-11 14:24:57 | dur=506ms | rows=95
SELECT investment_type, current_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-010';

-- QUERY 235 — Please display the breakdown of investment types held by investor INV-010
-- query_id=200235 | userid=23 | start=2026-02-11 15:58:14 | end=2026-02-11 15:58:14 | dur=666ms | rows=39
SELECT investment_type, current_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-010';

-- QUERY 236 — Which investment type generates the most dividends on average
-- query_id=200236 | userid=18 | start=2026-02-11 18:04:48 | end=2026-02-11 18:04:48 | dur=829ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(dividends) DESC LIMIT 1;

-- QUERY 237 — Identify the investment type generates the most dividends on average
-- query_id=200237 | userid=95 | start=2026-02-11 18:35:30 | end=2026-02-11 18:35:31 | dur=1239ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(dividends) DESC LIMIT 1;

-- QUERY 238 — Do you know which investment type generates the most dividends on average
-- query_id=200238 | userid=74 | start=2026-02-11 19:26:05 | end=2026-02-11 19:26:05 | dur=998ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(dividends) DESC LIMIT 1;

-- QUERY 239 — Out of all options, which investment type generates the most dividends on average
-- query_id=200239 | userid=12 | start=2026-02-12 07:47:18 | end=2026-02-12 07:47:19 | dur=1254ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(dividends) DESC LIMIT 1;

-- QUERY 240 — Given all the data available, which investment type generates the most dividends on average
-- query_id=200240 | userid=74 | start=2026-02-12 10:55:36 | end=2026-02-12 10:55:36 | dur=833ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(dividends) DESC LIMIT 1;

-- QUERY 241 — List all investors who hold Gold investments and their total gold value.
-- query_id=200241 | userid=12 | start=2026-02-12 11:52:25 | end=2026-02-12 11:52:26 | dur=1124ms | rows=27
SELECT p.investor_name, SUM(h.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE h.investment_type = 'Gold' GROUP BY p.investor_name;

-- QUERY 242 — List all investors who hold Gold investments and their total gold value.
-- query_id=200242 | userid=18 | start=2026-02-12 12:38:06 | end=2026-02-12 12:38:07 | dur=1433ms | rows=18
SELECT p.investor_name, SUM(h.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE h.investment_type = 'Gold' GROUP BY p.investor_name;

-- QUERY 243 — Can you tell me ?¢¬Ä¬î list all investors who hold gold investments and their total gold value.
-- query_id=200243 | userid=74 | start=2026-02-12 14:06:31 | end=2026-02-12 14:06:32 | dur=1440ms | rows=6
SELECT p.investor_name, SUM(h.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE h.investment_type = 'Gold' GROUP BY p.investor_name;

-- QUERY 244 — Across the portfolio database, list all investors who hold gold investments and their total gold value.
-- query_id=200244 | userid=23 | start=2026-02-12 14:34:44 | end=2026-02-12 14:34:45 | dur=1390ms | rows=20
SELECT p.investor_name, SUM(h.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE h.investment_type = 'Gold' GROUP BY p.investor_name;

-- QUERY 245 — From the complete wealth management dataset, list all investors who hold gold investments and their total gold value.
-- query_id=200245 | userid=18 | start=2026-02-12 15:28:51 | end=2026-02-12 15:28:52 | dur=1409ms | rows=20
SELECT p.investor_name, SUM(h.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE h.investment_type = 'Gold' GROUP BY p.investor_name;

-- QUERY 246 — What is the average taxes paid per investment type
-- query_id=200246 | userid=95 | start=2026-02-12 18:17:14 | end=2026-02-12 18:17:15 | dur=1085ms | rows=21
SELECT investment_type, AVG(taxes_paid) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type;

-- QUERY 247 — Please provide the average taxes paid per investment type
-- query_id=200247 | userid=68 | start=2026-02-12 19:19:39 | end=2026-02-12 19:19:39 | dur=743ms | rows=30
SELECT investment_type, AVG(taxes_paid) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type;

-- QUERY 248 — Can you tell me what the average taxes paid per investment type
-- query_id=200248 | userid=55 | start=2026-02-12 19:41:25 | end=2026-02-12 19:41:25 | dur=495ms | rows=28
SELECT investment_type, AVG(taxes_paid) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type;

-- QUERY 249 — What would be the average taxes paid per investment type
-- query_id=200249 | userid=74 | start=2026-02-12 19:47:05 | end=2026-02-12 19:47:05 | dur=905ms | rows=26
SELECT investment_type, AVG(taxes_paid) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type;

-- QUERY 250 — Looking at all available records, what is the average taxes paid per investment type
-- query_id=200250 | userid=55 | start=2026-02-13 08:14:14 | end=2026-02-13 08:14:15 | dur=1006ms | rows=16
SELECT investment_type, AVG(taxes_paid) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type;

-- QUERY 251 — Which investor has received the highest total dividends from their holdings
-- query_id=200251 | userid=30 | start=2026-02-13 12:57:03 | end=2026-02-13 12:57:04 | dur=1857ms | rows=1
SELECT p.investor_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id GROUP BY p.investor_id ORDER BY SUM(h.dividends) DESC LIMIT 1;

-- QUERY 252 — Identify the investor who has received the highest total dividends from their holdings
-- query_id=200252 | userid=23 | start=2026-02-13 13:03:24 | end=2026-02-13 13:03:25 | dur=1047ms | rows=1
SELECT p.investor_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id GROUP BY p.investor_id ORDER BY SUM(h.dividends) DESC LIMIT 1;

-- QUERY 253 — I want to know which investor has received the highest total dividends from their holdings
-- query_id=200253 | userid=81 | start=2026-02-13 14:25:35 | end=2026-02-13 14:25:36 | dur=1596ms | rows=1
SELECT p.investor_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id GROUP BY p.investor_id ORDER BY SUM(h.dividends) DESC LIMIT 1;

-- QUERY 254 — Among all investors, who has received the highest total dividends from their holdings
-- query_id=200254 | userid=55 | start=2026-02-13 14:54:04 | end=2026-02-13 14:54:05 | dur=1753ms | rows=1
SELECT p.investor_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id GROUP BY p.investor_id ORDER BY SUM(h.dividends) DESC LIMIT 1;

-- QUERY 255 — Considering all investors in the system, which investor has received the highest total dividends from their holdings
-- query_id=200255 | userid=68 | start=2026-02-13 15:09:55 | end=2026-02-13 15:09:56 | dur=1168ms | rows=1
SELECT p.investor_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id GROUP BY p.investor_id ORDER BY SUM(h.dividends) DESC LIMIT 1;

-- QUERY 256 — Show total dividends earned per sector across all investors.
-- query_id=200256 | userid=74 | start=2026-02-13 15:10:51 | end=2026-02-13 15:10:51 | dur=931ms | rows=28
SELECT sector, SUM(dividends) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector;

-- QUERY 257 — Display total dividends earned per sector across all investors.
-- query_id=200257 | userid=18 | start=2026-02-13 15:41:16 | end=2026-02-13 15:41:16 | dur=974ms | rows=22
SELECT sector, SUM(dividends) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector;

-- QUERY 258 — Could you show me total dividends earned per sector across all investors.
-- query_id=200258 | userid=30 | start=2026-02-13 19:26:26 | end=2026-02-13 19:26:26 | dur=948ms | rows=29
SELECT sector, SUM(dividends) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector;

-- QUERY 259 — What does the system show for total dividends earned per sector across all investors.
-- query_id=200259 | userid=12 | start=2026-02-13 19:46:41 | end=2026-02-13 19:46:41 | dur=810ms | rows=11
SELECT sector, SUM(dividends) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector;

-- QUERY 260 — Please display total dividends earned per sector across all investors.
-- query_id=200260 | userid=42 | start=2026-02-16 07:12:31 | end=2026-02-16 07:12:32 | dur=1057ms | rows=16
SELECT sector, SUM(dividends) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector;

-- QUERY 261 — What is the total dividend income for investor INV-003 from all holdings
-- query_id=200261 | userid=42 | start=2026-02-16 07:42:00 | end=2026-02-16 07:42:01 | dur=1119ms | rows=1
SELECT SUM(dividends) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-003';

-- QUERY 262 — Please provide the total dividend income for investor INV-003 from all holdings
-- query_id=200262 | userid=55 | start=2026-02-16 08:21:25 | end=2026-02-16 08:21:25 | dur=743ms | rows=1
SELECT SUM(dividends) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-003';

-- QUERY 263 — Can you tell me what the total dividend income for investor INV-003 from all holdings
-- query_id=200263 | userid=18 | start=2026-02-16 08:54:52 | end=2026-02-16 08:54:52 | dur=620ms | rows=1
SELECT SUM(dividends) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-003';

-- QUERY 264 — What would be the total dividend income for investor INV-003 from all holdings
-- query_id=200264 | userid=42 | start=2026-02-16 10:36:21 | end=2026-02-16 10:36:21 | dur=645ms | rows=1
SELECT SUM(dividends) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-003';

-- QUERY 265 — Looking at all available records, what is the total dividend income for investor INV-003 from all holdings
-- query_id=200265 | userid=68 | start=2026-02-16 10:57:59 | end=2026-02-16 10:57:59 | dur=674ms | rows=1
SELECT SUM(dividends) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-003';

-- QUERY 266 — List the top 5 holdings by dividend amount across all investors.
-- query_id=200266 | userid=68 | start=2026-02-16 11:12:25 | end=2026-02-16 11:12:25 | dur=736ms | rows=5
SELECT investment_name, dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY dividends DESC LIMIT 5;

-- QUERY 267 — Enumerate all top 5 holdings by dividend amount across all investors.
-- query_id=200267 | userid=55 | start=2026-02-16 11:55:43 | end=2026-02-16 11:55:43 | dur=877ms | rows=5
SELECT investment_name, dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY dividends DESC LIMIT 5;

-- QUERY 268 — Can you list all top 5 holdings by dividend amount across all investors.
-- query_id=200268 | userid=23 | start=2026-02-16 13:51:09 | end=2026-02-16 13:51:09 | dur=983ms | rows=5
SELECT investment_name, dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY dividends DESC LIMIT 5;

-- QUERY 269 — What are all the top 5 holdings by dividend amount across all investors.
-- query_id=200269 | userid=74 | start=2026-02-16 15:59:26 | end=2026-02-16 15:59:26 | dur=910ms | rows=5
SELECT investment_name, dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY dividends DESC LIMIT 5;

-- QUERY 270 — Provide a complete list of all the top 5 holdings by dividend amount across all investors.
-- query_id=200270 | userid=55 | start=2026-02-16 17:06:38 | end=2026-02-16 17:06:38 | dur=685ms | rows=5
SELECT investment_name, dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY dividends DESC LIMIT 5;

-- QUERY 271 — Show all Dividend cash flow events in the last 6 months.
-- query_id=200271 | userid=55 | start=2026-02-16 18:20:53 | end=2026-02-16 18:20:53 | dur=852ms | rows=1
SELECT * FROM ATOM_EVENT_CASH_FLOW_001 WHERE type LIKE '%Dividend%' AND date > date((SELECT MAX(date) FROM ATOM_EVENT_CASH_FLOW_001), '-6
     months');

-- QUERY 272 — Display all Dividend cash flow events in the last 6 months.
-- query_id=200272 | userid=95 | start=2026-02-16 18:32:34 | end=2026-02-16 18:32:35 | dur=1082ms | rows=1
SELECT * FROM ATOM_EVENT_CASH_FLOW_001 WHERE type LIKE '%Dividend%' AND date > date((SELECT MAX(date) FROM ATOM_EVENT_CASH_FLOW_001), '-6
     months');

-- QUERY 273 — Could you show me all Dividend cash flow events in the last 6 months.
-- query_id=200273 | userid=18 | start=2026-02-16 19:43:41 | end=2026-02-16 19:43:41 | dur=906ms | rows=1
SELECT * FROM ATOM_EVENT_CASH_FLOW_001 WHERE type LIKE '%Dividend%' AND date > date((SELECT MAX(date) FROM ATOM_EVENT_CASH_FLOW_001), '-6
     months');

-- QUERY 274 — What are all Dividend cash flow events in the last 6 months.
-- query_id=200274 | userid=30 | start=2026-02-17 07:06:47 | end=2026-02-17 07:06:47 | dur=572ms | rows=1
SELECT * FROM ATOM_EVENT_CASH_FLOW_001 WHERE type LIKE '%Dividend%' AND date > date((SELECT MAX(date) FROM ATOM_EVENT_CASH_FLOW_001), '-6
     months');

-- QUERY 275 — Display all available information about Dividend cash flow events in the last 6 months.
-- query_id=200275 | userid=55 | start=2026-02-17 07:52:06 | end=2026-02-17 07:52:06 | dur=866ms | rows=1
SELECT * FROM ATOM_EVENT_CASH_FLOW_001 WHERE type LIKE '%Dividend%' AND date > date((SELECT MAX(date) FROM ATOM_EVENT_CASH_FLOW_001), '-6
     months');

-- QUERY 276 — Which investors have received dividend cash flows from HDFC Bank as source
-- query_id=200276 | userid=12 | start=2026-02-17 08:29:09 | end=2026-02-17 08:29:09 | dur=797ms | rows=396
SELECT DISTINCT p.investor_name FROM ATOM_EVENT_CASH_FLOW_001 c JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON c.investor_id = p.investor_id WHERE c.type = 'Dividend' AND c.source = 'HDFC Bank';

-- QUERY 277 — Identify the investor whos have received dividend cash flows from HDFC Bank as source
-- query_id=200277 | userid=23 | start=2026-02-17 09:02:59 | end=2026-02-17 09:03:00 | dur=1088ms | rows=249
SELECT DISTINCT p.investor_name FROM ATOM_EVENT_CASH_FLOW_001 c JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON c.investor_id = p.investor_id WHERE c.type = 'Dividend' AND c.source = 'HDFC Bank';

-- QUERY 278 — I want to know which investors have received dividend cash flows from HDFC Bank as source
-- query_id=200278 | userid=68 | start=2026-02-17 10:02:33 | end=2026-02-17 10:02:33 | dur=610ms | rows=461
SELECT DISTINCT p.investor_name FROM ATOM_EVENT_CASH_FLOW_001 c JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON c.investor_id = p.investor_id WHERE c.type = 'Dividend' AND c.source = 'HDFC Bank';

-- QUERY 279 — Among all investors, which ones have received dividend cash flows from HDFC Bank as source
-- query_id=200279 | userid=55 | start=2026-02-17 10:26:52 | end=2026-02-17 10:26:53 | dur=1273ms | rows=454
SELECT DISTINCT p.investor_name FROM ATOM_EVENT_CASH_FLOW_001 c JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON c.investor_id = p.investor_id WHERE c.type = 'Dividend' AND c.source = 'HDFC Bank';

-- QUERY 280 — Considering all investors in the system, which investors have received dividend cash flows from HDFC Bank as source
-- query_id=200280 | userid=55 | start=2026-02-17 12:54:05 | end=2026-02-17 12:54:05 | dur=727ms | rows=90
SELECT DISTINCT p.investor_name FROM ATOM_EVENT_CASH_FLOW_001 c JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON c.investor_id = p.investor_id WHERE c.type = 'Dividend' AND c.source = 'HDFC Bank';

-- QUERY 281 — What is the average dividend cash flow amount per investor
-- query_id=200281 | userid=18 | start=2026-02-17 13:02:56 | end=2026-02-17 13:02:57 | dur=1028ms | rows=15
SELECT investor_id,  AVG(amount) as total_div FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Dividend' GROUP BY investor_id;

-- QUERY 282 — Please provide the average dividend cash flow amount per investor
-- query_id=200282 | userid=23 | start=2026-02-17 13:16:43 | end=2026-02-17 13:16:43 | dur=896ms | rows=2
SELECT investor_id,  AVG(amount) as total_div FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Dividend' GROUP BY investor_id;

-- QUERY 283 — Can you tell me what the average dividend cash flow amount per investor
-- query_id=200283 | userid=30 | start=2026-02-17 16:05:25 | end=2026-02-17 16:05:25 | dur=685ms | rows=24
SELECT investor_id,  AVG(amount) as total_div FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Dividend' GROUP BY investor_id;

-- QUERY 284 — What would be the average dividend cash flow amount per investor
-- query_id=200284 | userid=12 | start=2026-02-17 19:26:48 | end=2026-02-17 19:26:48 | dur=962ms | rows=3
SELECT investor_id,  AVG(amount) as total_div FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Dividend' GROUP BY investor_id;

-- QUERY 285 — Looking at all available records, what is the average dividend cash flow amount per investor
-- query_id=200285 | userid=18 | start=2026-02-18 09:20:53 | end=2026-02-18 09:20:53 | dur=919ms | rows=17
SELECT investor_id,  AVG(amount) as total_div FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Dividend' GROUP BY investor_id;

-- QUERY 286 — Show the count and total amount of Dividend transactions per investor.
-- query_id=200286 | userid=23 | start=2026-02-18 10:53:34 | end=2026-02-18 10:53:34 | dur=924ms | rows=23
SELECT investor_id, COUNT(*), SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Dividend' GROUP BY investor_id;

-- QUERY 287 — Display the count and total amount of Dividend transactions per investor.
-- query_id=200287 | userid=18 | start=2026-02-18 11:16:28 | end=2026-02-18 11:16:29 | dur=1087ms | rows=25
SELECT investor_id, COUNT(*), SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Dividend' GROUP BY investor_id;

-- QUERY 288 — Could you show me the count and total amount of Dividend transactions per investor.
-- query_id=200288 | userid=95 | start=2026-02-18 12:10:56 | end=2026-02-18 12:10:56 | dur=736ms | rows=21
SELECT investor_id, COUNT(*), SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Dividend' GROUP BY investor_id;

-- QUERY 289 — What does the system show for the count and total amount of Dividend transactions per investor.
-- query_id=200289 | userid=30 | start=2026-02-18 13:05:57 | end=2026-02-18 13:05:58 | dur=1037ms | rows=19
SELECT investor_id, COUNT(*), SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Dividend' GROUP BY investor_id;

-- QUERY 290 — Please display the count and total amount of Dividend transactions per investor.
-- query_id=200290 | userid=74 | start=2026-02-18 13:32:31 | end=2026-02-18 13:32:32 | dur=1292ms | rows=2
SELECT investor_id, COUNT(*), SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Dividend' GROUP BY investor_id;

-- QUERY 291 — Which investors have zero dividend income from their holdings
-- query_id=200291 | userid=12 | start=2026-02-18 14:47:56 | end=2026-02-18 14:47:56 | dur=578ms | rows=200
SELECT investor_name FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE dividends > 0);

-- QUERY 292 — Identify the investor whos have zero dividend income from their holdings
-- query_id=200292 | userid=81 | start=2026-02-18 16:00:19 | end=2026-02-18 16:00:19 | dur=610ms | rows=60
SELECT investor_name FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE dividends > 0);

-- QUERY 293 — I want to know which investors have zero dividend income from their holdings
-- query_id=200293 | userid=74 | start=2026-02-18 16:07:59 | end=2026-02-18 16:08:00 | dur=1138ms | rows=93
SELECT investor_name FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE dividends > 0);

-- QUERY 294 — Among all investors, which ones have zero dividend income from their holdings
-- query_id=200294 | userid=55 | start=2026-02-18 18:18:35 | end=2026-02-18 18:18:35 | dur=490ms | rows=36
SELECT investor_name FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE dividends > 0);

-- QUERY 295 — Considering all investors in the system, which investors have zero dividend income from their holdings
-- query_id=200295 | userid=23 | start=2026-02-18 19:37:33 | end=2026-02-18 19:37:33 | dur=927ms | rows=47
SELECT investor_name FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE dividends > 0);

-- QUERY 296 — Which investor has paid the highest total taxes across all holdings
-- query_id=200296 | userid=18 | start=2026-02-18 19:40:28 | end=2026-02-18 19:40:29 | dur=1643ms | rows=1
SELECT p.investor_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id GROUP BY p.investor_id ORDER BY SUM(h.taxes_paid) DESC LIMIT 1;

-- QUERY 297 — Identify the investor who has paid the highest total taxes across all holdings
-- query_id=200297 | userid=74 | start=2026-02-19 07:37:12 | end=2026-02-19 07:37:14 | dur=2029ms | rows=1
SELECT p.investor_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id GROUP BY p.investor_id ORDER BY SUM(h.taxes_paid) DESC LIMIT 1;

-- QUERY 298 — I want to know which investor has paid the highest total taxes across all holdings
-- query_id=200298 | userid=23 | start=2026-02-19 11:05:34 | end=2026-02-19 11:05:35 | dur=1584ms | rows=1
SELECT p.investor_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id GROUP BY p.investor_id ORDER BY SUM(h.taxes_paid) DESC LIMIT 1;

-- QUERY 299 — Among all investors, who has paid the highest total taxes across all holdings
-- query_id=200299 | userid=74 | start=2026-02-19 11:52:21 | end=2026-02-19 11:52:22 | dur=1781ms | rows=1
SELECT p.investor_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id GROUP BY p.investor_id ORDER BY SUM(h.taxes_paid) DESC LIMIT 1;

-- QUERY 300 — Considering all investors in the system, which investor has paid the highest total taxes across all holdings
-- query_id=200300 | userid=23 | start=2026-02-19 13:54:31 | end=2026-02-19 13:54:32 | dur=1301ms | rows=1
SELECT p.investor_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id GROUP BY p.investor_id ORDER BY SUM(h.taxes_paid) DESC LIMIT 1;

-- QUERY 301 — What is the total taxes paid per sector for all investors combined
-- query_id=200301 | userid=18 | start=2026-02-19 14:48:25 | end=2026-02-19 14:48:25 | dur=726ms | rows=9
SELECT sector, SUM(taxes_paid) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector;

-- QUERY 302 — Please provide the total taxes paid per sector for all investors combined
-- query_id=200302 | userid=55 | start=2026-02-19 16:41:31 | end=2026-02-19 16:41:31 | dur=758ms | rows=23
SELECT sector, SUM(taxes_paid) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector;

-- QUERY 303 — Can you tell me what the total taxes paid per sector for all investors combined
-- query_id=200303 | userid=30 | start=2026-02-19 16:53:54 | end=2026-02-19 16:53:55 | dur=1033ms | rows=21
SELECT sector, SUM(taxes_paid) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector;

-- QUERY 304 — What would be the total taxes paid per sector for all investors combined
-- query_id=200304 | userid=12 | start=2026-02-19 18:10:55 | end=2026-02-19 18:10:55 | dur=509ms | rows=29
SELECT sector, SUM(taxes_paid) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector;

-- QUERY 305 — Looking at all available records, what is the total taxes paid per sector for all investors combined
-- query_id=200305 | userid=23 | start=2026-02-20 07:55:12 | end=2026-02-20 07:55:12 | dur=721ms | rows=22
SELECT sector, SUM(taxes_paid) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector;

-- QUERY 306 — List holdings where taxes paid exceeds 10% of the current value.
-- query_id=200306 | userid=68 | start=2026-02-20 12:24:58 | end=2026-02-20 12:24:58 | dur=633ms | rows=23
SELECT investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE taxes_paid > 0.1 * current_value;

-- QUERY 307 — List holdings where taxes paid exceeds 10% of the current value.
-- query_id=200307 | userid=74 | start=2026-02-20 13:02:17 | end=2026-02-20 13:02:17 | dur=571ms | rows=141
SELECT investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE taxes_paid > 0.1 * current_value;

-- QUERY 308 — Can you tell me ?¢¬Ä¬î list holdings where taxes paid exceeds 10% of the current value.
-- query_id=200308 | userid=12 | start=2026-02-20 15:15:22 | end=2026-02-20 15:15:22 | dur=856ms | rows=144
SELECT investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE taxes_paid > 0.1 * current_value;

-- QUERY 309 — Across the portfolio database, list holdings where taxes paid exceeds 10% of the current value.
-- query_id=200309 | userid=30 | start=2026-02-20 17:21:03 | end=2026-02-20 17:21:03 | dur=772ms | rows=85
SELECT investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE taxes_paid > 0.1 * current_value;

-- QUERY 310 — From the complete wealth management dataset, list holdings where taxes paid exceeds 10% of the current value.
-- query_id=200310 | userid=81 | start=2026-02-20 19:58:03 | end=2026-02-20 19:58:03 | dur=612ms | rows=116
SELECT investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE taxes_paid > 0.1 * current_value;

-- QUERY 311 — What is the total cost basis vs total current value for all Conservative investors
-- query_id=200311 | userid=18 | start=2026-02-23 07:10:16 | end=2026-02-23 07:10:17 | dur=1224ms | rows=1
SELECT SUM(h.cost), SUM(h.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Conservative';

-- QUERY 312 — Please provide the total cost basis vs total current value for all Conservative investors
-- query_id=200312 | userid=42 | start=2026-02-23 07:31:14 | end=2026-02-23 07:31:14 | dur=738ms | rows=1
SELECT SUM(h.cost), SUM(h.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Conservative';

-- QUERY 313 — Can you tell me what the total cost basis vs total current value for all Conservative investors
-- query_id=200313 | userid=74 | start=2026-02-23 07:43:00 | end=2026-02-23 07:43:00 | dur=944ms | rows=1
SELECT SUM(h.cost), SUM(h.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Conservative';

-- QUERY 314 — What would be the total cost basis vs total current value for all Conservative investors
-- query_id=200314 | userid=68 | start=2026-02-23 08:04:19 | end=2026-02-23 08:04:19 | dur=850ms | rows=1
SELECT SUM(h.cost), SUM(h.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Conservative';

-- QUERY 315 — Looking at all available records, what is the total cost basis vs total current value for all Conservative investors
-- query_id=200315 | userid=68 | start=2026-02-23 09:40:02 | end=2026-02-23 09:40:03 | dur=1123ms | rows=1
SELECT SUM(h.cost), SUM(h.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Conservative';

-- QUERY 316 — Show the average taxes paid per category of investment.
-- query_id=200316 | userid=95 | start=2026-02-23 09:43:46 | end=2026-02-23 09:43:47 | dur=1166ms | rows=25
SELECT category, AVG(taxes_paid) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category;

-- QUERY 317 — Display the average taxes paid per category of investment.
-- query_id=200317 | userid=12 | start=2026-02-23 13:42:02 | end=2026-02-23 13:42:03 | dur=1115ms | rows=20
SELECT category, AVG(taxes_paid) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category;

-- QUERY 318 — Could you show me the average taxes paid per category of investment.
-- query_id=200318 | userid=23 | start=2026-02-23 15:24:22 | end=2026-02-23 15:24:22 | dur=990ms | rows=30
SELECT category, AVG(taxes_paid) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category;

-- QUERY 319 — What does the system show for the average taxes paid per category of investment.
-- query_id=200319 | userid=68 | start=2026-02-23 15:30:17 | end=2026-02-23 15:30:17 | dur=824ms | rows=11
SELECT category, AVG(taxes_paid) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category;

-- QUERY 320 — Please display the average taxes paid per category of investment.
-- query_id=200320 | userid=74 | start=2026-02-23 16:34:53 | end=2026-02-23 16:34:54 | dur=1141ms | rows=28
SELECT category, AVG(taxes_paid) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category;

-- QUERY 321 — Which holding has the highest taxes paid for investor INV-007
-- query_id=200321 | userid=81 | start=2026-02-23 17:25:23 | end=2026-02-23 17:25:24 | dur=1091ms | rows=1
SELECT investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-007' ORDER BY taxes_paid DESC LIMIT 1;

-- QUERY 322 — Identify the holding has the highest taxes paid for investor INV-007
-- query_id=200322 | userid=42 | start=2026-02-24 07:18:10 | end=2026-02-24 07:18:10 | dur=947ms | rows=1
SELECT investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-007' ORDER BY taxes_paid DESC LIMIT 1;

-- QUERY 323 — Do you know which holding has the highest taxes paid for investor INV-007
-- query_id=200323 | userid=81 | start=2026-02-24 07:41:00 | end=2026-02-24 07:41:00 | dur=701ms | rows=1
SELECT investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-007' ORDER BY taxes_paid DESC LIMIT 1;

-- QUERY 324 — Out of all options, which holding has the highest taxes paid for investor INV-007
-- query_id=200324 | userid=68 | start=2026-02-24 17:04:45 | end=2026-02-24 17:04:45 | dur=918ms | rows=1
SELECT investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-007' ORDER BY taxes_paid DESC LIMIT 1;

-- QUERY 325 — Given all the data available, which holding has the highest taxes paid for investor INV-007
-- query_id=200325 | userid=12 | start=2026-02-24 17:09:05 | end=2026-02-24 17:09:05 | dur=888ms | rows=1
SELECT investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-007' ORDER BY taxes_paid DESC LIMIT 1;

-- QUERY 326 — List all investors with total taxes paid above 500000.
-- query_id=200326 | userid=23 | start=2026-02-25 07:51:37 | end=2026-02-25 07:51:38 | dur=1494ms | rows=27
SELECT p.investor_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id GROUP BY p.investor_id HAVING SUM(h.taxes_paid) > 500000;

-- QUERY 327 — List all investors with total taxes paid above 500000.
-- query_id=200327 | userid=42 | start=2026-02-25 08:08:15 | end=2026-02-25 08:08:16 | dur=1185ms | rows=19
SELECT p.investor_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id GROUP BY p.investor_id HAVING SUM(h.taxes_paid) > 500000;

-- QUERY 328 — Can you tell me ?¢¬Ä¬î list all investors with total taxes paid above 500000.
-- query_id=200328 | userid=30 | start=2026-02-25 08:29:23 | end=2026-02-25 08:29:24 | dur=1563ms | rows=27
SELECT p.investor_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id GROUP BY p.investor_id HAVING SUM(h.taxes_paid) > 500000;

-- QUERY 329 — Across the portfolio database, list all investors with total taxes paid above 500000.
-- query_id=200329 | userid=42 | start=2026-02-25 09:21:27 | end=2026-02-25 09:21:29 | dur=2625ms | rows=12
SELECT p.investor_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id GROUP BY p.investor_id HAVING SUM(h.taxes_paid) > 500000;

-- QUERY 330 — From the complete wealth management dataset, list all investors with total taxes paid above 500000.
-- query_id=200330 | userid=81 | start=2026-02-25 11:35:22 | end=2026-02-25 11:35:22 | dur=923ms | rows=22
SELECT p.investor_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id GROUP BY p.investor_id HAVING SUM(h.taxes_paid) > 500000;

-- QUERY 331 — What is the average cost basis per investment type across the entire database
-- query_id=200331 | userid=55 | start=2026-02-25 13:22:24 | end=2026-02-25 13:22:25 | dur=1155ms | rows=16
SELECT investment_type, AVG(cost) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type;

-- QUERY 332 — Please provide the average cost basis per investment type across the entire database
-- query_id=200332 | userid=23 | start=2026-02-25 13:45:41 | end=2026-02-25 13:45:42 | dur=1002ms | rows=14
SELECT investment_type, AVG(cost) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type;

-- QUERY 333 — Can you tell me what the average cost basis per investment type across the entire database
-- query_id=200333 | userid=12 | start=2026-02-25 16:57:17 | end=2026-02-25 16:57:17 | dur=867ms | rows=16
SELECT investment_type, AVG(cost) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type;

-- QUERY 334 — What would be the average cost basis per investment type across the entire database
-- query_id=200334 | userid=23 | start=2026-02-25 17:06:53 | end=2026-02-25 17:06:53 | dur=691ms | rows=22
SELECT investment_type, AVG(cost) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type;

-- QUERY 335 — Looking at all available records, what is the average cost basis per investment type across the entire database
-- query_id=200335 | userid=95 | start=2026-02-25 17:52:33 | end=2026-02-25 17:52:33 | dur=940ms | rows=12
SELECT investment_type, AVG(cost) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type;

-- QUERY 336 — Which holdings were purchased before 2022 and are still held by investors
-- query_id=200336 | userid=81 | start=2026-02-25 19:16:59 | end=2026-02-25 19:16:59 | dur=580ms | rows=107
SELECT investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date < '2022-01-01';

-- QUERY 337 — Identify the holdings were purchased before 2022 and are still held by investors
-- query_id=200337 | userid=81 | start=2026-02-26 13:22:00 | end=2026-02-26 13:22:00 | dur=658ms | rows=56
SELECT investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date < '2022-01-01';

-- QUERY 338 — Do you know which holdings were purchased before 2022 and are still held by investors
-- query_id=200338 | userid=95 | start=2026-02-26 13:25:33 | end=2026-02-26 13:25:33 | dur=713ms | rows=172
SELECT investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date < '2022-01-01';

-- QUERY 339 — Out of all options, which holdings were purchased before 2022 and are still held by investors
-- query_id=200339 | userid=55 | start=2026-02-26 16:10:24 | end=2026-02-26 16:10:24 | dur=551ms | rows=30
SELECT investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date < '2022-01-01';

-- QUERY 340 — Given all the data available, which holdings were purchased before 2022 and are still held by investors
-- query_id=200340 | userid=68 | start=2026-02-26 17:27:19 | end=2026-02-26 17:27:19 | dur=509ms | rows=96
SELECT investment_name FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date < '2022-01-01';

-- QUERY 341 — Show all holdings purchased in 2024 and their current returns.
-- query_id=200341 | userid=81 | start=2026-02-27 07:18:51 | end=2026-02-27 07:18:51 | dur=897ms | rows=25
SELECT investment_name, returns_pct FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date LIKE '2024%';

-- QUERY 342 — Display all holdings purchased in 2024 and their current returns.
-- query_id=200342 | userid=23 | start=2026-02-27 07:27:31 | end=2026-02-27 07:27:32 | dur=1020ms | rows=172
SELECT investment_name, returns_pct FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date LIKE '2024%';

-- QUERY 343 — Could you show me all holdings purchased in 2024 and their current returns.
-- query_id=200343 | userid=30 | start=2026-02-27 07:52:30 | end=2026-02-27 07:52:30 | dur=985ms | rows=190
SELECT investment_name, returns_pct FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date LIKE '2024%';

-- QUERY 344 — What are all holdings purchased in 2024 and their current returns.
-- query_id=200344 | userid=68 | start=2026-02-27 09:46:55 | end=2026-02-27 09:46:55 | dur=538ms | rows=184
SELECT investment_name, returns_pct FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date LIKE '2024%';

-- QUERY 345 — Display all available information about holdings purchased in 2024 and their current returns.
-- query_id=200345 | userid=55 | start=2026-02-27 09:51:11 | end=2026-02-27 09:51:11 | dur=550ms | rows=67
SELECT investment_name, returns_pct FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date LIKE '2024%';

-- QUERY 346 — What is the average holding duration (in days from purchase date to today) per investor
-- query_id=200346 | userid=68 | start=2026-02-27 10:29:27 | end=2026-02-27 10:29:27 | dur=898ms | rows=14
SELECT investor_id, AVG(julianday('2026-04-28') - julianday(purchase_date)) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id;

-- QUERY 347 — Please provide the average holding duration (in days from purchase date to today) per investor
-- query_id=200347 | userid=18 | start=2026-02-27 10:51:54 | end=2026-02-27 10:51:55 | dur=1051ms | rows=29
SELECT investor_id, AVG(julianday('2026-04-28') - julianday(purchase_date)) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id;

-- QUERY 348 — Can you tell me what the average holding duration (in days from purchase date to today) per investor
-- query_id=200348 | userid=18 | start=2026-02-27 12:36:30 | end=2026-02-27 12:36:30 | dur=795ms | rows=4
SELECT investor_id, AVG(julianday('2026-04-28') - julianday(purchase_date)) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id;

-- QUERY 349 — What would be the average holding duration (in days from purchase date to today) per investor
-- query_id=200349 | userid=42 | start=2026-02-27 14:45:31 | end=2026-02-27 14:45:32 | dur=1113ms | rows=25
SELECT investor_id, AVG(julianday('2026-04-28') - julianday(purchase_date)) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id;

-- QUERY 350 — Looking at all available records, what is the average holding duration (in days from purchase date to today) per investo
-- query_id=200350 | userid=68 | start=2026-02-27 17:45:57 | end=2026-02-27 17:45:58 | dur=1294ms | rows=23
SELECT investor_id, AVG(julianday('2026-04-28') - julianday(purchase_date)) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id;

-- QUERY 351 — List the 5 oldest holdings (by purchase date) across all investors.
-- query_id=200351 | userid=55 | start=2026-03-02 08:12:02 | end=2026-03-02 08:12:03 | dur=1196ms | rows=5
SELECT holding_id, investor_id, investment_name, purchase_date FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY purchase_date ASC LIMIT 5;

-- QUERY 352 — Enumerate all 5 oldest holdings (by purchase date) across all investors.
-- query_id=200352 | userid=68 | start=2026-03-02 09:32:47 | end=2026-03-02 09:32:47 | dur=881ms | rows=5
SELECT holding_id, investor_id, investment_name, purchase_date FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY purchase_date ASC LIMIT 5;

-- QUERY 353 — Can you list all 5 oldest holdings (by purchase date) across all investors.
-- query_id=200353 | userid=55 | start=2026-03-02 12:20:07 | end=2026-03-02 12:20:07 | dur=701ms | rows=5
SELECT holding_id, investor_id, investment_name, purchase_date FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY purchase_date ASC LIMIT 5;

-- QUERY 354 — What are all the 5 oldest holdings (by purchase date) across all investors.
-- query_id=200354 | userid=42 | start=2026-03-02 12:42:11 | end=2026-03-02 12:42:11 | dur=694ms | rows=5
SELECT holding_id, investor_id, investment_name, purchase_date FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY purchase_date ASC LIMIT 5;

-- QUERY 355 — Provide a complete list of all the 5 oldest holdings (by purchase date) across all investors.
-- query_id=200355 | userid=81 | start=2026-03-02 13:49:34 | end=2026-03-02 13:49:34 | dur=879ms | rows=5
SELECT holding_id, investor_id, investment_name, purchase_date FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY purchase_date ASC LIMIT 5;

-- QUERY 356 — Which investor bought the most holdings in 2023
-- query_id=200356 | userid=74 | start=2026-03-02 16:07:02 | end=2026-03-02 16:07:03 | dur=1362ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY investor_id ORDER BY COUNT(*) DESC LIMIT 1;

-- QUERY 357 — Identify the investor who bought the most holdings in 2023
-- query_id=200357 | userid=42 | start=2026-03-02 16:27:55 | end=2026-03-02 16:27:55 | dur=934ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY investor_id ORDER BY COUNT(*) DESC LIMIT 1;

-- QUERY 358 — I want to know which investor bought the most holdings in 2023
-- query_id=200358 | userid=95 | start=2026-03-02 16:34:51 | end=2026-03-02 16:34:52 | dur=1084ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY investor_id ORDER BY COUNT(*) DESC LIMIT 1;

-- QUERY 359 — Among all investors, which one bought the most holdings in 2023
-- query_id=200359 | userid=23 | start=2026-03-02 18:58:05 | end=2026-03-02 18:58:05 | dur=882ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY investor_id ORDER BY COUNT(*) DESC LIMIT 1;

-- QUERY 360 — Considering all investors in the system, which investor bought the most holdings in 2023
-- query_id=200360 | userid=55 | start=2026-03-03 09:18:50 | end=2026-03-03 09:18:51 | dur=1165ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY investor_id ORDER BY COUNT(*) DESC LIMIT 1;

-- QUERY 361 — Show holdings purchased in the last 12 months with negative returns.
-- query_id=200361 | userid=81 | start=2026-03-03 09:29:33 | end=2026-03-03 09:29:33 | dur=454ms | rows=188
SELECT * FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date >= date('2026-04-28', '-12 months') AND returns_pct < 0;

-- QUERY 362 — Display holdings purchased in the last 12 months with negative returns.
-- query_id=200362 | userid=18 | start=2026-03-03 10:23:25 | end=2026-03-03 10:23:25 | dur=751ms | rows=8
SELECT * FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date >= date('2026-04-28', '-12 months') AND returns_pct < 0;

-- QUERY 363 — Could you show me holdings purchased in the last 12 months with negative returns.
-- query_id=200363 | userid=95 | start=2026-03-03 11:44:52 | end=2026-03-03 11:44:52 | dur=700ms | rows=139
SELECT * FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date >= date('2026-04-28', '-12 months') AND returns_pct < 0;

-- QUERY 364 — What does the system show for holdings purchased in the last 12 months with negative returns.
-- query_id=200364 | userid=74 | start=2026-03-03 14:42:56 | end=2026-03-03 14:42:57 | dur=1029ms | rows=151
SELECT * FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date >= date('2026-04-28', '-12 months') AND returns_pct < 0;

-- QUERY 365 — Please display holdings purchased in the last 12 months with negative returns.
-- query_id=200365 | userid=42 | start=2026-03-03 18:48:32 | end=2026-03-03 18:48:32 | dur=361ms | rows=158
SELECT * FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date >= date('2026-04-28', '-12 months') AND returns_pct < 0;

-- QUERY 366 — What is the total investment (cost) made in 2022 vs 2023 vs 2024
-- query_id=200366 | userid=23 | start=2026-03-04 08:14:23 | end=2026-03-04 08:14:24 | dur=1169ms | rows=20
SELECT CAST(substr(purchase_date, 1, 4) AS INTEGER) as purchase_year, SUM(cost) as total_investment_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE CAST(substr(purchase_date, 1, 4) AS INTEGER) IN (2022, 2023, 2024) GROUP BY purchase_year ORDER BY purchase_year ASC;

-- QUERY 367 — Please provide the total investment (cost) made in 2022 vs 2023 vs 2024
-- query_id=200367 | userid=23 | start=2026-03-04 08:57:13 | end=2026-03-04 08:57:14 | dur=1278ms | rows=10
SELECT CAST(substr(purchase_date, 1, 4) AS INTEGER) as purchase_year, SUM(cost) as total_investment_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE CAST(substr(purchase_date, 1, 4) AS INTEGER) IN (2022, 2023, 2024) GROUP BY purchase_year ORDER BY purchase_year ASC;

-- QUERY 368 — Can you tell me what the total investment (cost) made in 2022 vs 2023 vs 2024
-- query_id=200368 | userid=55 | start=2026-03-04 10:25:23 | end=2026-03-04 10:25:23 | dur=771ms | rows=17
SELECT CAST(substr(purchase_date, 1, 4) AS INTEGER) as purchase_year, SUM(cost) as total_investment_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE CAST(substr(purchase_date, 1, 4) AS INTEGER) IN (2022, 2023, 2024) GROUP BY purchase_year ORDER BY purchase_year ASC;

-- QUERY 369 — What would be the total investment (cost) made in 2022 vs 2023 vs 2024
-- query_id=200369 | userid=74 | start=2026-03-04 11:35:28 | end=2026-03-04 11:35:29 | dur=1604ms | rows=10
SELECT CAST(substr(purchase_date, 1, 4) AS INTEGER) as purchase_year, SUM(cost) as total_investment_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE CAST(substr(purchase_date, 1, 4) AS INTEGER) IN (2022, 2023, 2024) GROUP BY purchase_year ORDER BY purchase_year ASC;

-- QUERY 370 — Looking at all available records, what is the total investment (cost) made in 2022 vs 2023 vs 2024
-- query_id=200370 | userid=42 | start=2026-03-04 13:08:59 | end=2026-03-04 13:08:59 | dur=971ms | rows=20
SELECT CAST(substr(purchase_date, 1, 4) AS INTEGER) as purchase_year, SUM(cost) as total_investment_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE CAST(substr(purchase_date, 1, 4) AS INTEGER) IN (2022, 2023, 2024) GROUP BY purchase_year ORDER BY purchase_year ASC;

-- QUERY 371 — Show the number of holdings purchased per year per investor.
-- query_id=200371 | userid=18 | start=2026-03-04 13:47:24 | end=2026-03-04 13:47:24 | dur=982ms | rows=13
SELECT investor_id, CAST(substr(purchase_date, 1, 4) AS INTEGER) as purchase_year, COUNT(*) as holding_count FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id, purchase_year ORDER BY investor_id, purchase_year;

-- QUERY 372 — Display the number of holdings purchased per year per investor.
-- query_id=200372 | userid=74 | start=2026-03-04 14:02:53 | end=2026-03-04 14:02:54 | dur=1334ms | rows=16
SELECT investor_id, CAST(substr(purchase_date, 1, 4) AS INTEGER) as purchase_year, COUNT(*) as holding_count FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id, purchase_year ORDER BY investor_id, purchase_year;

-- QUERY 373 — Could you show me the number of holdings purchased per year per investor.
-- query_id=200373 | userid=23 | start=2026-03-04 14:07:38 | end=2026-03-04 14:07:38 | dur=965ms | rows=24
SELECT investor_id, CAST(substr(purchase_date, 1, 4) AS INTEGER) as purchase_year, COUNT(*) as holding_count FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id, purchase_year ORDER BY investor_id, purchase_year;

-- QUERY 374 — What does the system show for the number of holdings purchased per year per investor.
-- query_id=200374 | userid=18 | start=2026-03-04 18:15:34 | end=2026-03-04 18:15:35 | dur=1389ms | rows=23
SELECT investor_id, CAST(substr(purchase_date, 1, 4) AS INTEGER) as purchase_year, COUNT(*) as holding_count FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id, purchase_year ORDER BY investor_id, purchase_year;

-- QUERY 375 — Please display the number of holdings purchased per year per investor.
-- query_id=200375 | userid=74 | start=2026-03-04 18:33:54 | end=2026-03-04 18:33:54 | dur=952ms | rows=20
SELECT investor_id, CAST(substr(purchase_date, 1, 4) AS INTEGER) as purchase_year, COUNT(*) as holding_count FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id, purchase_year ORDER BY investor_id, purchase_year;

-- QUERY 376 — Which investors have not purchased any new holdings in the last 12 months
-- query_id=200376 | userid=23 | start=2026-03-05 08:07:21 | end=2026-03-05 08:07:21 | dur=543ms | rows=15
SELECT investor_id, investor_name FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date >= date('2026-04-28', '-12 months'));

-- QUERY 377 — Identify the investor whos have not purchased any new holdings in the last 12 months
-- query_id=200377 | userid=23 | start=2026-03-05 10:37:17 | end=2026-03-05 10:37:17 | dur=858ms | rows=170
SELECT investor_id, investor_name FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date >= date('2026-04-28', '-12 months'));

-- QUERY 378 — I want to know which investors have not purchased any new holdings in the last 12 months
-- query_id=200378 | userid=42 | start=2026-03-05 11:12:42 | end=2026-03-05 11:12:43 | dur=1034ms | rows=44
SELECT investor_id, investor_name FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date >= date('2026-04-28', '-12 months'));

-- QUERY 379 — Among all investors, which ones have not purchased any new holdings in the last 12 months
-- query_id=200379 | userid=30 | start=2026-03-05 13:34:26 | end=2026-03-05 13:34:27 | dur=1114ms | rows=68
SELECT investor_id, investor_name FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date >= date('2026-04-28', '-12 months'));

-- QUERY 380 — Considering all investors in the system, which investors have not purchased any new holdings in the last 12 months
-- query_id=200380 | userid=23 | start=2026-03-05 16:13:03 | end=2026-03-05 16:13:03 | dur=993ms | rows=97
SELECT investor_id, investor_name FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date >= date('2026-04-28', '-12 months'));

-- QUERY 381 — List all holdings for investor INV-015 sorted by purchase date oldest to newest.
-- query_id=200381 | userid=68 | start=2026-03-05 16:37:12 | end=2026-03-05 16:37:12 | dur=601ms | rows=25
SELECT * FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-015' ORDER BY purchase_date ASC;

-- QUERY 382 — List all holdings for investor INV-015 sorted by purchase date oldest to newest.
-- query_id=200382 | userid=23 | start=2026-03-05 17:09:39 | end=2026-03-05 17:09:39 | dur=884ms | rows=193
SELECT * FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-015' ORDER BY purchase_date ASC;

-- QUERY 383 — Can you tell me ?¢¬Ä¬î list all holdings for investor inv-015 sorted by purchase date oldest to newest.
-- query_id=200383 | userid=18 | start=2026-03-05 17:48:41 | end=2026-03-05 17:48:41 | dur=714ms | rows=167
SELECT * FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-015' ORDER BY purchase_date ASC;

-- QUERY 384 — Across the portfolio database, list all holdings for investor inv-015 sorted by purchase date oldest to newest.
-- query_id=200384 | userid=68 | start=2026-03-05 18:48:42 | end=2026-03-05 18:48:42 | dur=637ms | rows=59
SELECT * FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-015' ORDER BY purchase_date ASC;

-- QUERY 385 — From the complete wealth management dataset, list all holdings for investor inv-015 sorted by purchase date oldest to ne
-- query_id=200385 | userid=74 | start=2026-03-05 19:11:54 | end=2026-03-05 19:11:54 | dur=826ms | rows=197
SELECT * FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-015' ORDER BY purchase_date ASC;

-- QUERY 386 — Which investors have made more than 3 SIP transactions
-- query_id=200386 | userid=30 | start=2026-03-05 19:13:35 | end=2026-03-05 19:13:36 | dur=1482ms | rows=10
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'SIP' GROUP BY investor_id HAVING COUNT(*) > 3;

-- QUERY 387 — Identify the investor whos have made more than 3 SIP transactions
-- query_id=200387 | userid=30 | start=2026-03-06 07:16:12 | end=2026-03-06 07:16:13 | dur=1030ms | rows=22
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'SIP' GROUP BY investor_id HAVING COUNT(*) > 3;

-- QUERY 388 — I want to know which investors have made more than 3 SIP transactions
-- query_id=200388 | userid=30 | start=2026-03-06 10:52:52 | end=2026-03-06 10:52:53 | dur=1150ms | rows=22
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'SIP' GROUP BY investor_id HAVING COUNT(*) > 3;

-- QUERY 389 — Among all investors, which ones have made more than 3 SIP transactions
-- query_id=200389 | userid=95 | start=2026-03-06 11:12:26 | end=2026-03-06 11:12:26 | dur=681ms | rows=14
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'SIP' GROUP BY investor_id HAVING COUNT(*) > 3;

-- QUERY 390 — Considering all investors in the system, which investors have made more than 3 SIP transactions
-- query_id=200390 | userid=30 | start=2026-03-06 12:05:47 | end=2026-03-06 12:05:47 | dur=730ms | rows=19
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'SIP' GROUP BY investor_id HAVING COUNT(*) > 3;

-- QUERY 391 — Show the monthly total cash inflows (deposits and SIP) for the last 12 months.
-- query_id=200391 | userid=81 | start=2026-03-06 13:16:56 | end=2026-03-06 13:16:57 | dur=1327ms | rows=5
SELECT strftime('%Y-%m', date) as month, SUM(amount) as total_inflow FROM ATOM_EVENT_CASH_FLOW_001 WHERE date >= date('2026-04-28', '-12 months') AND type IN ('Deposit', 'SIP') AND amount > 0 GROUP BY month ORDER BY month;

-- QUERY 392 — Display the monthly total cash inflows (deposits and SIP) for the last 12 months.
-- query_id=200392 | userid=30 | start=2026-03-06 13:38:56 | end=2026-03-06 13:38:57 | dur=1348ms | rows=18
SELECT strftime('%Y-%m', date) as month, SUM(amount) as total_inflow FROM ATOM_EVENT_CASH_FLOW_001 WHERE date >= date('2026-04-28', '-12 months') AND type IN ('Deposit', 'SIP') AND amount > 0 GROUP BY month ORDER BY month;

-- QUERY 393 — Could you show me the monthly total cash inflows (deposits and SIP) for the last 12 months.
-- query_id=200393 | userid=68 | start=2026-03-06 16:12:44 | end=2026-03-06 16:12:45 | dur=1020ms | rows=27
SELECT strftime('%Y-%m', date) as month, SUM(amount) as total_inflow FROM ATOM_EVENT_CASH_FLOW_001 WHERE date >= date('2026-04-28', '-12 months') AND type IN ('Deposit', 'SIP') AND amount > 0 GROUP BY month ORDER BY month;

-- QUERY 394 — What does the system show for the monthly total cash inflows (deposits and SIP) for the last 12 months.
-- query_id=200394 | userid=18 | start=2026-03-06 17:19:46 | end=2026-03-06 17:19:47 | dur=1506ms | rows=4
SELECT strftime('%Y-%m', date) as month, SUM(amount) as total_inflow FROM ATOM_EVENT_CASH_FLOW_001 WHERE date >= date('2026-04-28', '-12 months') AND type IN ('Deposit', 'SIP') AND amount > 0 GROUP BY month ORDER BY month;

-- QUERY 395 — Please display the monthly total cash inflows (deposits and SIP) for the last 12 months.
-- query_id=200395 | userid=42 | start=2026-03-06 17:34:46 | end=2026-03-06 17:34:46 | dur=779ms | rows=24
SELECT strftime('%Y-%m', date) as month, SUM(amount) as total_inflow FROM ATOM_EVENT_CASH_FLOW_001 WHERE date >= date('2026-04-28', '-12 months') AND type IN ('Deposit', 'SIP') AND amount > 0 GROUP BY month ORDER BY month;

-- QUERY 396 — What is the ratio of total withdrawals to total deposits for each investor
-- query_id=200396 | userid=95 | start=2026-03-06 18:15:55 | end=2026-03-06 18:15:55 | dur=553ms | rows=2
SELECT investor_id, ABS(SUM(CASE WHEN amount < 0 THEN amount ELSE 0 END)) * 1.0 / NULLIF(SUM(CASE WHEN amount > 0 THEN amount ELSE 0 END), 0) as withdrawal_deposit_ratio FROM ATOM_EVENT_CASH_FLOW_001 GROUP BY investor_id;

-- QUERY 397 — Please provide the ratio of total withdrawals to total deposits for each investor
-- query_id=200397 | userid=30 | start=2026-03-06 18:29:10 | end=2026-03-06 18:29:11 | dur=1394ms | rows=18
SELECT investor_id, ABS(SUM(CASE WHEN amount < 0 THEN amount ELSE 0 END)) * 1.0 / NULLIF(SUM(CASE WHEN amount > 0 THEN amount ELSE 0 END), 0) as withdrawal_deposit_ratio FROM ATOM_EVENT_CASH_FLOW_001 GROUP BY investor_id;

-- QUERY 398 — Can you tell me what the ratio of total withdrawals to total deposits for each investor
-- query_id=200398 | userid=30 | start=2026-03-09 10:05:12 | end=2026-03-09 10:05:12 | dur=944ms | rows=2
SELECT investor_id, ABS(SUM(CASE WHEN amount < 0 THEN amount ELSE 0 END)) * 1.0 / NULLIF(SUM(CASE WHEN amount > 0 THEN amount ELSE 0 END), 0) as withdrawal_deposit_ratio FROM ATOM_EVENT_CASH_FLOW_001 GROUP BY investor_id;

-- QUERY 399 — What would be the ratio of total withdrawals to total deposits for each investor
-- query_id=200399 | userid=23 | start=2026-03-09 13:36:57 | end=2026-03-09 13:36:57 | dur=588ms | rows=25
SELECT investor_id, ABS(SUM(CASE WHEN amount < 0 THEN amount ELSE 0 END)) * 1.0 / NULLIF(SUM(CASE WHEN amount > 0 THEN amount ELSE 0 END), 0) as withdrawal_deposit_ratio FROM ATOM_EVENT_CASH_FLOW_001 GROUP BY investor_id;

-- QUERY 400 — Looking at all available records, what is the ratio of total withdrawals to total deposits for each investor
-- query_id=200400 | userid=18 | start=2026-03-09 18:29:56 | end=2026-03-09 18:29:57 | dur=1011ms | rows=13
SELECT investor_id, ABS(SUM(CASE WHEN amount < 0 THEN amount ELSE 0 END)) * 1.0 / NULLIF(SUM(CASE WHEN amount > 0 THEN amount ELSE 0 END), 0) as withdrawal_deposit_ratio FROM ATOM_EVENT_CASH_FLOW_001 GROUP BY investor_id;

-- QUERY 401 — Which cash flow source (Bank Transfer, UPI, Cheque etc.) handles the most transactions
-- query_id=200401 | userid=55 | start=2026-03-10 07:18:53 | end=2026-03-10 07:18:54 | dur=1167ms | rows=15
SELECT source, COUNT(*) as transaction_count FROM ATOM_EVENT_CASH_FLOW_001 GROUP BY source ORDER BY transaction_count DESC;

-- QUERY 402 — Identify the cash flow source (Bank Transfer, UPI, Cheque etc.) handles the most transactions
-- query_id=200402 | userid=81 | start=2026-03-10 07:33:21 | end=2026-03-10 07:33:21 | dur=769ms | rows=27
SELECT source, COUNT(*) as transaction_count FROM ATOM_EVENT_CASH_FLOW_001 GROUP BY source ORDER BY transaction_count DESC;

-- QUERY 403 — Do you know which cash flow source (Bank Transfer, UPI, Cheque etc.) handles the most transactions
-- query_id=200403 | userid=81 | start=2026-03-10 08:10:10 | end=2026-03-10 08:10:11 | dur=1162ms | rows=20
SELECT source, COUNT(*) as transaction_count FROM ATOM_EVENT_CASH_FLOW_001 GROUP BY source ORDER BY transaction_count DESC;

-- QUERY 404 — Out of all options, which cash flow source (Bank Transfer, UPI, Cheque etc.) handles the most transactions
-- query_id=200404 | userid=74 | start=2026-03-10 09:49:57 | end=2026-03-10 09:49:57 | dur=789ms | rows=16
SELECT source, COUNT(*) as transaction_count FROM ATOM_EVENT_CASH_FLOW_001 GROUP BY source ORDER BY transaction_count DESC;

-- QUERY 405 — Given all the data available, which cash flow source (Bank Transfer, UPI, Cheque etc.) handles the most transactions
-- query_id=200405 | userid=95 | start=2026-03-10 09:56:04 | end=2026-03-10 09:56:04 | dur=767ms | rows=23
SELECT source, COUNT(*) as transaction_count FROM ATOM_EVENT_CASH_FLOW_001 GROUP BY source ORDER BY transaction_count DESC;

-- QUERY 406 — Show total Lump Sum investments made per investor across all time.
-- query_id=200406 | userid=30 | start=2026-03-10 11:02:43 | end=2026-03-10 11:02:43 | dur=783ms | rows=2
SELECT investor_id, SUM(amount) as total_lump_sum FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' GROUP BY investor_id;

-- QUERY 407 — Display total Lump Sum investments made per investor across all time.
-- query_id=200407 | userid=42 | start=2026-03-10 12:14:30 | end=2026-03-10 12:14:30 | dur=672ms | rows=12
SELECT investor_id, SUM(amount) as total_lump_sum FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' GROUP BY investor_id;

-- QUERY 408 — Could you show me total Lump Sum investments made per investor across all time.
-- query_id=200408 | userid=55 | start=2026-03-10 15:53:11 | end=2026-03-10 15:53:11 | dur=697ms | rows=25
SELECT investor_id, SUM(amount) as total_lump_sum FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' GROUP BY investor_id;

-- QUERY 409 — What does the system show for total Lump Sum investments made per investor across all time.
-- query_id=200409 | userid=30 | start=2026-03-10 16:15:42 | end=2026-03-10 16:15:42 | dur=900ms | rows=21
SELECT investor_id, SUM(amount) as total_lump_sum FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' GROUP BY investor_id;

-- QUERY 410 — Please display total Lump Sum investments made per investor across all time.
-- query_id=200410 | userid=55 | start=2026-03-10 18:32:19 | end=2026-03-10 18:32:19 | dur=770ms | rows=23
SELECT investor_id, SUM(amount) as total_lump_sum FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' GROUP BY investor_id;

-- QUERY 411 — List all Redemption events for investor INV-008 with dates and amounts.
-- query_id=200411 | userid=74 | start=2026-03-10 19:08:46 | end=2026-03-10 19:08:46 | dur=659ms | rows=148
SELECT date, amount FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-008' AND type = 'Redemption';

-- QUERY 412 — List all Redemption events for investor INV-008 with dates and amounts.
-- query_id=200412 | userid=42 | start=2026-03-11 07:37:12 | end=2026-03-11 07:37:12 | dur=712ms | rows=57
SELECT date, amount FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-008' AND type = 'Redemption';

-- QUERY 413 — Can you tell me ?¢¬Ä¬î list all redemption events for investor inv-008 with dates and amounts.
-- query_id=200413 | userid=95 | start=2026-03-11 08:10:41 | end=2026-03-11 08:10:41 | dur=549ms | rows=176
SELECT date, amount FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-008' AND type = 'Redemption';

-- QUERY 414 — Across the portfolio database, list all redemption events for investor inv-008 with dates and amounts.
-- query_id=200414 | userid=23 | start=2026-03-11 11:30:42 | end=2026-03-11 11:30:42 | dur=690ms | rows=3
SELECT date, amount FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-008' AND type = 'Redemption';

-- QUERY 415 — From the complete wealth management dataset, list all redemption events for investor inv-008 with dates and amounts.
-- query_id=200415 | userid=12 | start=2026-03-11 13:31:48 | end=2026-03-11 13:31:48 | dur=675ms | rows=141
SELECT date, amount FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-008' AND type = 'Redemption';

-- QUERY 416 — What is the largest single cash flow transaction (any type) in the database
-- query_id=200416 | userid=42 | start=2026-03-11 14:33:36 | end=2026-03-11 14:33:36 | dur=623ms | rows=1
SELECT * FROM ATOM_EVENT_CASH_FLOW_001 ORDER BY ABS(amount) DESC LIMIT 1;

-- QUERY 417 — Please provide the largest single cash flow transaction (any type) in the database
-- query_id=200417 | userid=23 | start=2026-03-11 15:32:28 | end=2026-03-11 15:32:28 | dur=880ms | rows=1
SELECT * FROM ATOM_EVENT_CASH_FLOW_001 ORDER BY ABS(amount) DESC LIMIT 1;

-- QUERY 418 — Can you tell me what the largest single cash flow transaction (any type) in the database
-- query_id=200418 | userid=23 | start=2026-03-11 16:52:15 | end=2026-03-11 16:52:15 | dur=761ms | rows=1
SELECT * FROM ATOM_EVENT_CASH_FLOW_001 ORDER BY ABS(amount) DESC LIMIT 1;

-- QUERY 419 — What would be the largest single cash flow transaction (any type) in the database
-- query_id=200419 | userid=42 | start=2026-03-11 16:57:54 | end=2026-03-11 16:57:55 | dur=1200ms | rows=1
SELECT * FROM ATOM_EVENT_CASH_FLOW_001 ORDER BY ABS(amount) DESC LIMIT 1;

-- QUERY 420 — Looking at all available records, what is the largest single cash flow transaction (any type) in the database
-- query_id=200420 | userid=23 | start=2026-03-12 07:01:32 | end=2026-03-12 07:01:33 | dur=1060ms | rows=1
SELECT * FROM ATOM_EVENT_CASH_FLOW_001 ORDER BY ABS(amount) DESC LIMIT 1;

-- QUERY 421 — Show the total SWP (Systematic Withdrawal Plan) amount per investor.
-- query_id=200421 | userid=81 | start=2026-03-12 07:13:26 | end=2026-03-12 07:13:26 | dur=825ms | rows=14
SELECT investor_id, SUM(ABS(amount)) as total_swp_amount FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'SWP' GROUP BY investor_id;

-- QUERY 422 — Display the total SWP (Systematic Withdrawal Plan) amount per investor.
-- query_id=200422 | userid=18 | start=2026-03-12 07:44:38 | end=2026-03-12 07:44:38 | dur=896ms | rows=28
SELECT investor_id, SUM(ABS(amount)) as total_swp_amount FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'SWP' GROUP BY investor_id;

-- QUERY 423 — Could you show me the total SWP (Systematic Withdrawal Plan) amount per investor.
-- query_id=200423 | userid=18 | start=2026-03-12 07:55:06 | end=2026-03-12 07:55:06 | dur=645ms | rows=13
SELECT investor_id, SUM(ABS(amount)) as total_swp_amount FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'SWP' GROUP BY investor_id;

-- QUERY 424 — What does the system show for the total SWP (Systematic Withdrawal Plan) amount per investor.
-- query_id=200424 | userid=12 | start=2026-03-12 09:49:39 | end=2026-03-12 09:49:39 | dur=907ms | rows=20
SELECT investor_id, SUM(ABS(amount)) as total_swp_amount FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'SWP' GROUP BY investor_id;

-- QUERY 425 — Please display the total SWP (Systematic Withdrawal Plan) amount per investor.
-- query_id=200425 | userid=81 | start=2026-03-12 10:14:22 | end=2026-03-12 10:14:22 | dur=759ms | rows=4
SELECT investor_id, SUM(ABS(amount)) as total_swp_amount FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'SWP' GROUP BY investor_id;

-- QUERY 426 — Which investors have made Lump Sum investments but no SIP contributions
-- query_id=200426 | userid=68 | start=2026-03-12 11:36:46 | end=2026-03-12 11:36:46 | dur=734ms | rows=87
SELECT DISTINCT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' AND investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'SIP');

-- QUERY 427 — Identify the investor whos have made Lump Sum investments but no SIP contributions
-- query_id=200427 | userid=68 | start=2026-03-12 13:09:09 | end=2026-03-12 13:09:09 | dur=785ms | rows=82
SELECT DISTINCT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' AND investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'SIP');

-- QUERY 428 — I want to know which investors have made Lump Sum investments but no SIP contributions
-- query_id=200428 | userid=42 | start=2026-03-12 15:53:14 | end=2026-03-12 15:53:14 | dur=955ms | rows=200
SELECT DISTINCT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' AND investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'SIP');

-- QUERY 429 — Among all investors, which ones have made Lump Sum investments but no SIP contributions
-- query_id=200429 | userid=55 | start=2026-03-12 17:23:42 | end=2026-03-12 17:23:42 | dur=834ms | rows=187
SELECT DISTINCT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' AND investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'SIP');

-- QUERY 430 — Considering all investors in the system, which investors have made Lump Sum investments but no SIP contributions
-- query_id=200430 | userid=30 | start=2026-03-12 17:45:29 | end=2026-03-12 17:45:29 | dur=813ms | rows=43
SELECT DISTINCT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' AND investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'SIP');

-- QUERY 431 — Show total portfolio value grouped by category (Equity, Debt, Hybrid etc.).
-- query_id=200431 | userid=68 | start=2026-03-12 19:23:57 | end=2026-03-12 19:23:58 | dur=1070ms | rows=18
SELECT category, SUM(current_value) as total_portfolio_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category;

-- QUERY 432 — Display total portfolio value grouped by category (Equity, Debt, Hybrid etc.).
-- query_id=200432 | userid=18 | start=2026-03-13 07:54:17 | end=2026-03-13 07:54:17 | dur=684ms | rows=9
SELECT category, SUM(current_value) as total_portfolio_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category;

-- QUERY 433 — Could you show me total portfolio value grouped by category (Equity, Debt, Hybrid etc.).
-- query_id=200433 | userid=30 | start=2026-03-13 07:57:38 | end=2026-03-13 07:57:39 | dur=1125ms | rows=23
SELECT category, SUM(current_value) as total_portfolio_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category;

-- QUERY 434 — What does the system show for total portfolio value grouped by category (Equity, Debt, Hybrid etc.).
-- query_id=200434 | userid=55 | start=2026-03-13 08:57:31 | end=2026-03-13 08:57:32 | dur=1061ms | rows=19
SELECT category, SUM(current_value) as total_portfolio_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category;

-- QUERY 435 — Please display total portfolio value grouped by category (Equity, Debt, Hybrid etc.).
-- query_id=200435 | userid=74 | start=2026-03-13 10:15:47 | end=2026-03-13 10:15:47 | dur=692ms | rows=15
SELECT category, SUM(current_value) as total_portfolio_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category;

-- QUERY 436 — What is the count of holdings in each category for investor INV-012
-- query_id=200436 | userid=81 | start=2026-03-13 11:05:37 | end=2026-03-13 11:05:37 | dur=669ms | rows=19
SELECT category, COUNT(*) as holding_count FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-012' GROUP BY category;

-- QUERY 437 — Please provide the count of holdings in each category for investor INV-012
-- query_id=200437 | userid=30 | start=2026-03-13 13:44:01 | end=2026-03-13 13:44:02 | dur=1035ms | rows=18
SELECT category, COUNT(*) as holding_count FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-012' GROUP BY category;

-- QUERY 438 — Can you tell me what the count of holdings in each category for investor INV-012
-- query_id=200438 | userid=23 | start=2026-03-13 14:26:30 | end=2026-03-13 14:26:30 | dur=924ms | rows=17
SELECT category, COUNT(*) as holding_count FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-012' GROUP BY category;

-- QUERY 439 — What would be the count of holdings in each category for investor INV-012
-- query_id=200439 | userid=42 | start=2026-03-13 15:10:34 | end=2026-03-13 15:10:34 | dur=642ms | rows=30
SELECT category, COUNT(*) as holding_count FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-012' GROUP BY category;

-- QUERY 440 — Looking at all available records, what is the count of holdings in each category for investor INV-012
-- query_id=200440 | userid=81 | start=2026-03-13 15:45:35 | end=2026-03-13 15:45:35 | dur=788ms | rows=9
SELECT category, COUNT(*) as holding_count FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-012' GROUP BY category;

-- QUERY 441 — Which segment (Large Cap, Mid Cap etc.) has the most total invested amount
-- query_id=200441 | userid=42 | start=2026-03-13 16:40:16 | end=2026-03-13 16:40:16 | dur=696ms | rows=1
SELECT segment, SUM(cost) as total_invested_amount FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY segment ORDER BY total_invested_amount DESC LIMIT 1;

-- QUERY 442 — Identify the segment (Large Cap, Mid Cap etc.) has the most total invested amount
-- query_id=200442 | userid=42 | start=2026-03-13 18:07:15 | end=2026-03-13 18:07:15 | dur=739ms | rows=1
SELECT segment, SUM(cost) as total_invested_amount FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY segment ORDER BY total_invested_amount DESC LIMIT 1;

-- QUERY 443 — Do you know which segment (Large Cap, Mid Cap etc.) has the most total invested amount
-- query_id=200443 | userid=18 | start=2026-03-16 08:13:50 | end=2026-03-16 08:13:51 | dur=1039ms | rows=1
SELECT segment, SUM(cost) as total_invested_amount FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY segment ORDER BY total_invested_amount DESC LIMIT 1;

-- QUERY 444 — Out of all options, which segment (Large Cap, Mid Cap etc.) has the most total invested amount
-- query_id=200444 | userid=81 | start=2026-03-16 08:46:24 | end=2026-03-16 08:46:24 | dur=721ms | rows=1
SELECT segment, SUM(cost) as total_invested_amount FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY segment ORDER BY total_invested_amount DESC LIMIT 1;

-- QUERY 445 — Given all the data available, which segment (Large Cap, Mid Cap etc.) has the most total invested amount
-- query_id=200445 | userid=74 | start=2026-03-16 09:04:25 | end=2026-03-16 09:04:26 | dur=1090ms | rows=1
SELECT segment, SUM(cost) as total_invested_amount FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY segment ORDER BY total_invested_amount DESC LIMIT 1;

-- QUERY 446 — List all Crypto category holdings and their returns.
-- query_id=200446 | userid=74 | start=2026-03-16 11:38:25 | end=2026-03-16 11:38:25 | dur=634ms | rows=193
SELECT investment_name, returns_pct FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'Crypto';

-- QUERY 447 — List all Crypto category holdings and their returns.
-- query_id=200447 | userid=23 | start=2026-03-16 13:28:09 | end=2026-03-16 13:28:09 | dur=496ms | rows=65
SELECT investment_name, returns_pct FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'Crypto';

-- QUERY 448 — Can you tell me ?¢¬Ä¬î list all crypto category holdings and their returns.
-- query_id=200448 | userid=68 | start=2026-03-16 15:49:05 | end=2026-03-16 15:49:06 | dur=1061ms | rows=198
SELECT investment_name, returns_pct FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'Crypto';

-- QUERY 449 — Across the portfolio database, list all crypto category holdings and their returns.
-- query_id=200449 | userid=74 | start=2026-03-16 16:48:01 | end=2026-03-16 16:48:01 | dur=514ms | rows=100
SELECT investment_name, returns_pct FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'Crypto';

-- QUERY 450 — From the complete wealth management dataset, list all crypto category holdings and their returns.
-- query_id=200450 | userid=42 | start=2026-03-16 17:08:44 | end=2026-03-16 17:08:44 | dur=842ms | rows=141
SELECT investment_name, returns_pct FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'Crypto';

-- QUERY 451 — What is the total dividend amount received by the highest dividend-earning investor
-- query_id=200451 | userid=81 | start=2026-03-16 19:08:26 | end=2026-03-16 19:08:27 | dur=1091ms | rows=1
SELECT SUM(dividends) as total_dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id ORDER BY total_dividends DESC LIMIT 1;

-- QUERY 452 — Please provide the total dividend amount received by the highest dividend-earning investor
-- query_id=200452 | userid=30 | start=2026-03-17 11:13:15 | end=2026-03-17 11:13:16 | dur=1043ms | rows=1
SELECT SUM(dividends) as total_dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id ORDER BY total_dividends DESC LIMIT 1;

-- QUERY 453 — Can you tell me what the total dividend amount received by the highest dividend-earning investor
-- query_id=200453 | userid=23 | start=2026-03-17 12:12:21 | end=2026-03-17 12:12:22 | dur=1274ms | rows=1
SELECT SUM(dividends) as total_dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id ORDER BY total_dividends DESC LIMIT 1;

-- QUERY 454 — What would be the total dividend amount received by the highest dividend-earning investor
-- query_id=200454 | userid=74 | start=2026-03-17 15:05:36 | end=2026-03-17 15:05:37 | dur=1111ms | rows=1
SELECT SUM(dividends) as total_dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id ORDER BY total_dividends DESC LIMIT 1;

-- QUERY 455 — Looking at all available records, what is the total dividend amount received by the highest dividend-earning investor
-- query_id=200455 | userid=23 | start=2026-03-17 17:28:10 | end=2026-03-17 17:28:10 | dur=987ms | rows=1
SELECT SUM(dividends) as total_dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id ORDER BY total_dividends DESC LIMIT 1;

-- QUERY 456 — What is the total dividend income for investor INV-003 across all their holdings
-- query_id=200456 | userid=81 | start=2026-03-17 19:29:50 | end=2026-03-17 19:29:50 | dur=882ms | rows=1
SELECT SUM(dividends) as total_dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-003';

-- QUERY 457 — Please provide the total dividend income for investor INV-003 across all their holdings
-- query_id=200457 | userid=55 | start=2026-03-17 19:38:46 | end=2026-03-17 19:38:46 | dur=792ms | rows=1
SELECT SUM(dividends) as total_dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-003';

-- QUERY 458 — Can you tell me what the total dividend income for investor INV-003 across all their holdings
-- query_id=200458 | userid=12 | start=2026-03-18 12:16:02 | end=2026-03-18 12:16:02 | dur=609ms | rows=1
SELECT SUM(dividends) as total_dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-003';

-- QUERY 459 — What would be the total dividend income for investor INV-003 across all their holdings
-- query_id=200459 | userid=74 | start=2026-03-18 14:51:02 | end=2026-03-18 14:51:02 | dur=380ms | rows=1
SELECT SUM(dividends) as total_dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-003';

-- QUERY 460 — Looking at all available records, what is the total dividend income for investor INV-003 across all their holdings
-- query_id=200460 | userid=95 | start=2026-03-18 18:03:39 | end=2026-03-18 18:03:39 | dur=927ms | rows=1
SELECT SUM(dividends) as total_dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-003';

-- QUERY 461 — How many ETF holdings exist in the entire portfolio database
-- query_id=200461 | userid=42 | start=2026-03-18 19:46:41 | end=2026-03-18 19:46:41 | dur=785ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'ETF' OR investment_type = 'ETF';

-- QUERY 462 — Provide the count of ETF holdings exist in the entire portfolio database
-- query_id=200462 | userid=23 | start=2026-03-19 07:27:54 | end=2026-03-19 07:27:54 | dur=748ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'ETF' OR investment_type = 'ETF';

-- QUERY 463 — I need to find out how many ETF holdings exist in the entire portfolio database
-- query_id=200463 | userid=18 | start=2026-03-19 07:51:30 | end=2026-03-19 07:51:30 | dur=626ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'ETF' OR investment_type = 'ETF';

-- QUERY 464 — What is the total count of ETF holdings exist in the entire portfolio database
-- query_id=200464 | userid=95 | start=2026-03-19 08:59:09 | end=2026-03-19 08:59:09 | dur=507ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'ETF' OR investment_type = 'ETF';

-- QUERY 465 — Across the entire investor database, how many ETF holdings exist in the entire portfolio database
-- query_id=200465 | userid=81 | start=2026-03-19 10:13:02 | end=2026-03-19 10:13:02 | dur=759ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'ETF' OR investment_type = 'ETF';

-- QUERY 466 — What is the combined current value of all ETF holdings across all investors
-- query_id=200466 | userid=74 | start=2026-03-19 11:26:19 | end=2026-03-19 11:26:19 | dur=493ms | rows=1
SELECT SUM(current_value) as total_etf_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'ETF' OR investment_type = 'ETF';

-- QUERY 467 — Please provide the combined current value of all ETF holdings across all investors
-- query_id=200467 | userid=74 | start=2026-03-19 13:20:28 | end=2026-03-19 13:20:28 | dur=694ms | rows=1
SELECT SUM(current_value) as total_etf_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'ETF' OR investment_type = 'ETF';

-- QUERY 468 — Can you tell me what the combined current value of all ETF holdings across all investors
-- query_id=200468 | userid=12 | start=2026-03-19 14:31:02 | end=2026-03-19 14:31:03 | dur=1092ms | rows=1
SELECT SUM(current_value) as total_etf_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'ETF' OR investment_type = 'ETF';

-- QUERY 469 — What would be the combined current value of all ETF holdings across all investors
-- query_id=200469 | userid=12 | start=2026-03-19 14:38:10 | end=2026-03-19 14:38:10 | dur=589ms | rows=1
SELECT SUM(current_value) as total_etf_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'ETF' OR investment_type = 'ETF';

-- QUERY 470 — Looking at all available records, what is the combined current value of all ETF holdings across all investors
-- query_id=200470 | userid=95 | start=2026-03-19 16:14:11 | end=2026-03-19 16:14:11 | dur=470ms | rows=1
SELECT SUM(current_value) as total_etf_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'ETF' OR investment_type = 'ETF';

-- QUERY 471 — Which investment type holds the highest total current portfolio value
-- query_id=200471 | userid=30 | start=2026-03-19 18:13:53 | end=2026-03-19 18:13:54 | dur=1163ms | rows=1
SELECT investment_type, SUM(current_value) as total_current_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY total_current_value DESC LIMIT 1;

-- QUERY 472 — Identify the investment type holds the highest total current portfolio value
-- query_id=200472 | userid=30 | start=2026-03-19 18:14:33 | end=2026-03-19 18:14:34 | dur=1107ms | rows=1
SELECT investment_type, SUM(current_value) as total_current_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY total_current_value DESC LIMIT 1;

-- QUERY 473 — Do you know which investment type holds the highest total current portfolio value
-- query_id=200473 | userid=18 | start=2026-03-19 19:25:55 | end=2026-03-19 19:25:56 | dur=1042ms | rows=1
SELECT investment_type, SUM(current_value) as total_current_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY total_current_value DESC LIMIT 1;

-- QUERY 474 — Out of all options, which investment type holds the highest total current portfolio value
-- query_id=200474 | userid=23 | start=2026-03-19 19:47:25 | end=2026-03-19 19:47:25 | dur=904ms | rows=1
SELECT investment_type, SUM(current_value) as total_current_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY total_current_value DESC LIMIT 1;

-- QUERY 475 — Given all the data available, which investment type holds the highest total current portfolio value
-- query_id=200475 | userid=23 | start=2026-03-20 09:43:49 | end=2026-03-20 09:43:50 | dur=1366ms | rows=1
SELECT investment_type, SUM(current_value) as total_current_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY total_current_value DESC LIMIT 1;

-- QUERY 476 — Which investment type generates the highest average dividend income
-- query_id=200476 | userid=55 | start=2026-03-20 11:35:32 | end=2026-03-20 11:35:33 | dur=1075ms | rows=1
SELECT investment_type, AVG(dividends) as average_dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY average_dividends DESC LIMIT 1;

-- QUERY 477 — Identify the investment type generates the highest average dividend income
-- query_id=200477 | userid=30 | start=2026-03-20 12:15:08 | end=2026-03-20 12:15:09 | dur=1145ms | rows=1
SELECT investment_type, AVG(dividends) as average_dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY average_dividends DESC LIMIT 1;

-- QUERY 478 — Do you know which investment type generates the highest average dividend income
-- query_id=200478 | userid=74 | start=2026-03-20 12:38:45 | end=2026-03-20 12:38:46 | dur=1847ms | rows=1
SELECT investment_type, AVG(dividends) as average_dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY average_dividends DESC LIMIT 1;

-- QUERY 479 — Out of all options, which investment type generates the highest average dividend income
-- query_id=200479 | userid=12 | start=2026-03-20 12:44:50 | end=2026-03-20 12:44:50 | dur=977ms | rows=1
SELECT investment_type, AVG(dividends) as average_dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY average_dividends DESC LIMIT 1;

-- QUERY 480 — Given all the data available, which investment type generates the highest average dividend income
-- query_id=200480 | userid=42 | start=2026-03-20 15:35:14 | end=2026-03-20 15:35:15 | dur=1447ms | rows=1
SELECT investment_type, AVG(dividends) as average_dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY average_dividends DESC LIMIT 1;

-- QUERY 481 — Which investment type generates the lowest average dividend income
-- query_id=200481 | userid=18 | start=2026-03-23 07:06:03 | end=2026-03-23 07:06:03 | dur=762ms | rows=1
SELECT investment_type, AVG(dividends) as average_dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY average_dividends ASC LIMIT 1;

-- QUERY 482 — Identify the investment type generates the lowest average dividend income
-- query_id=200482 | userid=42 | start=2026-03-23 08:46:50 | end=2026-03-23 08:46:51 | dur=1130ms | rows=1
SELECT investment_type, AVG(dividends) as average_dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY average_dividends ASC LIMIT 1;

-- QUERY 483 — Do you know which investment type generates the lowest average dividend income
-- query_id=200483 | userid=18 | start=2026-03-23 09:16:20 | end=2026-03-23 09:16:21 | dur=1087ms | rows=1
SELECT investment_type, AVG(dividends) as average_dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY average_dividends ASC LIMIT 1;

-- QUERY 484 — Out of all options, which investment type generates the lowest average dividend income
-- query_id=200484 | userid=18 | start=2026-03-23 09:43:46 | end=2026-03-23 09:43:46 | dur=759ms | rows=1
SELECT investment_type, AVG(dividends) as average_dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY average_dividends ASC LIMIT 1;

-- QUERY 485 — Given all the data available, which investment type generates the lowest average dividend income
-- query_id=200485 | userid=18 | start=2026-03-23 11:06:14 | end=2026-03-23 11:06:14 | dur=940ms | rows=1
SELECT investment_type, AVG(dividends) as average_dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY average_dividends ASC LIMIT 1;

-- QUERY 486 — What is the total current market value of all holdings owned by Aggressive risk profile investors
-- query_id=200486 | userid=30 | start=2026-03-23 12:31:43 | end=2026-03-23 12:31:44 | dur=1550ms | rows=1
SELECT SUM(h.current_value) as total_market_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Aggressive';

-- QUERY 487 — Please provide the total current market value of all holdings owned by Aggressive risk profile investors
-- query_id=200487 | userid=68 | start=2026-03-23 12:33:40 | end=2026-03-23 12:33:40 | dur=889ms | rows=1
SELECT SUM(h.current_value) as total_market_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Aggressive';

-- QUERY 488 — Can you tell me what the total current market value of all holdings owned by Aggressive risk profile investors
-- query_id=200488 | userid=30 | start=2026-03-23 13:36:56 | end=2026-03-23 13:36:56 | dur=856ms | rows=1
SELECT SUM(h.current_value) as total_market_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Aggressive';

-- QUERY 489 — What would be the total current market value of all holdings owned by Aggressive risk profile investors
-- query_id=200489 | userid=95 | start=2026-03-23 14:00:38 | end=2026-03-23 14:00:39 | dur=1126ms | rows=1
SELECT SUM(h.current_value) as total_market_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Aggressive';

-- QUERY 490 — Looking at all available records, what is the total current market value of all holdings owned by Aggressive risk profil
-- query_id=200490 | userid=18 | start=2026-03-23 15:25:18 | end=2026-03-23 15:25:19 | dur=1173ms | rows=1
SELECT SUM(h.current_value) as total_market_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Aggressive';

-- QUERY 491 — What is the total current portfolio value for all Conservative risk profile investors
-- query_id=200491 | userid=18 | start=2026-03-23 17:49:06 | end=2026-03-23 17:49:07 | dur=1247ms | rows=1
SELECT SUM(h.current_value) as total_market_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Conservative';

-- QUERY 492 — Please provide the total current portfolio value for all Conservative risk profile investors
-- query_id=200492 | userid=74 | start=2026-03-24 08:03:07 | end=2026-03-24 08:03:08 | dur=1276ms | rows=1
SELECT SUM(h.current_value) as total_market_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Conservative';

-- QUERY 493 — Can you tell me what the total current portfolio value for all Conservative risk profile investors
-- query_id=200493 | userid=30 | start=2026-03-24 09:25:22 | end=2026-03-24 09:25:22 | dur=819ms | rows=1
SELECT SUM(h.current_value) as total_market_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Conservative';

-- QUERY 494 — What would be the total current portfolio value for all Conservative risk profile investors
-- query_id=200494 | userid=55 | start=2026-03-24 10:18:42 | end=2026-03-24 10:18:43 | dur=1015ms | rows=1
SELECT SUM(h.current_value) as total_market_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Conservative';

-- QUERY 495 — Looking at all available records, what is the total current portfolio value for all Conservative risk profile investors
-- query_id=200495 | userid=42 | start=2026-03-24 13:17:28 | end=2026-03-24 13:17:28 | dur=918ms | rows=1
SELECT SUM(h.current_value) as total_market_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Conservative';

-- QUERY 496 — What is the total original cost basis invested by Conservative risk profile investors
-- query_id=200496 | userid=30 | start=2026-03-24 13:19:29 | end=2026-03-24 13:19:30 | dur=1052ms | rows=1
SELECT SUM(h.cost) as total_cost_basis FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Conservative';

-- QUERY 497 — Please provide the total original cost basis invested by Conservative risk profile investors
-- query_id=200497 | userid=12 | start=2026-03-24 14:59:29 | end=2026-03-24 14:59:29 | dur=843ms | rows=1
SELECT SUM(h.cost) as total_cost_basis FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Conservative';

-- QUERY 498 — Can you tell me what the total original cost basis invested by Conservative risk profile investors
-- query_id=200498 | userid=42 | start=2026-03-24 17:50:41 | end=2026-03-24 17:50:42 | dur=1284ms | rows=1
SELECT SUM(h.cost) as total_cost_basis FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Conservative';

-- QUERY 499 — What would be the total original cost basis invested by Conservative risk profile investors
-- query_id=200499 | userid=30 | start=2026-03-24 18:34:44 | end=2026-03-24 18:34:45 | dur=1162ms | rows=1
SELECT SUM(h.cost) as total_cost_basis FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Conservative';

-- QUERY 500 — Looking at all available records, what is the total original cost basis invested by Conservative risk profile investors
-- query_id=200500 | userid=12 | start=2026-03-25 07:48:31 | end=2026-03-25 07:48:31 | dur=983ms | rows=1
SELECT SUM(h.cost) as total_cost_basis FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Conservative';

-- QUERY 501 — Which investor has paid the highest total taxes, and what is that amount
-- query_id=200501 | userid=23 | start=2026-03-25 08:23:53 | end=2026-03-25 08:23:53 | dur=810ms | rows=1
SELECT p.investor_id, p.investor_name, SUM(h.taxes_paid) as total_taxes_paid FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_PORTFOLIO_HOLDING_001 h ON p.investor_id = h.investor_id GROUP BY p.investor_id, p.investor_name ORDER BY total_taxes_paid DESC LIMIT 1;

-- QUERY 502 — Identify the investor who has paid the highest total taxes, and what is that amount
-- query_id=200502 | userid=18 | start=2026-03-25 08:36:35 | end=2026-03-25 08:36:36 | dur=1733ms | rows=1
SELECT p.investor_id, p.investor_name, SUM(h.taxes_paid) as total_taxes_paid FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_PORTFOLIO_HOLDING_001 h ON p.investor_id = h.investor_id GROUP BY p.investor_id, p.investor_name ORDER BY total_taxes_paid DESC LIMIT 1;

-- QUERY 503 — I want to know which investor has paid the highest total taxes, and what is that amount
-- query_id=200503 | userid=12 | start=2026-03-25 10:57:04 | end=2026-03-25 10:57:05 | dur=1612ms | rows=1
SELECT p.investor_id, p.investor_name, SUM(h.taxes_paid) as total_taxes_paid FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_PORTFOLIO_HOLDING_001 h ON p.investor_id = h.investor_id GROUP BY p.investor_id, p.investor_name ORDER BY total_taxes_paid DESC LIMIT 1;

-- QUERY 504 — Among all investors, who has paid the highest total taxes, and what is that amount
-- query_id=200504 | userid=95 | start=2026-03-25 11:25:26 | end=2026-03-25 11:25:27 | dur=1380ms | rows=1
SELECT p.investor_id, p.investor_name, SUM(h.taxes_paid) as total_taxes_paid FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_PORTFOLIO_HOLDING_001 h ON p.investor_id = h.investor_id GROUP BY p.investor_id, p.investor_name ORDER BY total_taxes_paid DESC LIMIT 1;

-- QUERY 505 — Considering all investors in the system, which investor has paid the highest total taxes, and what is that amount
-- query_id=200505 | userid=12 | start=2026-03-25 11:32:33 | end=2026-03-25 11:32:34 | dur=1082ms | rows=1
SELECT p.investor_id, p.investor_name, SUM(h.taxes_paid) as total_taxes_paid FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_PORTFOLIO_HOLDING_001 h ON p.investor_id = h.investor_id GROUP BY p.investor_id, p.investor_name ORDER BY total_taxes_paid DESC LIMIT 1;

-- QUERY 506 — Which payment source channel handles the highest number of cash flow transactions
-- query_id=200506 | userid=55 | start=2026-03-25 12:16:16 | end=2026-03-25 12:16:17 | dur=1256ms | rows=10
SELECT source, COUNT(*) as transaction_count FROM ATOM_EVENT_CASH_FLOW_001 GROUP BY source ORDER BY transaction_count DESC;

-- QUERY 507 — Identify the payment source channel handles the highest number of cash flow transactions
-- query_id=200507 | userid=12 | start=2026-03-25 12:52:27 | end=2026-03-25 12:52:28 | dur=1303ms | rows=12
SELECT source, COUNT(*) as transaction_count FROM ATOM_EVENT_CASH_FLOW_001 GROUP BY source ORDER BY transaction_count DESC;

-- QUERY 508 — Do you know which payment source channel handles the highest number of cash flow transactions
-- query_id=200508 | userid=68 | start=2026-03-25 14:46:29 | end=2026-03-25 14:46:30 | dur=1194ms | rows=21
SELECT source, COUNT(*) as transaction_count FROM ATOM_EVENT_CASH_FLOW_001 GROUP BY source ORDER BY transaction_count DESC;

-- QUERY 509 — Out of all options, which payment source channel handles the highest number of cash flow transactions
-- query_id=200509 | userid=30 | start=2026-03-25 14:59:52 | end=2026-03-25 14:59:52 | dur=876ms | rows=8
SELECT source, COUNT(*) as transaction_count FROM ATOM_EVENT_CASH_FLOW_001 GROUP BY source ORDER BY transaction_count DESC;

-- QUERY 510 — Given all the data available, which payment source channel handles the highest number of cash flow transactions
-- query_id=200510 | userid=23 | start=2026-03-25 15:08:45 | end=2026-03-25 15:08:46 | dur=1333ms | rows=24
SELECT source, COUNT(*) as transaction_count FROM ATOM_EVENT_CASH_FLOW_001 GROUP BY source ORDER BY transaction_count DESC;

-- QUERY 511 — Which portfolio segment has the highest total invested amount across all investors
-- query_id=200511 | userid=81 | start=2026-03-25 16:50:38 | end=2026-03-25 16:50:39 | dur=1903ms | rows=1
SELECT segment, SUM(cost) as total_invested_amount FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY segment ORDER BY total_invested_amount DESC LIMIT 1;

-- QUERY 512 — Identify the portfolio segment has the highest total invested amount across all investors
-- query_id=200512 | userid=55 | start=2026-03-25 17:59:29 | end=2026-03-25 17:59:29 | dur=838ms | rows=1
SELECT segment, SUM(cost) as total_invested_amount FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY segment ORDER BY total_invested_amount DESC LIMIT 1;

-- QUERY 513 — Do you know which portfolio segment has the highest total invested amount across all investors
-- query_id=200513 | userid=55 | start=2026-03-26 09:12:50 | end=2026-03-26 09:12:51 | dur=1309ms | rows=1
SELECT segment, SUM(cost) as total_invested_amount FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY segment ORDER BY total_invested_amount DESC LIMIT 1;

-- QUERY 514 — Out of all options, which portfolio segment has the highest total invested amount across all investors
-- query_id=200514 | userid=42 | start=2026-03-26 10:09:10 | end=2026-03-26 10:09:10 | dur=681ms | rows=1
SELECT segment, SUM(cost) as total_invested_amount FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY segment ORDER BY total_invested_amount DESC LIMIT 1;

-- QUERY 515 — Given all the data available, which portfolio segment has the highest total invested amount across all investors
-- query_id=200515 | userid=95 | start=2026-03-26 10:58:10 | end=2026-03-26 10:58:11 | dur=1224ms | rows=1
SELECT segment, SUM(cost) as total_invested_amount FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY segment ORDER BY total_invested_amount DESC LIMIT 1;

-- QUERY 516 — Which investment category holds the highest total portfolio value
-- query_id=200516 | userid=55 | start=2026-03-26 13:31:01 | end=2026-03-26 13:31:02 | dur=1026ms | rows=1
SELECT category, SUM(current_value) as total_portfolio_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category ORDER BY total_portfolio_value DESC LIMIT 1;

-- QUERY 517 — Identify the investment category holds the highest total portfolio value
-- query_id=200517 | userid=74 | start=2026-03-26 13:55:27 | end=2026-03-26 13:55:28 | dur=1059ms | rows=1
SELECT category, SUM(current_value) as total_portfolio_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category ORDER BY total_portfolio_value DESC LIMIT 1;

-- QUERY 518 — Do you know which investment category holds the highest total portfolio value
-- query_id=200518 | userid=30 | start=2026-03-26 14:23:59 | end=2026-03-26 14:23:59 | dur=910ms | rows=1
SELECT category, SUM(current_value) as total_portfolio_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category ORDER BY total_portfolio_value DESC LIMIT 1;

-- QUERY 519 — Out of all options, which investment category holds the highest total portfolio value
-- query_id=200519 | userid=30 | start=2026-03-26 15:08:34 | end=2026-03-26 15:08:35 | dur=1671ms | rows=1
SELECT category, SUM(current_value) as total_portfolio_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category ORDER BY total_portfolio_value DESC LIMIT 1;

-- QUERY 520 — Given all the data available, which investment category holds the highest total portfolio value
-- query_id=200520 | userid=95 | start=2026-03-26 15:22:16 | end=2026-03-26 15:22:16 | dur=938ms | rows=1
SELECT category, SUM(current_value) as total_portfolio_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category ORDER BY total_portfolio_value DESC LIMIT 1;

-- QUERY 521 — Which investment category holds the lowest total portfolio value
-- query_id=200521 | userid=68 | start=2026-03-26 16:10:31 | end=2026-03-26 16:10:32 | dur=1253ms | rows=1
SELECT category, SUM(current_value) as total_portfolio_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category ORDER BY total_portfolio_value ASC LIMIT 1;

-- QUERY 522 — Identify the investment category holds the lowest total portfolio value
-- query_id=200522 | userid=95 | start=2026-03-26 16:55:50 | end=2026-03-26 16:55:51 | dur=1459ms | rows=1
SELECT category, SUM(current_value) as total_portfolio_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category ORDER BY total_portfolio_value ASC LIMIT 1;

-- QUERY 523 — Do you know which investment category holds the lowest total portfolio value
-- query_id=200523 | userid=18 | start=2026-03-26 17:44:34 | end=2026-03-26 17:44:34 | dur=642ms | rows=1
SELECT category, SUM(current_value) as total_portfolio_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category ORDER BY total_portfolio_value ASC LIMIT 1;

-- QUERY 524 — Out of all options, which investment category holds the lowest total portfolio value
-- query_id=200524 | userid=12 | start=2026-03-26 19:13:27 | end=2026-03-26 19:13:28 | dur=1045ms | rows=1
SELECT category, SUM(current_value) as total_portfolio_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category ORDER BY total_portfolio_value ASC LIMIT 1;

-- QUERY 525 — Given all the data available, which investment category holds the lowest total portfolio value
-- query_id=200525 | userid=42 | start=2026-03-27 07:51:14 | end=2026-03-27 07:51:15 | dur=1105ms | rows=1
SELECT category, SUM(current_value) as total_portfolio_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category ORDER BY total_portfolio_value ASC LIMIT 1;

-- QUERY 526 — What is the total cost of all Mutual Fund holdings across the entire investor base
-- query_id=200526 | userid=12 | start=2026-03-27 09:19:16 | end=2026-03-27 09:19:16 | dur=791ms | rows=1
SELECT SUM(cost) as total_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'MF' OR investment_type = 'Mutual Fund';

-- QUERY 527 — Please provide the total cost of all Mutual Fund holdings across the entire investor base
-- query_id=200527 | userid=81 | start=2026-03-27 09:26:35 | end=2026-03-27 09:26:35 | dur=379ms | rows=1
SELECT SUM(cost) as total_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'MF' OR investment_type = 'Mutual Fund';

-- QUERY 528 — Can you tell me what the total cost of all Mutual Fund holdings across the entire investor base
-- query_id=200528 | userid=12 | start=2026-03-27 09:57:17 | end=2026-03-27 09:57:17 | dur=540ms | rows=1
SELECT SUM(cost) as total_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'MF' OR investment_type = 'Mutual Fund';

-- QUERY 529 — What would be the total cost of all Mutual Fund holdings across the entire investor base
-- query_id=200529 | userid=18 | start=2026-03-27 11:58:32 | end=2026-03-27 11:58:32 | dur=565ms | rows=1
SELECT SUM(cost) as total_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'MF' OR investment_type = 'Mutual Fund';

-- QUERY 530 — Looking at all available records, what is the total cost of all Mutual Fund holdings across the entire investor base
-- query_id=200530 | userid=74 | start=2026-03-27 12:44:00 | end=2026-03-27 12:44:00 | dur=716ms | rows=1
SELECT SUM(cost) as total_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'MF' OR investment_type = 'Mutual Fund';

-- QUERY 531 — What is the total current value of all Mutual Fund holdings across all investors
-- query_id=200531 | userid=81 | start=2026-03-27 13:19:57 | end=2026-03-27 13:19:57 | dur=810ms | rows=1
SELECT SUM(current_value) as total_current_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'MF' OR investment_type = 'Mutual Fund';

-- QUERY 532 — Please provide the total current value of all Mutual Fund holdings across all investors
-- query_id=200532 | userid=23 | start=2026-03-27 14:23:05 | end=2026-03-27 14:23:05 | dur=543ms | rows=1
SELECT SUM(current_value) as total_current_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'MF' OR investment_type = 'Mutual Fund';

-- QUERY 533 — Can you tell me what the total current value of all Mutual Fund holdings across all investors
-- query_id=200533 | userid=42 | start=2026-03-27 18:36:35 | end=2026-03-27 18:36:35 | dur=667ms | rows=1
SELECT SUM(current_value) as total_current_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'MF' OR investment_type = 'Mutual Fund';

-- QUERY 534 — What would be the total current value of all Mutual Fund holdings across all investors
-- query_id=200534 | userid=30 | start=2026-03-27 18:52:19 | end=2026-03-27 18:52:19 | dur=534ms | rows=1
SELECT SUM(current_value) as total_current_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'MF' OR investment_type = 'Mutual Fund';

-- QUERY 535 — Looking at all available records, what is the total current value of all Mutual Fund holdings across all investors
-- query_id=200535 | userid=74 | start=2026-03-27 19:06:09 | end=2026-03-27 19:06:09 | dur=560ms | rows=1
SELECT SUM(current_value) as total_current_value FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE category = 'MF' OR investment_type = 'Mutual Fund';

-- QUERY 536 — Which investor purchased the highest number of new holdings during 2023
-- query_id=200536 | userid=68 | start=2026-03-30 07:03:08 | end=2026-03-30 07:03:08 | dur=936ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY investor_id ORDER BY COUNT(*) DESC LIMIT 1;

-- QUERY 537 — Identify the investor who purchased the highest number of new holdings during 2023
-- query_id=200537 | userid=42 | start=2026-03-30 07:08:11 | end=2026-03-30 07:08:12 | dur=1241ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY investor_id ORDER BY COUNT(*) DESC LIMIT 1;

-- QUERY 538 — I want to know which investor purchased the highest number of new holdings during 2023
-- query_id=200538 | userid=55 | start=2026-03-30 07:27:23 | end=2026-03-30 07:27:23 | dur=803ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY investor_id ORDER BY COUNT(*) DESC LIMIT 1;

-- QUERY 539 — Among all investors, which one purchased the highest number of new holdings during 2023
-- query_id=200539 | userid=42 | start=2026-03-30 07:38:32 | end=2026-03-30 07:38:32 | dur=766ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY investor_id ORDER BY COUNT(*) DESC LIMIT 1;

-- QUERY 540 — Considering all investors in the system, which investor purchased the highest number of new holdings during 2023
-- query_id=200540 | userid=95 | start=2026-03-30 08:29:33 | end=2026-03-30 08:29:34 | dur=1001ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY investor_id ORDER BY COUNT(*) DESC LIMIT 1;

-- QUERY 541 — What is the earliest purchase date of any holding across all investors
-- query_id=200541 | userid=12 | start=2026-03-30 10:03:34 | end=2026-03-30 10:03:34 | dur=540ms | rows=1
SELECT purchase_date, investment_name, holding_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY purchase_date ASC LIMIT 1;

-- QUERY 542 — Please provide the earliest purchase date of any holding across all investors
-- query_id=200542 | userid=18 | start=2026-03-30 10:23:35 | end=2026-03-30 10:23:35 | dur=504ms | rows=1
SELECT purchase_date, investment_name, holding_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY purchase_date ASC LIMIT 1;

-- QUERY 543 — Can you tell me what the earliest purchase date of any holding across all investors
-- query_id=200543 | userid=81 | start=2026-03-30 15:15:58 | end=2026-03-30 15:15:58 | dur=423ms | rows=1
SELECT purchase_date, investment_name, holding_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY purchase_date ASC LIMIT 1;

-- QUERY 544 — What would be the earliest purchase date of any holding across all investors
-- query_id=200544 | userid=81 | start=2026-03-30 16:46:45 | end=2026-03-30 16:46:45 | dur=495ms | rows=1
SELECT purchase_date, investment_name, holding_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY purchase_date ASC LIMIT 1;

-- QUERY 545 — Looking at all available records, what is the earliest purchase date of any holding across all investors
-- query_id=200545 | userid=95 | start=2026-03-30 17:00:33 | end=2026-03-30 17:00:33 | dur=826ms | rows=1
SELECT purchase_date, investment_name, holding_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY purchase_date ASC LIMIT 1;

-- QUERY 546 — In which of the years 2022, 2023, or 2024 was the total investment (cost) highest
-- query_id=200546 | userid=74 | start=2026-03-30 17:26:21 | end=2026-03-30 17:26:21 | dur=920ms | rows=1
SELECT CAST(substr(purchase_date, 1, 4) AS INTEGER) as purchase_year, SUM(cost) as total_investment_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE CAST(substr(purchase_date, 1, 4) AS INTEGER) IN (2022, 2023, 2024) GROUP BY purchase_year ORDER BY total_investment_cost DESC LIMIT 1;

-- QUERY 547 — In which of the years 2022, 2023, or 2024 was the total investment (cost) highest
-- query_id=200547 | userid=12 | start=2026-03-30 18:18:13 | end=2026-03-30 18:18:14 | dur=1149ms | rows=1
SELECT CAST(substr(purchase_date, 1, 4) AS INTEGER) as purchase_year, SUM(cost) as total_investment_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE CAST(substr(purchase_date, 1, 4) AS INTEGER) IN (2022, 2023, 2024) GROUP BY purchase_year ORDER BY total_investment_cost DESC LIMIT 1;

-- QUERY 548 — Can you tell me ?¢¬Ä¬î in which of the years 2022, 2023, or 2024 was the total investment (cost) highest
-- query_id=200548 | userid=68 | start=2026-03-30 18:49:15 | end=2026-03-30 18:49:15 | dur=743ms | rows=1
SELECT CAST(substr(purchase_date, 1, 4) AS INTEGER) as purchase_year, SUM(cost) as total_investment_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE CAST(substr(purchase_date, 1, 4) AS INTEGER) IN (2022, 2023, 2024) GROUP BY purchase_year ORDER BY total_investment_cost DESC LIMIT 1;

-- QUERY 549 — Across the portfolio database, in which of the years 2022, 2023, or 2024 was the total investment (cost) highest
-- query_id=200549 | userid=30 | start=2026-03-31 08:12:25 | end=2026-03-31 08:12:26 | dur=1024ms | rows=1
SELECT CAST(substr(purchase_date, 1, 4) AS INTEGER) as purchase_year, SUM(cost) as total_investment_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE CAST(substr(purchase_date, 1, 4) AS INTEGER) IN (2022, 2023, 2024) GROUP BY purchase_year ORDER BY total_investment_cost DESC LIMIT 1;

-- QUERY 550 — From the complete wealth management dataset, in which of the years 2022, 2023, or 2024 was the total investment (cost) h
-- query_id=200550 | userid=12 | start=2026-03-31 09:10:06 | end=2026-03-31 09:10:06 | dur=848ms | rows=1
SELECT CAST(substr(purchase_date, 1, 4) AS INTEGER) as purchase_year, SUM(cost) as total_investment_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE CAST(substr(purchase_date, 1, 4) AS INTEGER) IN (2022, 2023, 2024) GROUP BY purchase_year ORDER BY total_investment_cost DESC LIMIT 1;

-- QUERY 551 — What was the total investment cost made in 2022
-- query_id=200551 | userid=12 | start=2026-03-31 13:06:51 | end=2026-03-31 13:06:51 | dur=716ms | rows=1
SELECT SUM(cost) as total_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date LIKE '2022-%';

-- QUERY 552 — What was the total investment cost made in 2022
-- query_id=200552 | userid=12 | start=2026-03-31 14:30:10 | end=2026-03-31 14:30:10 | dur=764ms | rows=1
SELECT SUM(cost) as total_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date LIKE '2022-%';

-- QUERY 553 — Can you tell me ?¢¬Ä¬î what was the total investment cost made in 2022
-- query_id=200553 | userid=55 | start=2026-03-31 15:35:04 | end=2026-03-31 15:35:04 | dur=494ms | rows=1
SELECT SUM(cost) as total_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date LIKE '2022-%';

-- QUERY 554 — Across the portfolio database, what was the total investment cost made in 2022
-- query_id=200554 | userid=81 | start=2026-03-31 15:40:14 | end=2026-03-31 15:40:14 | dur=609ms | rows=1
SELECT SUM(cost) as total_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date LIKE '2022-%';

-- QUERY 555 — From the complete wealth management dataset, what was the total investment cost made in 2022
-- query_id=200555 | userid=18 | start=2026-03-31 15:52:33 | end=2026-03-31 15:52:33 | dur=713ms | rows=1
SELECT SUM(cost) as total_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date LIKE '2022-%';

-- QUERY 556 — What was the total investment cost made in 2023
-- query_id=200556 | userid=95 | start=2026-03-31 16:57:56 | end=2026-03-31 16:57:56 | dur=595ms | rows=1
SELECT SUM(cost) as total_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date LIKE '2023-%';

-- QUERY 557 — What was the total investment cost made in 2023
-- query_id=200557 | userid=55 | start=2026-03-31 18:17:19 | end=2026-03-31 18:17:19 | dur=597ms | rows=1
SELECT SUM(cost) as total_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date LIKE '2023-%';

-- QUERY 558 — Can you tell me ?¢¬Ä¬î what was the total investment cost made in 2023
-- query_id=200558 | userid=42 | start=2026-04-01 07:00:07 | end=2026-04-01 07:00:07 | dur=674ms | rows=1
SELECT SUM(cost) as total_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date LIKE '2023-%';

-- QUERY 559 — Across the portfolio database, what was the total investment cost made in 2023
-- query_id=200559 | userid=12 | start=2026-04-01 07:12:55 | end=2026-04-01 07:12:55 | dur=825ms | rows=1
SELECT SUM(cost) as total_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date LIKE '2023-%';

-- QUERY 560 — From the complete wealth management dataset, what was the total investment cost made in 2023
-- query_id=200560 | userid=23 | start=2026-04-01 08:14:14 | end=2026-04-01 08:14:14 | dur=335ms | rows=1
SELECT SUM(cost) as total_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date LIKE '2023-%';

-- QUERY 561 — What was the total investment cost made in 2024
-- query_id=200561 | userid=55 | start=2026-04-01 11:21:52 | end=2026-04-01 11:21:52 | dur=560ms | rows=1
SELECT SUM(cost) as total_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date LIKE '2024-%';

-- QUERY 562 — What was the total investment cost made in 2024
-- query_id=200562 | userid=12 | start=2026-04-01 16:29:33 | end=2026-04-01 16:29:33 | dur=582ms | rows=1
SELECT SUM(cost) as total_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date LIKE '2024-%';

-- QUERY 563 — Can you tell me ?¢¬Ä¬î what was the total investment cost made in 2024
-- query_id=200563 | userid=42 | start=2026-04-01 18:11:45 | end=2026-04-01 18:11:45 | dur=829ms | rows=1
SELECT SUM(cost) as total_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date LIKE '2024-%';

-- QUERY 564 — Across the portfolio database, what was the total investment cost made in 2024
-- query_id=200564 | userid=81 | start=2026-04-02 07:47:19 | end=2026-04-02 07:47:19 | dur=846ms | rows=1
SELECT SUM(cost) as total_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date LIKE '2024-%';

-- QUERY 565 — From the complete wealth management dataset, what was the total investment cost made in 2024
-- query_id=200565 | userid=42 | start=2026-04-02 08:41:33 | end=2026-04-02 08:41:33 | dur=531ms | rows=1
SELECT SUM(cost) as total_cost FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date LIKE '2024-%';

-- QUERY 566 — What is the amount of the single largest cash flow transaction in the entire database
-- query_id=200566 | userid=18 | start=2026-04-02 09:34:28 | end=2026-04-02 09:34:28 | dur=538ms | rows=1
SELECT MAX(ABS(amount)) as largest_amount FROM ATOM_EVENT_CASH_FLOW_001;

-- QUERY 567 — Please provide the amount of the single largest cash flow transaction in the entire database
-- query_id=200567 | userid=81 | start=2026-04-02 13:14:29 | end=2026-04-02 13:14:29 | dur=622ms | rows=1
SELECT MAX(ABS(amount)) as largest_amount FROM ATOM_EVENT_CASH_FLOW_001;

-- QUERY 568 — Can you tell me what the amount of the single largest cash flow transaction in the entire database
-- query_id=200568 | userid=42 | start=2026-04-02 16:42:13 | end=2026-04-02 16:42:13 | dur=965ms | rows=1
SELECT MAX(ABS(amount)) as largest_amount FROM ATOM_EVENT_CASH_FLOW_001;

-- QUERY 569 — What would be the amount of the single largest cash flow transaction in the entire database
-- query_id=200569 | userid=74 | start=2026-04-02 17:47:58 | end=2026-04-02 17:47:58 | dur=369ms | rows=1
SELECT MAX(ABS(amount)) as largest_amount FROM ATOM_EVENT_CASH_FLOW_001;

-- QUERY 570 — Looking at all available records, what is the amount of the single largest cash flow transaction in the entire database
-- query_id=200570 | userid=68 | start=2026-04-02 18:48:23 | end=2026-04-02 18:48:23 | dur=541ms | rows=1
SELECT MAX(ABS(amount)) as largest_amount FROM ATOM_EVENT_CASH_FLOW_001;

-- QUERY 571 — How many total holdings do Conservative risk profile investors hold
-- query_id=200571 | userid=55 | start=2026-04-03 08:35:30 | end=2026-04-03 08:35:31 | dur=1109ms | rows=1
SELECT COUNT(*) as total_holdings FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Conservative';

-- QUERY 572 — Provide the count of total holdings do Conservative risk profile investors hold
-- query_id=200572 | userid=74 | start=2026-04-03 10:45:16 | end=2026-04-03 10:45:16 | dur=880ms | rows=1
SELECT COUNT(*) as total_holdings FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Conservative';

-- QUERY 573 — I need to find out how many total holdings do Conservative risk profile investors hold
-- query_id=200573 | userid=74 | start=2026-04-03 11:28:01 | end=2026-04-03 11:28:02 | dur=1131ms | rows=1
SELECT COUNT(*) as total_holdings FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Conservative';

-- QUERY 574 — What is the total count of total holdings do Conservative risk profile investors hold
-- query_id=200574 | userid=95 | start=2026-04-03 13:59:43 | end=2026-04-03 13:59:44 | dur=1070ms | rows=1
SELECT COUNT(*) as total_holdings FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Conservative';

-- QUERY 575 — Across the entire investor database, how many total holdings do Conservative risk profile investors hold
-- query_id=200575 | userid=55 | start=2026-04-03 14:53:12 | end=2026-04-03 14:53:12 | dur=766ms | rows=1
SELECT COUNT(*) as total_holdings FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Conservative';

-- QUERY 576 — How many total holdings do Moderate risk profile investors hold
-- query_id=200576 | userid=42 | start=2026-04-03 18:22:45 | end=2026-04-03 18:22:46 | dur=1177ms | rows=1
SELECT COUNT(*) as total_holdings FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Moderate';

-- QUERY 577 — Provide the count of total holdings do Moderate risk profile investors hold
-- query_id=200577 | userid=68 | start=2026-04-06 07:23:35 | end=2026-04-06 07:23:36 | dur=1578ms | rows=1
SELECT COUNT(*) as total_holdings FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Moderate';

-- QUERY 578 — I need to find out how many total holdings do Moderate risk profile investors hold
-- query_id=200578 | userid=74 | start=2026-04-06 07:39:37 | end=2026-04-06 07:39:38 | dur=1188ms | rows=1
SELECT COUNT(*) as total_holdings FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Moderate';

-- QUERY 579 — What is the total count of total holdings do Moderate risk profile investors hold
-- query_id=200579 | userid=23 | start=2026-04-06 11:36:29 | end=2026-04-06 11:36:30 | dur=1076ms | rows=1
SELECT COUNT(*) as total_holdings FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Moderate';

-- QUERY 580 — Across the entire investor database, how many total holdings do Moderate risk profile investors hold
-- query_id=200580 | userid=68 | start=2026-04-06 11:42:18 | end=2026-04-06 11:42:18 | dur=942ms | rows=1
SELECT COUNT(*) as total_holdings FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Moderate';

-- QUERY 581 — How many total holdings do Aggressive risk profile investors hold
-- query_id=200581 | userid=18 | start=2026-04-06 15:47:49 | end=2026-04-06 15:47:50 | dur=1217ms | rows=1
SELECT COUNT(*) as total_holdings FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Aggressive';

-- QUERY 582 — Provide the count of total holdings do Aggressive risk profile investors hold
-- query_id=200582 | userid=18 | start=2026-04-06 19:57:01 | end=2026-04-06 19:57:02 | dur=1176ms | rows=1
SELECT COUNT(*) as total_holdings FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Aggressive';

-- QUERY 583 — I need to find out how many total holdings do Aggressive risk profile investors hold
-- query_id=200583 | userid=18 | start=2026-04-07 08:28:28 | end=2026-04-07 08:28:29 | dur=1226ms | rows=1
SELECT COUNT(*) as total_holdings FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Aggressive';

-- QUERY 584 — What is the total count of total holdings do Aggressive risk profile investors hold
-- query_id=200584 | userid=30 | start=2026-04-07 10:55:00 | end=2026-04-07 10:55:01 | dur=1087ms | rows=1
SELECT COUNT(*) as total_holdings FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Aggressive';

-- QUERY 585 — Across the entire investor database, how many total holdings do Aggressive risk profile investors hold
-- query_id=200585 | userid=23 | start=2026-04-07 13:59:01 | end=2026-04-07 13:59:01 | dur=950ms | rows=1
SELECT COUNT(*) as total_holdings FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 h JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 p ON h.investor_id = p.investor_id WHERE p.risk_tolerance = 'Aggressive';

-- QUERY 586 — Which risk profile group has the highest average investment goal target amount
-- query_id=200586 | userid=55 | start=2026-04-07 14:37:37 | end=2026-04-07 14:37:38 | dur=1523ms | rows=1
SELECT p.risk_tolerance, AVG(g.target_amount) as average_target_amount FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON p.investor_id = g.investor_id GROUP BY p.risk_tolerance ORDER BY average_target_amount DESC LIMIT 1;

-- QUERY 587 — Identify the risk profile group has the highest average investment goal target amount
-- query_id=200587 | userid=55 | start=2026-04-07 15:17:50 | end=2026-04-07 15:17:51 | dur=1403ms | rows=1
SELECT p.risk_tolerance, AVG(g.target_amount) as average_target_amount FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON p.investor_id = g.investor_id GROUP BY p.risk_tolerance ORDER BY average_target_amount DESC LIMIT 1;

-- QUERY 588 — Do you know which risk profile group has the highest average investment goal target amount
-- query_id=200588 | userid=81 | start=2026-04-07 18:35:53 | end=2026-04-07 18:35:54 | dur=1499ms | rows=1
SELECT p.risk_tolerance, AVG(g.target_amount) as average_target_amount FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON p.investor_id = g.investor_id GROUP BY p.risk_tolerance ORDER BY average_target_amount DESC LIMIT 1;

-- QUERY 589 — Out of all options, which risk profile group has the highest average investment goal target amount
-- query_id=200589 | userid=42 | start=2026-04-07 19:08:46 | end=2026-04-07 19:08:47 | dur=1424ms | rows=1
SELECT p.risk_tolerance, AVG(g.target_amount) as average_target_amount FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON p.investor_id = g.investor_id GROUP BY p.risk_tolerance ORDER BY average_target_amount DESC LIMIT 1;

-- QUERY 590 — Given all the data available, which risk profile group has the highest average investment goal target amount
-- query_id=200590 | userid=68 | start=2026-04-08 08:32:27 | end=2026-04-08 08:32:28 | dur=1688ms | rows=1
SELECT p.risk_tolerance, AVG(g.target_amount) as average_target_amount FROM ATOM_ENTITY_INVESTOR_PROFILE_001 p JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 g ON p.investor_id = g.investor_id GROUP BY p.risk_tolerance ORDER BY average_target_amount DESC LIMIT 1;

-- QUERY 591 — Which risk profile group has the lowest average investment goal target amount
-- query_id=200591 | userid=30 | start=2026-04-08 10:31:59 | end=2026-04-08 10:32:00 | dur=1447ms | rows=1
SELECT t1.risk_tolerance, AVG(t2.target_amount) as average_target_amount FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id GROUP BY t1.risk_tolerance ORDER BY average_target_amount ASC LIMIT 1;

-- QUERY 592 — Identify the risk profile group has the lowest average investment goal target amount
-- query_id=200592 | userid=23 | start=2026-04-08 11:31:21 | end=2026-04-08 11:31:22 | dur=1440ms | rows=1
SELECT t1.risk_tolerance, AVG(t2.target_amount) as average_target_amount FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id GROUP BY t1.risk_tolerance ORDER BY average_target_amount ASC LIMIT 1;

-- QUERY 593 — Do you know which risk profile group has the lowest average investment goal target amount
-- query_id=200593 | userid=74 | start=2026-04-08 12:50:47 | end=2026-04-08 12:50:48 | dur=1615ms | rows=1
SELECT t1.risk_tolerance, AVG(t2.target_amount) as average_target_amount FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id GROUP BY t1.risk_tolerance ORDER BY average_target_amount ASC LIMIT 1;

-- QUERY 594 — Out of all options, which risk profile group has the lowest average investment goal target amount
-- query_id=200594 | userid=95 | start=2026-04-08 15:27:09 | end=2026-04-08 15:27:10 | dur=1175ms | rows=1
SELECT t1.risk_tolerance, AVG(t2.target_amount) as average_target_amount FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id WHERE target_amount IS NOT NULL GROUP BY t1.risk_tolerance ORDER BY average_target_amount ASC LIMIT 1;

-- QUERY 595 — Given all the data available, which risk profile group has the lowest average investment goal target amount
-- query_id=200595 | userid=81 | start=2026-04-08 15:42:54 | end=2026-04-08 15:42:55 | dur=1351ms | rows=1
SELECT t1.risk_tolerance, AVG(t2.target_amount) as average_target_amount FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id GROUP BY t1.risk_tolerance ORDER BY average_target_amount ASC LIMIT 1;

-- QUERY 596 — What is the average investment goal target amount for Aggressive risk profile investors
-- query_id=200596 | userid=30 | start=2026-04-09 11:06:26 | end=2026-04-09 11:06:27 | dur=1093ms | rows=1
SELECT AVG(t2.target_amount) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Aggressive';

-- QUERY 597 — Please provide the average investment goal target amount for Aggressive risk profile investors
-- query_id=200597 | userid=55 | start=2026-04-09 11:21:43 | end=2026-04-09 11:21:43 | dur=398ms | rows=1
SELECT AVG(t2.target_amount) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Aggressive';

-- QUERY 598 — Can you tell me what the average investment goal target amount for Aggressive risk profile investors
-- query_id=200598 | userid=18 | start=2026-04-09 12:19:06 | end=2026-04-09 12:19:06 | dur=858ms | rows=1
SELECT AVG(t2.target_amount) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Aggressive';

-- QUERY 599 — What would be the average investment goal target amount for Aggressive risk profile investors
-- query_id=200599 | userid=81 | start=2026-04-09 12:21:40 | end=2026-04-09 12:21:40 | dur=778ms | rows=1
SELECT AVG(t2.target_amount) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Aggressive';

-- QUERY 600 — Looking at all available records, what is the average investment goal target amount for Aggressive risk profile investor
-- query_id=200600 | userid=18 | start=2026-04-09 12:42:49 | end=2026-04-09 12:42:50 | dur=1090ms | rows=1
SELECT AVG(t2.target_amount) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Aggressive';

-- QUERY 601 — Which market scenario triggered the most scenario-based rebalancing events
-- query_id=200601 | userid=12 | start=2026-04-09 13:41:33 | end=2026-04-09 13:41:34 | dur=1753ms | rows=25
WITH ScenarioCounts AS (
    SELECT 
        scenario, 
        COUNT(*) AS event_count
    FROM ATOM_EVENT_SCENARIO_REBALANCING_001
    GROUP BY scenario
)
SELECT 
    scenario, 
    event_count
FROM ScenarioCounts
WHERE event_count = (SELECT MAX(event_count) FROM ScenarioCounts);

-- QUERY 602 — Identify the market scenario triggered the most scenario-based rebalancing events
-- query_id=200602 | userid=55 | start=2026-04-09 13:52:49 | end=2026-04-09 13:52:51 | dur=2039ms | rows=7
WITH ScenarioCounts AS (
    SELECT 
        scenario, 
        COUNT(*) AS event_count
    FROM ATOM_EVENT_SCENARIO_REBALANCING_001
    GROUP BY scenario
)
SELECT 
    scenario, 
    event_count
FROM ScenarioCounts
WHERE event_count = (SELECT MAX(event_count) FROM ScenarioCounts);

-- QUERY 603 — Do you know which market scenario triggered the most scenario-based rebalancing events
-- query_id=200603 | userid=12 | start=2026-04-09 13:58:05 | end=2026-04-09 13:58:07 | dur=2215ms | rows=7
WITH ScenarioCounts AS (
    SELECT 
        scenario, 
        COUNT(*) AS event_count
    FROM ATOM_EVENT_SCENARIO_REBALANCING_001
    GROUP BY scenario
)
SELECT 
    scenario, 
    event_count
FROM ScenarioCounts
WHERE event_count = (SELECT MAX(event_count) FROM ScenarioCounts);

-- QUERY 604 — Out of all options, which market scenario triggered the most scenario-based rebalancing events
-- query_id=200604 | userid=95 | start=2026-04-09 14:00:19 | end=2026-04-09 14:00:20 | dur=1585ms | rows=17
WITH ScenarioCounts AS (
    SELECT 
        scenario, 
        COUNT(*) AS event_count
    FROM ATOM_EVENT_SCENARIO_REBALANCING_001
    GROUP BY scenario
)
SELECT 
    scenario, 
    event_count
FROM ScenarioCounts
WHERE event_count = (SELECT MAX(event_count) FROM ScenarioCounts);

-- QUERY 605 — Given all the data available, which market scenario triggered the most scenario-based rebalancing events
-- query_id=200605 | userid=18 | start=2026-04-09 14:13:44 | end=2026-04-09 14:13:45 | dur=1074ms | rows=1
SELECT scenario, COUNT(*) as rebalance_event_count FROM ATOM_EVENT_SCENARIO_REBALANCING_001 GROUP BY scenario ORDER BY rebalance_event_count DESC, scenario ASC LIMIT 1;

-- QUERY 606 — Which market scenario triggered the fewest scenario-based rebalancing events
-- query_id=200606 | userid=42 | start=2026-04-09 14:39:08 | end=2026-04-09 14:39:08 | dur=923ms | rows=1
SELECT scenario, COUNT(*) as rebalance_event_count FROM ATOM_EVENT_SCENARIO_REBALANCING_001 GROUP BY scenario ORDER BY rebalance_event_count ASC, scenario ASC LIMIT 1;

-- QUERY 607 — Identify the market scenario triggered the fewest scenario-based rebalancing events
-- query_id=200607 | userid=74 | start=2026-04-09 16:34:27 | end=2026-04-09 16:34:28 | dur=1840ms | rows=3
WITH ScenarioCounts AS (
    SELECT 
        scenario, 
        COUNT(*) AS event_count
    FROM ATOM_EVENT_SCENARIO_REBALANCING_001
    GROUP BY scenario
)
SELECT 
    scenario, 
    event_count
FROM ScenarioCounts
WHERE event_count = (SELECT MAX(event_count) FROM ScenarioCounts);

-- QUERY 608 — Do you know which market scenario triggered the fewest scenario-based rebalancing events
-- query_id=200608 | userid=55 | start=2026-04-09 17:43:41 | end=2026-04-09 17:43:43 | dur=2070ms | rows=26
WITH ScenarioCounts AS (
    SELECT 
        scenario, 
        COUNT(*) AS event_count
    FROM ATOM_EVENT_SCENARIO_REBALANCING_001
    GROUP BY scenario
)
SELECT 
    scenario, 
    event_count
FROM ScenarioCounts
WHERE event_count = (SELECT MAX(event_count) FROM ScenarioCounts);

-- QUERY 609 — Out of all options, which market scenario triggered the fewest scenario-based rebalancing events
-- query_id=200609 | userid=68 | start=2026-04-09 19:30:55 | end=2026-04-09 19:30:56 | dur=1313ms | rows=3
WITH ScenarioCounts AS (
    SELECT 
        scenario, 
        COUNT(*) AS event_count
    FROM ATOM_EVENT_SCENARIO_REBALANCING_001
    GROUP BY scenario
)
SELECT 
    scenario, 
    event_count
FROM ScenarioCounts
WHERE event_count = (SELECT MAX(event_count) FROM ScenarioCounts);

-- QUERY 610 — Given all the data available, which market scenario triggered the fewest scenario-based rebalancing events
-- query_id=200610 | userid=42 | start=2026-04-10 07:24:15 | end=2026-04-10 07:24:16 | dur=1413ms | rows=11
WITH ScenarioCounts AS (
    SELECT 
        scenario, 
        COUNT(*) AS event_count
    FROM ATOM_EVENT_SCENARIO_REBALANCING_001
    GROUP BY scenario
)
SELECT 
    scenario, 
    event_count
FROM ScenarioCounts
WHERE event_count = (SELECT MAX(event_count) FROM ScenarioCounts);

-- QUERY 611 — How many rebalancing events were triggered by the Bull Market scenario
-- query_id=200611 | userid=74 | start=2026-04-10 11:42:24 | end=2026-04-10 11:42:24 | dur=780ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE scenario = 'Bull Market';

-- QUERY 612 — Provide the count of rebalancing events were triggered by the Bull Market scenario
-- query_id=200612 | userid=23 | start=2026-04-10 15:09:14 | end=2026-04-10 15:09:14 | dur=559ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE scenario = 'Bull Market';

-- QUERY 613 — I need to find out how many rebalancing events were triggered by the Bull Market scenario
-- query_id=200613 | userid=55 | start=2026-04-10 15:51:44 | end=2026-04-10 15:51:44 | dur=688ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE scenario = 'Bull Market';

-- QUERY 614 — What is the total count of rebalancing events were triggered by the Bull Market scenario
-- query_id=200614 | userid=68 | start=2026-04-10 16:23:49 | end=2026-04-10 16:23:49 | dur=497ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE scenario = 'Bull Market';

-- QUERY 615 — Across the entire investor database, how many rebalancing events were triggered by the Bull Market scenario
-- query_id=200615 | userid=18 | start=2026-04-13 07:41:27 | end=2026-04-13 07:41:27 | dur=503ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE scenario = 'Bull Market';

-- QUERY 616 — How many rebalancing events were triggered by the Market Volatility scenario
-- query_id=200616 | userid=81 | start=2026-04-13 10:08:26 | end=2026-04-13 10:08:26 | dur=404ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE scenario = 'Market Volatility';

-- QUERY 617 — Provide the count of rebalancing events were triggered by the Market Volatility scenario
-- query_id=200617 | userid=12 | start=2026-04-13 11:08:17 | end=2026-04-13 11:08:17 | dur=744ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE scenario = 'Market Volatility';

-- QUERY 618 — I need to find out how many rebalancing events were triggered by the Market Volatility scenario
-- query_id=200618 | userid=42 | start=2026-04-13 11:35:36 | end=2026-04-13 11:35:36 | dur=422ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE scenario = 'Market Volatility';

-- QUERY 619 — What is the total count of rebalancing events were triggered by the Market Volatility scenario
-- query_id=200619 | userid=95 | start=2026-04-13 17:02:32 | end=2026-04-13 17:02:32 | dur=823ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE scenario = 'Market Volatility';

-- QUERY 620 — Across the entire investor database, how many rebalancing events were triggered by the Market Volatility scenario
-- query_id=200620 | userid=95 | start=2026-04-13 17:51:05 | end=2026-04-13 17:51:05 | dur=431ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE scenario = 'Market Volatility';

-- QUERY 621 — How many records show investors with a Retirement Planning goal shortfall exceeding 1,000,000
-- query_id=200621 | userid=18 | start=2026-04-13 19:27:42 | end=2026-04-13 19:27:42 | dur=417ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTMENT_GOAL_001 WHERE investment_goal = 'Retirement Planning' AND shortfall > 1000000;

-- QUERY 622 — Provide the count of records show investors with a Retirement Planning goal shortfall exceeding 1,000,000
-- query_id=200622 | userid=68 | start=2026-04-14 10:00:49 | end=2026-04-14 10:00:49 | dur=826ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTMENT_GOAL_001 WHERE investment_goal = 'Retirement Planning' AND shortfall > 1000000;

-- QUERY 623 — I need to find out how many records show investors with a Retirement Planning goal shortfall exceeding 1,000,000
-- query_id=200623 | userid=18 | start=2026-04-14 10:35:26 | end=2026-04-14 10:35:26 | dur=490ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTMENT_GOAL_001 WHERE investment_goal = 'Retirement Planning' AND shortfall > 1000000;

-- QUERY 624 — What is the total count of records show investors with a Retirement Planning goal shortfall exceeding 1,000,000
-- query_id=200624 | userid=23 | start=2026-04-14 10:46:22 | end=2026-04-14 10:46:22 | dur=832ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTMENT_GOAL_001 WHERE investment_goal = 'Retirement Planning' AND shortfall > 1000000;

-- QUERY 625 — Across the entire investor database, how many records show investors with a Retirement Planning goal shortfall exceeding
-- query_id=200625 | userid=68 | start=2026-04-14 14:51:36 | end=2026-04-14 14:51:36 | dur=437ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTMENT_GOAL_001 WHERE investment_goal = 'Retirement Planning' AND shortfall > 1000000;

-- QUERY 626 — How many Moderate risk profile investors have total Financial Services sector investment exceeding 500,000
-- query_id=200626 | userid=18 | start=2026-04-14 16:40:20 | end=2026-04-14 16:40:21 | dur=1360ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Moderate' AND t2.sector = 'Financial Services' AND t2.total_investment > 500000;

-- QUERY 627 — Provide the count of Moderate risk profile investors have total Financial Services sector investment exceeding 500,000
-- query_id=200627 | userid=18 | start=2026-04-14 17:11:47 | end=2026-04-14 17:11:48 | dur=1439ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Moderate' AND t2.sector = 'Financial Services' AND t2.total_investment > 500000;

-- QUERY 628 — I need to find out how many Moderate risk profile investors have total Financial Services sector investment exceeding 50
-- query_id=200628 | userid=12 | start=2026-04-14 17:14:59 | end=2026-04-14 17:15:00 | dur=1335ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Moderate' AND t2.sector = 'Financial Services' AND t2.total_investment > 500000;

-- QUERY 629 — What is the total count of Moderate risk profile investors have total Financial Services sector investment exceeding 500
-- query_id=200629 | userid=95 | start=2026-04-14 17:16:20 | end=2026-04-14 17:16:20 | dur=642ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Moderate' AND t2.sector = 'Financial Services' AND t2.total_investment > 500000;

-- QUERY 630 — Across the entire investor database, how many Moderate risk profile investors have total Financial Services sector inves
-- query_id=200630 | userid=18 | start=2026-04-15 09:08:55 | end=2026-04-15 09:08:56 | dur=1064ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Moderate' AND t2.sector = 'Financial Services' AND t2.total_investment > 500000;

-- QUERY 631 — Which Moderate risk investor has the highest investment in the Financial Services sector
-- query_id=200631 | userid=95 | start=2026-04-15 09:33:28 | end=2026-04-15 09:33:28 | dur=842ms | rows=1
SELECT t1.investor_id FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Moderate' AND t2.sector = 'Financial Services' ORDER BY t2.total_investment DESC LIMIT 1;

-- QUERY 632 — Identify the Moderate risk investor has the highest investment in the Financial Services sector
-- query_id=200632 | userid=18 | start=2026-04-15 12:04:03 | end=2026-04-15 12:04:03 | dur=857ms | rows=1
SELECT t1.investor_id FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Moderate' AND t2.sector = 'Financial Services' ORDER BY t2.total_investment DESC LIMIT 1;

-- QUERY 633 — Do you know which Moderate risk investor has the highest investment in the Financial Services sector
-- query_id=200633 | userid=42 | start=2026-04-15 12:17:22 | end=2026-04-15 12:17:23 | dur=1249ms | rows=1
SELECT t1.investor_id FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Moderate' AND t2.sector = 'Financial Services' ORDER BY t2.total_investment DESC LIMIT 1;

-- QUERY 634 — Out of all options, which Moderate risk investor has the highest investment in the Financial Services sector
-- query_id=200634 | userid=18 | start=2026-04-15 13:22:05 | end=2026-04-15 13:22:06 | dur=1711ms | rows=1
SELECT t1.investor_id FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Moderate' AND t2.sector = 'Financial Services' ORDER BY t2.total_investment DESC LIMIT 1;

-- QUERY 635 — Given all the data available, which Moderate risk investor has the highest investment in the Financial Services sector
-- query_id=200635 | userid=30 | start=2026-04-15 13:58:02 | end=2026-04-15 13:58:02 | dur=695ms | rows=1
SELECT t1.investor_id FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_SECTOR_ALLOCATION_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Moderate' AND t2.sector = 'Financial Services' ORDER BY t2.total_investment DESC LIMIT 1;

-- QUERY 636 — How many investors affected by the Interest Rate Hike scenario have an At Risk portfolio health status
-- query_id=200636 | userid=42 | start=2026-04-15 15:48:58 | end=2026-04-15 15:48:59 | dur=1264ms | rows=1
SELECT COUNT(DISTINCT t1.investor_id) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.scenario = 'Interest Rate Hike' AND ((t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) >= 40 AND (t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) < 60);

-- QUERY 637 — Provide the count of investors affected by the Interest Rate Hike scenario have an At Risk portfolio health status
-- query_id=200637 | userid=12 | start=2026-04-15 17:00:44 | end=2026-04-15 17:00:44 | dur=962ms | rows=1
SELECT COUNT(DISTINCT t1.investor_id) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.scenario = 'Interest Rate Hike' AND ((t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) >= 40 AND (t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) < 60);

-- QUERY 638 — I need to find out how many investors affected by the Interest Rate Hike scenario have an At Risk portfolio health statu
-- query_id=200638 | userid=81 | start=2026-04-15 17:18:06 | end=2026-04-15 17:18:07 | dur=1450ms | rows=1
SELECT COUNT(DISTINCT t1.investor_id) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.scenario = 'Interest Rate Hike' AND ((t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) >= 40 AND (t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) < 60);

-- QUERY 639 — What is the total count of investors affected by the Interest Rate Hike scenario have an At Risk portfolio health status
-- query_id=200639 | userid=95 | start=2026-04-15 17:41:18 | end=2026-04-15 17:41:19 | dur=1043ms | rows=1
SELECT COUNT(DISTINCT t1.investor_id) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.scenario = 'Interest Rate Hike' AND ((t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) >= 40 AND (t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) < 60);

-- QUERY 640 — Across the entire investor database, how many investors affected by the Interest Rate Hike scenario have an At Risk port
-- query_id=200640 | userid=95 | start=2026-04-15 17:49:20 | end=2026-04-15 17:49:20 | dur=747ms | rows=1
SELECT COUNT(DISTINCT t1.investor_id) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.scenario = 'Interest Rate Hike' AND ((t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) >= 40 AND (t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) < 60);

-- QUERY 641 — How many investors affected by the Interest Rate Hike scenario have a Moderate portfolio health status
-- query_id=200641 | userid=12 | start=2026-04-15 17:52:29 | end=2026-04-15 17:52:30 | dur=1367ms | rows=1
SELECT COUNT(DISTINCT t1.investor_id) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.scenario = 'Interest Rate Hike' AND ((t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) >= 60 AND (t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) < 80);

-- QUERY 642 — Provide the count of investors affected by the Interest Rate Hike scenario have a Moderate portfolio health status
-- query_id=200642 | userid=18 | start=2026-04-15 19:30:50 | end=2026-04-15 19:30:51 | dur=1023ms | rows=1
SELECT COUNT(DISTINCT t1.investor_id) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.scenario = 'Interest Rate Hike' AND ((t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) >= 60 AND (t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) < 80);

-- QUERY 643 — I need to find out how many investors affected by the Interest Rate Hike scenario have a Moderate portfolio health statu
-- query_id=200643 | userid=30 | start=2026-04-16 08:40:09 | end=2026-04-16 08:40:10 | dur=1143ms | rows=1
SELECT COUNT(DISTINCT t1.investor_id) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.scenario = 'Interest Rate Hike' AND ((t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) >= 60 AND (t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) < 80);

-- QUERY 644 — What is the total count of investors affected by the Interest Rate Hike scenario have a Moderate portfolio health status
-- query_id=200644 | userid=81 | start=2026-04-16 08:45:04 | end=2026-04-16 08:45:05 | dur=1019ms | rows=1
SELECT COUNT(DISTINCT t1.investor_id) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.scenario = 'Interest Rate Hike' AND ((t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) >= 60 AND (t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) < 80);

-- QUERY 645 — Across the entire investor database, how many investors affected by the Interest Rate Hike scenario have a Moderate port
-- query_id=200645 | userid=12 | start=2026-04-16 10:42:23 | end=2026-04-16 10:42:23 | dur=963ms | rows=1
SELECT COUNT(DISTINCT t1.investor_id) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.scenario = 'Interest Rate Hike' AND ((t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) >= 60 AND (t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) < 80);

-- QUERY 646 — How many investors have a portfolio diversification score below 50
-- query_id=200646 | userid=55 | start=2026-04-16 11:34:45 | end=2026-04-16 11:34:45 | dur=580ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 WHERE diversification_score < 50;

-- QUERY 647 — Provide the count of investors have a portfolio diversification score below 50
-- query_id=200647 | userid=23 | start=2026-04-16 12:34:03 | end=2026-04-16 12:34:03 | dur=421ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 WHERE diversification_score < 50;

-- QUERY 648 — I need to find out how many investors have a portfolio diversification score below 50
-- query_id=200648 | userid=12 | start=2026-04-16 15:36:20 | end=2026-04-16 15:36:20 | dur=473ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 WHERE diversification_score < 50;

-- QUERY 649 — What is the total count of investors have a portfolio diversification score below 50
-- query_id=200649 | userid=74 | start=2026-04-16 17:23:41 | end=2026-04-16 17:23:41 | dur=688ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 WHERE diversification_score < 50;

-- QUERY 650 — Across the entire investor database, how many investors have a portfolio diversification score below 50
-- query_id=200650 | userid=23 | start=2026-04-16 17:50:40 | end=2026-04-16 17:50:40 | dur=765ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 WHERE diversification_score < 50;

-- QUERY 651 — How many Aggressive risk profile investors have a portfolio diversification score below 50
-- query_id=200651 | userid=18 | start=2026-04-16 19:36:40 | end=2026-04-16 19:36:41 | dur=1351ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Aggressive' AND t2.diversification_score < 50;

-- QUERY 652 — Provide the count of Aggressive risk profile investors have a portfolio diversification score below 50
-- query_id=200652 | userid=81 | start=2026-04-17 09:16:06 | end=2026-04-17 09:16:07 | dur=1248ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Aggressive' AND t2.diversification_score < 50;

-- QUERY 653 — I need to find out how many Aggressive risk profile investors have a portfolio diversification score below 50
-- query_id=200653 | userid=30 | start=2026-04-17 09:34:20 | end=2026-04-17 09:34:21 | dur=1297ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Aggressive' AND t2.diversification_score < 50;

-- QUERY 654 — What is the total count of Aggressive risk profile investors have a portfolio diversification score below 50
-- query_id=200654 | userid=74 | start=2026-04-17 11:31:34 | end=2026-04-17 11:31:35 | dur=1126ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Aggressive' AND t2.diversification_score < 50;

-- QUERY 655 — Across the entire investor database, how many Aggressive risk profile investors have a portfolio diversification score b
-- query_id=200655 | userid=55 | start=2026-04-17 13:36:47 | end=2026-04-17 13:36:47 | dur=838ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Aggressive' AND t2.diversification_score < 50;

-- QUERY 656 — How many Conservative risk profile investors have a portfolio diversification score below 50
-- query_id=200656 | userid=81 | start=2026-04-17 15:32:56 | end=2026-04-17 15:32:56 | dur=756ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Conservative' AND t2.diversification_score < 50;

-- QUERY 657 — Provide the count of Conservative risk profile investors have a portfolio diversification score below 50
-- query_id=200657 | userid=18 | start=2026-04-17 18:16:13 | end=2026-04-17 18:16:13 | dur=915ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Conservative' AND t2.diversification_score < 50;

-- QUERY 658 — I need to find out how many Conservative risk profile investors have a portfolio diversification score below 50
-- query_id=200658 | userid=55 | start=2026-04-17 19:38:09 | end=2026-04-17 19:38:10 | dur=1227ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Conservative' AND t2.diversification_score < 50;

-- QUERY 659 — What is the total count of Conservative risk profile investors have a portfolio diversification score below 50
-- query_id=200659 | userid=68 | start=2026-04-20 07:01:21 | end=2026-04-20 07:01:22 | dur=1107ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Conservative' AND t2.diversification_score < 50;

-- QUERY 660 — Across the entire investor database, how many Conservative risk profile investors have a portfolio diversification score
-- query_id=200660 | userid=68 | start=2026-04-20 07:44:25 | end=2026-04-20 07:44:25 | dur=762ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Conservative' AND t2.diversification_score < 50;

-- QUERY 661 — How many investors have more than 40% of their portfolio allocated to the Technology sector
-- query_id=200661 | userid=55 | start=2026-04-20 11:11:51 | end=2026-04-20 11:11:51 | dur=463ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 WHERE sector = 'Technology' AND allocation_pct > 40;

-- QUERY 662 — Provide the count of investors have more than 40% of their portfolio allocated to the Technology sector
-- query_id=200662 | userid=95 | start=2026-04-20 12:17:19 | end=2026-04-20 12:17:19 | dur=470ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 WHERE sector = 'Technology' AND allocation_pct > 40;

-- QUERY 663 — I need to find out how many investors have more than 40% of their portfolio allocated to the Technology sector
-- query_id=200663 | userid=68 | start=2026-04-20 14:15:26 | end=2026-04-20 14:15:26 | dur=589ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 WHERE sector = 'Technology' AND allocation_pct > 40;

-- QUERY 664 — What is the total count of investors have more than 40% of their portfolio allocated to the Technology sector
-- query_id=200664 | userid=95 | start=2026-04-20 14:43:20 | end=2026-04-20 14:43:21 | dur=1007ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 WHERE sector = 'Technology' AND allocation_pct > 40;

-- QUERY 665 — Across the entire investor database, how many investors have more than 40% of their portfolio allocated to the Technolog
-- query_id=200665 | userid=68 | start=2026-04-20 15:07:26 | end=2026-04-20 15:07:26 | dur=809ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 WHERE sector = 'Technology' AND allocation_pct > 40;

-- QUERY 666 — Which investor has the longest average holding duration across all investors
-- query_id=200666 | userid=30 | start=2026-04-20 18:08:54 | end=2026-04-20 18:08:55 | dur=1182ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id ORDER BY AVG(julianday('now') - julianday(purchase_date)) DESC LIMIT 1;

-- QUERY 667 — Identify the investor who has the longest average holding duration across all investors
-- query_id=200667 | userid=12 | start=2026-04-21 10:00:19 | end=2026-04-21 10:00:19 | dur=874ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id ORDER BY AVG(julianday('now') - julianday(purchase_date)) DESC LIMIT 1;

-- QUERY 668 — I want to know which investor has the longest average holding duration across all investors
-- query_id=200668 | userid=18 | start=2026-04-21 12:13:21 | end=2026-04-21 12:13:22 | dur=1057ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id ORDER BY AVG(julianday('now') - julianday(purchase_date)) DESC LIMIT 1;

-- QUERY 669 — Among all investors, who has the longest average holding duration across all investors
-- query_id=200669 | userid=68 | start=2026-04-21 12:41:49 | end=2026-04-21 12:41:50 | dur=1310ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id ORDER BY AVG(julianday('now') - julianday(purchase_date)) DESC LIMIT 1;

-- QUERY 670 — Considering all investors in the system, which investor has the longest average holding duration across all investors
-- query_id=200670 | userid=42 | start=2026-04-21 14:52:47 | end=2026-04-21 14:52:47 | dur=956ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id ORDER BY AVG(julianday('now') - julianday(purchase_date)) DESC LIMIT 1;

-- QUERY 671 — Which investor has the shortest average holding duration across all investors
-- query_id=200671 | userid=74 | start=2026-04-21 15:41:30 | end=2026-04-21 15:41:31 | dur=1194ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id ORDER BY AVG(julianday('now') - julianday(purchase_date)) ASC LIMIT 1;

-- QUERY 672 — Identify the investor who has the shortest average holding duration across all investors
-- query_id=200672 | userid=74 | start=2026-04-21 18:20:49 | end=2026-04-21 18:20:50 | dur=1108ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id ORDER BY AVG(julianday('now') - julianday(purchase_date)) ASC LIMIT 1;

-- QUERY 673 — I want to know which investor has the shortest average holding duration across all investors
-- query_id=200673 | userid=55 | start=2026-04-21 19:29:08 | end=2026-04-21 19:29:09 | dur=1347ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id ORDER BY AVG(julianday('now') - julianday(purchase_date)) ASC LIMIT 1;

-- QUERY 674 — Among all investors, who has the shortest average holding duration across all investors
-- query_id=200674 | userid=30 | start=2026-04-22 08:14:10 | end=2026-04-22 08:14:11 | dur=1263ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id ORDER BY AVG(julianday('now') - julianday(purchase_date)) ASC LIMIT 1;

-- QUERY 675 — Considering all investors in the system, which investor has the shortest average holding duration across all investors
-- query_id=200675 | userid=12 | start=2026-04-22 10:40:09 | end=2026-04-22 10:40:09 | dur=969ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id ORDER BY AVG(julianday('now') - julianday(purchase_date)) ASC LIMIT 1;

-- QUERY 676 — What is the average holding duration in days for investor INV-012
-- query_id=200676 | userid=55 | start=2026-04-22 11:19:59 | end=2026-04-22 11:19:59 | dur=702ms | rows=1
SELECT AVG(julianday('now') - julianday(purchase_date)) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-012';

-- QUERY 677 — Please provide the average holding duration in days for investor INV-012
-- query_id=200677 | userid=30 | start=2026-04-22 11:29:59 | end=2026-04-22 11:29:59 | dur=608ms | rows=1
SELECT AVG(julianday('now') - julianday(purchase_date)) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-012';

-- QUERY 678 — Can you tell me what the average holding duration in days for investor INV-012
-- query_id=200678 | userid=30 | start=2026-04-22 14:49:03 | end=2026-04-22 14:49:03 | dur=712ms | rows=1
SELECT AVG(julianday('now') - julianday(purchase_date)) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-012';

-- QUERY 679 — What would be the average holding duration in days for investor INV-012
-- query_id=200679 | userid=81 | start=2026-04-22 15:54:55 | end=2026-04-22 15:54:55 | dur=616ms | rows=1
SELECT AVG(julianday('now') - julianday(purchase_date)) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-012';

-- QUERY 680 — Looking at all available records, what is the average holding duration in days for investor INV-012
-- query_id=200680 | userid=18 | start=2026-04-22 16:37:19 | end=2026-04-22 16:37:19 | dur=659ms | rows=1
SELECT AVG(julianday('now') - julianday(purchase_date)) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-012';

-- QUERY 681 — How many investors have fewer than 12 months remaining to reach any active investment goal
-- query_id=200681 | userid=74 | start=2026-04-22 18:49:15 | end=2026-04-22 18:49:15 | dur=780ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_ENTITY_INVESTMENT_GOAL_001 WHERE time_to_goal_months < 12;

-- QUERY 682 — Provide the count of investors have fewer than 12 months remaining to reach any active investment goal
-- query_id=200682 | userid=18 | start=2026-04-22 18:54:41 | end=2026-04-22 18:54:41 | dur=511ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_ENTITY_INVESTMENT_GOAL_001 WHERE time_to_goal_months < 12;

-- QUERY 683 — I need to find out how many investors have fewer than 12 months remaining to reach any active investment goal
-- query_id=200683 | userid=42 | start=2026-04-22 19:13:55 | end=2026-04-22 19:13:55 | dur=487ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_ENTITY_INVESTMENT_GOAL_001 WHERE time_to_goal_months < 12;

-- QUERY 684 — What is the total count of investors have fewer than 12 months remaining to reach any active investment goal
-- query_id=200684 | userid=68 | start=2026-04-22 19:24:26 | end=2026-04-22 19:24:26 | dur=881ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_ENTITY_INVESTMENT_GOAL_001 WHERE time_to_goal_months < 12;

-- QUERY 685 — Across the entire investor database, how many investors have fewer than 12 months remaining to reach any active investme
-- query_id=200685 | userid=68 | start=2026-04-23 08:51:58 | end=2026-04-23 08:51:58 | dur=741ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_ENTITY_INVESTMENT_GOAL_001 WHERE time_to_goal_months < 12;

-- QUERY 686 — What is the risk profile of the investor with fewer than 12 months remaining to reach any active goal
-- query_id=200686 | userid=81 | start=2026-04-23 09:57:30 | end=2026-04-23 09:57:31 | dur=1154ms | rows=308
SELECT DISTINCT t1.risk_tolerance FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id WHERE t2.time_to_goal_months < 12;

-- QUERY 687 — Please provide the risk profile of the investor with fewer than 12 months remaining to reach any active goal
-- query_id=200687 | userid=81 | start=2026-04-23 11:10:32 | end=2026-04-23 11:10:33 | dur=1408ms | rows=409
SELECT DISTINCT t1.risk_tolerance FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id WHERE t2.time_to_goal_months < 12;

-- QUERY 688 — Can you tell me what the risk profile of the investor with fewer than 12 months remaining to reach any active goal
-- query_id=200688 | userid=42 | start=2026-04-23 12:31:01 | end=2026-04-23 12:31:01 | dur=859ms | rows=185
SELECT DISTINCT t1.risk_tolerance FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id WHERE t2.time_to_goal_months < 12;

-- QUERY 689 — What would be the risk profile of the investor with fewer than 12 months remaining to reach any active goal
-- query_id=200689 | userid=42 | start=2026-04-23 13:00:34 | end=2026-04-23 13:00:34 | dur=938ms | rows=367
SELECT DISTINCT t1.risk_tolerance FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id WHERE t2.time_to_goal_months < 12;

-- QUERY 690 — Looking at all available records, what is the risk profile of the investor with fewer than 12 months remaining to reach 
-- query_id=200690 | userid=23 | start=2026-04-23 14:38:19 | end=2026-04-23 14:38:19 | dur=834ms | rows=230
SELECT DISTINCT t1.risk_tolerance FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id WHERE t2.time_to_goal_months < 12;

-- QUERY 691 — How many investors with an Aggressive risk profile currently have a Healthy portfolio condition
-- query_id=200691 | userid=42 | start=2026-04-23 14:55:29 | end=2026-04-23 14:55:29 | dur=866ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Aggressive' AND (t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) >= 80;

-- QUERY 692 — Provide the count of investors with an Aggressive risk profile currently have a Healthy portfolio condition
-- query_id=200692 | userid=55 | start=2026-04-23 16:31:51 | end=2026-04-23 16:31:52 | dur=1204ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Aggressive' AND (t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) >= 80;

-- QUERY 693 — I need to find out how many investors with an Aggressive risk profile currently have a Healthy portfolio condition
-- query_id=200693 | userid=12 | start=2026-04-23 17:44:39 | end=2026-04-23 17:44:40 | dur=1284ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Aggressive' AND (t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) >= 80;

-- QUERY 694 — What is the total count of investors with an Aggressive risk profile currently have a Healthy portfolio condition
-- query_id=200694 | userid=81 | start=2026-04-24 07:27:37 | end=2026-04-24 07:27:38 | dur=1153ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Aggressive' AND (t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) >= 80;

-- QUERY 695 — Across the entire investor database, how many investors with an Aggressive risk profile currently have a Healthy portfol
-- query_id=200695 | userid=95 | start=2026-04-24 08:06:36 | end=2026-04-24 08:06:36 | dur=917ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 ON t1.investor_id = t2.investor_id WHERE t1.risk_tolerance = 'Aggressive' AND (t2.goal_match_pct * 0.3 + t2.risk_score * 0.3 + t2.liquidity_score * 0.2 + t2.diversification_score * 0.2) >= 80;

-- QUERY 696 — What is the total current market value of Large Cap segment holdings for Wealth Preservation objective investors
-- query_id=200696 | userid=12 | start=2026-04-24 10:00:26 | end=2026-04-24 10:00:26 | dur=788ms | rows=1
SELECT SUM(t2.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 t2 JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t1 ON t2.investor_id = t1.investor_id WHERE t2.segment = 'Large Cap' AND t1.investment_goal = 'Wealth Preservation';

-- QUERY 697 — Please provide the total current market value of Large Cap segment holdings for Wealth Preservation objective investors
-- query_id=200697 | userid=95 | start=2026-04-24 10:27:53 | end=2026-04-24 10:27:54 | dur=1014ms | rows=1
SELECT SUM(t2.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 t2 JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t1 ON t2.investor_id = t1.investor_id WHERE t2.segment = 'Large Cap' AND t1.investment_goal = 'Wealth Preservation';

-- QUERY 698 — Can you tell me what the total current market value of Large Cap segment holdings for Wealth Preservation objective inve
-- query_id=200698 | userid=81 | start=2026-04-24 12:14:50 | end=2026-04-24 12:14:50 | dur=998ms | rows=1
SELECT SUM(t2.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 t2 JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t1 ON t2.investor_id = t1.investor_id WHERE t2.segment = 'Large Cap' AND t1.investment_goal = 'Wealth Preservation';

-- QUERY 699 — What would be the total current market value of Large Cap segment holdings for Wealth Preservation objective investors
-- query_id=200699 | userid=18 | start=2026-04-24 12:22:05 | end=2026-04-24 12:22:06 | dur=1152ms | rows=1
SELECT SUM(t2.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 t2 JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t1 ON t2.investor_id = t1.investor_id WHERE t2.segment = 'Large Cap' AND t1.investment_goal = 'Wealth Preservation';

-- QUERY 700 — Looking at all available records, what is the total current market value of Large Cap segment holdings for Wealth Preser
-- query_id=200700 | userid=95 | start=2026-04-24 15:50:01 | end=2026-04-24 15:50:01 | dur=962ms | rows=1
SELECT SUM(t2.current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 t2 JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t1 ON t2.investor_id = t1.investor_id WHERE t2.segment = 'Large Cap' AND t1.investment_goal = 'Wealth Preservation';

-- QUERY 701 — What is the average liquidity score for investors whose total withdrawal transactions exceed 50,000
-- query_id=200701 | userid=68 | start=2026-04-24 15:59:49 | end=2026-04-24 15:59:49 | dur=958ms | rows=19
SELECT AVG(t2.liquidity_score) FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 WHERE t2.investor_id IN (SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type IN ('Withdrawal', 'Redemption', 'SWP') GROUP BY investor_id HAVING SUM(amount) > 50000);

-- QUERY 702 — Please provide the average liquidity score for investors whose total withdrawal transactions exceed 50,000
-- query_id=200702 | userid=18 | start=2026-04-27 07:17:02 | end=2026-04-27 07:17:03 | dur=1257ms | rows=11
SELECT AVG(t2.liquidity_score) FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 WHERE t2.investor_id IN (SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type IN ('Withdrawal', 'Redemption', 'SWP') GROUP BY investor_id HAVING SUM(amount) > 50000);

-- QUERY 703 — Can you tell me what the average liquidity score for investors whose total withdrawal transactions exceed 50,000
-- query_id=200703 | userid=23 | start=2026-04-27 09:03:24 | end=2026-04-27 09:03:25 | dur=1579ms | rows=6
SELECT AVG(t2.liquidity_score) FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 WHERE t2.investor_id IN (SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type IN ('Withdrawal', 'Redemption', 'SWP') GROUP BY investor_id HAVING SUM(amount) > 50000);

-- QUERY 704 — What would be the average liquidity score for investors whose total withdrawal transactions exceed 50,000
-- query_id=200704 | userid=30 | start=2026-04-27 09:18:07 | end=2026-04-27 09:18:07 | dur=912ms | rows=26
SELECT AVG(t2.liquidity_score) FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 WHERE t2.investor_id IN (SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type IN ('Withdrawal', 'Redemption', 'SWP') GROUP BY investor_id HAVING SUM(amount) > 50000);

-- QUERY 705 — Looking at all available records, what is the average liquidity score for investors whose total withdrawal transactions 
-- query_id=200705 | userid=68 | start=2026-04-27 14:06:49 | end=2026-04-27 14:06:50 | dur=1111ms | rows=20
SELECT AVG(t2.liquidity_score) FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 t2 WHERE t2.investor_id IN (SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type IN ('Withdrawal', 'Redemption', 'SWP') GROUP BY investor_id HAVING SUM(amount) > 50000);

-- QUERY 706 — What is the total amount recommended for Buy rebalancing actions for investors with Growth goals
-- query_id=200706 | userid=23 | start=2026-04-27 14:07:15 | end=2026-04-27 14:07:15 | dur=929ms | rows=1
SELECT SUM(t2.amount) FROM ATOM_EVENT_REBALANCING_ACTION_001 t2 JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t1 ON t2.investor_id = t1.investor_id WHERE t2.action LIKE '%Buy%' AND t1.investment_goal = 'Growth';

-- QUERY 707 — Please provide the total amount recommended for Buy rebalancing actions for investors with Growth goals
-- query_id=200707 | userid=12 | start=2026-04-28 09:56:09 | end=2026-04-28 09:56:10 | dur=1187ms | rows=1
SELECT SUM(t2.amount) FROM ATOM_EVENT_REBALANCING_ACTION_001 t2 JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t1 ON t2.investor_id = t1.investor_id WHERE t2.action LIKE '%Buy%' AND t1.investment_goal = 'Growth';

-- QUERY 708 — Can you tell me what the total amount recommended for Buy rebalancing actions for investors with Growth goals
-- query_id=200708 | userid=12 | start=2026-04-28 10:42:40 | end=2026-04-28 10:42:40 | dur=694ms | rows=1
SELECT SUM(t2.amount) FROM ATOM_EVENT_REBALANCING_ACTION_001 t2 JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t1 ON t2.investor_id = t1.investor_id WHERE t2.action LIKE '%Buy%' AND t1.investment_goal = 'Growth';

-- QUERY 709 — What would be the total amount recommended for Buy rebalancing actions for investors with Growth goals
-- query_id=200709 | userid=42 | start=2026-04-28 11:31:53 | end=2026-04-28 11:31:53 | dur=932ms | rows=1
SELECT SUM(t2.amount) FROM ATOM_EVENT_REBALANCING_ACTION_001 t2 JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t1 ON t2.investor_id = t1.investor_id WHERE t2.action LIKE '%Buy%' AND t1.investment_goal = 'Growth';

-- QUERY 710 — Looking at all available records, what is the total amount recommended for Buy rebalancing actions for investors with Gr
-- query_id=200710 | userid=18 | start=2026-04-28 11:56:46 | end=2026-04-28 11:56:47 | dur=1398ms | rows=1
SELECT SUM(t2.amount) FROM ATOM_EVENT_REBALANCING_ACTION_001 t2 JOIN ATOM_ENTITY_INVESTOR_PROFILE_001 t1 ON t2.investor_id = t1.investor_id WHERE t2.action LIKE '%Buy%' AND t1.investment_goal = 'Growth';

-- QUERY 711 — What are the monthly cash flow totals for investor INV-003
-- query_id=200711 | userid=42 | start=2026-04-28 13:29:36 | end=2026-04-28 13:29:37 | dur=1033ms | rows=29
SELECT strftime('%Y-%m', date) as month, SUM(amount) as monthly_total FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-003' GROUP BY month ORDER BY month;

-- QUERY 712 — What are the monthly cash flow totals for investor INV-003
-- query_id=200712 | userid=42 | start=2026-04-28 15:39:52 | end=2026-04-28 15:39:52 | dur=815ms | rows=6
SELECT strftime('%Y-%m', date) as month, SUM(amount) as monthly_total FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-003' GROUP BY month ORDER BY month;

-- QUERY 713 — Can you tell me ?¢¬Ä¬î what are the monthly cash flow totals for investor inv-003
-- query_id=200713 | userid=55 | start=2026-04-28 17:08:16 | end=2026-04-28 17:08:16 | dur=776ms | rows=4
SELECT strftime('%Y-%m', date) as month, SUM(amount) as monthly_total FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-003' GROUP BY month ORDER BY month;

-- QUERY 714 — Across the portfolio database, what are the monthly cash flow totals for investor inv-003
-- query_id=200714 | userid=81 | start=2026-04-28 17:38:42 | end=2026-04-28 17:38:43 | dur=1058ms | rows=26
SELECT strftime('%Y-%m', date) as month, SUM(amount) as monthly_total FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-003' GROUP BY month ORDER BY month;

-- QUERY 715 — From the complete wealth management dataset, what are the monthly cash flow totals for investor inv-003
-- query_id=200715 | userid=23 | start=2026-04-28 18:03:32 | end=2026-04-28 18:03:32 | dur=979ms | rows=5
SELECT strftime('%Y-%m', date) as month, SUM(amount) as monthly_total FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-003' GROUP BY month ORDER BY month;

-- QUERY 716 — Which sector earned the highest total dividends across all investors
-- query_id=200716 | userid=81 | start=2026-04-28 18:55:57 | end=2026-04-28 18:55:57 | dur=772ms | rows=1
SELECT sector FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector ORDER BY SUM(dividends) DESC LIMIT 1;

-- QUERY 717 — Identify the sector earned the highest total dividends across all investors
-- query_id=200717 | userid=42 | start=2026-04-28 19:14:52 | end=2026-04-28 19:14:52 | dur=964ms | rows=1
SELECT sector FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector ORDER BY SUM(dividends) DESC LIMIT 1;

-- QUERY 718 — Do you know which sector earned the highest total dividends across all investors
-- query_id=200718 | userid=30 | start=2026-04-29 08:26:15 | end=2026-04-29 08:26:16 | dur=1569ms | rows=1
SELECT sector FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector ORDER BY SUM(dividends) DESC LIMIT 1;

-- QUERY 719 — Out of all options, which sector earned the highest total dividends across all investors
-- query_id=200719 | userid=81 | start=2026-04-29 09:05:09 | end=2026-04-29 09:05:10 | dur=1090ms | rows=1
SELECT sector FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector ORDER BY SUM(dividends) DESC LIMIT 1;

-- QUERY 720 — Given all the data available, which sector earned the highest total dividends across all investors
-- query_id=200720 | userid=12 | start=2026-04-29 09:53:57 | end=2026-04-29 09:53:58 | dur=1161ms | rows=1
SELECT sector FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector ORDER BY SUM(dividends) DESC LIMIT 1;

-- QUERY 721 — Which sector earned the lowest total dividends across all investors
-- query_id=200721 | userid=95 | start=2026-04-29 11:11:20 | end=2026-04-29 11:11:20 | dur=956ms | rows=1
SELECT sector FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector ORDER BY SUM(dividends) ASC LIMIT 1;

-- QUERY 722 — Identify the sector earned the lowest total dividends across all investors
-- query_id=200722 | userid=23 | start=2026-04-29 12:21:06 | end=2026-04-29 12:21:07 | dur=1145ms | rows=1
SELECT sector FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector ORDER BY SUM(dividends) ASC LIMIT 1;

-- QUERY 723 — Do you know which sector earned the lowest total dividends across all investors
-- query_id=200723 | userid=30 | start=2026-04-29 13:34:51 | end=2026-04-29 13:34:52 | dur=1087ms | rows=1
SELECT sector FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector ORDER BY SUM(dividends) ASC LIMIT 1;

-- QUERY 724 — Out of all options, which sector earned the lowest total dividends across all investors
-- query_id=200724 | userid=68 | start=2026-04-29 16:44:35 | end=2026-04-29 16:44:35 | dur=800ms | rows=1
SELECT sector FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector ORDER BY SUM(dividends) ASC LIMIT 1;

-- QUERY 725 — Given all the data available, which sector earned the lowest total dividends across all investors
-- query_id=200725 | userid=12 | start=2026-04-29 18:37:29 | end=2026-04-29 18:37:29 | dur=811ms | rows=1
SELECT sector FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector ORDER BY SUM(dividends) ASC LIMIT 1;

-- QUERY 726 — Which sector has the highest total taxes paid across all investors
-- query_id=200726 | userid=18 | start=2026-04-30 09:13:13 | end=2026-04-30 09:13:14 | dur=1046ms | rows=1
SELECT sector FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector ORDER BY SUM(taxes_paid) DESC LIMIT 1;

-- QUERY 727 — Identify the sector has the highest total taxes paid across all investors
-- query_id=200727 | userid=55 | start=2026-04-30 09:24:56 | end=2026-04-30 09:24:56 | dur=928ms | rows=1
SELECT sector FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector ORDER BY SUM(taxes_paid) DESC LIMIT 1;

-- QUERY 728 — Do you know which sector has the highest total taxes paid across all investors
-- query_id=200728 | userid=81 | start=2026-04-30 10:08:48 | end=2026-04-30 10:08:49 | dur=1192ms | rows=1
SELECT sector FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector ORDER BY SUM(taxes_paid) DESC LIMIT 1;

-- QUERY 729 — Out of all options, which sector has the highest total taxes paid across all investors
-- query_id=200729 | userid=18 | start=2026-04-30 10:36:20 | end=2026-04-30 10:36:21 | dur=1210ms | rows=1
SELECT sector FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector ORDER BY SUM(taxes_paid) DESC LIMIT 1;

-- QUERY 730 — Given all the data available, which sector has the highest total taxes paid across all investors
-- query_id=200730 | userid=81 | start=2026-04-30 11:43:50 | end=2026-04-30 11:43:51 | dur=1041ms | rows=1
SELECT sector FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector ORDER BY SUM(taxes_paid) DESC LIMIT 1;

-- QUERY 731 — Which sector has the lowest total taxes paid across all investors
-- query_id=200731 | userid=74 | start=2026-04-30 12:30:26 | end=2026-04-30 12:30:27 | dur=1084ms | rows=1
SELECT sector FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector ORDER BY SUM(taxes_paid) ASC LIMIT 1;

-- QUERY 732 — Identify the sector has the lowest total taxes paid across all investors
-- query_id=200732 | userid=68 | start=2026-04-30 13:08:50 | end=2026-04-30 13:08:50 | dur=522ms | rows=1
SELECT sector FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector ORDER BY SUM(taxes_paid) ASC LIMIT 1;

-- QUERY 733 — Do you know which sector has the lowest total taxes paid across all investors
-- query_id=200733 | userid=74 | start=2026-04-30 14:21:34 | end=2026-04-30 14:21:34 | dur=894ms | rows=1
SELECT sector FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector ORDER BY SUM(taxes_paid) ASC LIMIT 1;

-- QUERY 734 — Out of all options, which sector has the lowest total taxes paid across all investors
-- query_id=200734 | userid=18 | start=2026-05-01 07:17:51 | end=2026-05-01 07:17:52 | dur=1180ms | rows=1
SELECT sector FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector ORDER BY SUM(taxes_paid) ASC LIMIT 1;

-- QUERY 735 — Given all the data available, which sector has the lowest total taxes paid across all investors
-- query_id=200735 | userid=42 | start=2026-05-01 08:03:34 | end=2026-05-01 08:03:35 | dur=1203ms | rows=1
SELECT sector FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY sector ORDER BY SUM(taxes_paid) ASC LIMIT 1;

-- QUERY 736 — Which investment category has the highest average taxes paid
-- query_id=200736 | userid=74 | start=2026-05-01 12:29:32 | end=2026-05-01 12:29:33 | dur=1254ms | rows=1
SELECT category FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category ORDER BY AVG(taxes_paid) DESC LIMIT 1;

-- QUERY 737 — Identify the investment category has the highest average taxes paid
-- query_id=200737 | userid=18 | start=2026-05-01 13:33:45 | end=2026-05-01 13:33:46 | dur=1150ms | rows=1
SELECT category FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category ORDER BY AVG(taxes_paid) DESC LIMIT 1;

-- QUERY 738 — Do you know which investment category has the highest average taxes paid
-- query_id=200738 | userid=95 | start=2026-05-01 14:11:49 | end=2026-05-01 14:11:50 | dur=1609ms | rows=1
SELECT category FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category ORDER BY AVG(taxes_paid) DESC LIMIT 1;

-- QUERY 739 — Out of all options, which investment category has the highest average taxes paid
-- query_id=200739 | userid=55 | start=2026-05-01 14:48:42 | end=2026-05-01 14:48:43 | dur=1241ms | rows=1
SELECT category FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category ORDER BY AVG(taxes_paid) DESC LIMIT 1;

-- QUERY 740 — Given all the data available, which investment category has the highest average taxes paid
-- query_id=200740 | userid=74 | start=2026-05-01 15:38:02 | end=2026-05-01 15:38:03 | dur=1258ms | rows=1
SELECT category FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category ORDER BY AVG(taxes_paid) DESC LIMIT 1;

-- QUERY 741 — Which investment category has the lowest average taxes paid
-- query_id=200741 | userid=68 | start=2026-05-01 17:26:34 | end=2026-05-01 17:26:34 | dur=984ms | rows=1
SELECT category FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category ORDER BY AVG(taxes_paid) ASC LIMIT 1;

-- QUERY 742 — Identify the investment category has the lowest average taxes paid
-- query_id=200742 | userid=18 | start=2026-05-01 19:55:39 | end=2026-05-01 19:55:40 | dur=1003ms | rows=1
SELECT category FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category ORDER BY AVG(taxes_paid) ASC LIMIT 1;

-- QUERY 743 — Do you know which investment category has the lowest average taxes paid
-- query_id=200743 | userid=18 | start=2026-05-04 07:12:47 | end=2026-05-04 07:12:47 | dur=881ms | rows=1
SELECT category FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category ORDER BY AVG(taxes_paid) ASC LIMIT 1;

-- QUERY 744 — Out of all options, which investment category has the lowest average taxes paid
-- query_id=200744 | userid=23 | start=2026-05-04 08:42:17 | end=2026-05-04 08:42:18 | dur=1082ms | rows=1
SELECT category FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category ORDER BY AVG(taxes_paid) ASC LIMIT 1;

-- QUERY 745 — Given all the data available, which investment category has the lowest average taxes paid
-- query_id=200745 | userid=81 | start=2026-05-04 09:11:48 | end=2026-05-04 09:11:48 | dur=986ms | rows=1
SELECT category FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY category ORDER BY AVG(taxes_paid) ASC LIMIT 1;

-- QUERY 746 — Which investment type has the highest average cost basis
-- query_id=200746 | userid=81 | start=2026-05-04 10:02:28 | end=2026-05-04 10:02:28 | dur=913ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(cost) DESC LIMIT 1;

-- QUERY 747 — Identify the investment type has the highest average cost basis
-- query_id=200747 | userid=18 | start=2026-05-04 10:26:26 | end=2026-05-04 10:26:27 | dur=1200ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(cost) DESC LIMIT 1;

-- QUERY 748 — Do you know which investment type has the highest average cost basis
-- query_id=200748 | userid=42 | start=2026-05-04 10:30:15 | end=2026-05-04 10:30:16 | dur=1277ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(cost) DESC LIMIT 1;

-- QUERY 749 — Out of all options, which investment type has the highest average cost basis
-- query_id=200749 | userid=68 | start=2026-05-04 14:51:15 | end=2026-05-04 14:51:15 | dur=942ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(cost) DESC LIMIT 1;

-- QUERY 750 — Given all the data available, which investment type has the highest average cost basis
-- query_id=200750 | userid=74 | start=2026-05-04 17:09:48 | end=2026-05-04 17:09:48 | dur=916ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(cost) DESC LIMIT 1;

-- QUERY 751 — Which investment type has the lowest average cost basis
-- query_id=200751 | userid=42 | start=2026-05-04 19:01:25 | end=2026-05-04 19:01:26 | dur=1249ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(cost) ASC LIMIT 1;

-- QUERY 752 — Identify the investment type has the lowest average cost basis
-- query_id=200752 | userid=12 | start=2026-05-04 19:43:03 | end=2026-05-04 19:43:04 | dur=1213ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(cost) ASC LIMIT 1;

-- QUERY 753 — Do you know which investment type has the lowest average cost basis
-- query_id=200753 | userid=95 | start=2026-05-05 07:16:35 | end=2026-05-05 07:16:35 | dur=469ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(cost) ASC LIMIT 1;

-- QUERY 754 — Out of all options, which investment type has the lowest average cost basis
-- query_id=200754 | userid=68 | start=2026-05-05 11:05:54 | end=2026-05-05 11:05:55 | dur=1123ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(cost) ASC LIMIT 1;

-- QUERY 755 — Given all the data available, which investment type has the lowest average cost basis
-- query_id=200755 | userid=42 | start=2026-05-05 12:06:39 | end=2026-05-05 12:06:40 | dur=1064ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(cost) ASC LIMIT 1;

-- QUERY 756 — Which investment type has the highest average taxes paid per holding
-- query_id=200756 | userid=55 | start=2026-05-05 13:31:17 | end=2026-05-05 13:31:17 | dur=962ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(taxes_paid) DESC LIMIT 1;

-- QUERY 757 — Identify the investment type has the highest average taxes paid per holding
-- query_id=200757 | userid=68 | start=2026-05-05 14:33:34 | end=2026-05-05 14:33:34 | dur=848ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(taxes_paid) DESC LIMIT 1;

-- QUERY 758 — Do you know which investment type has the highest average taxes paid per holding
-- query_id=200758 | userid=95 | start=2026-05-05 19:11:42 | end=2026-05-05 19:11:43 | dur=1031ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(taxes_paid) DESC LIMIT 1;

-- QUERY 759 — Out of all options, which investment type has the highest average taxes paid per holding
-- query_id=200759 | userid=74 | start=2026-05-05 19:25:49 | end=2026-05-05 19:25:50 | dur=1087ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(taxes_paid) DESC LIMIT 1;

-- QUERY 760 — Given all the data available, which investment type has the highest average taxes paid per holding
-- query_id=200760 | userid=18 | start=2026-05-05 19:38:40 | end=2026-05-05 19:38:41 | dur=1131ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(taxes_paid) DESC LIMIT 1;

-- QUERY 761 — Which investment type has the lowest average taxes paid per holding
-- query_id=200761 | userid=95 | start=2026-05-05 19:54:24 | end=2026-05-05 19:54:24 | dur=897ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(taxes_paid) ASC LIMIT 1;

-- QUERY 762 — Identify the investment type has the lowest average taxes paid per holding
-- query_id=200762 | userid=95 | start=2026-05-06 07:58:56 | end=2026-05-06 07:58:57 | dur=1059ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(taxes_paid) ASC LIMIT 1;

-- QUERY 763 — Do you know which investment type has the lowest average taxes paid per holding
-- query_id=200763 | userid=42 | start=2026-05-06 08:15:06 | end=2026-05-06 08:15:06 | dur=993ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(taxes_paid) ASC LIMIT 1;

-- QUERY 764 — Out of all options, which investment type has the lowest average taxes paid per holding
-- query_id=200764 | userid=81 | start=2026-05-06 10:07:32 | end=2026-05-06 10:07:33 | dur=1116ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(taxes_paid) ASC LIMIT 1;

-- QUERY 765 — Given all the data available, which investment type has the lowest average taxes paid per holding
-- query_id=200765 | userid=81 | start=2026-05-06 10:41:37 | end=2026-05-06 10:41:38 | dur=1415ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investment_type ORDER BY AVG(taxes_paid) ASC LIMIT 1;

-- QUERY 766 — Which holding has the highest dividend amount across all investors
-- query_id=200766 | userid=95 | start=2026-05-06 11:10:13 | end=2026-05-06 11:10:14 | dur=1001ms | rows=1
SELECT investment_name, dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY dividends DESC LIMIT 1;

-- QUERY 767 — Identify the holding has the highest dividend amount across all investors
-- query_id=200767 | userid=12 | start=2026-05-06 11:24:57 | end=2026-05-06 11:24:57 | dur=729ms | rows=1
SELECT investment_name, dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY dividends DESC LIMIT 1;

-- QUERY 768 — Do you know which holding has the highest dividend amount across all investors
-- query_id=200768 | userid=68 | start=2026-05-06 12:09:56 | end=2026-05-06 12:09:56 | dur=623ms | rows=1
SELECT investment_name, dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY dividends DESC LIMIT 1;

-- QUERY 769 — Out of all options, which holding has the highest dividend amount across all investors
-- query_id=200769 | userid=30 | start=2026-05-06 14:46:29 | end=2026-05-06 14:46:29 | dur=891ms | rows=1
SELECT investment_name, dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY dividends DESC LIMIT 1;

-- QUERY 770 — Given all the data available, which holding has the highest dividend amount across all investors
-- query_id=200770 | userid=30 | start=2026-05-06 16:39:41 | end=2026-05-06 16:39:41 | dur=519ms | rows=1
SELECT investment_name, dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY dividends DESC LIMIT 1;

-- QUERY 771 — What is the dividend amount for the 5th highest dividend-earning holding
-- query_id=200771 | userid=74 | start=2026-05-06 17:46:13 | end=2026-05-06 17:46:13 | dur=893ms | rows=1
SELECT dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY dividends DESC LIMIT 1 OFFSET 4;

-- QUERY 772 — Please provide the dividend amount for the 5th highest dividend-earning holding
-- query_id=200772 | userid=42 | start=2026-05-06 18:11:47 | end=2026-05-06 18:11:48 | dur=1012ms | rows=1
SELECT dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY dividends DESC LIMIT 1 OFFSET 4;

-- QUERY 773 — Can you tell me what the dividend amount for the 5th highest dividend-earning holding
-- query_id=200773 | userid=74 | start=2026-05-06 18:16:43 | end=2026-05-06 18:16:43 | dur=745ms | rows=1
SELECT dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY dividends DESC LIMIT 1 OFFSET 4;

-- QUERY 774 — What would be the dividend amount for the 5th highest dividend-earning holding
-- query_id=200774 | userid=68 | start=2026-05-06 18:32:45 | end=2026-05-06 18:32:45 | dur=863ms | rows=1
SELECT dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY dividends DESC LIMIT 1 OFFSET 4;

-- QUERY 775 — Looking at all available records, what is the dividend amount for the 5th highest dividend-earning holding
-- query_id=200775 | userid=23 | start=2026-05-07 07:21:04 | end=2026-05-07 07:21:04 | dur=611ms | rows=1
SELECT dividends FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 ORDER BY dividends DESC LIMIT 1 OFFSET 4;

-- QUERY 776 — How many rebalancing actions have an Overweight drift direction
-- query_id=200776 | userid=81 | start=2026-05-07 09:29:29 | end=2026-05-07 09:29:29 | dur=478ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_REBALANCING_ACTION_001 WHERE current_allocation_pct > target_allocation_pct;

-- QUERY 777 — Provide the count of rebalancing actions have an Overweight drift direction
-- query_id=200777 | userid=55 | start=2026-05-07 12:15:15 | end=2026-05-07 12:15:15 | dur=580ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_REBALANCING_ACTION_001 WHERE current_allocation_pct > target_allocation_pct;

-- QUERY 778 — I need to find out how many rebalancing actions have an Overweight drift direction
-- query_id=200778 | userid=30 | start=2026-05-07 13:23:48 | end=2026-05-07 13:23:48 | dur=912ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_REBALANCING_ACTION_001 WHERE current_allocation_pct > target_allocation_pct;

-- QUERY 779 — What is the total count of rebalancing actions have an Overweight drift direction
-- query_id=200779 | userid=74 | start=2026-05-07 13:46:57 | end=2026-05-07 13:46:57 | dur=552ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_REBALANCING_ACTION_001 WHERE current_allocation_pct > target_allocation_pct;

-- QUERY 780 — Across the entire investor database, how many rebalancing actions have an Overweight drift direction
-- query_id=200780 | userid=42 | start=2026-05-07 14:37:43 | end=2026-05-07 14:37:43 | dur=926ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_REBALANCING_ACTION_001 WHERE current_allocation_pct > target_allocation_pct;

-- QUERY 781 — How many rebalancing actions are classified as On Target drift
-- query_id=200781 | userid=12 | start=2026-05-07 15:12:55 | end=2026-05-07 15:12:55 | dur=917ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_REBALANCING_ACTION_001 WHERE current_allocation_pct = target_allocation_pct;

-- QUERY 782 — Provide the count of rebalancing actions are classified as On Target drift
-- query_id=200782 | userid=42 | start=2026-05-08 07:55:46 | end=2026-05-08 07:55:46 | dur=639ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_REBALANCING_ACTION_001 WHERE current_allocation_pct = target_allocation_pct;

-- QUERY 783 — I need to find out how many rebalancing actions are classified as On Target drift
-- query_id=200783 | userid=18 | start=2026-05-08 09:26:11 | end=2026-05-08 09:26:11 | dur=875ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_REBALANCING_ACTION_001 WHERE current_allocation_pct = target_allocation_pct;

-- QUERY 784 — What is the total count of rebalancing actions are classified as On Target drift
-- query_id=200784 | userid=42 | start=2026-05-08 09:27:06 | end=2026-05-08 09:27:06 | dur=385ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_REBALANCING_ACTION_001 WHERE current_allocation_pct = target_allocation_pct;

-- QUERY 785 — Across the entire investor database, how many rebalancing actions are classified as On Target drift
-- query_id=200785 | userid=55 | start=2026-05-08 11:48:37 | end=2026-05-08 11:48:37 | dur=990ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_REBALANCING_ACTION_001 WHERE current_allocation_pct = target_allocation_pct;

-- QUERY 786 — How many rebalancing actions have an Underweight drift direction
-- query_id=200786 | userid=74 | start=2026-05-08 12:36:46 | end=2026-05-08 12:36:46 | dur=540ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_REBALANCING_ACTION_001 WHERE current_allocation_pct < target_allocation_pct;

-- QUERY 787 — Provide the count of rebalancing actions have an Underweight drift direction
-- query_id=200787 | userid=68 | start=2026-05-08 14:19:42 | end=2026-05-08 14:19:42 | dur=985ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_REBALANCING_ACTION_001 WHERE current_allocation_pct < target_allocation_pct;

-- QUERY 788 — I need to find out how many rebalancing actions have an Underweight drift direction
-- query_id=200788 | userid=81 | start=2026-05-08 15:26:52 | end=2026-05-08 15:26:52 | dur=860ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_REBALANCING_ACTION_001 WHERE current_allocation_pct < target_allocation_pct;

-- QUERY 789 — What is the total count of rebalancing actions have an Underweight drift direction
-- query_id=200789 | userid=23 | start=2026-05-08 15:34:51 | end=2026-05-08 15:34:51 | dur=751ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_REBALANCING_ACTION_001 WHERE current_allocation_pct < target_allocation_pct;

-- QUERY 790 — Across the entire investor database, how many rebalancing actions have an Underweight drift direction
-- query_id=200790 | userid=95 | start=2026-05-08 16:55:10 | end=2026-05-08 16:55:10 | dur=525ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_REBALANCING_ACTION_001 WHERE current_allocation_pct < target_allocation_pct;

-- QUERY 791 — What is the average new allocation percentage for Increase scenario rebalancing changes
-- query_id=200791 | userid=68 | start=2026-05-08 17:42:56 | end=2026-05-08 17:42:56 | dur=861ms | rows=1
SELECT AVG(new_allocation_pct) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE new_allocation_pct > current_allocation_pct;

-- QUERY 792 — Please provide the average new allocation percentage for Increase scenario rebalancing changes
-- query_id=200792 | userid=55 | start=2026-05-08 19:34:23 | end=2026-05-08 19:34:23 | dur=921ms | rows=1
SELECT AVG(new_allocation_pct) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE new_allocation_pct > current_allocation_pct;

-- QUERY 793 — Can you tell me what the average new allocation percentage for Increase scenario rebalancing changes
-- query_id=200793 | userid=68 | start=2026-05-11 07:56:37 | end=2026-05-11 07:56:37 | dur=852ms | rows=1
SELECT AVG(new_allocation_pct) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE new_allocation_pct > current_allocation_pct;

-- QUERY 794 — What would be the average new allocation percentage for Increase scenario rebalancing changes
-- query_id=200794 | userid=81 | start=2026-05-11 10:17:17 | end=2026-05-11 10:17:17 | dur=743ms | rows=1
SELECT AVG(new_allocation_pct) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE new_allocation_pct > current_allocation_pct;

-- QUERY 795 — Looking at all available records, what is the average new allocation percentage for Increase scenario rebalancing change
-- query_id=200795 | userid=30 | start=2026-05-11 10:18:11 | end=2026-05-11 10:18:11 | dur=503ms | rows=1
SELECT AVG(new_allocation_pct) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE new_allocation_pct > current_allocation_pct;

-- QUERY 796 — What is the average new allocation percentage for Decrease scenario rebalancing changes
-- query_id=200796 | userid=18 | start=2026-05-11 13:03:33 | end=2026-05-11 13:03:33 | dur=883ms | rows=1
SELECT AVG(new_allocation_pct) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE new_allocation_pct < current_allocation_pct;

-- QUERY 797 — Please provide the average new allocation percentage for Decrease scenario rebalancing changes
-- query_id=200797 | userid=81 | start=2026-05-11 13:20:06 | end=2026-05-11 13:20:06 | dur=596ms | rows=1
SELECT AVG(new_allocation_pct) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE new_allocation_pct < current_allocation_pct;

-- QUERY 798 — Can you tell me what the average new allocation percentage for Decrease scenario rebalancing changes
-- query_id=200798 | userid=42 | start=2026-05-11 15:27:18 | end=2026-05-11 15:27:18 | dur=575ms | rows=1
SELECT AVG(new_allocation_pct) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE new_allocation_pct < current_allocation_pct;

-- QUERY 799 — What would be the average new allocation percentage for Decrease scenario rebalancing changes
-- query_id=200799 | userid=95 | start=2026-05-11 15:36:27 | end=2026-05-11 15:36:27 | dur=448ms | rows=1
SELECT AVG(new_allocation_pct) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE new_allocation_pct < current_allocation_pct;

-- QUERY 800 — Looking at all available records, what is the average new allocation percentage for Decrease scenario rebalancing change
-- query_id=200800 | userid=42 | start=2026-05-11 18:06:22 | end=2026-05-11 18:06:22 | dur=937ms | rows=1
SELECT AVG(new_allocation_pct) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE new_allocation_pct < current_allocation_pct;

-- QUERY 801 — Which investors have zero dividend income from all their holdings
-- query_id=200801 | userid=95 | start=2026-05-12 07:53:49 | end=2026-05-12 07:53:50 | dur=1004ms | rows=102
SELECT investor_id FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE dividends > 0);

-- QUERY 802 — Identify the investor whos have zero dividend income from all their holdings
-- query_id=200802 | userid=30 | start=2026-05-12 08:04:46 | end=2026-05-12 08:04:46 | dur=553ms | rows=25
SELECT investor_id FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE dividends > 0);

-- QUERY 803 — I want to know which investors have zero dividend income from all their holdings
-- query_id=200803 | userid=81 | start=2026-05-12 09:38:53 | end=2026-05-12 09:38:53 | dur=704ms | rows=154
SELECT investor_id FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE dividends > 0);

-- QUERY 804 — Among all investors, which ones have zero dividend income from all their holdings
-- query_id=200804 | userid=12 | start=2026-05-12 12:31:49 | end=2026-05-12 12:31:49 | dur=498ms | rows=172
SELECT investor_id FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE dividends > 0);

-- QUERY 805 — Considering all investors in the system, which investors have zero dividend income from all their holdings
-- query_id=200805 | userid=55 | start=2026-05-12 12:40:01 | end=2026-05-12 12:40:01 | dur=332ms | rows=120
SELECT investor_id FROM ATOM_ENTITY_INVESTOR_PROFILE_001 WHERE investor_id NOT IN (SELECT DISTINCT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE dividends > 0);

-- QUERY 806 — How many investors have made Lump Sum investments but have no SIP contributions on record
-- query_id=200806 | userid=23 | start=2026-05-12 13:53:44 | end=2026-05-12 13:53:44 | dur=589ms | rows=1
SELECT COUNT(*) FROM (SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' EXCEPT SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'SIP');

-- QUERY 807 — Provide the count of investors have made Lump Sum investments but have no SIP contributions on record
-- query_id=200807 | userid=18 | start=2026-05-12 14:36:40 | end=2026-05-12 14:36:40 | dur=803ms | rows=1
SELECT COUNT(*) FROM (SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' EXCEPT SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'SIP');

-- QUERY 808 — I need to find out how many investors have made Lump Sum investments but have no SIP contributions on record
-- query_id=200808 | userid=42 | start=2026-05-12 16:07:23 | end=2026-05-12 16:07:24 | dur=1041ms | rows=1
SELECT COUNT(*) FROM (SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' EXCEPT SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'SIP');

-- QUERY 809 — What is the total count of investors have made Lump Sum investments but have no SIP contributions on record
-- query_id=200809 | userid=23 | start=2026-05-12 16:43:28 | end=2026-05-12 16:43:28 | dur=771ms | rows=1
SELECT COUNT(*) FROM (SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' EXCEPT SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'SIP');

-- QUERY 810 — Across the entire investor database, how many investors have made Lump Sum investments but have no SIP contributions on 
-- query_id=200810 | userid=30 | start=2026-05-12 17:08:20 | end=2026-05-12 17:08:20 | dur=548ms | rows=1
SELECT COUNT(*) FROM (SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' EXCEPT SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'SIP');

-- QUERY 811 — Which investor has the highest total Lump Sum investment amount
-- query_id=200811 | userid=23 | start=2026-05-12 17:28:36 | end=2026-05-12 17:28:36 | dur=631ms | rows=1
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' GROUP BY investor_id ORDER BY SUM(amount) DESC LIMIT 1;

-- QUERY 812 — Identify the investor who has the highest total Lump Sum investment amount
-- query_id=200812 | userid=81 | start=2026-05-12 17:58:30 | end=2026-05-12 17:58:31 | dur=1137ms | rows=1
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' GROUP BY investor_id ORDER BY SUM(amount) DESC LIMIT 1;

-- QUERY 813 — I want to know which investor has the highest total Lump Sum investment amount
-- query_id=200813 | userid=55 | start=2026-05-12 19:53:33 | end=2026-05-12 19:53:33 | dur=719ms | rows=1
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' GROUP BY investor_id ORDER BY SUM(amount) DESC LIMIT 1;

-- QUERY 814 — Among all investors, who has the highest total Lump Sum investment amount
-- query_id=200814 | userid=95 | start=2026-05-13 09:00:02 | end=2026-05-13 09:00:02 | dur=773ms | rows=1
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' GROUP BY investor_id ORDER BY SUM(amount) DESC LIMIT 1;

-- QUERY 815 — Considering all investors in the system, which investor has the highest total Lump Sum investment amount
-- query_id=200815 | userid=68 | start=2026-05-13 09:25:12 | end=2026-05-13 09:25:13 | dur=1654ms | rows=1
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' GROUP BY investor_id ORDER BY SUM(amount) DESC LIMIT 1;

-- QUERY 816 — Which investor has the lowest total Lump Sum investment amount
-- query_id=200816 | userid=18 | start=2026-05-13 10:39:40 | end=2026-05-13 10:39:41 | dur=1088ms | rows=1
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' GROUP BY investor_id ORDER BY SUM(amount) ASC LIMIT 1;

-- QUERY 817 — Identify the investor who has the lowest total Lump Sum investment amount
-- query_id=200817 | userid=12 | start=2026-05-13 15:38:16 | end=2026-05-13 15:38:16 | dur=866ms | rows=1
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' GROUP BY investor_id ORDER BY SUM(amount) ASC LIMIT 1;

-- QUERY 818 — I want to know which investor has the lowest total Lump Sum investment amount
-- query_id=200818 | userid=12 | start=2026-05-13 17:33:46 | end=2026-05-13 17:33:46 | dur=966ms | rows=1
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' GROUP BY investor_id ORDER BY SUM(amount) ASC LIMIT 1;

-- QUERY 819 — Among all investors, who has the lowest total Lump Sum investment amount
-- query_id=200819 | userid=95 | start=2026-05-14 07:05:37 | end=2026-05-14 07:05:37 | dur=860ms | rows=1
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' GROUP BY investor_id ORDER BY SUM(amount) ASC LIMIT 1;

-- QUERY 820 — Considering all investors in the system, which investor has the lowest total Lump Sum investment amount
-- query_id=200820 | userid=81 | start=2026-05-14 08:49:04 | end=2026-05-14 08:49:04 | dur=888ms | rows=1
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum' GROUP BY investor_id ORDER BY SUM(amount) ASC LIMIT 1;

-- QUERY 821 — How many investors have made at least one Lump Sum investment
-- query_id=200821 | userid=30 | start=2026-05-14 08:59:10 | end=2026-05-14 08:59:10 | dur=988ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum';

-- QUERY 822 — Provide the count of investors have made at least one Lump Sum investment
-- query_id=200822 | userid=42 | start=2026-05-14 11:26:45 | end=2026-05-14 11:26:45 | dur=879ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum';

-- QUERY 823 — I need to find out how many investors have made at least one Lump Sum investment
-- query_id=200823 | userid=74 | start=2026-05-14 11:58:07 | end=2026-05-14 11:58:07 | dur=751ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum';

-- QUERY 824 — What is the total count of investors have made at least one Lump Sum investment
-- query_id=200824 | userid=18 | start=2026-05-14 12:33:09 | end=2026-05-14 12:33:09 | dur=754ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum';

-- QUERY 825 — Across the entire investor database, how many investors have made at least one Lump Sum investment
-- query_id=200825 | userid=74 | start=2026-05-14 15:04:01 | end=2026-05-14 15:04:01 | dur=469ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Lump Sum';

-- QUERY 826 — What is the total Lump Sum investment amount for investor INV-012
-- query_id=200826 | userid=68 | start=2026-05-14 17:28:19 | end=2026-05-14 17:28:19 | dur=428ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-012' AND type = 'Lump Sum';

-- QUERY 827 — Please provide the total Lump Sum investment amount for investor INV-012
-- query_id=200827 | userid=23 | start=2026-05-15 07:57:42 | end=2026-05-15 07:57:42 | dur=801ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-012' AND type = 'Lump Sum';

-- QUERY 828 — Can you tell me what the total Lump Sum investment amount for investor INV-012
-- query_id=200828 | userid=74 | start=2026-05-15 09:16:22 | end=2026-05-15 09:16:22 | dur=617ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-012' AND type = 'Lump Sum';

-- QUERY 829 — What would be the total Lump Sum investment amount for investor INV-012
-- query_id=200829 | userid=81 | start=2026-05-15 12:14:14 | end=2026-05-15 12:14:14 | dur=470ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-012' AND type = 'Lump Sum';

-- QUERY 830 — Looking at all available records, what is the total Lump Sum investment amount for investor INV-012
-- query_id=200830 | userid=68 | start=2026-05-15 12:53:40 | end=2026-05-15 12:53:40 | dur=436ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-012' AND type = 'Lump Sum';

-- QUERY 831 — What is the total Lump Sum investment amount for investor INV-049
-- query_id=200831 | userid=42 | start=2026-05-15 15:48:35 | end=2026-05-15 15:48:35 | dur=706ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-049' AND type = 'Lump Sum';

-- QUERY 832 — Please provide the total Lump Sum investment amount for investor INV-049
-- query_id=200832 | userid=23 | start=2026-05-15 16:45:13 | end=2026-05-15 16:45:13 | dur=755ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-049' AND type = 'Lump Sum';

-- QUERY 833 — Can you tell me what the total Lump Sum investment amount for investor INV-049
-- query_id=200833 | userid=95 | start=2026-05-15 18:02:25 | end=2026-05-15 18:02:25 | dur=989ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-049' AND type = 'Lump Sum';

-- QUERY 834 — What would be the total Lump Sum investment amount for investor INV-049
-- query_id=200834 | userid=23 | start=2026-05-15 18:16:47 | end=2026-05-15 18:16:47 | dur=509ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-049' AND type = 'Lump Sum';

-- QUERY 835 — Looking at all available records, what is the total Lump Sum investment amount for investor INV-049
-- query_id=200835 | userid=18 | start=2026-05-18 08:17:49 | end=2026-05-18 08:17:49 | dur=619ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-049' AND type = 'Lump Sum';

-- QUERY 836 — How many investors are not on track to meet their Child Education goals
-- query_id=200836 | userid=68 | start=2026-05-18 09:45:22 | end=2026-05-18 09:45:22 | dur=957ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_ENTITY_INVESTMENT_GOAL_001 WHERE investment_goal = 'Child Education' AND progress_pct < 50;

-- QUERY 837 — Provide the count of investors are not on track to meet their Child Education goals
-- query_id=200837 | userid=95 | start=2026-05-18 10:46:40 | end=2026-05-18 10:46:40 | dur=859ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_ENTITY_INVESTMENT_GOAL_001 WHERE investment_goal = 'Child Education' AND progress_pct < 50;

-- QUERY 838 — I need to find out how many investors are not on track to meet their Child Education goals
-- query_id=200838 | userid=30 | start=2026-05-18 11:36:19 | end=2026-05-18 11:36:19 | dur=451ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_ENTITY_INVESTMENT_GOAL_001 WHERE investment_goal = 'Child Education' AND progress_pct < 50;

-- QUERY 839 — What is the total count of investors are not on track to meet their Child Education goals
-- query_id=200839 | userid=74 | start=2026-05-18 15:10:43 | end=2026-05-18 15:10:43 | dur=861ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_ENTITY_INVESTMENT_GOAL_001 WHERE investment_goal = 'Child Education' AND progress_pct < 50;

-- QUERY 840 — Across the entire investor database, how many investors are not on track to meet their Child Education goals
-- query_id=200840 | userid=23 | start=2026-05-18 15:24:21 | end=2026-05-18 15:24:21 | dur=776ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_ENTITY_INVESTMENT_GOAL_001 WHERE investment_goal = 'Child Education' AND progress_pct < 50;

-- QUERY 841 — Which investor has the lowest portfolio health score among those not meeting their Child Education goals
-- query_id=200841 | userid=74 | start=2026-05-18 18:30:17 | end=2026-05-18 18:30:18 | dur=1564ms | rows=1
SELECT t1.investor_id FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id WHERE t2.investment_goal = 'Child Education' AND t2.progress_pct < 50 ORDER BY (t1.goal_match_pct * 0.3 + t1.risk_score * 0.3 + t1.liquidity_score * 0.2 + t1.diversification_score * 0.2) ASC LIMIT 1;

-- QUERY 842 — Identify the investor who has the lowest portfolio health score among those not meeting their Child Education goals
-- query_id=200842 | userid=68 | start=2026-05-18 19:49:39 | end=2026-05-18 19:49:40 | dur=1079ms | rows=1
SELECT t1.investor_id FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id WHERE t2.investment_goal = 'Child Education' AND t2.progress_pct < 50 ORDER BY (t1.goal_match_pct * 0.3 + t1.risk_score * 0.3 + t1.liquidity_score * 0.2 + t1.diversification_score * 0.2) ASC LIMIT 1;

-- QUERY 843 — I want to know which investor has the lowest portfolio health score among those not meeting their Child Education goals
-- query_id=200843 | userid=74 | start=2026-05-19 08:01:50 | end=2026-05-19 08:01:51 | dur=1139ms | rows=1
SELECT t1.investor_id FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id WHERE t2.investment_goal = 'Child Education' AND t2.progress_pct < 50 ORDER BY (t1.goal_match_pct * 0.3 + t1.risk_score * 0.3 + t1.liquidity_score * 0.2 + t1.diversification_score * 0.2) ASC LIMIT 1;

-- QUERY 844 — Among all investors, who has the lowest portfolio health score among those not meeting their Child Education goals
-- query_id=200844 | userid=95 | start=2026-05-19 10:34:58 | end=2026-05-19 10:34:59 | dur=1477ms | rows=1
SELECT t1.investor_id FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id WHERE t2.investment_goal = 'Child Education' AND t2.progress_pct < 50 ORDER BY (t1.goal_match_pct * 0.3 + t1.risk_score * 0.3 + t1.liquidity_score * 0.2 + t1.diversification_score * 0.2) ASC LIMIT 1;

-- QUERY 845 — Considering all investors in the system, which investor has the lowest portfolio health score among those not meeting th
-- query_id=200845 | userid=12 | start=2026-05-19 13:21:36 | end=2026-05-19 13:21:36 | dur=933ms | rows=1
SELECT t1.investor_id FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id WHERE t2.investment_goal = 'Child Education' AND t2.progress_pct < 50 ORDER BY (t1.goal_match_pct * 0.3 + t1.risk_score * 0.3 + t1.liquidity_score * 0.2 + t1.diversification_score * 0.2) ASC LIMIT 1;

-- QUERY 846 — Which investor has the highest portfolio health score among those not meeting their Child Education goals
-- query_id=200846 | userid=74 | start=2026-05-19 16:57:06 | end=2026-05-19 16:57:07 | dur=1313ms | rows=1
SELECT t1.investor_id FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id WHERE t2.investment_goal = 'Child Education' AND t2.progress_pct < 50 ORDER BY (t1.goal_match_pct * 0.3 + t1.risk_score * 0.3 + t1.liquidity_score * 0.2 + t1.diversification_score * 0.2) DESC LIMIT 1;

-- QUERY 847 — Identify the investor who has the highest portfolio health score among those not meeting their Child Education goals
-- query_id=200847 | userid=68 | start=2026-05-19 18:45:47 | end=2026-05-19 18:45:47 | dur=659ms | rows=1
SELECT t1.investor_id FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id WHERE t2.investment_goal = 'Child Education' AND t2.progress_pct < 50 ORDER BY (t1.goal_match_pct * 0.3 + t1.risk_score * 0.3 + t1.liquidity_score * 0.2 + t1.diversification_score * 0.2) DESC LIMIT 1;

-- QUERY 848 — I want to know which investor has the highest portfolio health score among those not meeting their Child Education goals
-- query_id=200848 | userid=95 | start=2026-05-20 08:18:54 | end=2026-05-20 08:18:55 | dur=1642ms | rows=1
SELECT t1.investor_id FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id WHERE t2.investment_goal = 'Child Education' AND t2.progress_pct < 50 ORDER BY (t1.goal_match_pct * 0.3 + t1.risk_score * 0.3 + t1.liquidity_score * 0.2 + t1.diversification_score * 0.2) DESC LIMIT 1;

-- QUERY 849 — Among all investors, who has the highest portfolio health score among those not meeting their Child Education goals
-- query_id=200849 | userid=42 | start=2026-05-20 08:33:05 | end=2026-05-20 08:33:06 | dur=1608ms | rows=1
SELECT t1.investor_id FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id WHERE t2.investment_goal = 'Child Education' AND t2.progress_pct < 50 ORDER BY (t1.goal_match_pct * 0.3 + t1.risk_score * 0.3 + t1.liquidity_score * 0.2 + t1.diversification_score * 0.2) DESC LIMIT 1;

-- QUERY 850 — Considering all investors in the system, which investor has the highest portfolio health score among those not meeting t
-- query_id=200850 | userid=95 | start=2026-05-20 09:43:22 | end=2026-05-20 09:43:22 | dur=657ms | rows=1
SELECT t1.investor_id FROM ATOM_ENTITY_PORTFOLIO_HEALTH_001 t1 JOIN ATOM_ENTITY_INVESTMENT_GOAL_001 t2 ON t1.investor_id = t2.investor_id WHERE t2.investment_goal = 'Child Education' AND t2.progress_pct < 50 ORDER BY (t1.goal_match_pct * 0.3 + t1.risk_score * 0.3 + t1.liquidity_score * 0.2 + t1.diversification_score * 0.2) DESC LIMIT 1;

-- QUERY 851 — What sector has the highest allocation percentage in investor INV-001's actual portfolio
-- query_id=200851 | userid=23 | start=2026-05-20 11:44:04 | end=2026-05-20 11:44:04 | dur=586ms | rows=1
SELECT sector FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 WHERE investor_id = 'INV-001' ORDER BY allocation_pct DESC LIMIT 1;

-- QUERY 852 — What sector has the highest allocation percentage in investor INV-001's actual portfolio
-- query_id=200852 | userid=12 | start=2026-05-20 11:47:14 | end=2026-05-20 11:47:14 | dur=555ms | rows=1
SELECT sector FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 WHERE investor_id = 'INV-001' ORDER BY allocation_pct DESC LIMIT 1;

-- QUERY 853 — Can you tell me ?¢¬Ä¬î what sector has the highest allocation percentage in investor inv-001's actual portfolio
-- query_id=200853 | userid=81 | start=2026-05-20 12:01:30 | end=2026-05-20 12:01:30 | dur=398ms | rows=1
SELECT sector FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 WHERE investor_id = 'INV-001' ORDER BY allocation_pct DESC LIMIT 1;

-- QUERY 854 — Across the portfolio database, what sector has the highest allocation percentage in investor inv-001's actual portfolio
-- query_id=200854 | userid=55 | start=2026-05-20 12:39:33 | end=2026-05-20 12:39:33 | dur=899ms | rows=1
SELECT sector FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 WHERE investor_id = 'INV-001' ORDER BY allocation_pct DESC LIMIT 1;

-- QUERY 855 — From the complete wealth management dataset, what sector has the highest allocation percentage in investor inv-001's act
-- query_id=200855 | userid=23 | start=2026-05-20 13:27:57 | end=2026-05-20 13:27:58 | dur=1389ms | rows=1
SELECT sector FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 WHERE investor_id = 'INV-001' ORDER BY allocation_pct DESC LIMIT 1;

-- QUERY 856 — Does investor INV-001's highest allocated sector match their stated sector focus
-- query_id=200856 | userid=74 | start=2026-05-20 16:03:34 | end=2026-05-20 16:03:35 | dur=1906ms | rows=1
SELECT CASE WHEN t2.sector = t1.sector_focus THEN 'Yes' ELSE 'No' END FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN (SELECT sector FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 WHERE investor_id = 'INV-001' ORDER BY allocation_pct DESC LIMIT 1) t2 ON t1.investor_id = 'INV-001';

-- QUERY 857 — Does investor INV-001's highest allocated sector match their stated sector focus
-- query_id=200857 | userid=12 | start=2026-05-20 16:47:12 | end=2026-05-20 16:47:13 | dur=1174ms | rows=1
SELECT CASE WHEN t2.sector = t1.sector_focus THEN 'Yes' ELSE 'No' END FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN (SELECT sector FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 WHERE investor_id = 'INV-001' ORDER BY allocation_pct DESC LIMIT 1) t2 ON t1.investor_id = 'INV-001';

-- QUERY 858 — Can you tell me ?¢¬Ä¬î does investor inv-001's highest allocated sector match their stated sector focus
-- query_id=200858 | userid=74 | start=2026-05-20 17:30:44 | end=2026-05-20 17:30:45 | dur=1631ms | rows=1
SELECT CASE WHEN t2.sector = t1.sector_focus THEN 'Yes' ELSE 'No' END FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN (SELECT sector FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 WHERE investor_id = 'INV-001' ORDER BY allocation_pct DESC LIMIT 1) t2 ON t1.investor_id = 'INV-001';

-- QUERY 859 — Across the portfolio database, does investor inv-001's highest allocated sector match their stated sector focus
-- query_id=200859 | userid=55 | start=2026-05-20 17:57:18 | end=2026-05-20 17:57:19 | dur=1054ms | rows=1
SELECT CASE WHEN t2.sector = t1.sector_focus THEN 'Yes' ELSE 'No' END FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN (SELECT sector FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 WHERE investor_id = 'INV-001' ORDER BY allocation_pct DESC LIMIT 1) t2 ON t1.investor_id = 'INV-001';

-- QUERY 860 — From the complete wealth management dataset, does investor inv-001's highest allocated sector match their stated sector 
-- query_id=200860 | userid=74 | start=2026-05-20 18:17:52 | end=2026-05-20 18:17:53 | dur=1085ms | rows=1
SELECT CASE WHEN t2.sector = t1.sector_focus THEN 'Yes' ELSE 'No' END FROM ATOM_ENTITY_INVESTOR_PROFILE_001 t1 JOIN (SELECT sector FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 WHERE investor_id = 'INV-001' ORDER BY allocation_pct DESC LIMIT 1) t2 ON t1.investor_id = 'INV-001';

-- QUERY 861 — How many Gold holdings does investor INV-005 hold
-- query_id=200861 | userid=68 | start=2026-05-20 19:47:28 | end=2026-05-20 19:47:28 | dur=598ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-005' AND (investment_name LIKE '%Gold%' OR investment_type LIKE '%Gold%');

-- QUERY 862 — Provide the count of Gold holdings does investor INV-005 hold
-- query_id=200862 | userid=68 | start=2026-05-21 11:04:02 | end=2026-05-21 11:04:02 | dur=596ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-005' AND (investment_name LIKE '%Gold%' OR investment_type LIKE '%Gold%');

-- QUERY 863 — I need to find out how many Gold holdings does investor INV-005 hold
-- query_id=200863 | userid=55 | start=2026-05-21 12:50:35 | end=2026-05-21 12:50:36 | dur=1039ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-005' AND (investment_name LIKE '%Gold%' OR investment_type LIKE '%Gold%');

-- QUERY 864 — What is the total count of Gold holdings does investor INV-005 hold
-- query_id=200864 | userid=18 | start=2026-05-21 14:55:47 | end=2026-05-21 14:55:47 | dur=351ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-005' AND (investment_name LIKE '%Gold%' OR investment_type LIKE '%Gold%');

-- QUERY 865 — Across the entire investor database, how many Gold holdings does investor INV-005 hold
-- query_id=200865 | userid=68 | start=2026-05-21 15:05:40 | end=2026-05-21 15:05:40 | dur=971ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-005' AND (investment_name LIKE '%Gold%' OR investment_type LIKE '%Gold%');

-- QUERY 866 — How many distinct investment types does investor INV-005 hold
-- query_id=200866 | userid=81 | start=2026-05-21 16:48:39 | end=2026-05-21 16:48:39 | dur=952ms | rows=1
SELECT COUNT(DISTINCT investment_type) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-005';

-- QUERY 867 — Provide the count of distinct investment types does investor INV-005 hold
-- query_id=200867 | userid=55 | start=2026-05-22 09:43:16 | end=2026-05-22 09:43:17 | dur=1075ms | rows=1
SELECT COUNT(DISTINCT investment_type) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-005';

-- QUERY 868 — I need to find out how many distinct investment types does investor INV-005 hold
-- query_id=200868 | userid=74 | start=2026-05-22 11:15:57 | end=2026-05-22 11:15:57 | dur=682ms | rows=1
SELECT COUNT(DISTINCT investment_type) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-005';

-- QUERY 869 — What is the total count of distinct investment types does investor INV-005 hold
-- query_id=200869 | userid=55 | start=2026-05-22 13:44:23 | end=2026-05-22 13:44:23 | dur=977ms | rows=1
SELECT COUNT(DISTINCT investment_type) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-005';

-- QUERY 870 — Across the entire investor database, how many distinct investment types does investor INV-005 hold
-- query_id=200870 | userid=68 | start=2026-05-22 13:58:37 | end=2026-05-22 13:58:37 | dur=864ms | rows=1
SELECT COUNT(DISTINCT investment_type) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-005';

-- QUERY 871 — Which investment type has the highest current value in investor INV-010's portfolio
-- query_id=200871 | userid=42 | start=2026-05-22 16:14:26 | end=2026-05-22 16:14:26 | dur=915ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-010' GROUP BY investment_type ORDER BY SUM(current_value) DESC LIMIT 1;

-- QUERY 872 — Identify the investment type has the highest current value in investor INV-010's portfolio
-- query_id=200872 | userid=12 | start=2026-05-22 16:47:47 | end=2026-05-22 16:47:48 | dur=1114ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-010' GROUP BY investment_type ORDER BY SUM(current_value) DESC LIMIT 1;

-- QUERY 873 — Do you know which investment type has the highest current value in investor INV-010's portfolio
-- query_id=200873 | userid=68 | start=2026-05-22 17:43:31 | end=2026-05-22 17:43:31 | dur=895ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-010' GROUP BY investment_type ORDER BY SUM(current_value) DESC LIMIT 1;

-- QUERY 874 — Out of all options, which investment type has the highest current value in investor INV-010's portfolio
-- query_id=200874 | userid=12 | start=2026-05-25 07:17:02 | end=2026-05-25 07:17:03 | dur=1014ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-010' GROUP BY investment_type ORDER BY SUM(current_value) DESC LIMIT 1;

-- QUERY 875 — Given all the data available, which investment type has the highest current value in investor INV-010's portfolio
-- query_id=200875 | userid=12 | start=2026-05-25 08:03:53 | end=2026-05-25 08:03:54 | dur=1092ms | rows=1
SELECT investment_type FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-010' GROUP BY investment_type ORDER BY SUM(current_value) DESC LIMIT 1;

-- QUERY 876 — What is the total current value of ETF holdings for investor INV-010
-- query_id=200876 | userid=81 | start=2026-05-25 09:41:07 | end=2026-05-25 09:41:07 | dur=568ms | rows=1
SELECT SUM(current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-010' AND investment_type = 'ETF';

-- QUERY 877 — Please provide the total current value of ETF holdings for investor INV-010
-- query_id=200877 | userid=95 | start=2026-05-25 14:02:09 | end=2026-05-25 14:02:09 | dur=641ms | rows=1
SELECT SUM(current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-010' AND investment_type = 'ETF';

-- QUERY 878 — Can you tell me what the total current value of ETF holdings for investor INV-010
-- query_id=200878 | userid=55 | start=2026-05-25 14:24:29 | end=2026-05-25 14:24:29 | dur=695ms | rows=1
SELECT SUM(current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-010' AND investment_type = 'ETF';

-- QUERY 879 — What would be the total current value of ETF holdings for investor INV-010
-- query_id=200879 | userid=18 | start=2026-05-25 14:34:39 | end=2026-05-25 14:34:39 | dur=525ms | rows=1
SELECT SUM(current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-010' AND investment_type = 'ETF';

-- QUERY 880 — Looking at all available records, what is the total current value of ETF holdings for investor INV-010
-- query_id=200880 | userid=68 | start=2026-05-25 15:54:01 | end=2026-05-25 15:54:01 | dur=802ms | rows=1
SELECT SUM(current_value) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-010' AND investment_type = 'ETF';

-- QUERY 881 — How many Redemption transactions has investor INV-008 made
-- query_id=200881 | userid=74 | start=2026-05-25 16:45:14 | end=2026-05-25 16:45:14 | dur=979ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-008' AND type = 'Redemption';

-- QUERY 882 — Provide the count of Redemption transactions has investor INV-008 made
-- query_id=200882 | userid=23 | start=2026-05-25 19:03:07 | end=2026-05-25 19:03:07 | dur=665ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-008' AND type = 'Redemption';

-- QUERY 883 — I need to find out how many Redemption transactions has investor INV-008 made
-- query_id=200883 | userid=81 | start=2026-05-25 19:42:08 | end=2026-05-25 19:42:08 | dur=924ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-008' AND type = 'Redemption';

-- QUERY 884 — What is the total count of Redemption transactions has investor INV-008 made
-- query_id=200884 | userid=81 | start=2026-05-26 08:25:58 | end=2026-05-26 08:25:58 | dur=563ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-008' AND type = 'Redemption';

-- QUERY 885 — Across the entire investor database, how many Redemption transactions has investor INV-008 made
-- query_id=200885 | userid=55 | start=2026-05-26 10:23:45 | end=2026-05-26 10:23:45 | dur=655ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-008' AND type = 'Redemption';

-- QUERY 886 — What is the total amount of Redemption transactions for investor INV-008
-- query_id=200886 | userid=42 | start=2026-05-26 10:38:49 | end=2026-05-26 10:38:49 | dur=740ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-008' AND type = 'Redemption';

-- QUERY 887 — Please provide the total amount of Redemption transactions for investor INV-008
-- query_id=200887 | userid=12 | start=2026-05-26 10:42:21 | end=2026-05-26 10:42:21 | dur=852ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-008' AND type = 'Redemption';

-- QUERY 888 — Can you tell me what the total amount of Redemption transactions for investor INV-008
-- query_id=200888 | userid=55 | start=2026-05-26 12:49:07 | end=2026-05-26 12:49:07 | dur=458ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-008' AND type = 'Redemption';

-- QUERY 889 — What would be the total amount of Redemption transactions for investor INV-008
-- query_id=200889 | userid=74 | start=2026-05-26 14:46:40 | end=2026-05-26 14:46:41 | dur=1031ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-008' AND type = 'Redemption';

-- QUERY 890 — Looking at all available records, what is the total amount of Redemption transactions for investor INV-008
-- query_id=200890 | userid=74 | start=2026-05-26 16:34:40 | end=2026-05-26 16:34:40 | dur=816ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-008' AND type = 'Redemption';

-- QUERY 891 — How many investors have received dividend cash flows sourced from HDFC Bank
-- query_id=200891 | userid=95 | start=2026-05-26 17:28:22 | end=2026-05-26 17:28:22 | dur=465ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Dividend' AND source = 'HDFC Bank';

-- QUERY 892 — Provide the count of investors have received dividend cash flows sourced from HDFC Bank
-- query_id=200892 | userid=74 | start=2026-05-26 19:20:39 | end=2026-05-26 19:20:39 | dur=737ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Dividend' AND source = 'HDFC Bank';

-- QUERY 893 — I need to find out how many investors have received dividend cash flows sourced from HDFC Bank
-- query_id=200893 | userid=12 | start=2026-05-26 19:44:53 | end=2026-05-26 19:44:53 | dur=618ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Dividend' AND source = 'HDFC Bank';

-- QUERY 894 — What is the total count of investors have received dividend cash flows sourced from HDFC Bank
-- query_id=200894 | userid=18 | start=2026-05-27 07:26:54 | end=2026-05-27 07:26:54 | dur=431ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Dividend' AND source = 'HDFC Bank';

-- QUERY 895 — Across the entire investor database, how many investors have received dividend cash flows sourced from HDFC Bank
-- query_id=200895 | userid=81 | start=2026-05-27 07:52:11 | end=2026-05-27 07:52:11 | dur=414ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Dividend' AND source = 'HDFC Bank';

-- QUERY 896 — How many distinct investment categories does investor INV-012 hold
-- query_id=200896 | userid=12 | start=2026-05-27 10:36:02 | end=2026-05-27 10:36:02 | dur=461ms | rows=1
SELECT COUNT(DISTINCT category) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-012';

-- QUERY 897 — Provide the count of distinct investment categories does investor INV-012 hold
-- query_id=200897 | userid=18 | start=2026-05-27 10:58:53 | end=2026-05-27 10:58:53 | dur=499ms | rows=1
SELECT COUNT(DISTINCT category) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-012';

-- QUERY 898 — I need to find out how many distinct investment categories does investor INV-012 hold
-- query_id=200898 | userid=55 | start=2026-05-27 11:55:33 | end=2026-05-27 11:55:33 | dur=624ms | rows=1
SELECT COUNT(DISTINCT category) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-012';

-- QUERY 899 — What is the total count of distinct investment categories does investor INV-012 hold
-- query_id=200899 | userid=68 | start=2026-05-27 11:58:20 | end=2026-05-27 11:58:20 | dur=491ms | rows=1
SELECT COUNT(DISTINCT category) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-012';

-- QUERY 900 — Across the entire investor database, how many distinct investment categories does investor INV-012 hold
-- query_id=200900 | userid=18 | start=2026-05-27 14:17:24 | end=2026-05-27 14:17:24 | dur=475ms | rows=1
SELECT COUNT(DISTINCT category) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-012';

-- QUERY 901 — Which investor has the highest average dividend cash flow amount per transaction
-- query_id=200901 | userid=95 | start=2026-05-27 15:43:12 | end=2026-05-27 15:43:13 | dur=1084ms | rows=1
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Dividend' GROUP BY investor_id ORDER BY AVG(amount) DESC LIMIT 1;

-- QUERY 902 — Identify the investor who has the highest average dividend cash flow amount per transaction
-- query_id=200902 | userid=68 | start=2026-05-27 15:47:27 | end=2026-05-27 15:47:28 | dur=1364ms | rows=1
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Dividend' GROUP BY investor_id ORDER BY AVG(amount) DESC LIMIT 1;

-- QUERY 903 — I want to know which investor has the highest average dividend cash flow amount per transaction
-- query_id=200903 | userid=30 | start=2026-05-27 17:14:43 | end=2026-05-27 17:14:43 | dur=949ms | rows=1
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Dividend' GROUP BY investor_id ORDER BY AVG(amount) DESC LIMIT 1;

-- QUERY 904 — Among all investors, who has the highest average dividend cash flow amount per transaction
-- query_id=200904 | userid=18 | start=2026-05-27 18:12:00 | end=2026-05-27 18:12:00 | dur=777ms | rows=1
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Dividend' GROUP BY investor_id ORDER BY AVG(amount) DESC LIMIT 1;

-- QUERY 905 — Considering all investors in the system, which investor has the highest average dividend cash flow amount per transactio
-- query_id=200905 | userid=74 | start=2026-05-28 08:17:55 | end=2026-05-28 08:17:55 | dur=652ms | rows=1
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Dividend' GROUP BY investor_id ORDER BY AVG(amount) DESC LIMIT 1;

-- QUERY 906 — What is the total dividend cash flow amount for investor INV-020
-- query_id=200906 | userid=18 | start=2026-05-28 08:27:21 | end=2026-05-28 08:27:21 | dur=479ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-020' AND type = 'Dividend';

-- QUERY 907 — Please provide the total dividend cash flow amount for investor INV-020
-- query_id=200907 | userid=95 | start=2026-05-28 09:54:23 | end=2026-05-28 09:54:23 | dur=593ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-020' AND type = 'Dividend';

-- QUERY 908 — Can you tell me what the total dividend cash flow amount for investor INV-020
-- query_id=200908 | userid=81 | start=2026-05-28 11:04:08 | end=2026-05-28 11:04:08 | dur=452ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-020' AND type = 'Dividend';

-- QUERY 909 — What would be the total dividend cash flow amount for investor INV-020
-- query_id=200909 | userid=12 | start=2026-05-28 13:17:03 | end=2026-05-28 13:17:03 | dur=435ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-020' AND type = 'Dividend';

-- QUERY 910 — Looking at all available records, what is the total dividend cash flow amount for investor INV-020
-- query_id=200910 | userid=74 | start=2026-05-28 13:48:45 | end=2026-05-28 13:48:45 | dur=532ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-020' AND type = 'Dividend';

-- QUERY 911 — What is the total dividend cash flow amount for investor INV-049
-- query_id=200911 | userid=30 | start=2026-05-28 14:49:32 | end=2026-05-28 14:49:32 | dur=763ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-049' AND type = 'Dividend';

-- QUERY 912 — Please provide the total dividend cash flow amount for investor INV-049
-- query_id=200912 | userid=18 | start=2026-05-28 14:51:36 | end=2026-05-28 14:51:36 | dur=823ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-049' AND type = 'Dividend';

-- QUERY 913 — Can you tell me what the total dividend cash flow amount for investor INV-049
-- query_id=200913 | userid=95 | start=2026-05-28 15:34:46 | end=2026-05-28 15:34:46 | dur=681ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-049' AND type = 'Dividend';

-- QUERY 914 — What would be the total dividend cash flow amount for investor INV-049
-- query_id=200914 | userid=55 | start=2026-05-28 16:11:08 | end=2026-05-28 16:11:08 | dur=465ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-049' AND type = 'Dividend';

-- QUERY 915 — Looking at all available records, what is the total dividend cash flow amount for investor INV-049
-- query_id=200915 | userid=23 | start=2026-05-28 16:39:46 | end=2026-05-28 16:39:46 | dur=833ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-049' AND type = 'Dividend';

-- QUERY 916 — How many dividend transactions has investor INV-001 made
-- query_id=200916 | userid=74 | start=2026-05-28 19:35:15 | end=2026-05-28 19:35:15 | dur=944ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-001' AND type = 'Dividend';

-- QUERY 917 — Provide the count of dividend transactions has investor INV-001 made
-- query_id=200917 | userid=12 | start=2026-05-29 09:14:52 | end=2026-05-29 09:14:52 | dur=910ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-001' AND type = 'Dividend';

-- QUERY 918 — I need to find out how many dividend transactions has investor INV-001 made
-- query_id=200918 | userid=23 | start=2026-05-29 10:33:52 | end=2026-05-29 10:33:52 | dur=733ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-001' AND type = 'Dividend';

-- QUERY 919 — What is the total count of dividend transactions has investor INV-001 made
-- query_id=200919 | userid=55 | start=2026-05-29 12:02:30 | end=2026-05-29 12:02:30 | dur=865ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-001' AND type = 'Dividend';

-- QUERY 920 — Across the entire investor database, how many dividend transactions has investor INV-001 made
-- query_id=200920 | userid=55 | start=2026-05-29 13:53:30 | end=2026-05-29 13:53:30 | dur=717ms | rows=1
SELECT COUNT(*) FROM ATOM_EVENT_CASH_FLOW_001 WHERE investor_id = 'INV-001' AND type = 'Dividend';

-- QUERY 921 — How many holdings does investor INV-015 have in total
-- query_id=200921 | userid=30 | start=2026-05-29 15:55:45 | end=2026-05-29 15:55:45 | dur=635ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-015';

-- QUERY 922 — Provide the count of holdings does investor INV-015 have in total
-- query_id=200922 | userid=30 | start=2026-05-29 16:57:01 | end=2026-05-29 16:57:01 | dur=336ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-015';

-- QUERY 923 — I need to find out how many holdings does investor INV-015 have in total
-- query_id=200923 | userid=95 | start=2026-05-29 17:02:49 | end=2026-05-29 17:02:49 | dur=636ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-015';

-- QUERY 924 — What is the total count of holdings does investor INV-015 have in total
-- query_id=200924 | userid=18 | start=2026-05-29 18:32:48 | end=2026-05-29 18:32:48 | dur=595ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-015';

-- QUERY 925 — Across the entire investor database, how many holdings does investor INV-015 have in total
-- query_id=200925 | userid=30 | start=2026-05-29 19:15:08 | end=2026-05-29 19:15:09 | dur=1235ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-015';

-- QUERY 926 — What is the earliest purchase date among investor INV-015's holdings
-- query_id=200926 | userid=81 | start=2026-06-01 07:04:03 | end=2026-06-01 07:04:03 | dur=702ms | rows=1
SELECT MIN(purchase_date) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-015';

-- QUERY 927 — Please provide the earliest purchase date among investor INV-015's holdings
-- query_id=200927 | userid=68 | start=2026-06-01 11:36:18 | end=2026-06-01 11:36:18 | dur=795ms | rows=1
SELECT MIN(purchase_date) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-015';

-- QUERY 928 — Can you tell me what the earliest purchase date among investor INV-015's holdings
-- query_id=200928 | userid=18 | start=2026-06-01 14:59:07 | end=2026-06-01 14:59:07 | dur=693ms | rows=1
SELECT MIN(purchase_date) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-015';

-- QUERY 929 — What would be the earliest purchase date among investor INV-015's holdings
-- query_id=200929 | userid=12 | start=2026-06-01 16:48:35 | end=2026-06-01 16:48:35 | dur=857ms | rows=1
SELECT MIN(purchase_date) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-015';

-- QUERY 930 — Looking at all available records, what is the earliest purchase date among investor INV-015's holdings
-- query_id=200930 | userid=30 | start=2026-06-01 17:10:39 | end=2026-06-01 17:10:39 | dur=617ms | rows=1
SELECT MIN(purchase_date) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investor_id = 'INV-015';

-- QUERY 931 — Which sector has the highest maximum total investment amount in sector allocation records
-- query_id=200931 | userid=30 | start=2026-06-01 18:10:18 | end=2026-06-01 18:10:19 | dur=1449ms | rows=1
SELECT sector FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 GROUP BY sector ORDER BY MAX(total_investment) DESC LIMIT 1;

-- QUERY 932 — Identify the sector has the highest maximum total investment amount in sector allocation records
-- query_id=200932 | userid=18 | start=2026-06-02 07:25:48 | end=2026-06-02 07:25:48 | dur=927ms | rows=1
SELECT sector FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 GROUP BY sector ORDER BY MAX(total_investment) DESC LIMIT 1;

-- QUERY 933 — Do you know which sector has the highest maximum total investment amount in sector allocation records
-- query_id=200933 | userid=30 | start=2026-06-02 08:35:29 | end=2026-06-02 08:35:29 | dur=859ms | rows=1
SELECT sector FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 GROUP BY sector ORDER BY MAX(total_investment) DESC LIMIT 1;

-- QUERY 934 — Out of all options, which sector has the highest maximum total investment amount in sector allocation records
-- query_id=200934 | userid=18 | start=2026-06-02 10:58:04 | end=2026-06-02 10:58:05 | dur=1248ms | rows=1
SELECT sector FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 GROUP BY sector ORDER BY MAX(total_investment) DESC LIMIT 1;

-- QUERY 935 — Given all the data available, which sector has the highest maximum total investment amount in sector allocation records
-- query_id=200935 | userid=74 | start=2026-06-02 13:54:05 | end=2026-06-02 13:54:06 | dur=1047ms | rows=1
SELECT sector FROM ATOM_ENTITY_SECTOR_ALLOCATION_001 GROUP BY sector ORDER BY MAX(total_investment) DESC LIMIT 1;

-- QUERY 936 — What is the total number of investors in the wealth management database
-- query_id=200936 | userid=18 | start=2026-06-02 16:56:49 | end=2026-06-02 16:56:49 | dur=960ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001;

-- QUERY 937 — Please provide the total number of investors in the wealth management database
-- query_id=200937 | userid=42 | start=2026-06-02 17:01:15 | end=2026-06-02 17:01:15 | dur=935ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001;

-- QUERY 938 — Can you tell me what the total number of investors in the wealth management database
-- query_id=200938 | userid=68 | start=2026-06-02 17:24:55 | end=2026-06-02 17:24:55 | dur=500ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001;

-- QUERY 939 — What would be the total number of investors in the wealth management database
-- query_id=200939 | userid=68 | start=2026-06-02 18:43:42 | end=2026-06-02 18:43:42 | dur=547ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001;

-- QUERY 940 — Looking at all available records, what is the total number of investors in the wealth management database
-- query_id=200940 | userid=12 | start=2026-06-02 19:35:01 | end=2026-06-02 19:35:01 | dur=486ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_INVESTOR_PROFILE_001;

-- QUERY 941 — How many investors hold Gold investments in their portfolio
-- query_id=200941 | userid=12 | start=2026-06-03 09:35:43 | end=2026-06-03 09:35:43 | dur=818ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_name LIKE '%Gold%' OR investment_type LIKE '%Gold%';

-- QUERY 942 — Provide the count of investors hold Gold investments in their portfolio
-- query_id=200942 | userid=55 | start=2026-06-03 09:41:44 | end=2026-06-03 09:41:44 | dur=671ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_name LIKE '%Gold%' OR investment_type LIKE '%Gold%';

-- QUERY 943 — I need to find out how many investors hold Gold investments in their portfolio
-- query_id=200943 | userid=23 | start=2026-06-03 12:50:42 | end=2026-06-03 12:50:42 | dur=636ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_name LIKE '%Gold%' OR investment_type LIKE '%Gold%';

-- QUERY 944 — What is the total count of investors hold Gold investments in their portfolio
-- query_id=200944 | userid=55 | start=2026-06-03 13:07:09 | end=2026-06-03 13:07:09 | dur=517ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_name LIKE '%Gold%' OR investment_type LIKE '%Gold%';

-- QUERY 945 — Across the entire investor database, how many investors hold Gold investments in their portfolio
-- query_id=200945 | userid=74 | start=2026-06-03 14:50:10 | end=2026-06-03 14:50:10 | dur=462ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_name LIKE '%Gold%' OR investment_type LIKE '%Gold%';

-- QUERY 946 — Which investor holds the highest total Gold investment value
-- query_id=200946 | userid=12 | start=2026-06-03 15:28:54 | end=2026-06-03 15:28:54 | dur=917ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_name LIKE '%Gold%' OR investment_type LIKE '%Gold%' GROUP BY investor_id ORDER BY SUM(current_value) DESC LIMIT 1;

-- QUERY 947 — Identify the investor who holds the highest total Gold investment value
-- query_id=200947 | userid=55 | start=2026-06-03 16:06:03 | end=2026-06-03 16:06:04 | dur=1042ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_name LIKE '%Gold%' OR investment_type LIKE '%Gold%' GROUP BY investor_id ORDER BY SUM(current_value) DESC LIMIT 1;

-- QUERY 948 — I want to know which investor holds the highest total Gold investment value
-- query_id=200948 | userid=74 | start=2026-06-03 16:33:14 | end=2026-06-03 16:33:15 | dur=1414ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_name LIKE '%Gold%' OR investment_type LIKE '%Gold%' GROUP BY investor_id ORDER BY SUM(current_value) DESC LIMIT 1;

-- QUERY 949 — Among all investors, which one holds the highest total Gold investment value
-- query_id=200949 | userid=95 | start=2026-06-03 17:24:43 | end=2026-06-03 17:24:43 | dur=525ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_name LIKE '%Gold%' OR investment_type LIKE '%Gold%' GROUP BY investor_id ORDER BY SUM(current_value) DESC LIMIT 1;

-- QUERY 950 — Considering all investors in the system, which investor holds the highest total Gold investment value
-- query_id=200950 | userid=30 | start=2026-06-03 18:08:18 | end=2026-06-03 18:08:19 | dur=1191ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_name LIKE '%Gold%' OR investment_type LIKE '%Gold%' GROUP BY investor_id ORDER BY SUM(current_value) DESC LIMIT 1;

-- QUERY 951 — Which investor holds the lowest total Gold investment value
-- query_id=200951 | userid=55 | start=2026-06-03 19:21:26 | end=2026-06-03 19:21:27 | dur=1054ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_name LIKE '%Gold%' OR investment_type LIKE '%Gold%' GROUP BY investor_id ORDER BY SUM(current_value) ASC LIMIT 1;

-- QUERY 952 — Identify the investor who holds the lowest total Gold investment value
-- query_id=200952 | userid=12 | start=2026-06-04 10:34:43 | end=2026-06-04 10:34:44 | dur=1121ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_name LIKE '%Gold%' OR investment_type LIKE '%Gold%' GROUP BY investor_id ORDER BY SUM(current_value) ASC LIMIT 1;

-- QUERY 953 — I want to know which investor holds the lowest total Gold investment value
-- query_id=200953 | userid=95 | start=2026-06-04 13:44:39 | end=2026-06-04 13:44:40 | dur=1061ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_name LIKE '%Gold%' OR investment_type LIKE '%Gold%' GROUP BY investor_id ORDER BY SUM(current_value) ASC LIMIT 1;

-- QUERY 954 — Among all investors, which one holds the lowest total Gold investment value
-- query_id=200954 | userid=42 | start=2026-06-04 14:11:55 | end=2026-06-04 14:11:56 | dur=1385ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_name LIKE '%Gold%' OR investment_type LIKE '%Gold%' GROUP BY investor_id ORDER BY SUM(current_value) ASC LIMIT 1;

-- QUERY 955 — Considering all investors in the system, which investor holds the lowest total Gold investment value
-- query_id=200955 | userid=30 | start=2026-06-04 14:17:50 | end=2026-06-04 14:17:50 | dur=806ms | rows=1
SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE investment_name LIKE '%Gold%' OR investment_type LIKE '%Gold%' GROUP BY investor_id ORDER BY SUM(current_value) ASC LIMIT 1;

-- QUERY 956 — How many unique investors currently have active Sell rebalancing recommendations
-- query_id=200956 | userid=18 | start=2026-06-04 14:41:15 | end=2026-06-04 14:41:15 | dur=529ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_EVENT_REBALANCING_ACTION_001 WHERE action LIKE '%Sell%';

-- QUERY 957 — Provide the count of unique investors currently have active Sell rebalancing recommendations
-- query_id=200957 | userid=23 | start=2026-06-04 15:09:55 | end=2026-06-04 15:09:55 | dur=992ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_EVENT_REBALANCING_ACTION_001 WHERE action LIKE '%Sell%';

-- QUERY 958 — I need to find out how many unique investors currently have active Sell rebalancing recommendations
-- query_id=200958 | userid=23 | start=2026-06-04 19:38:41 | end=2026-06-04 19:38:41 | dur=822ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_EVENT_REBALANCING_ACTION_001 WHERE action LIKE '%Sell%';

-- QUERY 959 — What is the total count of unique investors currently have active Sell rebalancing recommendations
-- query_id=200959 | userid=95 | start=2026-06-05 07:39:21 | end=2026-06-05 07:39:21 | dur=638ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_EVENT_REBALANCING_ACTION_001 WHERE action LIKE '%Sell%';

-- QUERY 960 — Across the entire investor database, how many unique investors currently have active Sell rebalancing recommendations
-- query_id=200960 | userid=23 | start=2026-06-05 07:44:37 | end=2026-06-05 07:44:37 | dur=480ms | rows=1
SELECT COUNT(DISTINCT investor_id) FROM ATOM_EVENT_REBALANCING_ACTION_001 WHERE action LIKE '%Sell%';

-- QUERY 961 — What was the total cash inflow from deposits and SIP contributions in the last 12 months
-- query_id=200961 | userid=81 | start=2026-06-05 11:01:53 | end=2026-06-05 11:01:53 | dur=739ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type IN ('Deposit', 'SIP') AND date >= date('now', '-12 months');

-- QUERY 962 — What was the total cash inflow from deposits and SIP contributions in the last 12 months
-- query_id=200962 | userid=18 | start=2026-06-05 13:22:40 | end=2026-06-05 13:22:40 | dur=501ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type IN ('Deposit', 'SIP') AND date >= date('now', '-12 months');

-- QUERY 963 — Can you tell me ?¢¬Ä¬î what was the total cash inflow from deposits and sip contributions in the last 12 months
-- query_id=200963 | userid=74 | start=2026-06-05 13:37:14 | end=2026-06-05 13:37:14 | dur=626ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type IN ('Deposit', 'SIP') AND date >= date('now', '-12 months');

-- QUERY 964 — Across the portfolio database, what was the total cash inflow from deposits and sip contributions in the last 12 months
-- query_id=200964 | userid=74 | start=2026-06-05 14:08:19 | end=2026-06-05 14:08:19 | dur=524ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type IN ('Deposit', 'SIP') AND date >= date('now', '-12 months');

-- QUERY 965 — From the complete wealth management dataset, what was the total cash inflow from deposits and sip contributions in the l
-- query_id=200965 | userid=12 | start=2026-06-05 14:25:54 | end=2026-06-05 14:25:54 | dur=521ms | rows=1
SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type IN ('Deposit', 'SIP') AND date >= date('now', '-12 months');

-- QUERY 966 — Which investor has the highest total deposit amount
-- query_id=200966 | userid=68 | start=2026-06-05 14:52:19 | end=2026-06-05 14:52:20 | dur=1390ms | rows=1
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Deposit' GROUP BY investor_id ORDER BY SUM(amount) DESC LIMIT 1;

-- QUERY 967 — Identify the investor who has the highest total deposit amount
-- query_id=200967 | userid=18 | start=2026-06-05 17:16:25 | end=2026-06-05 17:16:25 | dur=828ms | rows=1
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Deposit' GROUP BY investor_id ORDER BY SUM(amount) DESC LIMIT 1;

-- QUERY 968 — I want to know which investor has the highest total deposit amount
-- query_id=200968 | userid=81 | start=2026-06-05 18:41:12 | end=2026-06-05 18:41:13 | dur=1172ms | rows=1
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Deposit' GROUP BY investor_id ORDER BY SUM(amount) DESC LIMIT 1;

-- QUERY 969 — Among all investors, who has the highest total deposit amount
-- query_id=200969 | userid=55 | start=2026-06-08 08:04:03 | end=2026-06-08 08:04:04 | dur=1005ms | rows=1
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Deposit' GROUP BY investor_id ORDER BY SUM(amount) DESC LIMIT 1;

-- QUERY 970 — Considering all investors in the system, which investor has the highest total deposit amount
-- query_id=200970 | userid=18 | start=2026-06-08 10:56:38 | end=2026-06-08 10:56:39 | dur=1157ms | rows=1
SELECT investor_id FROM ATOM_EVENT_CASH_FLOW_001 WHERE type = 'Deposit' GROUP BY investor_id ORDER BY SUM(amount) DESC LIMIT 1;

-- QUERY 971 — What is the withdrawal to deposit ratio for all investors
-- query_id=200971 | userid=18 | start=2026-06-08 13:34:09 | end=2026-06-08 13:34:09 | dur=773ms | rows=1
SELECT (SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type IN ('Withdrawal', 'Redemption', 'SWP')) * 1.0 / (SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type IN ('Deposit', 'SIP', 'Lump Sum')) as ratio;

-- QUERY 972 — Please provide the withdrawal to deposit ratio for all investors
-- query_id=200972 | userid=55 | start=2026-06-08 14:06:46 | end=2026-06-08 14:06:46 | dur=712ms | rows=1
SELECT (SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type IN ('Withdrawal', 'Redemption', 'SWP')) * 1.0 / (SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type IN ('Deposit', 'SIP', 'Lump Sum')) as ratio;

-- QUERY 973 — Can you tell me what the withdrawal to deposit ratio for all investors
-- query_id=200973 | userid=95 | start=2026-06-08 14:59:20 | end=2026-06-08 14:59:20 | dur=531ms | rows=1
SELECT (SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type IN ('Withdrawal', 'Redemption', 'SWP')) * 1.0 / (SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type IN ('Deposit', 'SIP', 'Lump Sum')) as ratio;

-- QUERY 974 — What would be the withdrawal to deposit ratio for all investors
-- query_id=200974 | userid=55 | start=2026-06-08 15:58:52 | end=2026-06-08 15:58:53 | dur=1000ms | rows=1
SELECT (SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type IN ('Withdrawal', 'Redemption', 'SWP')) * 1.0 / (SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type IN ('Deposit', 'SIP', 'Lump Sum')) as ratio;

-- QUERY 975 — Looking at all available records, what is the withdrawal to deposit ratio for all investors
-- query_id=200975 | userid=12 | start=2026-06-09 07:58:36 | end=2026-06-09 07:58:36 | dur=806ms | rows=1
SELECT (SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type IN ('Withdrawal', 'Redemption', 'SWP')) * 1.0 / (SELECT SUM(amount) FROM ATOM_EVENT_CASH_FLOW_001 WHERE type IN ('Deposit', 'SIP', 'Lump Sum')) as ratio;

-- QUERY 976 — Which holdings in the Technology sector belong to investors who have pending Sell rebalancing actions
-- query_id=200976 | userid=74 | start=2026-06-09 08:02:15 | end=2026-06-09 08:02:16 | dur=1278ms | rows=421
SELECT DISTINCT t1.investor_id, t1.investment_name FROM
     ATOM_ENTITY_PORTFOLIO_HOLDING_001 t1 JOIN ATOM_EVENT_REBALANCING_ACTION_001
     t2 ON t1.investor_id = t2.investor_id WHERE t1.sector = 'Technology' AND
     t2.action LIKE '%Sell%';

-- QUERY 977 — Identify the holdings in the Technology sector belong to investors who have pending Sell rebalancing actions
-- query_id=200977 | userid=74 | start=2026-06-09 08:57:38 | end=2026-06-09 08:57:38 | dur=991ms | rows=229
SELECT DISTINCT t1.investor_id, t1.investment_name FROM
     ATOM_ENTITY_PORTFOLIO_HOLDING_001 t1 JOIN ATOM_EVENT_REBALANCING_ACTION_001
     t2 ON t1.investor_id = t2.investor_id WHERE t1.sector = 'Technology' AND
     t2.action LIKE '%Sell%';

-- QUERY 978 — Do you know which holdings in the Technology sector belong to investors who have pending Sell rebalancing actions
-- query_id=200978 | userid=74 | start=2026-06-09 12:06:01 | end=2026-06-09 12:06:02 | dur=1215ms | rows=161
SELECT DISTINCT t1.investor_id, t1.investment_name FROM
     ATOM_ENTITY_PORTFOLIO_HOLDING_001 t1 JOIN ATOM_EVENT_REBALANCING_ACTION_001
     t2 ON t1.investor_id = t2.investor_id WHERE t1.sector = 'Technology' AND
     t2.action LIKE '%Sell%';

-- QUERY 979 — Out of all options, which holdings in the Technology sector belong to investors who have pending Sell rebalancing action
-- query_id=200979 | userid=12 | start=2026-06-09 13:52:39 | end=2026-06-09 13:52:39 | dur=927ms | rows=395
SELECT DISTINCT t1.investor_id, t1.investment_name FROM
     ATOM_ENTITY_PORTFOLIO_HOLDING_001 t1 JOIN ATOM_EVENT_REBALANCING_ACTION_001
     t2 ON t1.investor_id = t2.investor_id WHERE t1.sector = 'Technology' AND
     t2.action LIKE '%Sell%';

-- QUERY 980 — Given all the data available, which holdings in the Technology sector belong to investors who have pending Sell rebalanc
-- query_id=200980 | userid=81 | start=2026-06-09 15:20:11 | end=2026-06-09 15:20:11 | dur=985ms | rows=83
SELECT DISTINCT t1.investor_id, t1.investment_name FROM
     ATOM_ENTITY_PORTFOLIO_HOLDING_001 t1 JOIN ATOM_EVENT_REBALANCING_ACTION_001
     t2 ON t1.investor_id = t2.investor_id WHERE t1.sector = 'Technology' AND
     t2.action LIKE '%Sell%';

-- QUERY 981 — What is the average new allocation percentage for No Change scenario rebalancing events
-- query_id=200981 | userid=55 | start=2026-06-09 16:20:23 | end=2026-06-09 16:20:23 | dur=759ms | rows=1
SELECT AVG(new_allocation_pct) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE new_allocation_pct = current_allocation_pct;

-- QUERY 982 — Please provide the average new allocation percentage for No Change scenario rebalancing events
-- query_id=200982 | userid=68 | start=2026-06-09 16:23:17 | end=2026-06-09 16:23:17 | dur=418ms | rows=1
SELECT AVG(new_allocation_pct) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE new_allocation_pct = current_allocation_pct;

-- QUERY 983 — Can you tell me what the average new allocation percentage for No Change scenario rebalancing events
-- query_id=200983 | userid=95 | start=2026-06-09 16:44:32 | end=2026-06-09 16:44:32 | dur=993ms | rows=1
SELECT AVG(new_allocation_pct) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE new_allocation_pct = current_allocation_pct;

-- QUERY 984 — What would be the average new allocation percentage for No Change scenario rebalancing events
-- query_id=200984 | userid=12 | start=2026-06-10 08:12:07 | end=2026-06-10 08:12:07 | dur=890ms | rows=1
SELECT AVG(new_allocation_pct) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE new_allocation_pct = current_allocation_pct;

-- QUERY 985 — Looking at all available records, what is the average new allocation percentage for No Change scenario rebalancing event
-- query_id=200985 | userid=18 | start=2026-06-10 12:22:49 | end=2026-06-10 12:22:49 | dur=753ms | rows=1
SELECT AVG(new_allocation_pct) FROM ATOM_EVENT_SCENARIO_REBALANCING_001 WHERE new_allocation_pct = current_allocation_pct;

-- QUERY 986 — How many investors have total taxes paid above 500,000
-- query_id=200986 | userid=55 | start=2026-06-10 16:03:11 | end=2026-06-10 16:03:12 | dur=1172ms | rows=7
SELECT COUNT(*) FROM (SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id HAVING SUM(taxes_paid) > 500000);

-- QUERY 987 — Provide the count of investors have total taxes paid above 500,000
-- query_id=200987 | userid=18 | start=2026-06-11 07:29:13 | end=2026-06-11 07:29:14 | dur=1228ms | rows=6
SELECT COUNT(*) FROM (SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id HAVING SUM(taxes_paid) > 500000);

-- QUERY 988 — I need to find out how many investors have total taxes paid above 500,000
-- query_id=200988 | userid=30 | start=2026-06-11 08:57:30 | end=2026-06-11 08:57:31 | dur=1053ms | rows=21
SELECT COUNT(*) FROM (SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id HAVING SUM(taxes_paid) > 500000);

-- QUERY 989 — What is the total count of investors have total taxes paid above 500,000
-- query_id=200989 | userid=95 | start=2026-06-11 09:15:20 | end=2026-06-11 09:15:21 | dur=1556ms | rows=16
SELECT COUNT(*) FROM (SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id HAVING SUM(taxes_paid) > 500000);

-- QUERY 990 — Across the entire investor database, how many investors have total taxes paid above 500,000
-- query_id=200990 | userid=18 | start=2026-06-11 10:20:55 | end=2026-06-11 10:20:57 | dur=2153ms | rows=20
SELECT COUNT(*) FROM (SELECT investor_id FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 GROUP BY investor_id HAVING SUM(taxes_paid) > 500000);

-- QUERY 991 — Which sector focus combination is the most common among investors
-- query_id=200991 | userid=74 | start=2026-06-11 11:50:32 | end=2026-06-11 11:50:32 | dur=760ms | rows=13
SELECT sector_focus, COUNT(*) as investor_count FROM ATOM_ENTITY_INVESTOR_PROFILE_001 GROUP BY sector_focus ORDER BY investor_count DESC;

-- QUERY 992 — Identify the sector focus combination is the most common among investors
-- query_id=200992 | userid=42 | start=2026-06-11 11:59:14 | end=2026-06-11 11:59:14 | dur=841ms | rows=9
SELECT sector_focus, COUNT(*) as investor_count FROM ATOM_ENTITY_INVESTOR_PROFILE_001 GROUP BY sector_focus ORDER BY investor_count DESC;

-- QUERY 993 — Do you know which sector focus combination is the most common among investors
-- query_id=200993 | userid=23 | start=2026-06-11 12:20:16 | end=2026-06-11 12:20:17 | dur=1394ms | rows=14
SELECT sector_focus, COUNT(*) as investor_count FROM ATOM_ENTITY_INVESTOR_PROFILE_001 GROUP BY sector_focus ORDER BY investor_count DESC;

-- QUERY 994 — Out of all options, which sector focus combination is the most common among investors
-- query_id=200994 | userid=12 | start=2026-06-11 13:02:53 | end=2026-06-11 13:02:54 | dur=1229ms | rows=23
SELECT sector_focus, COUNT(*) as investor_count FROM ATOM_ENTITY_INVESTOR_PROFILE_001 GROUP BY sector_focus ORDER BY investor_count DESC;

-- QUERY 995 — Given all the data available, which sector focus combination is the most common among investors
-- query_id=200995 | userid=18 | start=2026-06-11 13:31:18 | end=2026-06-11 13:31:19 | dur=1482ms | rows=13
SELECT sector_focus, COUNT(*) as investor_count FROM ATOM_ENTITY_INVESTOR_PROFILE_001 GROUP BY sector_focus ORDER BY investor_count DESC;

-- QUERY 996 — How many holdings were purchased before 2022 and are still held by investors
-- query_id=200996 | userid=18 | start=2026-06-11 14:04:05 | end=2026-06-11 14:04:05 | dur=780ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date < '2022-01-01';

-- QUERY 997 — Provide the count of holdings were purchased before 2022 and are still held by investors
-- query_id=200997 | userid=74 | start=2026-06-11 16:19:45 | end=2026-06-11 16:19:45 | dur=527ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date < '2022-01-01';

-- QUERY 998 — I need to find out how many holdings were purchased before 2022 and are still held by investors
-- query_id=200998 | userid=74 | start=2026-06-11 17:18:38 | end=2026-06-11 17:18:38 | dur=656ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date < '2022-01-01';

-- QUERY 999 — What is the total count of holdings were purchased before 2022 and are still held by investors
-- query_id=200999 | userid=12 | start=2026-06-11 17:33:15 | end=2026-06-11 17:33:15 | dur=364ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date < '2022-01-01';

-- QUERY 1000 — Across the entire investor database, how many holdings were purchased before 2022 and are still held by investors
-- query_id=201000 | userid=74 | start=2026-06-11 19:42:43 | end=2026-06-11 19:42:43 | dur=342ms | rows=1
SELECT COUNT(*) FROM ATOM_ENTITY_PORTFOLIO_HOLDING_001 WHERE purchase_date < '2022-01-01';


-- =============================================================================
-- END OF SYNTHETIC QUERY LOG
-- Total queries: 1000
-- =============================================================================
