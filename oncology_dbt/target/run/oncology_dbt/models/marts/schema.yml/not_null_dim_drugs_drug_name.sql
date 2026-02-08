
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select drug_name
from "postgres"."public"."dim_drugs"
where drug_name is null



  
  
      
    ) dbt_internal_test