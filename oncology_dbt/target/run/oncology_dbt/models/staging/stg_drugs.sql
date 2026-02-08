
  create view "postgres"."public"."stg_drugs__dbt_tmp"
    
    
  as (
    SELECT DISTINCT
    CASE 
        WHEN "drugId" IS NOT NULL THEN "drugId"
        ELSE "drugFromSource"
    END AS drug_identifier,
    
    "drugFromSource" AS drug_name,
    
    CASE
        WHEN "drugId" IS NOT NULL THEN 'compound'
        ELSE 'family'
    END AS drug_type,
    
    "drugId" AS chembl_id
    
FROM "postgres"."raw"."biomarkers"
  );