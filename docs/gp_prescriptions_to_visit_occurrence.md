## Table name: visit_occurrence

### Reading from gp_prescriptions

See gp_clinical_to_visit_occurrence, merge the two.

![](md_files/image6.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| visit_occurrence_id |  |  | Auto-increment |
| person_id | eid |  |  |
| visit_concept_id |  |  | 38004453 - Family Practice |
| visit_start_date | issue_date |  |  |
| visit_start_datetime | issue_date |  |  |
| visit_end_date | issue_date |  |  |
| visit_end_datetime | issue_date |  |  |
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