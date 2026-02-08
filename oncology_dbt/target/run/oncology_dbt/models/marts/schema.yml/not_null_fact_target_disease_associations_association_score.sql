
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select association_score
from "postgres"."public"."fact_target_disease_associations"
where association_score is null



  
  
      
    ) dbt_internal_test