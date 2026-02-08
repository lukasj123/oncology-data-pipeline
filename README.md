## Project Goal

This project builds an **ELT data pipeline** for oncology drug discovery using **dbt, Postgres, and Python**. It integrates biomedical data from Open Targets (target-disease associations) and Cancer Genome Interpreter (biomarker evidence), creating a queryable data warehouse for cancer research analytics.

**The problem:** Biotech R&D teams often work with siloed CSV exports, inconsistent identifiers, and no standardized data model — making cross-dataset analysis difficult and error-prone.

**This solution:** An automated pipeline that:
- Ingests raw data from Open Targets (4.5M associations, 1.3K biomarker records)
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

*[To be filled with setup instructions]*

---

## Key Design Decisions

### Why filter 4.5M → 9.4K associations?

The full Open Targets dataset contains associations for **all diseases**. We filtered to associations where both the target (gene) AND disease appear in the cancer biomarkers dataset, creating a **cancer-focused** data warehouse while enabling discovery queries like "What other cancers involve this gene?"

### Normalization trade-offs

We chose **moderate normalization** — dimension tables for entities (genes, diseases, drugs) with fact tables referencing them. This balances:
- **Query performance** (pre-joined dimensions = fast lookups)
- **Storage efficiency** (genes stored once, not repeated 10K times)
- **Data integrity** (foreign key tests ensure no orphaned records)

For edge cases like drug families vs. compounds, we used a single `drugs` table with a `type` flag rather than splitting into two tables — simpler queries, negligible storage difference.

### dbt over Python transformations

We use **dbt for all transformations** (not Python scripts) because:
- SQL is declarative and easier to review/maintain
- Built-in dependency management (dbt runs models in correct order)
- Automatic testing and documentation
- Industry standard for analytics engineering roles