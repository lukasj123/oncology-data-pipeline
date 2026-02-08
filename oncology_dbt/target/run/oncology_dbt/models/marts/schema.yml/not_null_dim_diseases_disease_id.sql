
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select disease_id
from "postgres"."public"."dim_diseases"
where disease_id is null



  
  
      
    ) dbt_internal_test