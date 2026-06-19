USE TradeFlow;
select * from daily_port_cargo;

--TIER 1 — Basic (Q1–8)
--SELECT, WHERE, ORDER BY, basic aggregates

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

