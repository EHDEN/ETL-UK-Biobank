---
layout: default
title: emis gp_clinical & gp_scripts to visit_occurrence
parent: covid19 general practitioner
nav_order: 3
---

## Table name: visit_occurrence

### Reading from covid19_emis_gp_clinical and covid19_emis_gp_scripts

We assume that a person can have only one gp visit per day. 
To get all the visits, we take the union of covia19_emis_gp_clinical and covia19_emis_gp_scripts. Then we map each unique combination of eid and event_dt/issue_date as visit.
If the `event_dt` or `issue_date` is not given, no visit is created.

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| visit_occurrence_id | eid<br>covia19_emis_gp_clinical.event_dt<br>covia19_emis_gp_scripts.issue_date | Concatenate '5', eid and the date in YYYYMMDD format |  |
| person_id | eid |  |  |
| visit_concept_id |  |  | 38004453 - Family Practice |
| visit_start_date | covia19_emis_gp_clinical.event_dt<br>covia19_emis_gp_scripts.issue_date |  |  |
| visit_start_datetime | covia19_emis_gp_clinical.event_dt<br>covia19_emis_gp_scripts.issue_date |  |  |
| visit_end_date | covia19_emis_gp_clinical.event_dt<br>covia19_emis_gp_scripts.issue_date |  |  |
| visit_end_datetime | covia19_emis_gp_clinical.event_dt<br>covia19_emis_gp_scripts.issue_date |  |  |
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
| data_source |  |  | covid19 gp_emis |
