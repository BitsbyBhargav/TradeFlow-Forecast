USE TradeFlow;
select * from daily_port_cargo;

--TIER 1 — Basic (Q1–8)
--SELECT, WHERE, ORDER BY, basic aggregates
--Q1.how all columns for the first 15 rows where Port_Region = 'West Coast' (or whatever region values exist — check first).
--Port_Region is same so no need of verification

--→ Goal: confirm filtering works on your actual region values.
--Q2. Find all records where Total_Volume_MMT exceeds 5. Show only Record_Date, Port_Region, Total_Volume_MMT. (Changed value from 5 to .15  because values were in 0.00 format)

select Record_date,Port_Region,Total_Volume_MMT from daily_port_cargo where Total_Volume_MMT>0.15;

--→ Goal: identify high-volume days.
--Q3. List all records where Avg_Berth_Turnaround_Days is 0, ordered by Record_Date.
select Record_Date from daily_port_cargo where Avg_Berth_Turnaround_Days=0 order by Record_Date;

--→ Goal: find days with zero turnaround (likely no vessels, or instant processing — investigate which).
--Q4. Find records where Cargo_Type is a specific type AND Vessel_Arrival_Count is greater than 1.

select distinct(Cargo_Type) from daily_port_cargo;
select Record_date,Cargo_Type from daily_port_cargo  where Cargo_Type='Dry Bulk (Coal/Minerals)' and Vessel_Arrival_Count>1

--→ Goal: practice multi-condition filtering.
--Q5. Count total number of distinct Port_Region values in the table.
-- No distinct regions present all the data is shaped and specifically kept for Gujarat Coast(Hazira/Mundra) so it reflects like we're working on an actual dummy dataset given by Adani IT Tean
select distinct(Port_Region) from daily_port_cargo;
--→ Goal: confirm how many regions exist (COUNT(DISTINCT ...) — new function).
--Q6. Find the single row with the highest Total_Volume_MMT in the entire dataset.

select top 1* from daily_port_cargo order by Total_Volume_MMT desc;

select Total_Volume_MMT from daily_port_cargo
where Total_Volume_MMT= (
select max(Total_Volume_MMT) from daily_port_cargo)

--→ Goal: identify the peak volume day.
--Q7. Find the single row with the lowest Avg_Berth_Turnaround_Days (excluding zeros) — hint: WHERE > 0.

select top 1 * from daily_port_cargo where Avg_Berth_Turnaround_Days > 0 order by Avg_Berth_Turnaround_Days asc;

--→ Goal: best-case turnaround performance.
--Q8. Select all records from June 2023 only.

select * from daily_port_cargo where year(Record_date)=2023 and month(Record_date)=6;

--→ Goal: practice filtering on Year + Month together.

--TIER 2 — Intermediate (Q9–17)
--GROUP BY, HAVING, conditional aggregation

--Q9. For each Port_Region, find total Import_Volume_MMT and total Export_Volume_MMT.
--We've only port_Region
select Port_Region, sum(Import_Volume_MMT) as Total_Import_volume_MMT, 
sum(Export_Volume_MMT) as TotalExport_Volume_MMT 
from daily_port_cargo 
group by Port_Region;

--→ Goal: which region imports more vs exports more?
--Q10. For each Cargo_Type, find the average Vessel_Arrival_Count.
select count(Cargo_Type) from daily_port_cargo where Vessel_Arrival_Count>=1 group by Cargo_Type
select Cargo_Type,cast(avg(Vessel_Arrival_Count) as decimal (10,9))  as Avg_vessel_count from daily_port_cargo group by Cargo_type;

-- Don't why the average for other two except container is getting 0. Because when I verfied throught the previous query there 655 entries for both having vessel>=1. 

--→ Goal: which cargo type brings more frequent vessel traffic?
--Q11. Find total Total_Volume_MMT for each Year and Month combination.

select Year,Month,sum(Total_Volume_MMT) as TotalVolume 
from daily_port_cargo 
group by Year,Month order by Year,Month asc;

--→ Goal: build the monthly trend baseline (you'll compare this to Session 008's YoY query).
--Q12. Using HAVING, find which Port_Region(s) have an average Avg_Berth_Turnaround_Days greater than 1.5.
 -- SINCE WE HAVE ONLY ONE REGION SO ALTERED IT A LITTLE BIT WOULD COMPARE IT WITH A SPECIFIC CONTAINER TYPE

 select Cargo_Type from daily_port_cargo 
 group by Cargo_Type
 having avg(Avg_Berth_Turnaround_Days)>1.5;

--→ Goal: identify regions with slower processing.
--Q13. Count how many days had Vessel_Arrival_Count = 0 vs > 0, for each Port_Region.

--Since we've only one port region. The case for each get's cancelled. 

select sum(case when Vessel_Arrival_Count=0 then 1 else 0 end) as Idle_Days,
       sum(case when Vessel_Arrival_Count>0 then 1 else 0 end) as Active_Days
       from daily_port_cargo;


--→ Goal: idle-day analysis per region (use conditional COUNT like your Bank Marketing Q9).
--Q14. Find the difference between Export_Volume_MMT and Import_Volume_MMT for each row, then find which Port_Region has the highest average of this difference.
--Have same port region so we would compare it with Cargo_Type

with volume_difference as(
select Cargo_Type,CAST((Import_Volume_MMT-Export_Volume_MMT) as DECIMAL(10,4)) as netVariance
from daily_port_cargo
)

select  Cargo_Type,
cast(avg(netVariance) as decimal(10,5)) as Highest_Avg_Difference
from volume_difference
group by Cargo_Type
order by Highest_Avg_Difference desc;


--Key finding: When it was rounder off to two decimals then only container tonnage was displayed although highest was asked but for verification I displayed the other 0.
-- After rounding off to 5 decimals point Liquid cargo and dry bulk showed up which means due to natural chemical reacn (expansion/contraction) etc might have occured which changed their value.
--Highest avg container tonnage 0.01971



--→ Goal: trade balance — which region is export-heavy vs import-heavy.
--Q15. For each Cargo_Type, find min, max, and average Total_Volume_MMT.

select Cargo_Type, min(Total_Volume_MMT) as MinimumTotalVolume , 
max(Total_Volume_MMT) as MaximumTotalVolume, 
avg(Total_Volume_MMT) as AvgTotalVolume 
from daily_port_cargo
group by Cargo_Type;

--→ Goal: volume range/variability per cargo type.
--Q16. Find the number of records per Year (just to confirm data spread across years).
select count(Record_Date) as Records from daily_port_cargo 
group by Year
order by Year asc;

--→ Goal: data distribution sanity check.
--Q17. For each Port_Region + Cargo_Type combination, count total records.
--Since there's only port_region so this query invalid as of now

--→ Goal: confirm if all combinations are evenly represented (important before modeling).

--TIER 3 — Advanced (Q18–24)
--Subqueries, CASE, window functions
--Q18. Find all records where Total_Volume_MMT is ABOVE the overall average — subquery in WHERE.

select Record_Date,Total_Volume_MMT from daily_port_cargo
where Total_Volume_MMT>(
select avg(Total_Volume_MMT) from daily_port_cargo
);

--→ Goal: identify above-average-volume days.
/*Q19. Using CASE, create a turnaround_category column:
< 1.0 days   → 'Fast'
1.0–2.0 days → 'Moderate'  
> 2.0 days   → 'Slow'
Then count records per category.*/

select * from daily_port_cargo

WITH DailyTurnaroundCounts AS (
    SELECT 
        Record_Date,
        SUM(CASE WHEN Avg_Berth_Turnaround_Days < 1.00 THEN 1 ELSE 0 END) AS FastCount,
        SUM(CASE WHEN Avg_Berth_Turnaround_Days BETWEEN 1.00 AND 2.00 THEN 1 ELSE 0 END) AS MediumCount,
        SUM(CASE WHEN Avg_Berth_Turnaround_Days > 2.00 THEN 1 ELSE 0 END) AS SlowCount
    FROM daily_port_cargo
    GROUP BY Record_Date
)
SELECT 
    Record_Date,
    FastCount,
    MediumCount,
    SlowCount,
    -- Evaluation logic to predict/classify the operational velocity of the day
    CASE 
        WHEN SlowCount >= FastCount AND SlowCount >= MediumCount THEN 'Slow Day'
        WHEN MediumCount >= FastCount AND MediumCount >= SlowCount THEN 'Moderate Day'
        ELSE 'Fast Day'
    -- Direct operational label output
    END AS Predicted_Day_Classification
FROM DailyTurnaroundCounts
ORDER BY Record_Date ASC;


--→ Goal: operational efficiency segmentation.
--Q20. Find the TOP 10 days (by Total_Volume_MMT) for each Port_Region — hint: needs RANK() OVER (PARTITION BY Port_Region ...), new pattern.
--Since same port region than Cargo Type

WITH RankedCargoDays AS (
    SELECT 
        Record_Date,
        Cargo_Type,
        CAST(Total_Volume_MMT AS DECIMAL(10,3)) AS Total_Volume_MMT,
        Vessel_Arrival_Count,
        -- Evaluates ranks sequentially within each cargo bucket, sorting heaviest volumes first
        DENSE_RANK() OVER (
            PARTITION BY Cargo_Type 
            ORDER BY Total_Volume_MMT DESC
        ) AS Volume_Rank
    FROM daily_port_cargo
)
SELECT 
    Volume_Rank,
    Record_Date,
    Cargo_Type,
    Total_Volume_MMT,
    Vessel_Arrival_Count
FROM RankedCargoDays
WHERE Volume_Rank <= 10
ORDER BY Cargo_Type, Volume_Rank ASC;

-- **Q21.** For each row, calculate a `rolling_30day_avg` of `Total_Volume_MMT` using a window function.

SELECT 
    Record_Date,
    Cargo_Type,
    CAST(Total_Volume_MMT AS DECIMAL(10,3)) AS Daily_Volume,
    -- Calculates moving average of current row + 29 preceding chronological rows
    CAST(AVG(Total_Volume_MMT) OVER (
        PARTITION BY Cargo_Type
        ORDER BY Record_Date ASC
        ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
    ) AS DECIMAL(10,3)) AS Rolling_30Day_Avg
FROM daily_port_cargo
ORDER BY Cargo_Type, Record_Date;


--  **Q22.** Find the percentage contribution of each `Cargo_Type` to the TOTAL `Total_Volume_MMT` across the whole dataset.

SELECT 
    Cargo_Type,
    CAST(SUM(Total_Volume_MMT) AS DECIMAL(12,3)) AS Category_Total_Volume,
    -- Divides category sum by the universal sum of all records combined
    CAST((SUM(Total_Volume_MMT) / SUM(SUM(Total_Volume_MMT)) OVER()) * 100 AS DECIMAL(5,2)) AS Percentage_Contribution
FROM daily_port_cargo
GROUP BY Cargo_Type;


--   **Q23.** Using a CTE, rank each `Cargo_Type` by total volume, and show only the rank alongside the cargo type and volume.

WITH CargoVolumeSummaries AS (
    SELECT 
        Cargo_Type,
        SUM(Total_Volume_MMT) AS Aggregate_Volume
    FROM daily_port_cargo
    GROUP BY Cargo_Type
)
SELECT 
    RANK() OVER (ORDER BY Aggregate_Volume DESC) AS Volume_Rank,
    Cargo_Type,
    CAST(Aggregate_Volume AS DECIMAL(12,3)) AS Total_Volume_MMT
FROM CargoVolumeSummaries;

--  **Q24.** Find days where `Vessel_Arrival_Count` is in the TOP 5% of all values — subquery using `PERCENTILE_CONT` or a percentile cutoff approach.

WITH VesselPercentiles AS (
    SELECT 
        Record_Date,
        Cargo_Type,
        Vessel_Arrival_Count,
        -- Computes relative standing (0.0 to 1.0). Top 5% means ranking >= 0.95
        PERCENT_RANK() OVER (ORDER BY Vessel_Arrival_Count ASC) AS Trailing_Percentile
    FROM daily_port_cargo
)
SELECT 
    Record_Date,
    Cargo_Type,
    Vessel_Arrival_Count,
    CAST(Trailing_Percentile * 100 AS DECIMAL(5,2)) AS Percentile_Rank
FROM VesselPercentiles
WHERE Trailing_Percentile >= 0.95
ORDER BY Vessel_Arrival_Count DESC, Record_Date ASC;

--  **Q25.** Which month, historically, has the highest average daily volume? Find the single month (across all years) with highest average `Total_Volume_MMT`

SELECT TOP 1
    MONTH(Record_Date) AS Operational_Month,
    CAST(AVG(Total_Volume_MMT) AS DECIMAL(10,3)) AS Peak_Avg_Daily_Volume
FROM daily_port_cargo
GROUP BY MONTH(Record_Date)
ORDER BY Peak_Avg_Daily_Volume DESC;

--  **Q26.** Is turnaround time getting worse or better over time? Find average `Avg_Berth_Turnaround_Days` per `Year`, compare Year over Year.

WITH YearlyTurnaroundMetrics AS (
    SELECT 
        YEAR(Record_Date) AS Operational_Year,
        AVG(Avg_Berth_Turnaround_Days) AS Avg_Turnaround_Days
    FROM daily_port_cargo
    GROUP BY YEAR(Record_Date)
)
SELECT 
    Operational_Year,
    CAST(Avg_Turnaround_Days AS DECIMAL(5,2)) AS Current_Year_Avg,
    CAST(LAG(Avg_Turnaround_Days, 1) OVER (ORDER BY Operational_Year ASC) AS DECIMAL(5,2)) AS Previous_Year_Avg,
    -- Positive variance means wait times are increasing (getting worse)
    CAST((Avg_Turnaround_Days - LAG(Avg_Turnaround_Days, 1) OVER (ORDER BY Operational_Year ASC)) AS DECIMAL(5,2)) AS YoY_Variance
FROM YearlyTurnaroundMetrics;


--  **Q27.** Which `Cargo_Type` should get priority crane/resource investment? Find cargo types where `AVG(Total_Volume_MMT)` is high AND `AVG(Avg_Berth_Turnaround_Days)` is also high simultaneously.

WITH GlobalTerminalBaselines AS (
    SELECT 
        AVG(Total_Volume_MMT) AS Global_Avg_Volume,
        AVG(Avg_Berth_Turnaround_Days) AS Global_Avg_Turnaround
    FROM daily_port_cargo
)
SELECT 
    d.Cargo_Type,
    CAST(AVG(d.Total_Volume_MMT) AS DECIMAL(10,3)) AS Category_Avg_Volume,
    CAST(AVG(d.Avg_Berth_Turnaround_Days) AS DECIMAL(5,2)) AS Category_Avg_Turnaround
FROM daily_port_cargo d
CROSS JOIN GlobalTerminalBaselines b
GROUP BY d.Cargo_Type, b.Global_Avg_Volume, b.Global_Avg_Turnaround
-- Isolate categories scoring higher than the overall baseline averages
HAVING AVG(d.Total_Volume_MMT) >= b.Global_Avg_Volume 
   AND AVG(d.Avg_Berth_Turnaround_Days) >= b.Global_Avg_Turnaround;


--  **Q28.** Are we import-heavy or export-heavy overall, and is this changing? Find total Import vs Export volume by `Year`, and the ratio between them.

SELECT 
    YEAR(Record_Date) AS Operational_Year,
    CAST(SUM(Import_Volume_MMT) AS DECIMAL(12,3)) AS Total_Imports,
    CAST(SUM(Export_Volume_MMT) AS DECIMAL(12,3)) AS Total_Exports,
    -- Ratio > 1.0 means Import-Heavy; Ratio < 1.0 means Export-Heavy
    CAST(SUM(Import_Volume_MMT) / NULLIF(SUM(Export_Volume_MMT), 0) AS DECIMAL(5,2)) AS Import_Export_Ratio
FROM daily_port_cargo
GROUP BY YEAR(Record_Date)
ORDER BY Operational_Year ASC;


--  **Q29.** What's our realistic monthly capacity ceiling? Find the 95th percentile of monthly `Total_Volume_MMT`.

WITH MonthlyAggregatedVolumes AS (
    SELECT 
        YEAR(Record_Date) AS Clear_Year,
        MONTH(Record_Date) AS Clear_Month,
        SUM(Total_Volume_MMT) AS Monthly_Total
    FROM daily_port_cargo
    GROUP BY YEAR(Record_Date), MONTH(Record_Date)
)
SELECT DISTINCT
    PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY Monthly_Total ASC) OVER() AS Realistic_Capacity_Ceiling_MMT
FROM MonthlyAggregatedVolumes;

--  **Q30.** If next month matches last year's same month plus average YoY growth, what volume should we expect? Combine Session 008's YoY query with current month's last-year value to project forward.

WITH MonthlyHistory AS (
    SELECT 
        YEAR(Record_Date) AS Op_Year,
        MONTH(Record_Date) AS Op_Month,
        SUM(Total_Volume_MMT) AS Monthly_Volume
    FROM daily_port_cargo
    GROUP BY YEAR(Record_Date), MONTH(Record_Date)
),
YoYGrowthCalculations AS (
    SELECT 
        h1.Op_Year,
        h1.Op_Month,
        h1.Monthly_Volume AS Current_Vol,
        h2.Monthly_Volume AS Prev_Year_Vol,
        (h1.Monthly_Volume - h2.Monthly_Volume) AS Absolute_YoY_Growth
    FROM MonthlyHistory h1
    -- Self-join to line up the exact same month from the previous year
    LEFT JOIN MonthlyHistory h2 ON h1.Op_Month = h2.Op_Month AND h1.Op_Year = h2.Op_Year + 1
),
BaselineGrowthTrend AS (
    SELECT AVG(Absolute_YoY_Growth) AS Avg_YoY_Step_Size
    FROM YoYGrowthCalculations
    WHERE Absolute_YoY_Growth IS NOT NULL
),
LatestHistoricalBaseline AS (
    -- Isolates the single most recent matching month profile in the database
    SELECT TOP 1 
        Op_Month, 
        Monthly_Volume AS Last_Known_Volume
    FROM MonthlyHistory
    ORDER BY Op_Year DESC, Op_Month DESC
)
SELECT 
    l.Op_Month AS Target_Forecast_Month,
    CAST(l.Last_Known_Volume AS DECIMAL(12,3)) AS Last_Year_Base_Volume,
    CAST(g.Avg_YoY_Step_Size AS DECIMAL(12,3)) AS Historical_Growth_Factor,
    -- Baseline calculation applying target growth parameters
    CAST((l.Last_Known_Volume + g.Avg_YoY_Step_Size) AS DECIMAL(12,3)) AS Projected_Month_Volume
FROM LatestHistoricalBaseline l
CROSS JOIN BaselineGrowthTrend g;


-- 3 Business Analytical Queries

-- Monthly YoY Growth via LAG()

WITH monthly_totals AS (
    SELECT 
        [Year], [Month],
        SUM(Total_Volume_MMT) AS monthly_volume
    FROM daily_port_cargo
    GROUP BY [Year], [Month]
)
SELECT 
    [Year], [Month],
    CAST(monthly_volume AS DECIMAL(10,3)) 
        AS monthly_volume,
    CAST(LAG(monthly_volume, 12) OVER (
        ORDER BY [Year], [Month]
    ) AS DECIMAL(10,3)) AS same_month_last_year,
    CAST(
        (monthly_volume - LAG(monthly_volume,12) 
            OVER (ORDER BY [Year],[Month]))
        / NULLIF(LAG(monthly_volume,12) 
            OVER (ORDER BY [Year],[Month]),0)
        * 100
    AS DECIMAL(5,2)) AS yoy_growth_pct
FROM monthly_totals
ORDER BY [Year], [Month];

-- Day Moving average

WITH daily_totals AS (
    SELECT 
        Record_Date,
        SUM(Total_Volume_MMT) AS daily_volume
    FROM daily_port_cargo
    GROUP BY Record_Date
)
SELECT 
    Record_Date,
    CAST(daily_volume AS DECIMAL(10,3)) 
        AS daily_volume,
    CAST(AVG(daily_volume) OVER (
        ORDER BY Record_Date
        ROWS BETWEEN 6 PRECEDING 
             AND CURRENT ROW
    ) AS DECIMAL(10,3)) AS moving_avg_7day
FROM daily_totals
ORDER BY Record_Date;

-- Quaterly review 

WITH daily_totals AS (
    SELECT 
        Record_Date, [Year],
        DATEPART(QUARTER, Record_Date) 
            AS quarter_num,
        SUM(Total_Volume_MMT) AS daily_volume
    FROM daily_port_cargo
    GROUP BY Record_Date, [Year],
        DATEPART(QUARTER, Record_Date)
)
SELECT 
    Record_Date, [Year], quarter_num,
    CAST(daily_volume AS DECIMAL(10,3)) 
        AS daily_volume,
    CAST(SUM(daily_volume) OVER (
        PARTITION BY [Year], quarter_num
        ORDER BY Record_Date
    ) AS DECIMAL(10,3)) 
        AS cumulative_quarter_volume
FROM daily_totals
ORDER BY Record_Date;