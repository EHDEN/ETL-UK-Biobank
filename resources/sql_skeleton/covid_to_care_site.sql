/*
Covid test results, for everybody in baseline that got tested

Linked to national testing database
Can have multiple tests per patient.
*//*
Unique laboratory values
Get laboratory names from dictionary
*/
INSERT INTO care_site
(
    care_site_id,
    care_site_name,
    place_of_service_concept_id,
    location_id,
    care_site_source_value,
    place_of_service_source_value
)
SELECT
 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS care_site_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS care_site_name,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS place_of_service_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS location_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS care_site_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS place_of_service_source_value

FROM covid
;