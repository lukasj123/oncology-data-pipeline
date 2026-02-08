
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    target_id as unique_field,
    count(*) as n_records

from "postgres"."public"."dim_targets"
where target_id is not null
group by target_id
having count(*) > 1



  
  
      
    ) dbt_internal_test