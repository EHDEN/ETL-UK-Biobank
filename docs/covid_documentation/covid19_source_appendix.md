# Appendix: source tables

### Table: stem_table

| Field | Type | Most freq. value | Comment |
| --- | --- | --- | --- |
| domain_id | CHARACTER VARYING |  | All records from covid19_gp_clinical will be inserted in the measurement table. |
| person_id | INTEGER |  |  |
| visit_occurrence_id | INTEGER |  |  |
| provider_id | INTEGER |  |  |
| id | INTEGER |  | Not used. |
| concept_id | INTEGER |  |  |
| source_value | CHARACTER VARYING |  |  |
| source_concept_id | INTEGER |  |  |
| type_concept_id | INTEGER |  | 32817: EHR |
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

### Table: 0_covid19_emis_gp_clinical.txt.gz.pure

| Field | Type | Most freq. value | Comment |
| --- | --- | --- | --- |
| eid | INT | 1000015 |  |
| event_dt | VARCHAR | 15/04/2019 |  |
| code_type | INT | 2 | 0: CTV3  1: Local TPP code  2: SNOMED CT  3: Local EMIS code  -1: redacted - potentially sensitive or identifying  -2: redacted - rare occupation  -3: redacted - incorrect SNOMED  -4: redacted - incorrect READ2  5: EMIS online test request code (OLTR)  6: dm+d  -99: redacted - missing     |
| code | VARCHAR | -99 |  |
| value | REAL | -9999999 |  |
| unit | VARCHAR | -9999999 |  |

### Table: 1_covid19_tpp_gp_scripts.txt.gz.pure

| Field | Type | Most freq. value | Comment |
| --- | --- | --- | --- |
| eid | INT | 1000040 |  |
| issue_date | VARCHAR | 10/04/2018 |  |
| dmd_code | INT | 317291008 |  |

### Table: 2_covid19_emis_gp_scripts.txt.gz.pure

| Field | Type | Most freq. value | Comment |
| --- | --- | --- | --- |
| eid | INT | 1000163 |  |
| issue_date | VARCHAR | 09/01/2020 |  |
| code_type | INT | 6 | 3 - Local EMIS code  6 - dm+d code |
| code | VARCHAR | 322236009 | dm+d codes have quantity and unit information, some EMIS local codes.  https://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=7678&nl=1 (EMIS) |

### Table: 3_covid19_tpp_gp_clinical.txt.gz.pure

| Field | Type | Most freq. value | Comment |
| --- | --- | --- | --- |
| eid | INT | 1000154 |  |
| event_dt | VARCHAR | 11/11/2010 |  |
| code_type | INT | 0 | 0 - ctv3  1 - local TTP |
| code | VARCHAR | 246A. |  |
| value | REAL | 0 | -1: redacted - potentially sensitive or identifying  -2: redacted - rare occupation  https://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=5702 |

