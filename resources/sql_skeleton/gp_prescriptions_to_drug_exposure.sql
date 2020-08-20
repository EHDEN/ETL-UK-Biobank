/*
Field to field mapping to be completed.
*//*
Drug code either in read_2, bnf_code or dmd_code
Mutually exclusive
*/
INSERT INTO drug_exposure
(
    drug_exposure_id,
    person_id,
    drug_exposure_start_date,
    drug_concept_id,
    drug_concept_id, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    drug_concept_id, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    drug_exposure_start_datetime,
    drug_exposure_end_date,
    drug_exposure_end_datetime,
    verbatim_end_date,
    drug_type_concept_id, -- 38000177 - Prescription written
    stop_reason,
    refills,
    quantity,
    days_supply,
    sig,
    route_concept_id,
    lot_number,
    provider_id,
    visit_occurrence_id,
    visit_detail_id,
    drug_source_value,
    drug_source_value, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    drug_source_value, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    drug_source_concept_id,
    drug_source_concept_id, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    drug_source_concept_id, -- [!#WARNING!#] THIS TARGET FIELD WAS ALREADY USED
    route_source_value,
    dose_unit_source_value
)
SELECT
 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS drug_exposure_id,

    gp_prescriptions.eid AS person_id,

    gp_prescriptions.issue_date AS drug_exposure_start_date,

    gp_prescriptions.read_2 AS drug_concept_id,

    gp_prescriptions.bnf_code AS drug_concept_id,

    gp_prescriptions.dmd_code AS drug_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS drug_exposure_start_datetime,

 -- [MAPPING   LOGIC] Assumption:  * See Themis convention 
    gp_prescriptions.issue_date AS drug_exposure_end_date,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS drug_exposure_end_datetime,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS verbatim_end_date,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS drug_type_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS stop_reason,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS refills,

    gp_prescriptions.quantity AS quantity,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS days_supply,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS sig,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS route_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS lot_number,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS provider_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS visit_occurrence_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS visit_detail_id,

    gp_prescriptions.read_2 AS drug_source_value,

    gp_prescriptions.bnf_code AS drug_source_value,

    gp_prescriptions.dmd_code AS drug_source_value,

    gp_prescriptions.read_2 AS drug_source_concept_id,

    gp_prescriptions.bnf_code AS drug_source_concept_id,

    gp_prescriptions.dmd_code AS drug_source_concept_id,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS route_source_value,

 -- [!WARNING!] no source column found. See possible comment at the INSERT INTO
    NULL AS dose_unit_source_value

FROM gp_prescriptions
;