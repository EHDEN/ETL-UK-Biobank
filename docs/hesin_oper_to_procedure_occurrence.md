## Table name: procedure_occurrence

### Reading from hesin_oper

![](md_files/image20.png)

Combine at the start with the hesin data based on the combination of eid and ins_index. 

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| procedure_occurrence_id |  |  | Auto-increment |
| person_id | eid |  |  |
| procedure_concept_id | oper4<br>oper3 | If oper4 is filled map to standard OMOP concept <br> If oper4 is empty and oper3 is filled map to standard OMOP concept |  |
| procedure_date | opdate |  |  |
| procedure_datetime | opdate |  |  |
| procedure_type_concept_id | level | 1 - 44786630 Primary Procedure  2 - 44786631 Secondary Procedure |  |
| modifier_concept_id |  |  |  |
| quantity |  |  |  |
| provider_id |  |  |  |
| visit_occurrence_id | ins_index<br>eid | Lookup visit_occurrence_id by spell_index |  |
| visit_detail_id |  | Lookup by eid and ins_index |  |
| procedure_source_value | oper3<br>oper4 |  |  |
| procedure_source_concept_id | oper3<br>oper4 |  |  |
| modifier_source_value |  |  |  |