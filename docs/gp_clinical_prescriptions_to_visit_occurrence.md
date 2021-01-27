## Table name: visit_occurrence

### Reading from gp_clinical and gp_prescriptions

We assume that a person can have only one gp visit per day. 
To get all the visits, we take the union of gp_clinical and gp_prescriptions. Then we map each unique combination of eid and event_dt/issue_date as visit.
If the `event_dt` or `issue_date` is not given, no visit is created.

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| visit_occurrence_id | eid<br>gp_clinical.event_dt<br>gp_prescriptions.issue_date | Concatenate '4', eid and the date in YYYYMMDD format |  |
| person_id | eid |  |  |
| visit_concept_id |  |  | 38004453 - Family Practice |
| visit_start_date | gp_clinical.event_dt<br>gp_prescriptions.issue_date |  |  |
| visit_start_datetime | gp_clinical.event_dt<br>gp_prescriptions.issue_date |  |  |
| visit_end_date | gp_clinical.event_dt<br>gp_prescriptions.issue_date |  |  |
| visit_end_datetime | gp_clinical.event_dt<br>gp_prescriptions.issue_date |  |  |
| visit_type_concept_id |  |  | 32827 - 'EHR encounter record' |
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
