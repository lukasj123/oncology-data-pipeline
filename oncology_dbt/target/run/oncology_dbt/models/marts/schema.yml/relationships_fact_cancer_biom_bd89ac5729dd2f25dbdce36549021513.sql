
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with child as (
    select drug_identifier as from_field
    from "postgres"."public"."fact_cancer_biomarker_evidence"
    where drug_identifier is not null
),

parent as (
    select drug_identifier as to_field
    from "postgres"."public"."dim_drugs"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



  
  
      
    ) dbt_internal_test