
  create view "postgres"."public"."stg_test__dbt_tmp"
    
    
  as (
    SELECT 
    'Hello from dbt!' as message,
    CURRENT_TIMESTAMP as created_at
  );