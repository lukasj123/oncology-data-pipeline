
    
    

with child as (
    select disease_id as from_field
    from "postgres"."public"."fact_target_disease_associations"
    where disease_id is not null
),

parent as (
    select disease_id as to_field
    from "postgres"."public"."dim_diseases"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


