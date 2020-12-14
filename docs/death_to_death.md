## Table name: death

Deaths are recorded both in the baseline table (fields `40000` and `40001`) and in separate death tables; `death` and `death_cause`. 
The death tables is a recent addition to quicker process deaths.
These dedicated tables therefore contain more recent information than the field in the baseline table.
We will use these tables.

### Reading from death.csv and death_cause.csv
Join `death` and `death_cause` by eid. ~and ins_index.~

There are a few people with multiple records in the `death` table. 
The OMOP death table only accepts one death. 
We will use the first death and drop duplicates.

Also, only one cause of death is recorded in the OMOP death table. 
The primary cause (`array_index`=0) is recorded here.
**TODO**: The other causes of death are captured as conditions. 

If the date of death is not given, no death is recorded.

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| person_id | eid |  |  |
| death_date | death.date_of_death |  | Date of death |
| death_datetime | death.date_of_death |  | Date of death |
| death_type_concept_id | death.source |  | Death information source, coded with https://biobank.ctsu.ox.ac.uk/crystal/coding.cgi?id=261 |
| cause_concept_id | death_cause.cause_icd10 |  | There can be multiple causes of death, take the first (`array_index`=0) |
| cause_source_value | death_cause.cause_icd10 |  |  |
| cause_source_concept_id | death_cause.cause_icd10 |  |  |

### Reading Baseline
Only include deaths not recorded in the death and death_cause table.

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| person_id | eid |  |  |
| death_date | 40000-0.0 |  | Date of death |
| death_datetime | 40000-0.0 |  | Date of death |
| death_type_concept_id | 40020-0.0 |  | Death record origin |
| cause_concept_id | 40001-0.0 |  | Underlying (primary) cause of death: ICD10 |
| cause_source_value | 40001-0.0 |  | Underlying (primary) cause of death: ICD10 |
| cause_source_concept_id | 40001-0.0 |  | Underlying (primary) cause of death: ICD10 |