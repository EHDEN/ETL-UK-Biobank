## Table name: condition_occurrence

### Reading from Cancer register

![](baseline/md_files/image1.png)

The Cancer registry is acquired from national registries.

The first step is to combine histology (40011), behaviour (40012) and topography (40006) to an ICDO3 code.
If all three codes are given, they are combined to `histology/behaviour-topography` (e.g. 8050/3-C80.9).
If a codes is absent, they are replaced by a default or the record is skipped (Table 1).
Note that histology is also mapped independently using the mapping given in [40011_histology_cancer_tumour.csv](resources/baseline_field_mapping/40011_histology_cancer_tumour.csv). 

_Table 1. h = 4 digit Histology, b = 1 digit Behaviour, t = ICD10 Topography. 
1 = code given, 0 = code absent._

| h | b | t | ICDOO3 code |
| --- | --- | --- | --- |
|1|1|1| h/b-t |
|1|1|0| h/b-NULL |
|1|0|1| h/1-t |
|0|1|1| NULL-t |
|0|0|1| NULL-t |
|0|1|0| not captured |
|1|0|0| mapped using 40011_histology_cancer_tumour.csv |
|0|0|0| not captured |

The second step is to lookup the concept_id of the ICDO3 code.

...



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

