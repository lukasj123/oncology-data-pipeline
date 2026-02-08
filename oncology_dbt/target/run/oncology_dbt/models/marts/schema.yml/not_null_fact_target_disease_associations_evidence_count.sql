
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select evidence_count
from "postgres"."public"."fact_target_disease_associations"
where evidence_count is null



  
  
      
    ) dbt_internal_test