-- ============================================
-- TradeFlow Forecast — Schema Creation
-- File: 01_schema_creation.sql
-- Purpose: Create relational table for
-- daily port cargo data
-- ============================================

CREATE DATABASE TradeFlow;
GO

USE TradeFlow;
GO

CREATE TABLE daily_port_cargo (
    Record_Date         DATE NOT NULL,
    [Year]               SMALLINT NOT NULL,
    [Month]              TINYINT NOT NULL,
    [Day]                TINYINT NOT NULL,
    Port_Region          VARCHAR(50) NOT NULL,
    Cargo_Type           VARCHAR(50) NOT NULL,
    Import_Volume_MMT    DECIMAL(10,2) NOT NULL,
    Export_Volume_MMT    DECIMAL(10,2) NOT NULL,
    Total_Volume_MMT     DECIMAL(10,2) NOT NULL,
    Vessel_Arrival_Count INT NOT NULL,
    Avg_Berth_Turnaround_Days DECIMAL(5,2) NOT NULL,

    CONSTRAINT PK_daily_port_cargo 
        PRIMARY KEY (Record_Date, Port_Region, Cargo_Type)
);
GO

select*from daily_port_cargo;
select count(*) as entry_count from daily_port_cargo;