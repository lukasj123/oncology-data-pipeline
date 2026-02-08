
    
    

select
    disease_id as unique_field,
    count(*) as n_records

from "postgres"."public"."dim_diseases"
where disease_id is not null
group by disease_id
having count(*) > 1


