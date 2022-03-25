---
layout: default
title: baseline to death
parent: assessment centre
nav_order: 6
---

## Table name: death

### Reading from Baseline

The baseline includes information about the death date and the cause of death of a person.
This information might also exist in the death registry records. 
Currently first a check is made if the record is already in the OMOP instance. 
If not a script is executed according to the table below. 

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| person_id | eid |  |  |
| death_date | 40000-0.0 |  |  |
| death_datetime | 40000-0.0 |  |  |
| death_type_concept_id |  |  | 32815: Death Certificate |
| cause_concept_id | 40001-0.0 | vocabulary lookup |  |
| cause_source_concept_id | 40001-0.0 | reformat the ICD10 code given |  |
| cause_source_value | 40001-0.0 |  |
