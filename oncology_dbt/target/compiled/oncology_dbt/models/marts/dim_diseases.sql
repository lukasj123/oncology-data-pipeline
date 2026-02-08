-- Diseases dimension table for oncology data mart
-- Contains disease information for cancer-relevant conditions

SELECT 
    disease_id,
    disease_name
FROM "postgres"."public"."stg_diseases"