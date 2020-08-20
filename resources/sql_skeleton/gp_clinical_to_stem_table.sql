/*
Read v2 and Read v3 used by different data providers
If read code is a lab test, then the value fields contain result
How value1, value2, value3 are used depends on the read code and data_provider.
*/
INSERT INTO stem_table
(
    id,
    domain_id,
    person_id,
    start_date,
    start_datetime,
    visit_occurrence_id,
    visit_occurrence_id, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    provider_id,
    concept_id,
    source_value,
    source_concept_id,
    type_concept_id, -- For condition: 32020 - EHR encounter diagnosis For meas/obs: derived from EHR
    end_date,
    end_datetime,
    verbatim_end_date,
    days_supply,
    dose_unit_source_value,
    lot_number,
    modifier_concept_id,
    modifier_source_value,
    operator_concept_id,
    modifier_source_value, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    modifier_source_value, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    modifier_source_value, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    modifier_source_value, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    modifier_source_value, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    modifier_source_value, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    modifier_source_value, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    modifier_source_value, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    modifier_source_value, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    modifier_source_value, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    unit_concept_id,
    unit_source_value,
    value_as_concept_id,
    value_as_concept_id, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    value_as_number,
    value_as_number, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    refills,
    route_concept_id,
    route_source_value,
    sig,
    stop_reason,
    unique_device_id,
    unit_concept_id, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    unit_concept_id, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    unit_concept_id, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    unit_concept_id, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    unit_concept_id -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
)
SELECT
 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS domain_id,

    gp_clinical.eid AS person_id,

 -- [VALUE   COMMENT] Empty event date:  In source, a placeholder is used (1900-01-01) 
 -- [MAPPING   LOGIC] If date empty, ignore record. Capture as observation (history of) 
    gp_clinical.event_dt AS start_date,

 -- [VALUE   COMMENT] Empty event date:  In source, a placeholder is used (1900-01-01) 
    gp_clinical.event_dt AS start_datetime,

 -- [MAPPING   LOGIC] Look up visit occurrence by unique eid+event_dt 
    gp_clinical.eid AS visit_occurrence_id,

 -- [VALUE   COMMENT] Empty event date:  In source, a placeholder is used (1900-01-01) 
    gp_clinical.event_dt AS visit_occurrence_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS provider_id,

 -- [VALUE   COMMENT] Deduced field, read_2 or read_3. Read v2 is subset of Read v3 
 -- [MAPPING   LOGIC] Map to OMOP standard concept 
    gp_clinical.read_code AS concept_id,

 -- [VALUE   COMMENT] Deduced field, read_2 or read_3. Read v2 is subset of Read v3 
    gp_clinical.read_code AS source_value,

 -- [VALUE   COMMENT] Deduced field, read_2 or read_3. Read v2 is subset of Read v3 
 -- [MAPPING   LOGIC] As Read concept 
    gp_clinical.read_code AS source_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS type_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS end_date,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS end_datetime,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS verbatim_end_date,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS days_supply,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS dose_unit_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS lot_number,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS modifier_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS modifier_source_value,

 -- [VALUE   COMMENT] Some lookups, some corresponding with the one for Caliber. e.g. OPR = operator Lookups not documented For now focus on the numeric values. 
 -- [MAPPING   LOGIC] IF prefixed with OPR 
    gp_clinical.value1 AS operator_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS modifier_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS modifier_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS modifier_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS modifier_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS modifier_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS modifier_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS modifier_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS modifier_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS modifier_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS modifier_source_value,

 -- [VALUE   COMMENT] Units only captured for one data_provider. MEAxxx = unit lookup (to be provided) 
 -- [MAPPING   LOGIC] Map to UCUM (standard OMOP unit concept) 
    gp_clinical.value3 AS unit_concept_id,

 -- [VALUE   COMMENT] Units only captured for one data_provider. MEAxxx = unit lookup (to be provided) 
    gp_clinical.value3 AS unit_source_value,

 -- [VALUE   COMMENT] Some lookups, some corresponding with the one for Caliber. e.g. OPR = operator Lookups not documented For now focus on the numeric values. 
 -- [MAPPING   LOGIC] Meaning of value depends on the read_code and data_provider.  
 -- [MAPPING COMMENT] Same for value 1, 2, 3 
    gp_clinical.value1 AS value_as_concept_id,

 -- [VALUE   COMMENT] For now focus on the numeric values, ignore the lookups. 
    gp_clinical.value2 AS value_as_concept_id,

 -- [VALUE   COMMENT] Some lookups, some corresponding with the one for Caliber. e.g. OPR = operator Lookups not documented For now focus on the numeric values. 
    gp_clinical.value1 AS value_as_number,

 -- [VALUE   COMMENT] For now focus on the numeric values, ignore the lookups. 
    gp_clinical.value2 AS value_as_number,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS refills,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS route_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS route_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS sig,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS stop_reason,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS unique_device_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS unit_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS unit_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS unit_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS unit_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS unit_concept_id

FROM gp_clinical
;