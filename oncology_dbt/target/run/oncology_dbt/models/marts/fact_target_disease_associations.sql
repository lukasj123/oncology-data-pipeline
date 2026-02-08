
  
    

  create  table "postgres"."public"."fact_target_disease_associations__dbt_tmp"
  
  
    as
  
  (
    -- Fact table: Target-disease associations
-- Filtered to cancer-relevant gene-disease pairs (9,428 associations)

SELECT 
    target_id,
    disease_id,
    association_score,
    evidence_count
FROM "postgres"."public"."stg_cancer_associations"
  );
  