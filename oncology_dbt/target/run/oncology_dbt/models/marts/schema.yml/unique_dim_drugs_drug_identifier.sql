
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    drug_identifier as unique_field,
    count(*) as n_records

from "postgres"."public"."dim_drugs"
where drug_identifier is not null
group by drug_identifier
having count(*) > 1



  
  
      
    ) dbt_internal_test