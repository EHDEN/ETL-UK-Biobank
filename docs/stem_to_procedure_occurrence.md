---
layout: default
title: stem_table to procedure_occurrence
parent: stem table
nav_order: 3
---

## Table name: procedure_occurrence

### Reading from stem_table

![](md_files/image21.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| procedure_occurrence_id | id |  | Auto-increment |
| person_id | person_id |  |  |
| procedure_concept_id | concept_id |  0 if `concept_id` is empty |  |
| procedure_date | start_date |  |  |
| procedure_datetime | start_datetime |  |  |
| procedure_type_concept_id | type_concept_id |  |  |
| modifier_concept_id | modifier_concept_id |  |  |
| quantity | quantity |  |  |
| provider_id | provider_id |  |  |
| visit_occurrence_id | visit_occurrence_id |  |  |
| visit_detail_id |  |  |  |
| procedure_source_value | source_value |  |  |
| procedure_source_concept_id | source_concept_id |  |  |
| modifier_source_value | modifier_source_value |  |  |

