-- Test that all association scores are between 0 and 1
-- Test fails if any rows are returned

SELECT *
FROM "postgres"."public"."fact_target_disease_associations"
WHERE association_score < 0 
   OR association_score > 1
   OR association_score IS NULL