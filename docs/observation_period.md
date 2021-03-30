---
layout: default
title: observation_period
parent: general practitioner
nav_order: 1
---

## Table name: observation_period

Every person has one observation_period. The minimum date and maximum date of the date records in the VISIT_OCCURRENCE, CONDITION_OCCURRENCE,
DRUG_EXPOSURE, PROCEDURE_OCCURRENCE, OBSERVATION and MEASUREMENT tables are taken and saved as Observation_period_start_date and Observation_period_end_date.
If the date of death is given, the Observation_period_end_date is the date of death.

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| observation_period_id |  | Auto-increment |  |
| person_id | eid |  |  |
| observation_period_start_date | start_date | If empty, use 1970-01-01 |  |
| observation_period_end_date | end_date | If empty, use 1970-01-01 |  |
| period_type_concept_id |  | 32817 - "EHR" |  |
