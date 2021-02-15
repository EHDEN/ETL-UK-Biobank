---
layout: default
title: Death To Condition Occurrence
nav_order: 11
---

---
layout: default
title: Death To Condition Occurrence
nav_order: 11
---

## Table name: condition_occurrence

### Reading from death and death_cause
Join death and death_cause using eid. Save to condition occurrence if the record is not the primary cause of death (arr_index is not equal to 0)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| condition_occurrence_id |  |  | Auto-increment |
| person_id | eid |  |  |
| condition_concept_id | cause_icd10 |  |  |
| condition_start_date | date_of_death | | |
| condition_start_datetime | date_of_death |  |  |
| condition_end_date |  |  |  |
| condition_end_datetime |  |  |  |
| condition_type_concept_id |  | 32815 - Death certificate |  |
| stop_reason |  |  |  |
| provider_id |  |  |  |
| visit_occurrence_id |  |  |  |
| visit_detail_id |  |  |  |
| condition_source_value | cause_icd10 |  |  |
| condition_source_concept_id | cause_icd10 |  |  |
| condition_status_source_value |  |  |  |
| condition_status_concept_id |  |  |  |
