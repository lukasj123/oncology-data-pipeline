-- Fact table: Cancer biomarker evidence
-- Detailed evidence linking targets, diseases, drugs, and biomarkers

SELECT 
    id AS evidence_id,
    "targetId" AS target_id,
    "diseaseId" AS disease_id,
    CASE 
        WHEN "drugId" IS NOT NULL THEN "drugId"
        ELSE "drugFromSource"
    END AS drug_identifier,
    confidence,
    "biomarkerName" AS biomarker_name,
    "drugResponse" AS drug_response,
    "publicationDate" AS publication_date,
    "evidenceDate" AS evidence_date,
    score
FROM "postgres"."raw"."biomarkers"