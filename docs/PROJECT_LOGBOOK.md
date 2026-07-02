# Project Logbook - TradeFlow Forecast

## Project Start Date
[15/06/2026]

## 4-Week Strategic Timeline (June 15 – July 13)

## Phase 1: Data Ingestion & Relational Architecture (Week 2)
Dates: June 15 – June 22

Repository Focus: data/raw/, notebooks/01_data_generation.ipynb, sql/01_schema_creation.sql

Objective: Build your high-fidelity port data generator and initialize your local SQL database layer.

## Tasks & Deliverables:

Write the Python generation script to simulate 36 months of monthly import/export volume data (in MMT or TEUs). Build in sharp seasonal dips around mid-year monsoons and spikes in Q3 ahead of major global shipping seasons.

Save this generated file to data/raw/cargo_volumes.csv.

Execute 01_schema_creation.sql in MS SQL Server to build a time-series optimized relational table with appropriate data constraints.

Write a fast Python insert script to migrate the raw data directly into SQL Server.

## Phase 2: SQL Trends, Cloud Ingestion & EDA (Week 3)
Dates: June 23 – June 29

Repository Focus: data/processed/, notebooks/02_eda_trends.ipynb, sql/02_trend_queries.sql

Objective: Run local and cloud-based trend profiling to prepare your features.

## Tasks & Deliverables:

Write analytical window functions in 02_trend_queries.sql to calculate Year-over-Year (YoY) volume growth, moving averages, and cumulative quarterly cargo distributions.

The Cloud Edge: Manually upload your clean CSV to an AWS S3 bucket, run an AWS Glue Crawler to map the data schema automatically, and execute validation queries using AWS Athena.

Complete 02_eda_trends.ipynb by plotting overall historical trends, seasonality, and finding structural data skewness. Save the output as data/processed/clean_cargo_trends.csv.

## Phase 3: Time-Series Forecasting & Evaluation (Week 4)
Dates: June 30 – July 6

Repository Focus: notebooks/03_forecasting_model.ipynb, notebooks/04_evaluation.ipynb

Objective: Implement statistical forecasting models and evaluate their error margins.

## Tasks & Deliverables:

Open 03_forecasting_model.ipynb and perform Seasonal Decomposition (separating your data into Trend, Seasonality, and Residual noise).

Build a baseline moving average model, followed by a Prophet or ARIMA time-series model to predict the upcoming 3 months of cargo volumes.

In 04_evaluation.ipynb, run your backtesting. Calculate MAE (Mean Absolute Error) and MAPE (Mean Absolute Percentage Error), keeping them rounded strictly to 2 decimal places. Save the true vs. predicted matrix to your data folder.

## Phase 4: Power BI & Project Delivery (Week 5)
Dates: July 7 – July 13

Repository Focus: dashboard/, docs/, README.md

Objective: Build the interactive executive control panel and finalize your 2-credit college presentation.

## Tasks & Deliverables:

Connect Power BI Desktop to your SQL Server instance or your cloud AWS Athena database.

Build tradeflow_dashboard.pbix with a 3-page setup: Executive Operations Overview, Historical Volume Drilldowns, and 3-Month Predictive Look-Ahead Bands.

Populate docs/INSIGHTS.md with operational recommendations (e.g., when to reallocate harbor cranes or optimize container yard space based on predicted spikes).

Finalize your 30-day PROJECT_LOGBOOK.md, clean up your project README.md, and push everything to GitHub.


## June 15, 2026
## SESSION 001 — June 15, 2026 (Morning)

Project: PulseOps Pivot & TradeFlow Forecast Initiation

Phase: Project Ideation & Domain Realignment

WHAT WAS DONE: * Discovered a resource overlap on the PulseOps failure prediction project with a senior intern at the Adani Ports terminal.

Strategically shifted focus to a high-impact, port-centric logistics forecasting domain to maximize individual value add while maintaining the established repository standards.

Finalized the project concept: TradeFlow Forecast—a cargo import/export volume forecasting system designed to optimize berth allocation, resource planning, and staffing.

Designed the new 5-layer enterprise architecture: Python Generation/EDA ➔ Local SQL Server Tier ➔ Serverless AWS Cloud Ingestion (S3/Athena) ➔ Time-Series Modeling (Prophet/ARIMA) ➔ Power BI Analytics.

## SESSION 002 — June 15, 2026 (Afternoon)
## Project: TradeFlow Forecast

Phase: Data Sourcing & Infrastructure Scope

WHAT WAS DONE: * Conducted a strict search for public maritime data catalogs to avoid generic national trade files and isolate concrete port-level operational metrics.

Evaluated multiple frameworks and successfully finalized the selection of the global shipping and port traffic registry data: Global Daily Port Activity and Trade Estimates.

Selected this specific dataset because it moves beyond flat trade valuations and explicitly captures vessel arrival counts, turnaround timelines, anchorage metrics, and estimated cargo metric volumes.

Created the production folder hierarchy (data/, notebooks/, sql/, dashboard/, docs/) and populated the .gitignore configuration.

## June 16, 2026 (Today)
## SESSION 003 — June 16, 2026 (Morning)
Project: TradeFlow Forecast

Phase: Data Ingestion & Directory Initialization

WHAT WAS DONE: * Downloaded the finalized port-centric dataset and successfully staged the raw CSV inside the local project repository path: data/raw/port_activity_raw.csv.

Executed an initial programmatic schema verification check using Pandas to parse data structures, index parameters, and datetime attributes.

Formulated the Phase 1 script parameters within notebooks/01_data_generation.ipynb to read the raw activity data, isolate West-Coast India shipping channels, and prepare baseline parameters.

New Concepts: Multi-index column filtering, file path isolation via os.path, memory optimization for dense CSV parsing.

## SESSION 004 — June 16, 2026 (Afternoon)
Project: TradeFlow Forecast

Phase: Phase 1 — Data Ingestion & Relational Architecture

WHAT WAS DONE:

Read and examined the expanded daily port-centric dataset (data/raw/port_cargo_generation.csv) comprising 3,291 records and 11 features.

Executed programmatic data profiling using Pandas to analyze data distributions, structural constraints, and verify schema integrity before moving to the relational tier.

Confirmed that time-series variations (monsoon dips, Q4 surges) and operational bounds perfectly match targeted metrics with zero null values.

Pushed the finalized raw data layer, updated notebooks, and initial file layout to the GitHub repository (tradeflow-forecast).


## SESSION 005 — June 17, 2026
Project: TradeFlow Forecast
Phase: 1 — Data Ingestion & Relational
       Architecture

OBJECTIVE
Design and execute relational schema for
daily port cargo data in MS SQL Server.

WHAT WAS DONE
- Created database: TradeFlow
- Created table: daily_port_cargo
  (11 columns matching source CSV)
- Applied appropriate data types:
  SMALLINT (Year), TINYINT (Month/Day),
  DECIMAL(10,2) for volume fields,
  DECIMAL(5,2) for turnaround days
- Applied composite primary key:
  (Record_Date, Port_Region, Cargo_Type)
- Verified schema via
  INFORMATION_SCHEMA.COLUMNS

BLOCKERS
None

─────────────────────────────────────

## SESSION 006 — June 17, 2026
Project: TradeFlow Forecast
Phase: 1 — Data Ingestion & Relational
       Architecture

OBJECTIVE
Push synthetic dataset
(daily_port_cargo_generation.csv) from
local CSV into SQL Server table via
Python.

WHAT WAS DONE
- Wrote Python insert script using
  pandas + SQLAlchemy to_sql()
- Loaded daily_port_cargo_generation.csv
  (3,291 rows, 11 columns)
- Pushed data into daily_port_cargo
  table in TradeFlow database
- Verified row count in SQL Server:
  3,291 rows confirmed — matches
  source file exactly
- Spot-checked sample rows for
  accuracy

RESULT
Data successfully loaded and verified.
SQL Server now holds the complete
dataset, ready for analytical querying.

KEY DECISIONS
- Phase 1 completed in a single day
  (originally planned across Day 1-3)
  — ahead of schedule

BLOCKERS
None
## SESSION 007 — June 18, 2026
Project: TradeFlow forecast
Phase 2: SQL trends + Cloud Edge

Tasks:
→ Push sql/01_schema_creation.sql,
  notebooks, docs to GitHub
→ Fix PROJECT_BRIEF.md data source
  line (per our earlier correction —
  "synthetic, derived from patterns
  observed in Kaggle daily port
  activity data," not a named
  download)
→ Confirm README matches actual
  repo structure
→ Logbook: mark Phase 1 COMPLETE
  (1 day, 2 days ahead of plan)

## SESSION 008 — June 17, 2026
Project: TradeFlow Forecast
Phase: 2 — SQL Trends (Initial Plan)

PLANNED
Three core trend queries: YoY growth
(LAG window function), 7-day moving
average, cumulative quarterly volume.

ACTUAL OUTCOME
Superseded — a comprehensive 30-question
practice set (Tier 1-4, basic through
business-decision queries) was adopted
instead as the primary Phase 2
execution path, providing broader SQL
coverage. Original 3 queries to be
revisited as part of Tier 4 (Q30
directly extends the YoY growth
concept).


## SESSION 009 — June 18, 2026

Project: TradeFlow Forecast
Phase: 2 — SQL Trends + Cloud Edge

WHAT WAS DONE
- Internet/network connectivity 
  unavailable at site for the day
- Reviewed Phase 2 SQL query set 
  (Tier 1-4 practice questions) 
  conceptually without execution
- Planned query approach for tomorrow's 
  session (window functions, YoY 
  growth, business decision queries)

BLOCKERS
Internet outage — execution deferred

─────────────────────────────────────

## SESSION 010 — June 19, 2026
Project: TradeFlow Forecast
Phase: 2 — SQL Trends (Practice)

WHAT WAS DONE
- Completed Tier 1 (8 queries) and
  Tier 2 (9 queries) of SQL practice
  set on daily_port_cargo
- Tier 1: 3/8 correct first attempt,
  4 logic gaps identified and
  corrected (missing columns,
  wrong operators, missing
  conditions) — pattern: question
  misreading, not syntax errors
- Tier 2: 9/9 logically sound
- Found and fixed a real bug:
  decimal(10,9) precision overflow
  suppressing Vessel_Arrival_Count
  averages to 0 for non-Container
  cargo types — corrected to
  decimal(10,2)
- Discovered rounding-suppression
  issue in Q14: 2-decimal rounding
  hid near-zero trade balance
  differences for Liquid/Dry Bulk
  cargo; revealed at 5 decimals —
  attributed to synthetic data
  generation pattern

KEY LEARNING
Decimal(precision,scale) choice can
silently distort output if scale
doesn't leave room for the actual
value range. Always sanity-check
unexpected zeros before trusting
them.

## SESSION 011 — June 19, 2026
Project: TradeFlow Forecast
Phase: 2 — SQL Trends (Practice, Tier 3)

WHAT WAS DONE
- Q18: subquery filtering above-average
  volume days — correct
- Q19: attempted, built a more complex
  day-level operational classification
  using CTE + multi-condition CASE;
  reinterpreted scope from original
  question (record-level classification
  → day-level majority classification).
  Simpler record-level version
  identified as the core pattern to
  also practice (CASE + GROUP BY on
  same expression)
- Q20: TOP-N per group via DENSE_RANK()
  OVER (PARTITION BY Cargo_Type...) —
  correctly substituted Cargo_Type for
  Port_Region given single-region
  dataset; correctly reasoned
  DENSE_RANK() over RANK() for tie
  handling

KEY LEARNING
DENSE_RANK() vs RANK(): DENSE_RANK
doesn't skip rank numbers after ties,
RANK() does — matters for "top N"
queries when duplicate values exist.

NEXT SESSION
- Tier 3 remainder (Q21, adapted
  Q22-24) + Tier 4 (adapted Q25-30)
  — Port_Region references replaced
  with Cargo_Type/Year/overall-dataset
  framing

## SESSION 012 — June 22, 2026
Project: TradeFlow Forecast
Phase: 2 — SQL Trends (Core Queries)

OBJECTIVE
Execute 3 core analytical trend queries
planned in Session 008, close out SQL
analysis layer, push to GitHub.

WHAT WAS DONE
1. Executed 3 core trend queries in
   sql/02_trend_queries.sql:

   Query 1 — Monthly YoY Growth
   → CTE for monthly aggregation
   → LAG(12) window function for
     same-month prior year comparison
   → NULLIF applied for safe division
   → YoY growth % per month

   Query 2 — 7-Day Moving Average
   → Daily totals via CTE
   → AVG() OVER (ROWS BETWEEN 6
     PRECEDING AND CURRENT ROW)
   → Smooths daily noise for
     trend visibility

   Query 3 — Cumulative Quarterly
   Volume
   → DATEPART(QUARTER) extraction
   → SUM() OVER (PARTITION BY Year,
     quarter_num) running total
   → Resets each quarter — produces
     seasonal sawtooth pattern

2. YoY chart screenshot added to
   assets/ folder
3. All pushed to GitHub

KEY CONCEPTS APPLIED
LAG(n) for prior-year comparison,
NULLIF for division safety, ROWS
BETWEEN for moving average frame,
PARTITION BY for resetting cumulative
totals within sub-periods.

BLOCKERS
None

##  SESSION 013 — June 22, 2026
Project: TradeFlow Forecast
Phase: 2 — Cloud Edge (Orientation)

OBJECTIVE
Build foundational AWS cloud mental
model before hands-on implementation.

WHAT WAS DONE
- Watched Darshil Parmar AWS S3 +
  Athena project tutorial
- Understood core concepts:
  S3 bucket as cloud storage layer,
  Glue Crawler for automatic schema
  mapping, Athena as serverless SQL
  query engine on top of S3 data
- AWS free tier account creation
  initiated / in progress

KEY CONCEPTS UNDERSTOOD
S3: object storage — files (CSV,
  Parquet) stored in "buckets"
  accessible via AWS console or
  Python (boto3)
Glue Crawler: scans S3 files and
  auto-generates a queryable schema
  (table definition) without manual
  CREATE TABLE
Athena: serverless SQL directly on
  S3 data — no database server
  needed, pay-per-query model
  (free tier sufficient for project)

BLOCKERS
AWS account setup pending completion

## SESSION 014 — June 23, 2026
Project: TradeFlow Forecast
Phase: 2 — Cloud Edge (S3 Setup)

OBJECTIVE
Create AWS S3 bucket, upload processed
dataset, verify cloud storage layer.

WHAT WAS DONE
- AWS free tier account activated
- S3 bucket created:
  tradeflow-forecast-data
  Region: ap-south-1 (Mumbai)
- Processed dataset uploaded to
  bucket (clean_cargo_trends.csv)
- Cloud storage layer confirmed
  accessible via AWS Console

STATUS
S3 layer: COMPLETE
Athena setup: deferred to next session

BLOCKERS
Afternoon occupied by site activity
(official port operations exposure)

NEXT SESSION (015)
AWS Glue Crawler setup → Athena
query validation on S3 data

## SESSION 015 — June 23, 2026 (Afternoon)
Project: TradeFlow Forecast
Phase: 2 — Operational Domain Learning

NOTE
Not a technical coding session —
officially directed site activity
organized by the internship department.
Logged as domain knowledge acquisition
directly relevant to the project's
business context.

WHAT WAS DONE
- Attended crane simulation and port
  operations walkthrough at Hazira
  terminal (2.5 hours)
- Learned operational mechanics of
  container-lifting cranes (types,
  load capacity, pricing structure,
  operational workflow)
- Understood berth structure:
  2 active berths at Hazira port
- Observed container and vessel
  management protocols — tracking,
  verification, and zero-missing-cargo
  security chain
- Understood how cargo movement at
  the operational level connects to
  the data metrics in TradeFlow
  dataset (vessel arrivals, berth
  turnaround days, container volume)

KEY DOMAIN CONNECTIONS TO PROJECT
- "Avg_Berth_Turnaround_Days" column
  now has real operational context:
  crane capacity + vessel size +
  container count all influence this
  metric directly
- "Vessel_Arrival_Count" relates to
  berth scheduling — 2 berths = max
  2 simultaneous vessel operations
  at any time
- Crane pricing knowledge adds a
  cost dimension to the "high volume
  + slow turnaround" insight from
  SQL Q27 — high turnaround cargo
  types are not just slow, they are
  actively expensive per hour

UPCOMING
Vessel and crane boarding scheduled
in coming days — further operational
exposure planned

BLOCKERS
None

## SESSION 016 — June 24, 2026
Project: TradeFlow Forecast
Phase: 2 — Cloud Edge

NOTE
Morning occupied by blood donation
camp organized at the internship
site. Afternoon available but used
for rest and personal reflection.
No technical work today.

STATUS
S3 layer: Complete (from Session 014)
Athena setup: Carries forward to
tomorrow, June 26

## SESSION 017 — June 25, 2026
Project: TradeFlow Forecast
Phase: 2 — Cloud Edge (Glue & Athena Integration)  

OBJECTIVE:
Connect AWS Glue Crawler with Athena, catalog the S3 data lake bucket, and verify serverless query execution matching the local database grain.

WHAT WAS DONE:
- Automated AWS Glue Crawler built and deployed (tradeflowcrawler)Configured data lake crawling targets pointed at AWS S3 source buckets.
- Successfully ran crawler pipeline to auto-discover schema and register tables inside tradeflowdatabase.
- CloudWatch logs analyzed (ADD: 1 table change, 1 partition mapping validated)Executed serverless query tests in AWS Athena editor and verified record synchronization -(exact match at 3,291 records)STATUS.
- AWS Glue Cataloging: COMPLETE
- Athena Serverless Layer: COMPLETE

Next Session: Execution of cost-optimized analytical query matrix
BLOCKERS: None. Initial AWS Management Console configuration complexity successfully navigated and resolved before lunch.

## SESSION 018 — June 25, 2026
Project: TradeFlow Forecast
Phase: 2 — Cloud Edge (Business Queries)

OBJECTIVE
Execute business-decision SQL queries
via AWS Athena on cloud-stored data.
Validate cloud analytical layer matches
local SQL findings.

WHAT WAS DONE
- 6 business queries executed in
  Athena query editor:

  Query 1: Data verification
  → SELECT * LIMIT 10 — schema
    confirmed, columns correctly mapped

  Query 2: Row count verification
  → COUNT(*) = 3,291 — cloud record
    count matches local SQL Server
    exactly

  Query 3: Monthly volume trend
  → SUM(total_volume_mmt) GROUP BY
    year, month — seasonal patterns
    visible, consistent with local
    trend queries

  Query 4: Peak cargo month
  → Highest average daily volume
    month identified

  Query 5: Import vs Export by year
  → Import/Export ratio calculated
    per year — trade balance trend
    confirmed on cloud

  Query 6: Cargo type performance
  → AVG volume, AVG turnaround,
    total vessel count per cargo type
    — matches local SQL Q27 findings

- Query result CSV downloaded from
  S3 athena-results/ folder
- Athena result screenshots saved
  to assets/
- All assets pushed to GitHub

PHASE 2 STATUS
All components complete:
✓ SQL schema + local analysis
✓ 30-query practice set
✓ 3 core trend queries
✓ AWS S3 storage
✓ Glue Crawler + schema mapping
✓ Athena serverless SQL (6 queries)
✓ Query results exported + saved
✓ LinkedIn milestone post published
✓ GitHub fully updated

PHASE 2: COMPLETE


## SESSION 019 — June 26, 2026
Project: TradeFlow Forecast
Phase: Internship Domain Exposure

NOTE
Official site visit organized by
internship department — operational
domain learning directly relevant
to project context.

WHAT WAS DONE
- Boarded MV Obe Odyssey at Hazira
  terminal — vessel arrived from
  China carrying PTA chemical cargo,
  operated by Syrian crew
- Met Chief Officer and crew members
- Observed vessel interior, cargo
  hold structure, and onboard
  operations during port stay
- Interaction with new joinee crew
  member (similar age, boarded from
  Singapore 20 days prior) —
  gained perspective on maritime
  life and cross-cultural work
  environments
- Understood how vessel turnaround
  works from the crew's side —
  complements existing data understanding
  of Avg_Berth_Turnaround_Days metric

KEY DOMAIN CONNECTIONS TO PROJECT
- PTA chemical cargo = Liquid/Chemical
  Cargo_Type category in dataset —
  now have direct operational context
  for this data field
- Berth turnaround from crew perspective:
  documentation, customs clearance,
  cargo discharge all happen
  simultaneously — explains why
  turnaround variance exists in data
- Two berths confirmed at Hazira —
  vessel queuing is a real operational
  constraint, not just a data artifact

PERSONAL NOTE
Meaningful cross-cultural interaction
with international crew. Hospitality
shown during rest period reflects
maritime professional culture.

BLOCKERS
Photography restricted on vessel —
sea-facing and ship-to-ship images
only captured for personal reference

## SESSION 020 — June 27, 2026
Project: TradeFlow Forecast
Phase: 3 — EDA Visualizations

OBJECTIVE
Build EDA notebook with trend and
seasonality visualizations. Fix
monthly trend chart (remove partial
month cliff drop) and seasonality
chart (readable y-axis values).
Generate additional operational charts.

WHAT WAS DONE
1. 02_eda_trends.ipynb built:

   Fix 1 — Monthly Trend (fixed)
   → Partial June 2026 data removed
   → Cliff drop eliminated
   → Marker dots added per month
   → Every month on x-axis
   → Result: clean upward trend
     visible May 2023 → Jan 2026
     (9 MMT → 18+ MMT)

   Fix 2 — Seasonality (fixed)
   → Y-axis converted to monthly
     totals (not tiny daily decimals)
   → Color coding added:
     Red = below average months
     Purple = monsoon dip (Jun-Aug)
     Blue = above average (peak)
   → Value labels on each bar
   → Result: Jun/Jul/Aug dip clearly
     visible (0.11 MMT), Q4 peak
     confirmed (Oct-Dec 0.17-0.18)

   Chart 3 — Import vs Export Trend
   → Import consistently above export
   → Port confirmed as import-heavy
   → Both lines follow same seasonal
     pattern (Q4 surge, monsoon dip)

   Chart 4 — Cargo Type Volume
   → 3 cargo types tracked monthly
   → Individual type seasonality
     patterns visible

   Chart 5 — Vessel Arrival Count
   → Bar + 3-month moving average
   → Vessel count stable 90-135
     range throughout dataset

2. clean_cargo_trends.csv saved to
   data/processed/
3. All 5 charts saved to assets/
4. Notebook + assets pushed to GitHub

KEY FINDINGS FROM EDA
→ Clear upward volume trend over
  3-year period (port growth confirmed)
→ Monsoon dip: Jun-Aug consistently
  25-30% below annual average
→ Q4 surge: Oct-Dec 15-20% above
  annual average
→ Import consistently exceeds export
  — import-heavy port profile
→ Vessel arrivals stable despite
  volume growth — efficiency improving
  (more cargo per vessel over time)

BLOCKERS
None

## SESSION 021 — June 29, 2026
Project: TradeFlow Forecast
Phase: 4 — Power BI Dashboard (Page 1)

OBJECTIVE
Build Page 1 (Executive Overview) of
TradeFlow dashboard. Connect data,
create DAX measures, design KPI cards
and trend visualizations using dark
theme professional template.

WHAT WAS DONE
- Connected Power BI to
  clean_cargo_trends.csv
- Created 6 DAX measures: Total
  Volume, Total Import, Total Export,
  Total Vessels, Avg Turnaround,
  Import Export Ratio
- Built dark theme canvas (#0D1B2A)
  using BP Oil Pipeline template as
  structural reference
- Resolved card visual white
  background issue (General →
  Effects → Background toggle)
- Built 4 KPI cards, donut chart
  (Volume by Cargo Type), bar chart
  (Vessel Count by Cargo Type),
  and yearly volume trend chart
- Applied teal/yellow/coral color
  scheme across visuals

FEEDBACK RECEIVED
Reviewed by [reviewer] — recommended:
1. Switch to light background theme
2. Better space utilization —
   reduce empty/unbalanced areas
3. Overall polish toward more
   professional standard

BLOCKERS
Current version assessed as
functional but not yet presentation-
ready for stakeholder audience

## SESSION 022 — June 30, 2026
Project: TradeFlow Forecast
Phase: 4 — Power BI Dashboard
        (Page 1) + Domain Exposure

OBJECTIVE
Refine Page 1 dashboard based on
feedback. Document control room
operational exposure.

WHAT WAS DONE

1. Dashboard Page 1 — v3 rebuild:
   - Avg Turnaround by Cargo Type
     rebuilt as proper clustered
     bar chart — values now correctly
     visible (Container: 1.51,
     Liquid: 1.06, Dry Bulk: 1.05)
   - Light theme retained and refined
   - KPI card styling improved —
     consistent shadow, no harsh borders
   - Color scheme reviewed across
     all visuals

2. Control Room visit —
   Hazira terminal operations centre:
   - Observed live port management
     system integrating vessel
     tracking, berth allocation,
     cargo loading/unloading status
   - CCTV surveillance network:
     cargo zones, truck lanes,
     employee movement — all
     integrated into single
     operational interface
   - Truck allocation system: real-
     time assignment of trucks to
     specific cargo type and berth
   - Complete port operational flow
     managed from one centralized
     dashboard — direct conceptual
     parallel to TradeFlow's
     analytical layer

KEY DOMAIN CONNECTION
The control room IS the operational
version of what TradeFlow models
analytically. Vessel count → berth
allocation → cargo assignment →
truck dispatch: each step tracked
live. TradeFlow provides the
PREDICTIVE intelligence layer
on top of this operational system.

BLOCKERS
2026 purple line crash to zero at
month 6 still present — filter
fix needed next session

─────────────────────────────────

## SESSION 023 — July 1, 2026
Project: TradeFlow Forecast
Phase: 4 — Dashboard Refinement
        (Remote Work Day)

OBJECTIVE
Continue dashboard improvements,
push trial versions to GitHub assets.

WHAT WAS DONE
- Reviewed and studied professional
  Power BI dashboard design
  references via video tutorial
- Identified remaining fixes for
  Page 1:
  → 2026 line crash filter to apply
  → Diagonal streak artifact to remove
  → Chart title font standardization
  → Dry Bulk bar color (black → grey
    or muted tone — harsh on light bg)
  → Back arrow button — assign
    navigation action or remove
- Dashboard screenshot(s) pushed
  to assets/ as trial/progress
  versions for version tracking
- .pbix file pushed to GitHub

BLOCKERS
Some visual inconsistencies remain —
Page 1 finalization carries into
next session

## SESSION 024 — July 2, 2026
Project: TradeFlow Forecast
Phase: 4 — Power BI Dashboard

OBJECTIVE
Finalize Page 1 and begin Page 2
structure before leave period.

WHAT WAS DONE
1. Page 1 — Executive Overview
   finalized:
   - 2026 year filter removed from
     trend chart — line crash bug
     resolved
   - 3 complete years (2023-2025)
     now displaying clean seasonal
     pattern (Jun-Aug dip visible
     at month 6, Q4 surge at
     month 10-12)
   - Light grey background (#F5F6FA)
     confirmed as final theme
   - Page 1 assessed as presentation-
     ready (8/10 professional rating)

2. Page 2 — Cargo Type Analysis
   initiated:
   - Page added and named
   - Initial structure planned:
     3 cargo KPI cards (top row),
     monthly trend by cargo type,
     turnaround comparison,
     vessel arrivals by cargo type,
     summary table with conditional
     formatting
   - Navigation button structure
     planned (page-to-page toggle)

3. Dashboard pushed to GitHub:
   assets/ updated with latest
   screenshots, .pbix file committed

STATUS
Page 1: Complete ✓
Page 2: Structure initiated,
        build continues July 8
Page 3: Planned (Trend &
        Operational Insights)

BLOCKERS
None 


