-- Targets dimension table for oncology data mart
-- Contains gene information for cancer-relevant targets

SELECT 
    target_id,
    gene_symbol
FROM "postgres"."public"."stg_targets"