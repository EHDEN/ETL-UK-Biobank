/*
field_id-instance_id.array_id

field_id determines concept_id
eid+instance_id determines visit_occurrence_id
*//*
One person can have up to 4 visits (labeled 0-3)
Follow-up online or to assessment center.
*/
INSERT INTO visit_occurrence
(
    visit_occurrence_id, -- Auto-increment
    person_id,
    visit_concept_id, -- For gp_clinical, gp_prescription: 38004453 - Family Practice For baseline: 44818519 - Clinical Study visit (to be discussed) For covid: 32693 - Health examination
    visit_start_date,
    visit_start_datetime,
    visit_end_date,
    visit_end_datetime,
    visit_type_concept_id, -- For gp_clinical, gp_prescriptions: 44818518 - Visit derived from EHR record For hesin: 44818517 - Visit derived from encounter on claim For baseline: 44818519 - Clinical Study visit For covid: x - Screening (Procedure Type)
    provider_id,
    care_site_id, -- For hesin: care site group info is present, but not granular enough.
    visit_source_value,
    visit_source_concept_id,
    admitting_source_concept_id,
    admitting_source_value,
    discharge_to_concept_id,
    discharge_to_source_value,
    preceding_visit_occurrence_id
)
SELECT
 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS visit_occurrence_id,

 -- [VALUE   COMMENT] Numerical 
    baseline.eid AS person_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS visit_concept_id,

 -- [MAPPING   LOGIC] Field 53-0.0 -> date of initial assessment visit Field 53-1.0 -> date of repeat assessment visit Field 53-2.0 -> date of first imaging visit Field 53-3.0 -> date of second imaging visit 
 -- [MAPPING COMMENT] For each 
    baseline.value AS visit_start_date,

 -- [MAPPING   LOGIC] Same as mapping to visit_start_date 
    baseline.value AS visit_start_datetime,

 -- [MAPPING   LOGIC] Same as mapping to visit_start_date 
    baseline.value AS visit_end_date,

 -- [MAPPING   LOGIC] Same as mapping to visit_start_date 
    baseline.value AS visit_end_datetime,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS visit_type_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS provider_id,

 -- [MAPPING   LOGIC] Corresponding value from field 54.x.0 
 -- [MAPPING COMMENT] See also person to location_id mapping 
    baseline.value AS care_site_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS visit_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS visit_source_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS admitting_source_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS admitting_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS discharge_to_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS discharge_to_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS preceding_visit_occurrence_id

FROM baseline
;