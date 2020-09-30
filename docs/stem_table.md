## Table name: stem_table

### Reading from gp_clinical

![](md_files/image1.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| id |  |  |  |
| domain_id |  |  |  |
| person_id | eid |  |  |
| start_date | event_dt | If date empty, ignore record. Capture as observation (history of) |  |
| start_datetime | event_dt |  |  |
| visit_occurrence_id | eid<br>event_dt | Look up visit occurrence by unique eid+event_dt<br> |  |
| provider_id |  |  |  |
| concept_id | read_code | Map to OMOP standard concept |  |
| source_value | read_code |  |  |
| source_concept_id | read_code | As Read concept |  |
| type_concept_id |  |  | For condition: 32020 - EHR encounter diagnosis  For meas/obs: derived from EHR |
| end_date |  |  |  |
| end_datetime |  |  |  |
| verbatim_end_date |  |  |  |
| days_supply |  |  |  |
| dose_unit_source_value |  |  |  |
| lot_number |  |  |  |
| modifier_concept_id |  |  |  |
| modifier_source_value |  |  |  |
| operator_concept_id | value1 | IF prefixed with OPR |  |
| modifier_source_value |  |  |  |
| quantity |  |  |  |
| range_high |  |  |  |
| range_low |  |  |  |
| refills |  |  |  |
| route_concept_id |  |  |  |
| route_source_value |  |  |  |
| sig |  |  |  |
| stop_reason |  |  |  |
| unique_device_id |  |  |  |
| unit_concept_id | value3 | Map to UCUM (standard OMOP unit concept) |  |
| unit_source_value | value3 |  |  |
| value_as_concept_id | value1<br>value2 | Meaning of value depends on the read_code and data_provider.<br> | Same for value 1, 2, 3<br><br> |
| value_as_number | value1<br>value2 |  |  |
| value_as_string |  |  |  |
| value_source_value |  |  |  |
| anatomic_site_concept_id |  |  |  |
| disease_status_concept_id |  |  |  |
| specimen_source_id |  |  |  |
| anatomic_site_source_value |  |  |  |
| disease_status_source_value |  |  |  |
| condition_status_concept_id |  |  |  |
| condition_status_source_value |  |  |  |
| qualifier_concept_id |  |  |  |
| qualifier_source_value |  |  |  |

### Reading from baseline

![](md_files/image2.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| id |  |  |  |
| domain_id |  |  |  |
| person_id |  |  |  |
| start_date |  |  |  |
| start_datetime |  |  |  |
| visit_occurrence_id |  |  |  |
| provider_id |  |  |  |
| concept_id |  |  |  |
| source_value |  |  |  |
| source_concept_id |  |  |  |
| type_concept_id |  |  | For condition: 32020 - EHR encounter diagnosis  For meas/obs: derived from EHR |
| end_date |  |  |  |
| end_datetime |  |  |  |
| verbatim_end_date |  |  |  |
| days_supply |  |  |  |
| dose_unit_source_value |  |  |  |
| lot_number |  |  |  |
| modifier_concept_id |  |  |  |
| modifier_source_value |  |  |  |
| operator_concept_id |  |  |  |
| modifier_source_value |  |  |  |
| quantity |  |  |  |
| range_high |  |  |  |
| range_low |  |  |  |
| refills |  |  |  |
| route_concept_id |  |  |  |
| route_source_value |  |  |  |
| sig |  |  |  |
| stop_reason |  |  |  |
| unique_device_id |  |  |  |
| unit_concept_id |  |  |  |
| unit_source_value |  |  |  |
| value_as_concept_id |  |  |  |
| value_as_number |  |  |  |
| value_as_string |  |  |  |
| value_source_value |  |  |  |
| anatomic_site_concept_id |  |  |  |
| disease_status_concept_id |  |  |  |
| specimen_source_id |  |  |  |
| anatomic_site_source_value |  |  |  |
| disease_status_source_value |  |  |  |
| condition_status_concept_id |  |  |  |
| condition_status_source_value |  |  |  |
| qualifier_concept_id |  |  |  |
| qualifier_source_value |  |  |  |

