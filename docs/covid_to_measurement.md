---
layout: default
title: covid to measurement
parent: covid19 registry
nav_order: 4
---

## Table name: measurement

### Reading from covid

An additional mapping of the covid table to measurement. Measurement concept comes from the AESI study - 
["Measurement of Severe acute respiratory syndrome coronavirus 2 (SARS-CoV-2)"](https://athena.ohdsi.org/search-terms/terms/756055). Result is also captured (positive or negative).

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| measurement_id |  |  |  |
| person_id | eid |  |  |
| measurement_concept_id |  |  | 756055 - Measurement of Severe acute respiratory syndrome coronavirus 2 (SARS-CoV-2) |
| measurement_date | specdate |  |  |
| measurement_datetime | specdate |  |  |
| visit_occurrence_id | specdate<br>eid | Lookup id of previously created visit occurrence (from covid_to_observation) by eid and specdate |  |
| measurement_type_concept_id |  |  | 32856 - Lab |
| value_as_concept_id | result | the test result: 1 (Positive)-> 45884084, 0 (Negative)-> 45878583 |  |
| data_source |  | 'covid' |  |