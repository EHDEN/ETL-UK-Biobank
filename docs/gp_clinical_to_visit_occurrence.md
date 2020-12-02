## Table name: visit_occurrence

### Reading from gp_clinical

Merge with gp_prescriptions to get all unique eid+event_dt/issue_date combinations.

![](md_files/image7.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| visit_occurrence_id |  |  | Auto-increment |
| person_id | eid |  |  |
| visit_concept_id |  |  | 38004453 - Family Practice |
| visit_start_date | event_dt |  |  |
| visit_start_datetime | event_dt |  |  |
| visit_end_date | event_dt |  |  |
| visit_end_datetime | event_dt |  |  |
| visit_type_concept_id |  |  | 44818518 - Visit derived from EHR record |
| provider_id |  |  |  |
| care_site_id |  |  |  |
| visit_source_value |  |  |  |
| visit_source_concept_id |  |  |  |
| admitting_source_concept_id |  |  |  |
| admitting_source_value |  |  |  |
| discharge_to_concept_id |  |  |  |
| discharge_to_source_value |  |  |  |
| preceding_visit_occurrence_id |  |  |  |
| data_source | data_provider | 'GP-<data_provider> |  |