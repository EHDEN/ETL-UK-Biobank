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