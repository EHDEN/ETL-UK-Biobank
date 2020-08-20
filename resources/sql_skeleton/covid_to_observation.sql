/*
Covid test results, for everybody in baseline that got tested

Linked to national testing database
Can have multiple tests per patient.
*//*
Test done with result (positive or negative or suspected)
TODO: is covid19 pre or post coordinated concept?
*/
INSERT INTO observation
(
    observation_id,
    person_id,
    observation_concept_id,
    observation_date,
    observation_datetime,
    visit_occurrence_id,
    visit_occurrence_id, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    observation_type_concept_id, -- 38000279 - Lab observation concept code result
    value_as_number,
    value_as_string,
    value_as_concept_id,
    qualifier_concept_id,
    unit_concept_id,
    provider_id,
    visit_detail_id,
    observation_source_value,
    observation_source_concept_id,
    unit_source_value,
    qualifier_source_value
)
SELECT
 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS observation_id,

    covid.eid AS person_id,

    covid.spectype AS observation_concept_id,

    covid.specdate AS observation_date,

    covid.specdate AS observation_datetime,

 -- [MAPPING   LOGIC] Lookup in previously created visit occurrence by eid and specdate 
    covid.eid AS visit_occurrence_id,

    covid.specdate AS visit_occurrence_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS observation_type_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS value_as_number,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS value_as_string,

 -- [VALUE   COMMENT] 1=covid positive 
    covid.result AS value_as_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS qualifier_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS unit_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS provider_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS visit_detail_id,

    covid.spectype AS observation_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS observation_source_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS unit_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS qualifier_source_value

FROM covid
;