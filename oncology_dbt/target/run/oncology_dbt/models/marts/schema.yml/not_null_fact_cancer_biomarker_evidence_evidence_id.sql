
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select evidence_id
from "postgres"."public"."fact_cancer_biomarker_evidence"
where evidence_id is null



  
  
      
    ) dbt_internal_test