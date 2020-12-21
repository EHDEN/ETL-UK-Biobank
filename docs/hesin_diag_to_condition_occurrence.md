## Table name: condition_occurrence

### Reading from hesin_diag

Join hesin using ins_index

![](md_files/image11.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| condition_occurrence_id |  |  | Auto-increment |
| person_id | eid |  |  |
| condition_concept_id | diag_icd10<br>diag_icd9 | If diag_icd10 is filled, map ICD10 to Standard OMOP concept. <br> If diag_icd10 is empty and diag_icd9 is filled, map ICD9 to Standard Concept.   |  |
| condition_start_date | admidate | Join hesin on eid and ins_index to get admidate. | hesin.admidate<br> |
| condition_start_datetime | admidate | Join hesin on eid and ins_index to get admidate. | hesin.admidate<br> |
| condition_end_date |  |  |  |
| condition_end_datetime |  |  |  |
| condition_type_concept_id | level | 1 - 44786627 primary condition  2 - 44786629 secondary condition  3 - 44786629 |  |
| stop_reason |  |  |  |
| provider_id |  |  |  |
| visit_occurrence_id | ins_index | Lookup visit_occurrence_id by spell_index |  |
| visit_detail_id |  | Lookup by eid and ins_index |  |
| condition_source_value | diag_icd9<br>diag_icd10 |  |  |
| condition_source_concept_id | diag_icd9<br>diag_icd10 |  |  |
| condition_status_source_value |  |  |  |
| condition_status_concept_id |  |  |  |
| data_source |  | 'HES-<dsource>' |  |