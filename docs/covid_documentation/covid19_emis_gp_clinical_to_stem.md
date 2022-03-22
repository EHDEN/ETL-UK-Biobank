---
layout: default
title: emis gp_clinical
parent: covid19 general practitioner
nav_order: 1
---

## Table name: stem_table

### Reading from 0_covid19_emis_gp_clinical.txt.gz.pure

Rows are skipped if:
 - `value` is  -9000001, -9000002, -9000003 or -9000004
 - `code` is -99, -1 or -4
 - `event_dt` is emtpy or in 2037

![](md_files/image1.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| domain_id |  |  'Measurement' if the record has a value_as_number (which is not 0) or a value_as_concept_id. | As values can only be stored in the measurement (and observation) table, we enforce the domain if a value is given from the source. In other cases, the domain_id of the target `concept_id` will be used to determine the target table as per OMOP conventions. |
| person_id | eid |  |  |
| visit_occurrence_id |  |  |  |
| provider_id |  |  |  |
| id |  |  | Not used. |
| concept_id | code_type<br>code | Combine the "code_type" with the "code" to use the correct lookup. If "code_type" = "2" use SNOMED lookup. If "code_type' = "3" use Local EMIS lookup. https://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=3175<br> |  |
| source_value | code |  |  |
| source_concept_id | code_type<br>code |  |  |
| type_concept_id |  |  | 32817: EHR |
| start_date | event_dt | If 1902-02-02 or 1903-03-3, set date to yob-07-01 (field 34 in baseline) |  |
| start_datetime | event_dt |  |  |
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
| unit_concept_id | unit |  |  |
| unit_source_value | unit |  |  |
| value_as_concept_id |  |  |  |
| value_as_number | value | If "value" = -9999999 or -9000099 leave "value_as_number" empty.  If "values" = -9000004, -9000003, -9000002, -9000001 ignore the row. https://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=2360 |  |
| value_as_string | value | If "value" = -9999999 or -9000099, save as value_as_string |  |
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
