## Table name: drug_exposure

### Reading from gp_prescriptions

Drug code either in read_2, bnf_code or dmd_code. Mutually exclusive.


Field to field mapping to be completed.

![](md_files/image13.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| drug_exposure_id |  |  |  |
| person_id | eid |  |  |
| drug_exposure_start_date | issue_date |  |  |
| drug_concept_id | read_2<br>bnf_code<br>dmd_code |  |  |
| drug_exposure_start_datetime |  |  |  |
| drug_exposure_end_date | issue_date | Assumption:   * See Themis convention |  |
| drug_exposure_end_datetime |  |  |  |
| verbatim_end_date |  |  |  |
| drug_type_concept_id |  |  | 38000177 - Prescription written |
| stop_reason |  |  |  |
| refills |  |  |  |
| quantity | quantity |  |  |
| days_supply |  |  |  |
| sig |  |  |  |
| route_concept_id |  |  |  |
| lot_number |  |  |  |
| provider_id |  |  |  |
| visit_occurrence_id |  |  |  |
| visit_detail_id |  |  |  |
| drug_source_value | read_2<br>bnf_code<br>dmd_code |  |  |
| drug_source_concept_id | read_2<br>bnf_code<br>dmd_code |  |  |
| route_source_value |  |  |  |
| dose_unit_source_value |  |  |  |

### Reading from stem_table

![](md_files/image14.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| drug_exposure_id | id |  |  |
| person_id | person_id |  |  |
| drug_exposure_start_date | start_date |  |  |
| drug_concept_id | concept_id |  |  |
| drug_exposure_start_datetime | start_datetime |  |  |
| drug_exposure_end_date | end_date |  |  |
| drug_exposure_end_datetime | end_datetime |  |  |
| verbatim_end_date |  |  |  |
| drug_type_concept_id | type_concept_id |  | 38000177 - Prescription written |
| stop_reason | stop_reason |  |  |
| refills | refills |  |  |
| quantity | quantity |  |  |
| days_supply | days_supply |  |  |
| sig | sig |  |  |
| route_concept_id | route_concept_id |  |  |
| lot_number | lot_number |  |  |
| provider_id | provider_id |  |  |
| visit_occurrence_id | visit_occurrence_id |  |  |
| visit_detail_id |  |  |  |
| drug_source_value | source_value |  |  |
| drug_source_concept_id | source_concept_id |  |  |
| route_source_value | route_source_value |  |  |
| dose_unit_source_value | dose_unit_source_value |  |  |
