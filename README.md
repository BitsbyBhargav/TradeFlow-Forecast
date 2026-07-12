# TradeFlow Forecast
### Cargo Import/Export Volume Forecasting System

![Python](https://img.shields.io/badge/Python-3.9+-3776AB?style=flat&logo=python&logoColor=white)
![Prophet](https://img.shields.io/badge/Prophet-ML%20Model-FF6F00?style=flat)
![SQL Server](https://img.shields.io/badge/MS%20SQL%20Server-CC2927?style=flat&logo=microsoftsqlserver&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-S3%20%7C%20Glue%20%7C%20Athena-232F3E?style=flat&logo=amazonaws&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=flat&logo=powerbi&logoColor=black)
![Status](https://img.shields.io/badge/Status-Complete-2ECC71?style=flat)

---

## Overview

TradeFlow Forecast is an end-to-end cargo volume forecasting system built during a Data Analytics internship at **Adani Ports and SEZ Ltd., Hazira, Surat**. The project analyzes historical daily import/export cargo patterns across Gujarat Coast port operations to forecast upcoming monthly volumes — enabling port operations teams to optimize berth allocation, crane deployment, staffing, and resource planning.

---

## Business Problem

Port operations require forward visibility on cargo volumes to:
- Pre-allocate berths and cranes efficiently
- Optimize workforce scheduling ahead of seasonal surges
- Prevent congestion during Q4 peak periods (Oct–Dec)
- Reduce idle capacity during monsoon dips (Jun–Aug)

**Current state:** Planning driven by historical averages, not data-driven forecasts.
**Solution:** A forecasting system producing 3-month cargo volume projections with quantified error margins, surfaced via an interactive executive dashboard.

---

## Project Structure

```
tradeflow-forecast/
├── data/
│   ├── raw/                        # Daily port cargo dataset (3,291 records)
│   └── processed/                  # Cleaned trends + forecast + evaluation outputs
├── notebooks/
│   ├── 01_data_generation.ipynb    # Dataset generation with seasonal patterns
│   ├── 02_eda_trends.ipynb         # EDA — trend, seasonality, import/export analysis
│   ├── 03_forecasting_model.ipynb  # Prophet model training + 3-month forecast
│   └── 04_evaluation.ipynb         # Backtesting — MAE, MAPE, RMSE evaluation
├── sql/
│   ├── 01_schema_creation.sql      # MS SQL Server schema + composite primary key
│   └── 02_trend_queries.sql        # YoY growth, moving averages, cumulative volume
├── dashboard/
│   └── tradeflow_dashboard.pbix    # 4-page Power BI executive dashboard
├── docs/
│   ├── PROJECT_BRIEF.md            # Project scope and objectives
│   ├── PROJECT_LOGBOOK.md          # 28-session chronological project log
│   └── INSIGHTS.md                 # Key operational findings and recommendations
├── assets/                         # Charts, visualizations, dashboard screenshots
├── .gitignore
└── README.md
```

---

## System Architecture

```
Daily Port Cargo Dataset (3,291 records)
              │
              ▼
   Python Processing Layer
   Pandas · NumPy · Matplotlib · Seaborn
   (Cleaning, EDA, Feature Engineering)
              │
              ▼
   MS SQL Server (Local)
   Schema design · Window functions
   YoY growth · Moving averages
              │
              ▼
   AWS Cloud Layer
   S3 (Storage) → Glue Crawler (Schema)
   → Athena (Serverless SQL)
              │
              ▼
   Facebook Prophet (ML Model)
   Multiplicative seasonality
   24-month train / 12-month test
   3-month forward projection
              │
              ▼
   Power BI Dashboard (4 Pages)
   Executive Overview · Cargo Analysis
   Seasonal & YoY Growth · Navigation
```

---

## Dataset

| Attribute | Detail |
|---|---|
| Source | Synthetic — modeled on Gujarat Coast port activity patterns |
| Records | 3,291 daily observations |
| Date Range | May 2023 – May 2026 |
| Features | 11 columns |
| Target Variables | Import_Volume_MMT, Export_Volume_MMT, Total_Volume_MMT |
| Geography | Hazira/Mundra, Gujarat Coast |
| Null Values | Zero |

**Key columns:** `Record_Date`, `Cargo_Type`, `Import_Volume_MMT`, `Export_Volume_MMT`, `Total_Volume_MMT`, `Vessel_Arrival_Count`, `Avg_Berth_Turnaround_Days`

---

## Tech Stack

| Layer | Tools |
|---|---|
| Data Processing | Python 3.9+, Pandas, NumPy |
| Visualization | Matplotlib, Seaborn |
| Database | Microsoft SQL Server |
| Cloud | AWS S3, AWS Glue, AWS Athena |
| Forecasting | Facebook Prophet |
| Evaluation | Scikit-learn (MAE, RMSE), NumPy (MAPE) |
| Business Intelligence | Power BI Desktop |
| Version Control | Git, GitHub |

---

## Model Performance

Trained on 24 months of historical data. Evaluated on a strict 12-month out-of-sample holdout.

| Metric | Value |
|---|---|
| Algorithm | Facebook Prophet (Multiplicative Seasonality) |
| Training Period | May 2023 – May 2025 (24 months) |
| Test Period | Jun 2025 – May 2026 (12 months) |
| MAE | **0.554 MMT** |
| MAPE | **3.92%** |
| RMSE | **0.675 MMT** |
| Best Prediction | Oct 2025 — 0.19% error |
| Worst Prediction | Nov 2025 — 7.51% error |
| Rating | **EXCELLENT** |

Model successfully captures the port's seasonal pattern — monsoon dip (Jun–Aug, ~25% below average) and Q4 surge (Oct–Dec, ~18% above average) — confirmed by the Prophet components chart.

---

## Key Findings

- **Volume growth:** Port cargo grew ~100% over 3 years (9 MMT → 18 MMT)
- **Monsoon impact:** Jun–Aug consistently 25% below annual average — pre-position resources by May
- **Q4 surge:** Oct–Dec runs 18% above average — increase berth allocation from September
- **Container dominance:** 44.84% of total volume with highest turnaround (1.51 days) — priority for crane efficiency investment
- **Import-heavy port:** Import/Export ratio of 1.05 — import berth capacity should lead expansion planning
- **Vessel efficiency improving:** Vessel count stable (4,201 total) despite volume growth — more cargo per vessel over time

---

## Phase Completion

| Phase | Description | Status |
|---|---|---|
| Phase 1 | Data Ingestion & SQL Schema | ✅ Complete |
| Phase 2 | SQL Trends + AWS Cloud Pipeline | ✅ Complete |
| Phase 3 | Prophet Forecasting + Evaluation | ✅ Complete |
| Phase 4 | Power BI Executive Dashboard | ✅ Complete |

---

## Getting Started

### Prerequisites
```bash
Python 3.9+
MS SQL Server (Express edition)
AWS Account (free tier sufficient)
Power BI Desktop
```

### Setup
```bash
# Clone repository
git clone https://github.com/BitsbyBhargav/tradeflow-forecast
cd tradeflow-forecast

# Install dependencies
pip install pandas numpy matplotlib seaborn prophet scikit-learn pyodbc sqlalchemy boto3
```

### Run in order
```
1. notebooks/01_data_generation.ipynb   → Generate dataset
2. notebooks/02_eda_trends.ipynb        → Explore patterns
3. sql/01_schema_creation.sql           → Create SQL schema
4. notebooks/03_forecasting_model.ipynb → Train Prophet model
5. notebooks/04_evaluation.ipynb        → Evaluate performance
6. dashboard/tradeflow_dashboard.pbix   → Open Power BI dashboard
```

---

## Project Context

This project was self-initiated during a **Data Analytics Internship at Adani Ports and SEZ Ltd.** (IT Department, Hazira, Surat) in June–July 2026. No task was formally assigned for the first month. The project was conceived, scoped, built, and documented independently over 28 sessions, alongside direct operational domain exposure including control room observation, crane operation simulation, and vessel boarding.

---

## Author

**Bhargav Sonawane**
Computer Science — Big Data & Cloud Engineering
MIT ADT University, Pune

[![GitHub](https://img.shields.io/badge/GitHub-BitsbyBhargav-181717?style=flat&logo=github)](https://github.com/BitsbyBhargav)
[![Email](https://img.shields.io/badge/Email-officialbhargav22@gmail.com-D14836?style=flat&logo=gmail)](mailto:officialbhargav22@gmail.com)

---

## License

MIT License — see LICENSE file for details.

*Built during internship at Adani Ports and SEZ Ltd., Hazira — June/July 2026*