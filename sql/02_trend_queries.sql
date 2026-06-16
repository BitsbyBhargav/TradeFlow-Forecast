-- Trend Analysis Queries for Tradeflow Forecast

-- Query 1: Total Trade Volume by Country
SELECT 
    country,
    YEAR(trade_date) AS year,
    MONTH(trade_date) AS month,
    SUM(export_value) AS total_exports,
    SUM(import_value) AS total_imports
FROM TradeFlow
GROUP BY country, YEAR(trade_date), MONTH(trade_date)
ORDER BY year, month;

-- Query 2: Commodity-wise Trade Analysis
SELECT 
    commodity,
    AVG(export_value) AS avg_export,
    AVG(import_value) AS avg_import,
    COUNT(*) AS trade_count
FROM TradeFlow
GROUP BY commodity
ORDER BY trade_count DESC;

-- Query 3: Year-over-Year Growth
SELECT 
    country,
    commodity,
    SUM(export_value + import_value) AS total_trade_value
FROM TradeFlow
WHERE YEAR(trade_date) = YEAR(GETDATE())
GROUP BY country, commodity;
