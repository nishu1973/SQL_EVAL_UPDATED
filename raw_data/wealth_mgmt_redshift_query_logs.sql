-- =============================================================================
-- SYNTHETIC REDSHIFT QUERY LOGS — WEALTH MANAGEMENT
-- Generated: 2026-06-13
-- Environment: NeoSapients / Wealth AI Insights Platform
-- Cluster: neos-wealth-prod-rs-01  |  Database: wealthdb
-- Note: All data is synthetic. No real client, account, or advisor information.
-- =============================================================================

-- ─────────────────────────────────────────────────────────────────────────────
-- LOG FORMAT (emulated from STL_QUERY / SVL_QLOG):
--   query_id | userid | starttime            | endtime              | duration_ms | rows_returned | query_text
-- ─────────────────────────────────────────────────────────────────────────────

-- QUERY 1 — AUM by advisor (monthly snapshot)
-- query_id=100101 | userid=42 | start=2026-06-01 08:02:14 | end=2026-06-01 08:02:16 | dur=1820ms | rows=38
SELECT
    a.advisor_id,
    a.advisor_name,
    a.region,
    SUM(p.aum_usd)          AS total_aum,
    COUNT(DISTINCT p.client_id) AS client_count
FROM dim_advisors a
JOIN fact_portfolios p ON a.advisor_id = p.advisor_id
WHERE p.snapshot_date = '2026-05-31'
GROUP BY 1, 2, 3
ORDER BY total_aum DESC;

-- QUERY 2 — Top 10 clients by net worth tier
-- query_id=100102 | userid=55 | start=2026-06-01 08:15:03 | end=2026-06-01 08:15:05 | dur=2210ms | rows=10
SELECT
    c.client_id,
    c.client_segment,
    c.risk_profile,
    SUM(p.market_value_usd) AS total_portfolio_value,
    NTILE(4) OVER (ORDER BY SUM(p.market_value_usd) DESC) AS wealth_quartile
FROM dim_clients c
JOIN fact_holdings p ON c.client_id = p.client_id
WHERE p.as_of_date = CURRENT_DATE - 1
GROUP BY 1, 2, 3
ORDER BY total_portfolio_value DESC
LIMIT 10;

-- QUERY 3 — Asset allocation breakdown by asset class
-- query_id=100103 | userid=42 | start=2026-06-01 08:30:44 | end=2026-06-01 08:30:47 | dur=2975ms | rows=7
SELECT
    h.asset_class,
    SUM(h.market_value_usd)                                      AS total_value,
    ROUND(100.0 * SUM(h.market_value_usd) /
          SUM(SUM(h.market_value_usd)) OVER (), 2)               AS pct_of_total
FROM fact_holdings h
WHERE h.as_of_date = CURRENT_DATE - 1
  AND h.portfolio_type = 'DISCRETIONARY'
GROUP BY 1
ORDER BY total_value DESC;

-- QUERY 4 — Daily portfolio return vs benchmark (S&P 500)
-- query_id=100104 | userid=30 | start=2026-06-01 09:00:01 | end=2026-06-01 09:00:04 | dur=3410ms | rows=250
SELECT
    r.portfolio_id,
    r.return_date,
    r.daily_return_pct,
    b.benchmark_return_pct,
    r.daily_return_pct - b.benchmark_return_pct AS active_return_pct
FROM fact_portfolio_returns r
JOIN fact_benchmark_returns b
    ON r.return_date = b.benchmark_date
   AND b.benchmark_name = 'SP500'
WHERE r.return_date BETWEEN '2026-01-01' AND '2026-05-31'
ORDER BY r.portfolio_id, r.return_date;

-- QUERY 5 — Rebalancing candidates (drift > 5% from target)
-- query_id=100105 | userid=55 | start=2026-06-01 09:12:30 | end=2026-06-01 09:12:33 | dur=2650ms | rows=19
SELECT
    h.portfolio_id,
    h.asset_class,
    t.target_weight_pct,
    ROUND(100.0 * SUM(h.market_value_usd) /
          SUM(SUM(h.market_value_usd)) OVER (PARTITION BY h.portfolio_id), 2) AS current_weight_pct,
    ABS(ROUND(100.0 * SUM(h.market_value_usd) /
              SUM(SUM(h.market_value_usd)) OVER (PARTITION BY h.portfolio_id), 2)
        - t.target_weight_pct)                                                AS drift_pct
FROM fact_holdings h
JOIN dim_target_allocations t
    ON h.portfolio_id = t.portfolio_id
   AND h.asset_class  = t.asset_class
WHERE h.as_of_date = CURRENT_DATE - 1
GROUP BY 1, 2, 3
HAVING ABS(ROUND(100.0 * SUM(h.market_value_usd) /
                 SUM(SUM(h.market_value_usd)) OVER (PARTITION BY h.portfolio_id), 2)
           - t.target_weight_pct) > 5.0
ORDER BY drift_pct DESC;

-- QUERY 6 — Transaction volume by trade type (last 30 days)
-- query_id=100106 | userid=42 | start=2026-06-01 09:25:11 | end=2026-06-01 09:25:13 | dur=1590ms | rows=6
SELECT
    t.trade_type,
    COUNT(*)              AS trade_count,
    SUM(t.notional_usd)   AS total_notional,
    AVG(t.notional_usd)   AS avg_trade_size
FROM fact_trades t
WHERE t.trade_date >= CURRENT_DATE - 30
  AND t.trade_status = 'SETTLED'
GROUP BY 1
ORDER BY total_notional DESC;

-- QUERY 7 — Fee revenue by product line (YTD)
-- query_id=100107 | userid=68 | start=2026-06-01 09:40:05 | end=2026-06-01 09:40:09 | dur=4120ms | rows=12
SELECT
    p.product_line,
    p.fee_structure,
    SUM(f.management_fee_usd)  AS mgmt_fee_ytd,
    SUM(f.performance_fee_usd) AS perf_fee_ytd,
    SUM(f.management_fee_usd + f.performance_fee_usd) AS total_fee_ytd
FROM fact_fees f
JOIN dim_products p ON f.product_id = p.product_id
WHERE f.fee_date BETWEEN DATE_TRUNC('year', CURRENT_DATE) AND CURRENT_DATE - 1
GROUP BY 1, 2
ORDER BY total_fee_ytd DESC;

-- QUERY 8 — Client risk profile distribution
-- query_id=100108 | userid=30 | start=2026-06-01 10:00:00 | end=2026-06-01 10:00:01 | dur=880ms | rows=5
SELECT
    c.risk_profile,
    COUNT(DISTINCT c.client_id)          AS client_count,
    ROUND(100.0 * COUNT(DISTINCT c.client_id) /
          SUM(COUNT(DISTINCT c.client_id)) OVER (), 2) AS pct_of_clients
FROM dim_clients c
WHERE c.is_active = TRUE
GROUP BY 1
ORDER BY client_count DESC;

-- QUERY 9 — Fixed income holdings by credit rating
-- query_id=100109 | userid=55 | start=2026-06-01 10:15:22 | end=2026-06-01 10:15:26 | dur=3780ms | rows=8
SELECT
    s.credit_rating,
    s.rating_agency,
    COUNT(DISTINCT h.security_id)   AS security_count,
    SUM(h.market_value_usd)         AS total_exposure,
    AVG(s.duration_years)           AS avg_duration
FROM fact_holdings h
JOIN dim_securities s ON h.security_id = s.security_id
WHERE h.as_of_date = CURRENT_DATE - 1
  AND s.asset_class = 'FIXED_INCOME'
GROUP BY 1, 2
ORDER BY total_exposure DESC;

-- QUERY 10 — Equity sector concentration
-- query_id=100110 | userid=42 | start=2026-06-01 10:30:45 | end=2026-06-01 10:30:49 | dur=3210ms | rows=11
SELECT
    s.gics_sector,
    SUM(h.market_value_usd)                                      AS sector_value,
    ROUND(100.0 * SUM(h.market_value_usd) /
          SUM(SUM(h.market_value_usd)) OVER (), 2)               AS sector_weight_pct,
    COUNT(DISTINCT h.security_id)                                AS security_count
FROM fact_holdings h
JOIN dim_securities s ON h.security_id = s.security_id
WHERE h.as_of_date = CURRENT_DATE - 1
  AND s.asset_class = 'EQUITY'
GROUP BY 1
ORDER BY sector_value DESC;

-- QUERY 11 — Rolling 12-month Sharpe ratio by portfolio
-- query_id=100111 | userid=68 | start=2026-06-01 11:00:10 | end=2026-06-01 11:00:16 | dur=5940ms | rows=120
SELECT
    portfolio_id,
    ROUND(AVG(daily_return_pct), 6)                             AS avg_daily_return,
    ROUND(STDDEV(daily_return_pct), 6)                          AS stddev_daily_return,
    ROUND((AVG(daily_return_pct) - (0.0525 / 252)) /
           NULLIF(STDDEV(daily_return_pct), 0) * SQRT(252), 4)  AS sharpe_ratio_annualized
FROM fact_portfolio_returns
WHERE return_date BETWEEN CURRENT_DATE - 365 AND CURRENT_DATE - 1
GROUP BY 1
ORDER BY sharpe_ratio_annualized DESC;

-- QUERY 12 — Cash drag analysis (idle cash > 3% of portfolio)
-- query_id=100112 | userid=30 | start=2026-06-01 11:20:33 | end=2026-06-01 11:20:36 | dur=2830ms | rows=14
SELECT
    h.portfolio_id,
    SUM(CASE WHEN s.asset_class = 'CASH' THEN h.market_value_usd ELSE 0 END) AS cash_value,
    SUM(h.market_value_usd)                                                   AS total_value,
    ROUND(100.0 * SUM(CASE WHEN s.asset_class = 'CASH' THEN h.market_value_usd ELSE 0 END)
          / NULLIF(SUM(h.market_value_usd), 0), 2)                            AS cash_pct
FROM fact_holdings h
JOIN dim_securities s ON h.security_id = s.security_id
WHERE h.as_of_date = CURRENT_DATE - 1
GROUP BY 1
HAVING ROUND(100.0 * SUM(CASE WHEN s.asset_class = 'CASH' THEN h.market_value_usd ELSE 0 END)
             / NULLIF(SUM(h.market_value_usd), 0), 2) > 3.0
ORDER BY cash_pct DESC;

-- QUERY 13 — Client onboarding funnel (last quarter)
-- query_id=100113 | userid=55 | start=2026-06-01 11:35:00 | end=2026-06-01 11:35:02 | dur=1470ms | rows=5
SELECT
    stage,
    COUNT(*)                                                AS prospects,
    ROUND(100.0 * COUNT(*) / MAX(COUNT(*)) OVER (), 2)     AS conversion_rate_pct
FROM fact_onboarding_pipeline
WHERE initiated_date BETWEEN '2026-01-01' AND '2026-03-31'
GROUP BY 1
ORDER BY FIELD(stage, 'LEAD','QUALIFIED','KYC_COMPLETE','FUNDED','ACTIVE');

-- QUERY 14 — ESG score distribution across holdings
-- query_id=100114 | userid=42 | start=2026-06-01 12:00:05 | end=2026-06-01 12:00:09 | dur=3610ms | rows=5
SELECT
    CASE
        WHEN s.esg_score >= 80 THEN 'AAA (80-100)'
        WHEN s.esg_score >= 60 THEN 'A (60-79)'
        WHEN s.esg_score >= 40 THEN 'B (40-59)'
        WHEN s.esg_score >= 20 THEN 'C (20-39)'
        ELSE                        'D (<20)'
    END                            AS esg_band,
    COUNT(DISTINCT h.security_id)  AS security_count,
    SUM(h.market_value_usd)        AS total_exposure
FROM fact_holdings h
JOIN dim_securities s ON h.security_id = s.security_id
WHERE h.as_of_date = CURRENT_DATE - 1
GROUP BY 1
ORDER BY esg_band;

-- QUERY 15 — Dividend income projection (next 90 days)
-- query_id=100115 | userid=68 | start=2026-06-01 12:15:44 | end=2026-06-01 12:15:49 | dur=4470ms | rows=320
SELECT
    h.portfolio_id,
    s.ticker,
    s.security_name,
    d.ex_dividend_date,
    d.dividend_per_share,
    h.quantity * d.dividend_per_share AS projected_income_usd
FROM fact_holdings h
JOIN dim_securities s ON h.security_id = s.security_id
JOIN dim_dividend_calendar d ON s.security_id = d.security_id
WHERE h.as_of_date = CURRENT_DATE - 1
  AND d.ex_dividend_date BETWEEN CURRENT_DATE AND CURRENT_DATE + 90
ORDER BY h.portfolio_id, d.ex_dividend_date;

-- QUERY 16 — Currency exposure by base currency
-- query_id=100116 | userid=30 | start=2026-06-01 13:00:22 | end=2026-06-01 13:00:25 | dur=2910ms | rows=9
SELECT
    s.denominated_currency,
    SUM(h.market_value_usd)                                      AS exposure_usd,
    ROUND(100.0 * SUM(h.market_value_usd) /
          SUM(SUM(h.market_value_usd)) OVER (), 2)               AS pct_of_portfolio
FROM fact_holdings h
JOIN dim_securities s ON h.security_id = s.security_id
WHERE h.as_of_date = CURRENT_DATE - 1
  AND h.portfolio_id = 'PORT-00821'
GROUP BY 1
ORDER BY exposure_usd DESC;

-- QUERY 17 — Advisor productivity: AUM per client
-- query_id=100117 | userid=42 | start=2026-06-01 13:20:15 | end=2026-06-01 13:20:17 | dur=1730ms | rows=38
SELECT
    a.advisor_id,
    a.advisor_name,
    COUNT(DISTINCT p.client_id)          AS client_count,
    SUM(p.aum_usd)                       AS total_aum,
    ROUND(SUM(p.aum_usd) /
          NULLIF(COUNT(DISTINCT p.client_id), 0), 0) AS aum_per_client
FROM dim_advisors a
JOIN fact_portfolios p ON a.advisor_id = p.advisor_id
WHERE p.snapshot_date = '2026-05-31'
  AND a.employment_status = 'ACTIVE'
GROUP BY 1, 2
ORDER BY aum_per_client DESC;

-- QUERY 18 — Unrealised gain/loss by holding (top 50)
-- query_id=100118 | userid=55 | start=2026-06-01 13:40:00 | end=2026-06-01 13:40:04 | dur=3880ms | rows=50
SELECT
    h.portfolio_id,
    s.ticker,
    h.quantity,
    h.cost_basis_usd,
    h.market_value_usd,
    h.market_value_usd - h.cost_basis_usd                        AS unrealised_pnl_usd,
    ROUND(100.0 * (h.market_value_usd - h.cost_basis_usd) /
          NULLIF(h.cost_basis_usd, 0), 2)                        AS unrealised_pnl_pct
FROM fact_holdings h
JOIN dim_securities s ON h.security_id = s.security_id
WHERE h.as_of_date = CURRENT_DATE - 1
ORDER BY ABS(h.market_value_usd - h.cost_basis_usd) DESC
LIMIT 50;

-- QUERY 19 — Tax-loss harvesting opportunities (loss > $10k)
-- query_id=100119 | userid=68 | start=2026-06-01 14:00:05 | end=2026-06-01 14:00:09 | dur=4150ms | rows=27
SELECT
    h.portfolio_id,
    h.client_id,
    s.ticker,
    s.asset_class,
    h.cost_basis_usd,
    h.market_value_usd,
    h.cost_basis_usd - h.market_value_usd AS harvestable_loss_usd,
    h.purchase_date,
    DATEDIFF('day', h.purchase_date, CURRENT_DATE) AS holding_days
FROM fact_holdings h
JOIN dim_securities s ON h.security_id = s.security_id
WHERE h.as_of_date = CURRENT_DATE - 1
  AND h.market_value_usd < h.cost_basis_usd
  AND (h.cost_basis_usd - h.market_value_usd) > 10000
ORDER BY harvestable_loss_usd DESC;

-- QUERY 20 — Monthly AUM trend (last 12 months)
-- query_id=100120 | userid=30 | start=2026-06-01 14:15:30 | end=2026-06-01 14:15:34 | dur=3260ms | rows=12
SELECT
    DATE_TRUNC('month', p.snapshot_date)   AS aum_month,
    SUM(p.aum_usd)                         AS total_aum,
    LAG(SUM(p.aum_usd)) OVER (ORDER BY DATE_TRUNC('month', p.snapshot_date)) AS prev_month_aum,
    ROUND(100.0 * (SUM(p.aum_usd) -
          LAG(SUM(p.aum_usd)) OVER (ORDER BY DATE_TRUNC('month', p.snapshot_date))) /
          NULLIF(LAG(SUM(p.aum_usd)) OVER (ORDER BY DATE_TRUNC('month', p.snapshot_date)), 0), 2)
          AS mom_growth_pct
FROM fact_portfolios p
WHERE p.snapshot_date >= CURRENT_DATE - 365
GROUP BY 1
ORDER BY 1;

-- QUERY 21 — Margin lending utilisation by client
-- query_id=100121 | userid=42 | start=2026-06-01 14:30:00 | end=2026-06-01 14:30:03 | dur=2670ms | rows=45
SELECT
    m.client_id,
    m.margin_limit_usd,
    m.margin_used_usd,
    ROUND(100.0 * m.margin_used_usd / NULLIF(m.margin_limit_usd, 0), 2) AS utilisation_pct,
    m.margin_rate_pct,
    m.collateral_value_usd,
    ROUND(m.collateral_value_usd / NULLIF(m.margin_used_usd, 0), 2)     AS collateral_ratio
FROM fact_margin_accounts m
WHERE m.as_of_date = CURRENT_DATE - 1
  AND m.margin_used_usd > 0
ORDER BY utilisation_pct DESC;

-- QUERY 22 — Model portfolio drift report
-- query_id=100122 | userid=55 | start=2026-06-01 14:50:18 | end=2026-06-01 14:50:23 | dur=4830ms | rows=88
WITH current_weights AS (
    SELECT
        h.portfolio_id,
        h.security_id,
        ROUND(100.0 * h.market_value_usd /
              SUM(h.market_value_usd) OVER (PARTITION BY h.portfolio_id), 4) AS current_pct
    FROM fact_holdings h
    WHERE h.as_of_date = CURRENT_DATE - 1
),
model_weights AS (
    SELECT portfolio_id, security_id, target_pct
    FROM dim_model_portfolios
    WHERE effective_date = (SELECT MAX(effective_date) FROM dim_model_portfolios)
)
SELECT
    cw.portfolio_id,
    cw.security_id,
    mw.target_pct,
    cw.current_pct,
    cw.current_pct - mw.target_pct AS drift_pct
FROM current_weights cw
JOIN model_weights mw ON cw.portfolio_id = mw.portfolio_id AND cw.security_id = mw.security_id
WHERE ABS(cw.current_pct - mw.target_pct) > 1.0
ORDER BY ABS(cw.current_pct - mw.target_pct) DESC;

-- QUERY 23 — Client retention analysis (churn last 6 months)
-- query_id=100123 | userid=68 | start=2026-06-01 15:00:00 | end=2026-06-01 15:00:03 | dur=2190ms | rows=9
SELECT
    c.client_segment,
    COUNT(DISTINCT CASE WHEN c.offboarding_date IS NULL THEN c.client_id END) AS retained_clients,
    COUNT(DISTINCT CASE WHEN c.offboarding_date >= CURRENT_DATE - 180 THEN c.client_id END) AS churned_clients,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN c.offboarding_date >= CURRENT_DATE - 180 THEN c.client_id END) /
          NULLIF(COUNT(DISTINCT c.client_id), 0), 2) AS churn_rate_pct
FROM dim_clients c
WHERE c.onboarding_date < CURRENT_DATE - 180
GROUP BY 1
ORDER BY churn_rate_pct DESC;

-- QUERY 24 — Real estate / alternatives exposure
-- query_id=100124 | userid=30 | start=2026-06-01 15:20:45 | end=2026-06-01 15:20:51 | dur=5510ms | rows=34
SELECT
    s.sub_asset_class,
    s.fund_manager,
    COUNT(DISTINCT h.portfolio_id) AS portfolios_invested,
    SUM(h.market_value_usd)        AS total_exposure_usd,
    AVG(s.expected_liquidity_days) AS avg_liquidity_days,
    AVG(s.vintage_year)            AS avg_vintage_year
FROM fact_holdings h
JOIN dim_securities s ON h.security_id = s.security_id
WHERE h.as_of_date = CURRENT_DATE - 1
  AND s.asset_class IN ('REAL_ESTATE', 'PRIVATE_EQUITY', 'HEDGE_FUND', 'INFRASTRUCTURE')
GROUP BY 1, 2
ORDER BY total_exposure_usd DESC;

-- QUERY 25 — Performance attribution: alpha vs beta contribution
-- query_id=100125 | userid=42 | start=2026-06-01 15:45:00 | end=2026-06-01 15:45:07 | dur=6820ms | rows=60
WITH portfolio_betas AS (
    SELECT
        portfolio_id,
        REGR_SLOPE(daily_return_pct, benchmark_return_pct) AS beta,
        REGR_INTERCEPT(daily_return_pct, benchmark_return_pct) AS alpha_daily
    FROM (
        SELECT r.portfolio_id, r.daily_return_pct, b.benchmark_return_pct
        FROM fact_portfolio_returns r
        JOIN fact_benchmark_returns b ON r.return_date = b.benchmark_date
            AND b.benchmark_name = 'SP500'
        WHERE r.return_date BETWEEN CURRENT_DATE - 365 AND CURRENT_DATE - 1
    ) sub
    GROUP BY 1
)
SELECT
    pb.portfolio_id,
    ROUND(pb.beta, 4)                        AS market_beta,
    ROUND(pb.alpha_daily * 252, 4)           AS alpha_annualized,
    ROUND(pb.beta * 0.1823, 4)              AS beta_contribution,  -- assumes 18.23% mkt return YTD
    ROUND(pb.alpha_daily * 252 + pb.beta * 0.1823, 4) AS total_return_attributed
FROM portfolio_betas pb
ORDER BY alpha_annualized DESC;

-- QUERY 26 — Concentration risk: single-stock > 10% of portfolio
-- query_id=100126 | userid=55 | start=2026-06-01 16:00:10 | end=2026-06-01 16:00:14 | dur=3740ms | rows=8
SELECT
    h.portfolio_id,
    s.ticker,
    s.security_name,
    h.market_value_usd,
    ROUND(100.0 * h.market_value_usd /
          SUM(h.market_value_usd) OVER (PARTITION BY h.portfolio_id), 2) AS holding_weight_pct
FROM fact_holdings h
JOIN dim_securities s ON h.security_id = s.security_id
WHERE h.as_of_date = CURRENT_DATE - 1
QUALIFY ROUND(100.0 * h.market_value_usd /
              SUM(h.market_value_usd) OVER (PARTITION BY h.portfolio_id), 2) > 10.0
ORDER BY holding_weight_pct DESC;

-- QUERY 27 — Trade cost analysis (commission + slippage)
-- query_id=100127 | userid=68 | start=2026-06-01 16:15:00 | end=2026-06-01 16:15:05 | dur=4380ms | rows=200
SELECT
    t.trade_date,
    t.portfolio_id,
    s.ticker,
    t.trade_type,
    t.notional_usd,
    t.commission_usd,
    t.slippage_bps,
    ROUND(t.commission_usd + (t.notional_usd * t.slippage_bps / 10000), 2) AS total_cost_usd,
    ROUND(100.0 * (t.commission_usd + (t.notional_usd * t.slippage_bps / 10000)) /
          NULLIF(t.notional_usd, 0), 4)                                      AS cost_pct
FROM fact_trades t
JOIN dim_securities s ON t.security_id = s.security_id
WHERE t.trade_date >= CURRENT_DATE - 30
  AND t.trade_status = 'SETTLED'
ORDER BY total_cost_usd DESC;

-- QUERY 28 — Liquidity stress test: days to liquidate at 20% ADV
-- query_id=100128 | userid=30 | start=2026-06-01 16:30:22 | end=2026-06-01 16:30:29 | dur=6310ms | rows=180
SELECT
    h.portfolio_id,
    s.ticker,
    h.quantity,
    s.avg_daily_volume_shares,
    ROUND(h.quantity / NULLIF(s.avg_daily_volume_shares * 0.20, 0), 1) AS days_to_liquidate
FROM fact_holdings h
JOIN dim_securities s ON h.security_id = s.security_id
WHERE h.as_of_date = CURRENT_DATE - 1
  AND s.asset_class = 'EQUITY'
  AND h.quantity > 0
ORDER BY days_to_liquidate DESC;

-- =============================================================================
-- END OF SYNTHETIC QUERY LOG
-- Total queries: 28  |  Covers: AUM, holdings, returns, risk, fees, trading,
--   ESG, tax, client analytics, model portfolios, stress testing
-- =============================================================================
