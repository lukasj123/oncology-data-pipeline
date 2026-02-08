
    
    

with all_values as (

    select
        drug_type as value_field,
        count(*) as n_records

    from "postgres"."public"."dim_drugs"
    group by drug_type

)

select *
from all_values
where value_field not in (
    'compound','family'
)


