-- Targets dimension table for oncology data mart
-- Contains gene information for cancer-relevant targets

SELECT 
    target_id,
    gene_symbol
FROM {{ ref('stg_targets') }}