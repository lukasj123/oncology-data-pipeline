
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select target_id
from "postgres"."public"."fact_target_disease_associations"
where target_id is null



  
  
      
    ) dbt_internal_test