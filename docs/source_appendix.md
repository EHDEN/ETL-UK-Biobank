---
layout: default
title: hes, gp & covid appendix
parent: appendix
nav_order: 2
---

# Appendix: source tables

### Table: stem_table

| Field | Type | Most freq. value | Comment |
| --- | --- | --- | --- |
| domain_id | CHARACTER VARYING |  |  |
| person_id | INTEGER |  |  |
| visit_occurrence_id | INTEGER |  |  |
| provider_id | INTEGER |  |  |
| id | INTEGER |  |  |
| concept_id | INTEGER |  |  |
| source_value | CHARACTER VARYING |  |  |
| source_concept_id | INTEGER |  |  |
| type_concept_id | INTEGER |  | For condition: 32020 - EHR encounter diagnosis  For meas/obs: derived from EHR |
| start_date | DATE |  |  |
| start_datetime | DATETIME |  |  |
| end_date | DATE |  |  |
| end_datetime | DATETIME |  |  |
| verbatim_end_date | DATE |  |  |
| days_supply | INTEGER |  |  |
| dose_unit_source_value | CHARACTER VARYING |  |  |
| lot_number | CHARACTER VARYING |  |  |
| modifier_concept_id | INTEGER |  |  |
| modifier_source_value | CHARACTER VARYING |  |  |
| operator_concept_id | INTEGER |  |  |
| modifier_source_value | CHARACTER VARYING |  |  |
| quantity | INTEGER |  |  |
| range_high | FLOAT |  |  |
| range_low | FLOAT |  |  |
| refills | INTEGER |  |  |
| route_concept_id | INTEGER |  |  |
| route_source_value | CHARACTER VARYING |  |  |
| sig | CHARACTER VARYING |  |  |
| stop_reason | CHARACTER VARYING |  |  |
| unique_device_id | CHARACTER VARYING |  |  |
| unit_concept_id | INTEGER |  |  |
| unit_source_value | CHARACTER VARYING |  |  |
| value_as_concept_id | INTEGER |  |  |
| value_as_number | DECIMAL |  |  |
| value_as_string | CHARACTER VARYING |  |  |
| value_source_value | CHARACTER VARYING |  |  |
| anatomic_site_concept_id | INTEGER |  |  |
| disease_status_concept_id | INTEGER |  |  |
| specimen_source_id | INTEGER |  |  |
| anatomic_site_source_value | CHARACTER VARYING |  |  |
| disease_status_source_value | CHARACTER VARYING |  |  |
| condition_status_concept_id | CHARACTER VARYING |  |  |
| condition_status_source_value | INTEGER |  |  |
| qualifier_concept_id | INTEGER |  |  |
| qualifier_source_value | CHARACTER VARYING |  |  |

### Table: baseline

| Field | Type | Most freq. value | Comment |
| --- | --- | --- | --- |
| eid | int | XXX | Numerical |
| field | varchar | 728-0.0 |  |
| value | varbinary | 0 |  |

### Table: gp_registrations

| Field | Type | Most freq. value | Comment |
| --- | --- | --- | --- |
| eid | int | XXX |  |
| data_provider | int | 3 | Data system (Scotland, Wales, Englandx2). |
| reg_date | date | YYYY-MM-DD | entry |
| deduct_date | date | YYYY-MM-DD | exit date, can be missing, still active GP practices |

### Table: gp_clinical

| Field | Type | Most freq. value | Comment |
| --- | --- | --- | --- |
| eid | int | XXX |  |
| data_provider | int | 3 | Used for understanding the data  Relevant for ETL, but less for the data itself. |
| event_dt | date |  | Empty event date:   In source, a placeholder is used (1900-01-01) |
| read_code | varchar | 2469. | Deduced field, read_2 or read_3. Read v2 is subset of Read v3 |
| read_2 | varchar |  |  |
| read_3 | varchar |  |  |
| value1 | varchar |  | Some lookups, some corresponding with the one for Caliber. e.g. OPR = operator  Lookups not documented  For now focus on the numeric values. |
| value2 | varchar |  | For now focus on the numeric values, ignore the lookups. |
| value3 | varchar |  | Units only captured for one data_provider.  MEAxxx = unit lookup (to be provided) |

### Table: gp_prescriptions

| Field | Type | Most freq. value | Comment |
| --- | --- | --- | --- |
| eid | int | XXX |  |
| data_provider | int | 3 |  |
| issue_date | date |  |  |
| read_2 | varchar |  |  |
| bnf_code | varchar |  |  |
| dmd_code | varchar |  |  |
| drug_name | varchar |  |  |
| quantity | varchar |  |  |

### Table: hesin

| Field | Type | Most freq. value | Comment |
| --- | --- | --- | --- |
| eid | int | XXX |  |
| ins_index | int | 0 | Unique key within eid, identifying a visit.  UKB provided field |
| admidate | date |  |  |
| disdate | date |  |  |
| dsource | char | HES | Data source. Lookups of other fields depend on this. |
| source | int | 6 |  |
| epistart | date |  | Within an admission |
| epiend | date |  |  |
| epidur | int | 0 |  |
| bedyear | int | 0 | Only for data from England, year an episode counts for (administrative) |
| epistat | int | 3 |  |
| epitype | int | 1 |  |
| epiorder | int | 1 |  |
| spell_index | int | 0 | If multiple admissions chained together. |
| spell_seq | int | 0 |  |
| spelbgin | int | 2 |  |
| spelend | char | Y |  |
| speldur | int | 0 |  |
| pctcode | char |  | Care site, group of hospitals (primary care trust) |
| gpprpct | char |  |  |
| category | int |  | TBD |
| elecdate | date |  | Date decided to be admitted to hospital (administrative, to capture delays) |
| elecdur | int |  |  |
| admimeth_uni | int | 1001 |  |
| admimeth | char | 11 | Way a patient was seen (emergency, planned, ...)  Coding depends on dsource  http://biobank.ctsu.ox.ac.uk/crystal/field.cgi?id=41251 |
| admisorc_uni | int | 1000 |  |
| admisorc | char | 19 |  |
| firstreg | int |  | First registration (adminstrative) |
| classpat_uni | int | 2000 |  |
| classpat | char | 2 |  |
| intmanag_uni | int | 200 |  |
| intmanag | int | 2 |  |
| mainspef_uni | int | 1350 |  |
| mainspef | char | 100 |  |
| tretspef_uni | int | 1490 |  |
| tretspef | char | 300 |  |
| operstat | int | 1 |  |
| dismeth_uni | int | 1000 |  |
| dismeth | int | 1 |  |
| disdest_uni | int | 1000 |  |
| disdest | char | 19 |  |
| carersi | int | 99 |  |

### Table: hesin_diag

| Field | Type | Most freq. value | Comment |
| --- | --- | --- | --- |
| eid | int | XXX |  |
| ins_index | int | 0 |  |
| arr_index | int | 0 | Order in which diagnoses were recorded (administrative) |
| level | int | 2 |  |
| diag_icd9 | char |  | NHS version of ICD standard |
| diag_icd9_nb | char |  | Ignore |
| diag_icd10 | char | I10 | NHS version of ICD standard |
| diag_icd10_nb | char |  | Used addendum to ICD10.  Infrequent. |

### Table: hesin_oper

| Field | Type | Most freq. value | Comment |
| --- | --- | --- | --- |
| eid | int | 3045406 |  |
| ins_index | int | 0 |  |
| arr_index | int | 0 |  |
| level | int | 2 |  |
| opdate | date |  |  |
| oper3 | char |  | OPCS v3 |
| oper3_nb | char |  |  |
| oper4 | char | X998 | OPCS v4 |
| oper4_nb | char |  |  |
| posopdur | int |  | Days spent in hospital before (administrative, can be derived from visit) |
| preopdur | int |  | Days spent in hospital after (administrative, can be derived from visit) |

### Table: covid

| Field | Type | Most freq. value | Comment |
| --- | --- | --- | --- |
| eid | int | XXX |  |
| specdate | date | YYYY-MM-DD |  |
| spectype | int | 2 |  |
| laboratory | int | 44 |  |
| origin | int | 1 |  |
| result | int | 0 | 1=covid positive |

