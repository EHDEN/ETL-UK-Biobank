/*
field_id-instance_id.array_id

field_id determines concept_id
eid+instance_id determines visit_occurrence_id
*/
INSERT INTO person
(
    person_id,
    gender_concept_id,
    year_of_birth,
    month_of_birth,
    gender_source_value,
    day_of_birth,
    birth_datetime,
    race_concept_id, -- Is present in UKB data, but >90% 'white british'.
    race_source_value,
    ethnicity_concept_id, -- NULL
    location_id,
    care_site_id,
    provider_id,
    person_source_value,
    gender_source_concept_id,
    race_source_concept_id,
    ethnicity_source_value,
    ethnicity_source_concept_id
)
SELECT
 -- [VALUE   COMMENT] Numerical 
    baseline.eid AS person_id,

 -- [MAPPING   LOGIC] Value from field 31-0.0 Female - 8532 Male - 8507 
    baseline.value AS gender_concept_id,

 -- [MAPPING   LOGIC] Value from field 34-0.0 
    baseline.value AS year_of_birth,

 -- [MAPPING   LOGIC] Value from field 52-0.0 
    baseline.value AS month_of_birth,

 -- [MAPPING   LOGIC] Value from field 31 
    baseline.value AS gender_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS day_of_birth,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS birth_datetime,

 -- [MAPPING   LOGIC] Value from field 21000 Only top level (White, mixed, asian, black, chinese) 
    baseline.value AS race_concept_id,

 -- [MAPPING   LOGIC] Value from field 21000 
    baseline.value AS race_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS ethnicity_concept_id,

 -- [MAPPING   LOGIC] Value from field 54 Populate location table with each of the ~23 cities where assessment center where. 
 -- [MAPPING COMMENT] Centers in 23 different cities (either location or care_site) 
    baseline.value AS location_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS care_site_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS provider_id,

 -- [VALUE   COMMENT] Numerical 
    baseline.eid AS person_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS gender_source_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS race_source_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS ethnicity_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS ethnicity_source_concept_id

FROM baseline
;