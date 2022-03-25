---
layout: default
title: emis gp_scripts
parent: covid19 general practitioner
nav_order: 2
---

## Table name: drug_exposure

### Reading from 2_covid19_emis_gp_scripts.txt.gz.pure

Rows are skipped if:
- `code_type` is NOT 3 (EMIS code) or NOT 6 (dm+d code)
- `date` is emtpy or in 2037

![](md_files/image7.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| drug_exposure_id |  |  | Auto-increment |
| person_id | eid |  |  |
| drug_concept_id | code<br>code_type | Map in combination with code_type: 6 - dm+d lookup, 3 - local emis |  |
| drug_exposure_start_date | issue_date | If 1902-02-02 or 1903-03-3, set date to yob-07-01 (field 34 in baseline) |  |
| drug_exposure_start_datetime | issue_date |  |  |
| drug_exposure_end_date | issue_date | use the same as the start date |  |
| drug_exposure_end_datetime | issue_date |  |  |
| verbatim_end_date |  |  |  |
| drug_type_concept_id |  |  | 32838 - ‘EHR prescription’ |
| stop_reason |  |  |  |
| refills |  |  |  |
| quantity |  |  |  |
| days_supply |  |  |  |
| sig |  |  |  |
| route_concept_id |  |  |  |
| lot_number |  |  |  |
| provider_id |  |  |  |
| visit_occurrence_id |  | visit_id from 'eid' & 'date' |  |
| visit_detail_id |  |  |  |
| drug_source_value | code |  |  |
| drug_source_concept_id | code<br>code_type |  |  |
| route_source_value |  |  |  |
| dose_unit_source_value |  |  |  |
| data_source |  |  | covid19 gp emis |