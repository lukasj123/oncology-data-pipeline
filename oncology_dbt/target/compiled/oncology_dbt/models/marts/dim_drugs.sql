-- Drugs dimension table for oncology data mart
-- Contains both individual drug compounds and drug families

SELECT 
    drug_identifier,
    drug_name,
    drug_type,
    chembl_id
FROM "postgres"."public"."stg_drugs"