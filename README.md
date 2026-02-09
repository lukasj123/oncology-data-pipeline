# End-to-End ELT Pipeline for Cancer Drug Discovery R&D Teams
## Lukas Jenkins, February 2026

---

## Executive Summary

In oncology drug discovery, R&D teams need to explore relationships between genes, diseases, and drugs to prioritize targets and identify repurposing opportunities. However, critical datasets containing information on target-disease associations and cancer biomarker evidence exist in separate sources with inconsistent identifiers, making integrated analysis difficult and time-consuming.

I built an **end-to-end ELT data pipeline** using **dbt, Postgres, and Python** that integrates publicly available biomedical data from Open Targets and Cancer Genome Interpreter. The pipeline filters to 9,428 cancer-relevant associations across 184 genes and 77 diseases, transforms data through staging and mart layers, and enables analysts to query drug-gene-disease relationships through a standardized dimensional model.

**Key outcomes:**
- Automated data ingestion and transformation with 23 quality tests
- Star schema data warehouse with dimension and fact tables
- Example analyses demonstrating drug targeting patterns and pan-cancer genes
- Full pipeline documentation via dbt docs

**Tech stack:** Python (ingestion), dbt (transformation), PostgreSQL (warehouse), Docker (local dev), Jupyter (EDA + Example Application)

---

## Project Goal

I architected an **ELT data pipeline** for oncology drug discovery using **dbt, Postgres, and Python**. The pipeline integrates two large publicly available biomedical data:
- **Open Targets: Associations - Direct (overall score)** (4.5M rows of target-disease associations across all diseases)
- **Cancer Genome Interpreter (downloaded through Open Targets): Cancer biomarker evidence** (1.3K rows of cancer biomarker records with drug response evidence)

Both datasets are publicly available and were downloaded directly from Open Targets FTP for this project.

**The technical challenge:** I filtered the full 4.5M association dataset to 9,428 cancer-relevant associations (184 genes × 77 diseases), then transformed the data through staging and marts layers using dbt, creating dimension tables (targets, diseases, drugs) and fact tables (associations, biomarker evidence). The pipeline includes 23 automated data quality tests and generates documentation via dbt docs.

---

## Architecture

I designed a **three-layer ELT pipeline:**
```
RAW → STAGING (dbt views) → MARTS (dbt tables)
```

**Raw layer** (Python → Postgres):
I built Python ingestion scripts that download and load:
- `raw.associations` — 4.5M target-disease pairs from Open Targets
- `raw.biomarkers` — 1.3K cancer biomarker evidence records

**Staging layer** (dbt views):
I engineered staging models to:
- Filter associations to cancer-relevant genes/diseases only
- Deduplicate disease names (some IDs had multiple variants)
- Unify drug compounds and drug families into single table
- Standardize column naming (camelCase → snake_case)

**Marts layer** (dbt tables - analytics-ready):
I created the final dimensional model with:
- `dim_targets` (184 genes), `dim_diseases` (77 diseases), `dim_drugs` (266 drugs)
- `fact_target_disease_associations` (9,428 filtered associations)
- `fact_cancer_biomarker_evidence` (1,301 evidence records with drug info)

**Data quality:** I implemented 23 dbt tests validating uniqueness, referential integrity, and business rules.

---

## Key Design Decisions

### Why filter 4.5M → 9.4K associations?

The full Open Targets dataset contains associations for **all diseases**. I filtered to associations where both the target (gene) AND disease appear in the cancer biomarkers dataset, creating a **cancer-focused** data warehouse while enabling discovery queries like "What other cancers involve this gene?"

### Normalization trade-offs

I chose **moderate normalization** — dimension tables for entities (genes, diseases, drugs) with fact tables referencing them. This balances:
- **Query performance** (pre-joined dimensions = fast lookups)
- **Storage efficiency** (genes stored once, not repeated 10K times)
- **Data integrity** (foreign key tests ensure no orphaned records)

For edge cases like drug families vs. compounds, I used a single `drugs` table with a `type` flag rather than splitting into two tables. This enables simpler queries with a negligible storage difference.

### dbt over Python transformations

I use **dbt for all transformations** (not Python scripts) because:
- SQL is declarative and easier to review/maintain
- Built-in dependency management (dbt runs models in correct order)
- Automatic testing and documentation
- Industry standard for analytics engineering

---

## Example Analysis

See `notebooks/02_example_analysis.ipynb` for example queries and visualizations demonstrating the data warehouse in action:

- **Top cancer genes by disease associations** — Which genes are implicated across the most cancer types?
- **Drug targeting analysis** — What drugs target specific genes like BRCA2?
- **Cancer types by biomarker evidence** — Which cancers have the most drug-target evidence?

The notebook includes SQL queries, pandas analysis, and matplotlib/seaborn visualizations.

---

## Key Insights

The data warehouse enables exploration of cancer drug discovery patterns. Here are sample findings from the analysis:

### Top Cancer Genes by Disease Associations

Genes like **TP53, KRAS, and KIT** are associated with 70+ different cancer types, highlighting their role as broad cancer targets for drug development.

| Gene Symbol | Disease Count | Avg Association Score |
|-------------|---------------|----------------------|
| TP53        | 72            | 0.382                |
| KRAS        | 72            | 0.272                |
| KIT         | 71            | 0.250                |

### Drug Targeting Patterns

The warehouse contains evidence for **266 drugs** (106 individual compounds, 160 drug families) targeting cancer genes. For example, BRCA2 has documented biomarker evidence with multiple PARP inhibitors (Olaparib, Talazoparib) across breast and ovarian cancers.

### Cancer Types with Most Drug-Target Evidence

| Cancer Type              | Target Count | Drug Count | Evidence Records |
|--------------------------|--------------|------------|------------------|
| Breast adenocarcinoma    | 29           | 48         | 120              |
| Cutaneous melanoma       | 26           | 33         | 103              |
| Lung adenocarcinoma      | 16           | 43         | 96               |

*Full analysis with visualizations available in `notebooks/02_example_analysis.ipynb`*

---

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