/*
HES inpatient master table, containing all episodes (admission to certain ward/provider specialty)
All information and metadata on hospitalizations
No outpatient data (only if admitted overnight)
Multiple dates for: admission, episode, discharge
Admission (=spell) longer, episode more granular
Both admission and episode can have multiple diagnoses

_uni fields are unified counterparts of regular fields
Provided by UKB
*//*
From admission to discharge
*//*
Group by the eid and ins_index
Take smallest admidate and biggest disdate
*/
INSERT INTO visit_occurrence
(
    visit_occurrence_id, -- Auto-increment
    person_id,
    visit_concept_id, -- For gp_clinical, gp_prescription: 38004453 - Family Practice For baseline: 44818519 - Clinical Study visit (to be discussed) For covid: 32693 - Health examination
    visit_concept_id, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED -- For gp_clinical, gp_prescription: 38004453 - Family Practice For baseline: 44818519 - Clinical Study visit (to be discussed) For covid: 32693 - Health examination
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
    admitting_source_concept_id, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    admitting_source_value,
    discharge_to_concept_id,
    discharge_to_concept_id, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    discharge_to_source_value,
    preceding_visit_occurrence_id
)
SELECT
 -- [VALUE   COMMENT] Unique key within eid, identifying a visit. UKB provided field 
 -- [MAPPING   LOGIC] Capture eid+ins_index as unique lookup key for the visit 
    hesin.ins_index AS visit_occurrence_id,

    hesin.eid AS person_id,

 -- [VALUE   COMMENT] Data source. Lookups of other fields depend on this. 
    hesin.dsource AS visit_concept_id,

 -- [VALUE   COMMENT] Way a patient was seen (emergency, planned, ...) Coding depends on dsource http://biobank.ctsu.ox.ac.uk/crystal/field.cgi?id=41251 
 -- [MAPPING   LOGIC] Map combination of dsource and  Grouping to higher level   - planned = inpatient visit (9201)  - unplanned = emergency room visit (9203) 
 -- [MAPPING COMMENT] The more granular information in admimeth can be stored in visit_detail. 
    hesin.admimeth AS visit_concept_id,

 -- [MAPPING   LOGIC] Minimum 
    hesin.admidate AS visit_start_date,

    hesin.admidate AS visit_start_datetime,

 -- [MAPPING   LOGIC] Maximum 
    hesin.disdate AS visit_end_date,

    hesin.disdate AS visit_end_datetime,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS visit_type_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS provider_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS care_site_id,

 -- [VALUE   COMMENT] Way a patient was seen (emergency, planned, ...) Coding depends on dsource http://biobank.ctsu.ox.ac.uk/crystal/field.cgi?id=41251 
    hesin.admimeth AS visit_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS visit_source_concept_id,

 -- [VALUE   COMMENT] Data source. Lookups of other fields depend on this. 
    hesin.dsource AS admitting_source_concept_id,

 -- [MAPPING   LOGIC] Lookup depends on dsource. Group by high level mapping:  - Home (19, 10)  - Hospital 
    hesin.admisorc AS admitting_source_concept_id,

    hesin.admisorc AS admitting_source_value,

 -- [VALUE   COMMENT] Data source. Lookups of other fields depend on this. 
    hesin.dsource AS discharge_to_concept_id,

 -- [MAPPING   LOGIC] Lookup depends on dsource. Group by high level mapping:  - Home (19, 10)  - Hospital  98 = not applicable 
    hesin.disdest AS discharge_to_concept_id,

    hesin.disdest AS discharge_to_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS preceding_visit_occurrence_id

FROM hesin
;