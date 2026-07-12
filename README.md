# TradeFlow Forecast

A comprehensive data analytics and forecasting project for international trade flow prediction and analysis.

## Project Structure

```
tradeflow-forecast/
├── data/
│   ├── raw/                          # Raw trade flow data
│   └── processed/                    # Cleaned and processed data
├── notebooks/
│   ├── 01_data_generation.ipynb     # Synthetic data generation
│   ├── 02_eda_trends.ipynb          # Exploratory data analysis
│   ├── 03_forecasting_model.ipynb   # Model building and training
│   └── 04_evaluation.ipynb          # Model evaluation and insights
├── sql/
│   ├── 01_schema_creation.sql       # Database schema setup
│   └── 02_trend_queries.sql         # Trade trend analysis queries
├── dashboard/
│   └── tradeflow_dashboard.pbix     # Power BI dashboard
├── docs/
│   ├── PROJECT_BRIEF.md             # Project overview
│   ├── PROJECT_LOGBOOK.md           # Development progress
│   └── INSIGHTS.md                  # Key findings and insights
├── assets/                           # Images, icons, and resources
├── .gitignore                        # Git ignore rules
└── README.md                         # This file
```

## Getting Started

### Prerequisites
- Python 3.9+
- Jupyter Notebook
- SQL Server or compatible database
- AWS Account (Free Tier eligible for S3, Glue, and Athena components)
- Power BI Desktop (for dashboard)
- Git

### Installation

1. Clone the repository
```bash
git clone <repository-url>
cd tradeflow-forecast
```

2. Create a virtual environment
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

3. Install dependencies
```bash
pip install -r requirements.txt

4. Configure AWS CLI Credentials:
Ensure your machine is authenticated with your AWS environment before spinning up programmatic deployment scripts:
```bash
  aws configure



### Usage

- Generate Data: Open notebooks/01_data_generation.ipynb and run cells to generate the standard operational baseline.

- Explore Data: Run notebooks/02_eda_trends.ipynb for exploratory analysis and anomaly evaluation.

- Build Models: Execute notebooks/03_forecasting_model.ipynb to train historical validation forecasting models.

- Evaluate Results: Review notebooks/04_evaluation.ipynb for model performance metrics.

- Automate Infrastructure: Deploy standard infrastructure components utilizing the predefined configuration templates:

Bash
  aws cloudformation create-stack --stack-name tradeflow-core --template-body file://deployments/infrastructure.yaml
Trigger Discovery: Run the automated programmatic pipeline to catalog S3 targets into your database structure:

Bash
  python scripts/run_pipeline.py
View Dashboard: Open dashboard/tradeflow_dashboard.pbix in Power BI.

## Database Setup

Execute the SQL scripts in order:
```sql
-- 1. Create schema
source sql/01_schema_creation.sql

-- 2. Run trend analysis queries
source sql/02_trend_queries.sql
```

## Project Phases

- **Phase 1**: Data Generation & Exploration
- **Phase 2**: Model Development
- **Phase 3**: Dashboard Creation
- **Phase 4**: Documentation & Insights

## Project Execution Phases

- **Phase 1**: Data Generation & Exploration 🟩 COMPLETE
Baseline synthesis, processing data validation checks, and local relational schema prototyping.
- **Phase 2**: Cloud Edge (Infrastructure & Analytics Modernization) 🟩 COMPLETE
Migration of local instances to high-availability AWS S3 cloud buckets.
Integration of serverless AWS Glue data catalog crawlers and distributed schema discoveries.
Implementation of serverless AWS Athena analytical frameworks targeting 3,291 production lines.
- **Phase 3**: Model Development & Refinement 🟦 IN PROGRESS
Time-series model tuning, baseline evaluation, and predictive forecasting.
Integration of serverless cloud views directly into training nodes.
- **Phase 4**: BI Dashboard & Strategic Insights Publication ⬜ UPCOMING
Interactive Power BI report construction mapping performance matrices and data pipelines.


## Key Features

Technical Features
✅ Data Synthesis Engine: Generates clean, granular multi-variable trade logs.
✅ Serverless Cloud Transition: Completely migrates physical architectures to scalable object stores via AWS S3.
✅ Automated Cataloging: Deploys AWS Glue Crawler workflows minimizing metadata schema drift.
✅ Cost-Optimized Queries: Direct distributed SQL execution utilizing partitioned parameters in AWS Athena.
✅ Predictive Models: Time-series implementations mapping upcoming import/export volumetric trends.
✅ Interactive BI Dashboards: Advanced analytical views presenting vessel turnarounds, capacity ratios, and customs variations

## Documentation

- [PROJECT_BRIEF.md](docs/Project_Brief.md) - Detailed project overview
- [PROJECT_LOGBOOK.md](docs/PROJECT_LOGBOOK.md) - Development progress tracking
- [INSIGHTS.md](docs/INSIGHTS.md) - Key findings and recommendations

## Contributing

1. Create a feature branch (`git checkout -b feature/AmazingFeature`)
2. Commit changes (`git commit -m 'Add AmazingFeature'`)
3. Push to branch (`git push origin feature/AmazingFeature`)
4. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

For questions or suggestions, please contact the give email officialbhargav22@gmail.com.

---

- **Last Updated**: 25/06/2026
- **Project Status**: Active Architecture Phase — In Development



## Model Performance

| Metric | Value |
|---|---|
| Algorithm | Facebook Prophet |
| Training Period | May 2023 – May 2025 (24 months) |
| Test Period | Jun 2025 – May 2026 (12 months) |
| MAE | 0.554 MMT |
| MAPE | 3.92% |
| RMSE | 0.675 MMT |
| Best Month | Oct 2025 (0.19% error) |
| Worst Month | Nov 2025 (7.51% error) |
| Rating | Excellent |

Model successfully captures seasonal
patterns (monsoon dip Jun-Aug, Q4 surge
Oct-Dec) with 3.92% average error rate
on unseen 12-month test data.