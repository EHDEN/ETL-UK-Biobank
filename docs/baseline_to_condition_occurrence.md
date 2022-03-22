---
layout: default
title: baseline to condition_occurrence
parent: assessment centre
nav_order: 7
---

## Table name: condition_occurrence

### Reading from Baseline

The baseline also includes information about the secondary cause of death of a person.
This information might also exist in the death registry records. 
Currently first a check is made if the record is already in the OMOP instance. 
If not a script is executed according to the table below. 

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| person_id | eid |  |  |
| condition_start_date | 40000-0.0 |  |  |
| condition_start_datetime | 40000-0.0 |  |  |
| condition_type_concept_id |  |  | 32815: Death Certificate |
| condition_concept_id | 40002-0.0 | vocabulary lookup |  |
| condition_source_concept_id | 40002-0.0 | reformat the ICD10 code given |  |
| condition_source_value | 40002-0.0 |  |