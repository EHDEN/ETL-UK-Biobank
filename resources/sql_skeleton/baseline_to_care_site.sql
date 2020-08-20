/*
field_id-instance_id.array_id

field_id determines concept_id
eid+instance_id determines visit_occurrence_id
*//*
For all unique assessment centres (field 54)
See data dictionary: https://biobank.ctsu.ox.ac.uk/crystal/field.cgi?id=54
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

FROM baseline
;