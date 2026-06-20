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
