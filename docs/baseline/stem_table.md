## Table name: stem_table

### Reading from Blood pressure

![](md_files/image16.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| domain_id |  |  |  |
| person_id |  |  | eid |
| visit_occurrence_id | 93-3.1 | Lookup by eid and instance_id | lookup |
| provider_id |  |  |  |
| id |  |  | Auto-increment |
| concept_id | 93-3.1 | Lookup |  |
| source_value | 93-3.1 | variable name |  |
| source_concept_id | 93-3.1 | TBD |  |
| type_concept_id |  |  | 45905771 (Observation recorded from a Survey, Observation Type, Type Concept) |
| start_date | 93-3.1 | Lookup field |  |
| start_datetime | 93-3.1 | Lookup field |  |
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
| unit_concept_id | 93-3.1 | Lookup if numeric mapping approach |  |
| unit_source_value | 93-3.1 | Lookup if numeric mapping approach |  |
| value_as_concept_id | 93-3.1 | Lookup if discrete post-coordinated mapping approach |  |
| value_as_number | 93-3.1 | If numeric mapping approach |  |
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

