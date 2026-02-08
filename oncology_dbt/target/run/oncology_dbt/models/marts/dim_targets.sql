
  
    

  create  table "postgres"."public"."dim_targets__dbt_tmp"
  
  
    as
  
  (
    -- Targets dimension table for oncology data mart
-- Contains gene information for cancer-relevant targets

SELECT 
    target_id,
    gene_symbol
FROM "postgres"."public"."stg_targets"
  );
  