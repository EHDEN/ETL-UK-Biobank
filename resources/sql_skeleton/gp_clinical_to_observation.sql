/*
Read v2 and Read v3 used by different data providers
If read code is a lab test, then the value fields contain result
How value1, value2, value3 are used depends on the read code and data_provider.
*//*
When event_dt is empty, capture 'history of'
*/
INSERT INTO observation
(
    observation_id,
    person_id,
    observation_concept_id,
    observation_date,
    observation_datetime,
    visit_occurrence_id,
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

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS person_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS observation_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS observation_date,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS observation_datetime,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS visit_occurrence_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS observation_type_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS value_as_number,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS value_as_string,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS value_as_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS qualifier_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS unit_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS provider_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS visit_detail_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS observation_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS observation_source_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS unit_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS qualifier_source_value

FROM gp_clinical
;