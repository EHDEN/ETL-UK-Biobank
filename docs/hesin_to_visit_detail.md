---
layout: default
title: hesin to visit_detail
parent: hospital episode statistic
nav_order: 2
---

## Table name: visit_detail

### Reading from hesin_c.txt
Every record of hesin episode is a visit_detail record. 
Episodes are combined into spells (one visit_occurrence record), which are a total continuous stay of a patient in a single hospital from admission to discharge.

![](md_files/image_visit_detail.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| visit_detail_id | eid<br>ins_index | Concatenate eid and ins_index | |
| person_id | eid |  |  |
| visit_occurrence_id | eid<br>spell_index | Lookup vist_occurrence_id by eid and spellindex  eid=visit_occurrence.person_id  'HES-spell_index'=visit_occurrence.record_source_value<br> |  |
| visit_detail_start_date | epistart | if missing use the admission date "admidate".  If both empty us default date 01/01/1970 |  |
| visit_detail_start_datetime | epistart |  |  |
| visit_detail_end_date | epiend | if missing use start_date |  |
| visit_detail_end_datetime | epiend |  |  |
| visit_detail_concept_id | admimeth<br>dsource | Map same as for visit_occurrence |  |
| visit_detail_source_value | admimeth<br>dsource | "record origin: dsource/admission method: admimeth" |  |
| visit_detail_type_concept_id |  |  | 32827,  # 'EHR encounter record' |
| provider_id |  |  | This can be retrieved from either hesin.mainspef or hesin.tretspef. Not implemented. |
| care_site_id |  |  |  |
| visit_source_concept_id |  |  |  |
| admitting_source_value | admisorc<br>dsource | "record origin: dsource/admission source: admisorc" |  |
| admitting_source_concept_id | admisorc<br>dsource |  |  |
| discharge_to_source_value | disdest<br>dsource | "record origin: dsource/discharge destination: disdest |  |
| discharge_to_concept_id | disdest<br>dsource |  |  |
| preceding_visit_detail_id |  |  |  |
| visit_detail_parent_id |  |  |  |
| data_source | dsource | "HES-dsource" |  |

