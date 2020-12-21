## Table name: condition_occurrence

### Reading from Cancer register

Cancer EHR
Acquired from national registries.

![](baseline/md_files/image1.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| condition_occurrence_id |  |  |  |
| person_id |  |  |  |
| condition_start_date | 40005-16.0 |  |  |
| condition_concept_id | 40006-16.0<br>40011-16.0 | Combine with 40011 (histology) to map to a SNOMED cancer condition.  - see also convention of the OHDSI oncology wg<br> |  |
| condition_start_datetime |  |  |  |
| condition_end_date |  |  |  |
| condition_end_datetime |  |  |  |
| condition_type_concept_id |  |  |  |
| stop_reason |  |  |  |
| provider_id |  |  |  |
| visit_occurrence_id |  |  |  |
| visit_detail_id |  |  |  |
| condition_source_value | 40006-16.0 |  |  |
| condition_source_concept_id | 40006-16.0 |  |  |
| condition_status_source_value |  |  |  |
| condition_status_concept_id |  |  |  |

