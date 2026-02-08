-- Raw associations table (unfiltered)
CREATE TABLE IF NOT EXISTS raw.associations (
    disease_id TEXT,
    target_id TEXT,
    score FLOAT,
    evidence_count INTEGER
);

-- Raw biomarkers table (unfiltered)
CREATE TABLE IF NOT EXISTS raw.biomarkers (
    id TEXT PRIMARY KEY,
    target_from_source_id TEXT,
    disease_from_source_mapped_id TEXT,
    datasource_id TEXT,
    datatype_id TEXT,
    drug_from_source TEXT,
    drug_id TEXT,
    drug_response TEXT,
    disease_from_source TEXT,
    confidence TEXT,
    biomarker_name TEXT,
    literature TEXT[],
    urls JSONB,
    biomarkers JSONB,
    quality_controls TEXT[],
    disease_id TEXT,
    target_id TEXT,
    publication_date DATE,
    evidence_date DATE,
    score FLOAT
);