WITH cancer_targets AS (
    SELECT DISTINCT "targetId"
    FROM "postgres"."raw"."biomarkers"
),

cancer_diseases AS (
    SELECT DISTINCT "diseaseId"
    FROM "postgres"."raw"."biomarkers"
)

SELECT 
    a."diseaseId" as disease_id,
    a."targetId" as target_id,
    a.score AS association_score,
    a."evidenceCount" as evidence_count
FROM "postgres"."raw"."associations" a
WHERE a."targetId" IN (SELECT "targetId" FROM cancer_targets)
  AND a."diseaseId" IN (SELECT "diseaseId" FROM cancer_diseases)