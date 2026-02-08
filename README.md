## Project Goal

This project builds an **ELT data pipeline** for oncology drug discovery using **dbt, Postgres, and Python**. It integrates biomedical data from Open Targets (target-disease associations) and Cancer Genome Interpreter (biomarker evidence), creating a queryable data warehouse for cancer research analytics. Please note, the Cancer Genome Interpreter dataset was also uploaded to Open Targets and downloaded from there for simplicity of having one data source.

**The problem:** Some biotech/pharma R&D teams work with siloed CSV exports, inconsistent identifiers, and little or no standardized data models, making cross-dataset analyses difficult and error-prone. To make the example problem come alive, I imagined that I am working as a data engineer at an oncology-focused biotech company in their R&D department.

**This solution:** An automated pipeline that:
- Ingests raw data from Open Targets (one dataset with 4.5M target-disease associations, and a dataset with 1.3K cancer biomarker records)
- Filters to 9,428 cancer-relevant associations (184 genes × 77 diseases)
- Transforms data through staging → marts layers using **dbt**
- Creates dimension tables (targets, diseases, drugs) and fact tables (associations, biomarker evidence)
- Validates data quality with **23 automated tests**
- Generates lineage documentation via dbt docs

**Tech stack:** Python (ingestion), dbt (transformation), Postgres (warehouse), Docker (local dev)

---

## Architecture

**Three-layer pipeline:**
```
RAW → STAGING (dbt views) → MARTS (dbt tables)
```

**Raw layer** (Python → Postgres):
- `raw.associations` — 4.5M target-disease pairs from Open Targets
- `raw.biomarkers` — 1.3K cancer biomarker evidence records

**Staging layer** (dbt views - cleaning & filtering):
- Filter associations to cancer-relevant genes/diseases only
- Deduplicate disease names (some IDs had multiple variants)
- Unify drug compounds and drug families into single table
- Standardize column naming (camelCase → snake_case)

**Marts layer** (dbt tables - analytics-ready):
- `dim_targets` (184 genes), `dim_diseases` (77 diseases), `dim_drugs` (266 drugs)
- `fact_target_disease_associations` (9,428 filtered associations)
- `fact_cancer_biomarker_evidence` (1,301 evidence records with drug info)

**Data quality:** 23 dbt tests validate uniqueness, referential integrity, and business rules.

---

## How to Run

## How to Run

### Prerequisites
- Docker Desktop
- Python 3.11+
- Git

### Setup

**1. Clone the repository**
```bash
git clone https://github.com/yourusername/oncology-data-pipeline.git
cd oncology-data-pipeline
```

**2. Create Python environment**
```bash
conda create -n oncology python=3.11 -y
conda activate oncology
pip install -r requirements.txt
```

**3. Set up Postgres (Docker)**
```bash
docker run --name postgres-local \
  -e POSTGRES_PASSWORD=your_password \
  -p 5432:5432 -d postgres
```

**4. Configure environment variables**
```bash
cp .env.example .env
# Edit .env with your Postgres credentials
```

**5. Download and load raw data**
```bash
# Download datasets from Open Targets
python src/ingest/download_associations.py
python src/ingest/download_biomarkers.py

# Load raw data into Postgres
python src/ingest/load_raw_data.py
```

**6. Run dbt transformations**
```bash
cd oncology_dbt
dbt run    # Build all models
dbt test   # Run data quality tests (23 tests)
```

**7. View documentation**
```bash
dbt docs generate
dbt docs serve  # Opens at http://localhost:8080
```

**8. Explore example analysis**
```bash
jupyter notebook notebooks/02_example_analysis.ipynb
```

### Project Structure
```
oncology-data-pipeline/
├── data/raw/              # Downloaded Parquet files
├── src/ingest/            # Python ingestion scripts
├── oncology_dbt/          # dbt project
│   ├── models/
│   │   ├── staging/       # Cleaning & filtering (views)
│   │   └── marts/         # Analytics tables
│   └── tests/             # Custom data quality tests
├── notebooks/             # Exploratory analysis
└── sql/                   # DDL scripts
```

---

## Key Design Decisions

### Why filter 4.5M → 9.4K associations?

The full Open Targets dataset contains associations for **all diseases**. We filtered to associations where both the target (gene) AND disease appear in the cancer biomarkers dataset, creating a **cancer-focused** data warehouse while enabling discovery queries like "What other cancers involve this gene?"

### Normalization trade-offs

We chose **moderate normalization** — dimension tables for entities (genes, diseases, drugs) with fact tables referencing them. This balances:
- **Query performance** (pre-joined dimensions = fast lookups)
- **Storage efficiency** (genes stored once, not repeated 10K times)
- **Data integrity** (foreign key tests ensure no orphaned records)

For edge cases like drug families vs. compounds, we used a single `drugs` table with a `type` flag rather than splitting into two tables. This enables simpler queries with a negligible storage difference.

### dbt over Python transformations

We use **dbt for all transformations** (not Python scripts) because:
- SQL is declarative and easier to review/maintain
- Built-in dependency management (dbt runs models in correct order)
- Automatic testing and documentation
- Industry standard for analytics engineering