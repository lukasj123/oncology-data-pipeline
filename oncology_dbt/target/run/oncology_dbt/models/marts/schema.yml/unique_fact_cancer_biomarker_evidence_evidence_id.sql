
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    evidence_id as unique_field,
    count(*) as n_records

from "postgres"."public"."fact_cancer_biomarker_evidence"
where evidence_id is not null
group by evidence_id
having count(*) > 1



  
  
      
    ) dbt_internal_test