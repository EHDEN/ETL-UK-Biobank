/*
Always registered at GP in your area
Can be one or more entries for a person, no overlap
Only available for half of the subjects (not for most of the English population)
Only see when someone moved GP, not to which GP (only data system)
*//*
Period different per centre and person
*/
INSERT INTO observation_period
(
    observation_period_id,
    person_id,
    observation_period_start_date,
    observation_period_end_date,
    period_type_concept_id
)
SELECT
 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS observation_period_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS person_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS observation_period_start_date,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS observation_period_end_date,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS period_type_concept_id

FROM gp_registrations
;