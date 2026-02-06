-- Dimension table: targets
CREATE TABLE targets (
     target_id TEXT PRIMARY KEY,
     gene_symbol TEXT
);

-- Dimension table: diseases
CREATE TABLE diseases (
     disease_id TEXT PRIMARY KEY,
     disease_name TEXT
);

-- Dimension table: drugs
CREATE TABLE drugs (
     drug_identifier TEXT PRIMARY KEY,
     drug_name TEXT,
     drug_type TEXT,
     chembl_id TEXT
);

-- Fact table: target-disease associations
CREATE TABLE target_disease_associations (
     target_id TEXT,
     disease_id TEXT,
     association_score FLOAT,
     evidence_count INTEGER,
     PRIMARY KEY (target_id, disease_id)
);

-- Fact table: cancer biomarker evidence
CREATE TABLE cancer_biomarker_evidence (
     id TEXT PRIMARY KEY,
     target_id TEXT NOT NULL,
     disease_id TEXT NOT NULL,
     drug_identifier TEXT,
     confidence TEXT,
     biomarker_name TEXT,
     drug_response TEXT,
     literature TEXT[],
     publication_date DATE,
     evidence_date DATE,
     score FLOAT,
     biomarkers JSONB,
     FOREIGN KEY (target_id, disease_id)
         REFERENCES target_disease_associations(target_id, disease_id)
);