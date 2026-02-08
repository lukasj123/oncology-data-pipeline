SELECT DISTINCT 
    "targetId" AS target_id,
    "targetFromSourceId" AS gene_symbol
FROM "postgres"."raw"."biomarkers"