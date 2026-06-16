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
```

### Usage

1. **Generate Data**: Open `notebooks/01_data_generation.ipynb` and run cells to generate synthetic data
2. **Explore Data**: Run `notebooks/02_eda_trends.ipynb` for exploratory analysis
3. **Build Models**: Execute `notebooks/03_forecasting_model.ipynb` to train forecasting models
4. **Evaluate Results**: Review `notebooks/04_evaluation.ipynb` for model performance metrics
5. **View Dashboard**: Open `dashboard/tradeflow_dashboard.pbix` in Power BI

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

## Key Features

✅ Synthetic trade flow data generation
✅ Comprehensive exploratory data analysis
✅ Multiple forecasting models
✅ Performance evaluation metrics
✅ Interactive Power BI dashboard
✅ Detailed SQL analytics queries

## Documentation

- [PROJECT_BRIEF.md](docs/PROJECT_BRIEF.md) - Detailed project overview
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

For questions or suggestions, please contact the project team.

---

**Last Updated**: [Date]
**Project Status**: In Development
