## Project Goal

This project builds an ELT data pipeline for oncology drug discovery, integrating industry-standard datasets from Open Targets (target-disease associations).

Without a centralized pipeline, biotech R&D teams often work with siloed, outdated exports and inconsistent identifiers across datasets. This pipeline addresses those challenges by automatically ingesting fresh data, normalizing schemas, and loading a clean relational data model into Postgres, enabling analysts to query drug-target-disease relationships with a professional backend.

The raw data is archived in S3 for auditability, and the pipeline includes data quality checks and orchestration for reproducibility. I chose S3 as the raw landing zone to mirror a production architecture where raw files are decoupled from the database and versioned for auditability.

## Architecture Overview

Note to flesh out later:
This pipeline focuses on cancer-relevant target-disease associations, filtering the full Open Targets dataset (4.5M associations) to the 9,428 associations involving the 184 genes and 77 diseases that have biomarker evidence in the Cancer Genome Interpreter dataset. This scope enables:

Analysis of known cancer biomarkers with drug response evidence
Discovery of potential drug repurposing opportunities within oncology
Integration of pharmacogenomic data for precision medicine applications

## How to Run

## Key Learnings & Design Decisions

### Normalization vs. Denormalization Trade-offs

One of the fundamental tensions in data modeling is the trade-off between **storage efficiency** (normalization) and **query efficiency** (denormalization).

**Normalization (storage efficient):**
- Eliminates data duplication by splitting related data into separate tables
- Requires joins to reassemble data for queries
- Ideal for transactional systems (OLTP) with frequent writes and updates
- Example: Storing drug metadata once in a `drugs` table, referenced by ID elsewhere

**Denormalization (query efficient):**
- Accepts some duplication to avoid expensive joins
- Faster read performance, especially for analytics queries
- Ideal for analytical systems (OLAP) where reads vastly outnumber writes
- Example: Storing drug names directly in biomarker records instead of joining to a dimension table

**Our approach:** Since this is an analytical data warehouse optimized for read queries, we lean toward denormalization when the trade-off is marginal. For example, we use a single `drugs` table with a `drug_type` flag rather than splitting into `drugs` and `drug_families` tables, because:
- Storage difference is negligible (~300 rows either way)
- Query complexity is reduced (one join instead of UNION logic)
- Transformation logic is simpler
- Still semantically clear with the type flag

This decision prioritizes **developer experience** and **query simplicity** over theoretical normalization purity — appropriate for a data warehouse context.