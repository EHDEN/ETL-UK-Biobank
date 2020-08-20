/*
To get respective hesin record, join using eid and ins_index
*/
INSERT INTO procedure_occurrence
(
    procedure_occurrence_id, -- Auto-increment
    person_id,
    procedure_concept_id,
    procedure_concept_id, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    procedure_date,
    procedure_datetime,
    procedure_type_concept_id,
    modifier_concept_id,
    quantity,
    provider_id,
    visit_occurrence_id,
    visit_occurrence_id, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    visit_detail_id,
    procedure_source_value,
    procedure_source_value, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    procedure_source_concept_id,
    procedure_source_concept_id, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    modifier_source_value
)
SELECT
 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS procedure_occurrence_id,

    hesin_oper.eid AS person_id,

 -- [VALUE   COMMENT] OPCS v3 
 -- [MAPPING   LOGIC] Map to standard OMOP concept 
    hesin_oper.oper3 AS procedure_concept_id,

 -- [VALUE   COMMENT] OPCS v4 
 -- [MAPPING   LOGIC] Map to standard OMOP concept 
    hesin_oper.oper4 AS procedure_concept_id,

    hesin_oper.opdate AS procedure_date,

    hesin_oper.opdate AS procedure_datetime,

 -- [MAPPING   LOGIC] 1 - 44786630 Primary Procedure 2 - 44786631 Secondary Procedure 
    hesin_oper.level AS procedure_type_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS modifier_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS quantity,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS provider_id,

    hesin_oper.eid AS visit_occurrence_id,

 -- [MAPPING   LOGIC] Lookup visit_occurrence_id by ins_index and eid 
    hesin_oper.ins_index AS visit_occurrence_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS visit_detail_id,

 -- [VALUE   COMMENT] OPCS v3 
    hesin_oper.oper3 AS procedure_source_value,

 -- [VALUE   COMMENT] OPCS v4 
    hesin_oper.oper4 AS procedure_source_value,

 -- [VALUE   COMMENT] OPCS v3 
    hesin_oper.oper3 AS procedure_source_concept_id,

 -- [VALUE   COMMENT] OPCS v4 
    hesin_oper.oper4 AS procedure_source_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS modifier_source_value

FROM hesin_oper
;