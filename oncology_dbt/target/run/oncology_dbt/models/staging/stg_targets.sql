
  create view "postgres"."public"."stg_targets__dbt_tmp"
    
    
  as (
    SELECT DISTINCT 
    "targetId" AS target_id,
    "targetFromSourceId" AS gene_symbol
FROM "postgres"."raw"."biomarkers"
  );