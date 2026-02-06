## Project Goal

This project builds an ELT data pipeline for oncology drug discovery, integrating industry-standard datasets from Open Targets (target-disease associations).

Without a centralized pipeline, biotech R&D teams often work with siloed, outdated exports and inconsistent identifiers across datasets. This pipeline addresses those challenges by automatically ingesting fresh data, normalizing schemas, and loading a clean relational data model into Postgres, enabling analysts to query drug-target-disease relationships with a professional backend.

The raw data is archived in S3 for auditability, and the pipeline includes data quality checks and orchestration for reproducibility. I chose S3 as the raw landing zone to mirror a production architecture where raw files are decoupled from the database and versioned for auditability.

## Architecture Overview

## How to Run