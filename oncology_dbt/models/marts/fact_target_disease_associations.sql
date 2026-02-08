-- Fact table: Target-disease associations
-- Filtered to cancer-relevant gene-disease pairs (9,428 associations)

SELECT 
    target_id,
    disease_id,
    association_score,
    evidence_count
FROM {{ ref('stg_cancer_associations') }}