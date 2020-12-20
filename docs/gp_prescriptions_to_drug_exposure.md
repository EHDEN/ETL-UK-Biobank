## Table name: drug_exposure

### Reading from gp_prescriptions

Drug code either in read_2, bnf_code or dmd_code. Mutually exclusive.


Field to field mapping to be completed.

![](md_files/image13.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| drug_exposure_id |  |  |  |
| person_id | eid |  |  |
| drug_concept_id | dmd_code<br>read_2<br>drug_name | Coding priority: use dm+d, then read, then drug name. Skip record if only BNF code available (not complete and not specific enough). |  |
| drug_exposure_start_date | issue_date |  |  |
| drug_exposure_start_datetime |  |  |  |
| drug_exposure_end_date | issue_date<br>quantity | No drug end date available, estimate using Themis convention:<br> either same as start date (if no valid quantity available), or 1 day x quantity (valid if expressed as: tablets, capsules, doses, strips, sachets, units, or a whole number without unit; other units such as volume will be ignored). | Date estimate from quantity available for > 68% of unique values in scan report. |
| drug_exposure_end_datetime |  |  |  |
| verbatim_end_date |  |  |  |
| drug_type_concept_id |  |  | 32838 - 'EHR prescription' |
| stop_reason |  |  |  |
| refills |  |  |  |
| quantity | quantity | Extract numerical value from free text using regex: first attempt to extract meaningful dose values (see end_datetime logic), then any value. In case of multiple matches, only first is taken. | >95% of source strings can be parsed as numbers using regular expressions, however some might not be particularly meaningful. |
| days_supply |  |  |  |
| sig |  |  |  |
| route_concept_id |  |  |  |
| lot_number |  |  |  |
| provider_id |  |  |  |
| visit_occurrence_id |  |  |  |
| visit_detail_id |  |  |  |
| drug_source_value | dmd_code<br>read_2<br>drug_name |  |  |
| drug_source_concept_id | dmd_code<br>read_2<br>drug_name |  |  |
| route_source_value |  |  |  |
| dose_unit_source_value |  |  |  |
| data_source | data_provider | Map as "GP-" + number found in data_provider, e.g. GP-1, GP-2, GP-3, or GP-4 |  |
