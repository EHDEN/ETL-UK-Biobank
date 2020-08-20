/*
To get respective hesin record, join using eid and ins_index
*//*
Join hesin using ins_index
*/
INSERT INTO condition_occurrence
(
    condition_occurrence_id, -- Auto-increment
    person_id,
    condition_concept_id,
    condition_concept_id, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    condition_start_date,
    condition_start_datetime,
    condition_end_date,
    condition_end_datetime,
    condition_type_concept_id,
    stop_reason,
    provider_id,
    visit_occurrence_id,
    visit_detail_id,
    condition_source_value,
    condition_source_value, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    condition_source_concept_id,
    condition_source_concept_id, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    condition_status_source_value,
    condition_status_concept_id
)
SELECT
 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS condition_occurrence_id,

    hesin_diag.eid AS person_id,

 -- [VALUE   COMMENT] NHS version of ICD standard 
 -- [MAPPING   LOGIC] Map to OMOP standard concept 
    hesin_diag.diag_icd9 AS condition_concept_id,

 -- [VALUE   COMMENT] NHS version of ICD standard 
 -- [MAPPING   LOGIC] Map to OMOP standard concept 
    hesin_diag.diag_icd10 AS condition_concept_id,

 -- [MAPPING   LOGIC] Join hesin on ins_index to get admidate.  
 -- [MAPPING COMMENT] hesin.admidate 
    hesin_diag.ins_index AS condition_start_date,

 -- [MAPPING   LOGIC] Join hesin on ins_index to get admidate.  
 -- [MAPPING COMMENT] hesin.admidate 
    hesin_diag.ins_index AS condition_start_datetime,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS condition_end_date,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS condition_end_datetime,

 -- [MAPPING   LOGIC] 1 - 44786627 primary condition 2 - 44786629 secondary condition 3 - 44786629 
    hesin_diag.level AS condition_type_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS stop_reason,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS provider_id,

 -- [MAPPING   LOGIC] Lookup visit_occurrence_id by ins_index 
    hesin_diag.ins_index AS visit_occurrence_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS visit_detail_id,

 -- [VALUE   COMMENT] NHS version of ICD standard 
    hesin_diag.diag_icd9 AS condition_source_value,

 -- [VALUE   COMMENT] NHS version of ICD standard 
    hesin_diag.diag_icd10 AS condition_source_value,

 -- [VALUE   COMMENT] NHS version of ICD standard 
    hesin_diag.diag_icd9 AS condition_source_concept_id,

 -- [VALUE   COMMENT] NHS version of ICD standard 
    hesin_diag.diag_icd10 AS condition_source_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS condition_status_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS condition_status_concept_id

FROM hesin_diag
;