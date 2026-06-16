-- Schema Creation for Tradeflow Forecast Database
-- This script creates the necessary tables for storing trade flow data

-- Create TradeFlow table
CREATE TABLE TradeFlow (
    trade_id INT PRIMARY KEY IDENTITY(1,1),
    trade_date DATE NOT NULL,
    country VARCHAR(100) NOT NULL,
    commodity VARCHAR(100) NOT NULL,
    export_value DECIMAL(15,2),
    import_value DECIMAL(15,2),
    created_at DATETIME DEFAULT GETDATE()
);

-- Create indices for performance
CREATE INDEX idx_trade_date ON TradeFlow(trade_date);
CREATE INDEX idx_country ON TradeFlow(country);
CREATE INDEX idx_commodity ON TradeFlow(commodity);
