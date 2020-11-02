## Table name: observation_period

### Reading from gp_registrations

For each General Practicioner registration, record an observation period.
The gp registration contains the entry (`reg_date`) and exit date (`deduct_date`).
A person can have multiple registrations (e.g. at different data providers), this will create multiple observation period records.

**Filters**
 - If `eid` not in person table, do not include record.

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| observation_period_id |  | Auto-increment |  |
| person_id | eid |  |  |
| observation_period_start_date | reg_date | If empty, use 1970-01-01 |  |
| observation_period_end_date | deduct_date | If empty, use 1970-01-01 |  |
| period_type_concept_id |  | 32817 - "EHR" |  |
