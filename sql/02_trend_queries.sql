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

