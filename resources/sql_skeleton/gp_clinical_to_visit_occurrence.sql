/*
Read v2 and Read v3 used by different data providers
If read code is a lab test, then the value fields contain result
How value1, value2, value3 are used depends on the read code and data_provider.
*//*
Merge with gp_prescriptions to get all unique eid+event_dt/issue_date combinations.
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

    gp_clinical.eid AS person_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS visit_concept_id,

 -- [VALUE   COMMENT] Empty event date:  In source, a placeholder is used (1900-01-01) 
    gp_clinical.event_dt AS visit_start_date,

 -- [VALUE   COMMENT] Empty event date:  In source, a placeholder is used (1900-01-01) 
    gp_clinical.event_dt AS visit_start_datetime,

 -- [VALUE   COMMENT] Empty event date:  In source, a placeholder is used (1900-01-01) 
    gp_clinical.event_dt AS visit_end_date,

 -- [VALUE   COMMENT] Empty event date:  In source, a placeholder is used (1900-01-01) 
    gp_clinical.event_dt AS visit_end_datetime,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS visit_type_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS provider_id,

 -- [VALUE   COMMENT] Used for understanding the data Relevant for ETL, but less for the data itself. 
 -- [MAPPING   LOGIC] Capture in the care_site table 1 - England, Vision 2 - Scotland 3 - England, TPP 4 - Wales 
 -- [MAPPING COMMENT] Placeholder. Note, the data_provider is not the specific care site, but what system the data what extracted from. 
    gp_clinical.data_provider AS care_site_id,

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

FROM gp_clinical
;