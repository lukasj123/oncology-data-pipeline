SELECT DISTINCT ON ("diseaseId")
    "diseaseId" AS disease_id,
    "diseaseFromSource" AS disease_name
FROM "postgres"."raw"."biomarkers"
ORDER BY "diseaseId", "diseaseFromSource"

/*
Note: The ORDER BY clause was added at the end because there were four diseaseIds that
actually mapped to multiple disease names. I inspected the data, and while I could have
implemented an approach that selected the mode of the names sets, I noticed that alphabetical
ordering would have the same effect in this specific case, so I implemented the simpler solution for efficiency. If this were a production setting with anticipated changes to the
ingested dataset, I would implement a more dynamic approach instead.
*/