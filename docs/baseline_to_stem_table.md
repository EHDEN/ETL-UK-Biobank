---
layout: default
title: baseline to stem_table
parent: assessment centre
nav_order: 4
---

## Baseline to stem_table

The Baseline table contains one row per person and a column for each field. There can be thousands of columns. Each column name is structured as `field_id-instance.array` (e.g. `20001-1.15`). The `field_id` encodes the variable, the `instance` indicates one of the four assessment centre visits (ranging from 0 to 3) and with the `array` index multiple values can be given for the same field_id at the same visit.

To map all these columns to individual events, we map them first to a staging table: the stem table. Depending on the domain of the target concepts, the events are then mapped to their respective tables. See the [section on stem table mapping](stem/index.md)

The input for this transformation are mapping tables for given prioritised `field_id`s (n=519). Each field can have multiple values, for which a separate mapping is made. The mappings are made using a modified version of Usagi, allowing for mapping of values and having different target types. They are saved as default Usagi save files: [resources/baseline_field_mapping](/resources/baseline_field_mapping) (also contains a detailed description of how the mappings were made). 

Each field or field/value combination can have a mapping to an event, unit and/or value. Also, each field is associated to a date field_id. Based the mappings given, both the semantic mapping and structural mapping is made. The field is considered discrete if it has mappings for its values, numeric if it has no values and value can be converted to float and text if the value cannot be converted to a float.

The process is as follows:
- Loop through all rows of the baseline table:
  - Loop through all columns in the row (except for the `eid`):
    1. If the value is empty, go to next column.
    2. From the column name, extract `field_id` and `instance` index (we can ignore the array index)
    3. Look up `target` concepts by `field_id` and value. If target is empty (=ignored field), go to next column.
    4. Look up date_field_id by `field_id`. Create the column name, using the extracted `instance` and array '0'. (e.g. `53-1.0`, if the date_field_id is '53' and the instance is '1')
    5. Map record to stem table columns according to the overview below.

Notes:
 - The field is considered numeric if it has no value mappings
 - For numeric fields, -1 and -3 are filtered out.
 - A field can also be 'ignored' meaning it should not map to an event
 - Fields not given in the mapping tables are also ignored (these are fields not prioritised)
 - Mappings that have not been approved will be mapped to a 0 (see the mapping status column in the mapping tables). 
 - If a field has no value mappings, but the value can't be converted to a float, then it is treated as free-text and populates the value_as_string field.
 - There are some cases where instances run higher than 3. These correspond to positions in the death or cancer registry and are handled separately.
 - Waist and Hip circumference (fields 48 and 49) are mapped to observation concepts ([4172830](https://athena.ohdsi.org/search-terms/terms/4172830) [4111665](https://athena.ohdsi.org/search-terms/terms/4111665), respectively).
   There does not exist an equivalent target concept for both in the measurement domain (see also issue #176).

| Destination Field | Source field | Logic | Comment |
| --- | --- | --- | --- |
| id |  |  | Not used |
| domain_id |  |  | Not used, the concept_id  |
| person_id | eid |  |  |
| start_date | `date_column` | Lookup date_field_id from field_id (step d) |  |
| start_datetime | `date_column` | Lookup date_field_id from field_id (step d) |  |
| end_date |  |  | One date provided |
| end_datetime |  |  | One date provided |
| visit_occurrence_id |  |  | TBD |
| provider_id |  |  | Not provided |
| concept_id | target.event_concept_id | Lookup from field_id and value (step c) |  |
| source_value | `field_id` value | If value numeric: `field_id`<br>If discrete: `field_id`\|`value`. Truncated to 50 characters. |  |
| source_concept_id | `field_id` value | Use `field_id` to find the UK Biobank vocabulary concept_id | UK Biobank has it is own vocabulary in Athena |
| value_as_concept_id | target.value_as_concept_id | Lookup from field_id and value (step c) | If value has a discrete mapping |
| value_as_number | target.value_as_number | Lookup from field_id and value (step c) | If value is numeric |
| value_as_string | target.value_as_string | Lookup from field_id and value (step c). Truncated to 50 characters. | If value is text |
| value_source_value |  |  | Not used, field and value are in source_value column |
| unit_concept_id | target.unit_concept_id | Lookup from field_id and value (step c) | If value is numeric |
| unit_source_value |  |  | Not used, unit is directly derived from the `field_id` |
| type_concept_id |  | Mapping given in [field_id_to_type_concept_id.csv](./resources/baseline_field_mapping/field_id_to_type_concept_id.csv) | Depending on the category of the field_id one of:<br>- 32862 Patient filled survey<br>- 32851 Healthcare professional filled survey<br>- 32879 Registry<br>- 32856 Lab<br>- 32817 EHR |

There are 26 more columns in the stem table, each corresponding to columns in the event tables. These are not used and omitted for brevity.

### Example
Given te following baseline row:

| eid | 31-0.0 | 53-0.0 | 53-1.0 | 46-0.0 | 2443-1.0 |
| --- | --- | --- | --- | --- | --- |
| 123 | 0 | 2010-01-01 | 2020-06-06 | 12.5 | 1 |

Loop through columns:
- Columns with field_id 31 (gender) and 53 (visit date) are marked as 'IGNORED' in the mapping files. We skip these for the mapping to stem table. These fields are used for other mappings (gender in the mapping to person).
- Column [`46-0.0`](https://biobank.ctsu.ox.ac.uk/crystal/field.cgi?id=46) ("Hand grip strength, left", initial visit)
  1. Not empty
  2. `field_id`=46, `instance`=0, (`array`=0)
  3. Lookup mapping for field 46 in mapping tables, we get:
     ```
     event_concept_id=44805437
     value_as_number=12.5
     unit_concept_id=9529
     value_as_concept_id=None
     source_value=46
     ```
  4. Lookup the date field associated with this `field_id`. We get: 53. Together with the instance (0), this means we have to retrieve the date from column `53-0.0` (=2010-01-01).
  5. Map (see result for 'Record 1' in table below)
- Column [`2443-1.0`](https://biobank.ctsu.ox.ac.uk/crystal/field.cgi?id=2443) ("Diabetes diagnosed by doctor", repeat visit)
  1. Not empty
  2. `field_id`=2443, `instance`=1, (`array`=0)
  3. Lookup mapping for field 2443 in mapping tables, we get:
     ```
     event_concept_id=4188893
     value_as_number=None
     unit_concept_id=None
     value_as_concept_id=201820
     source_value=2443|1
     ```
  4. Lookup the date field associated with this `field_id`. We get: 53. Together with the instance (1), this means we have to retrieve the date from column `53-1.0` (=2020-06-06).
  5. Map (see result for 'Record 2' in table below)
     
| Destination Field | Record 1 | Record 2 | 
| --- | --- | --- |
| person_id | 123 | 123 |
| start_date | 2010-01-01 | 2020-06-06 |
| start_datetime | 2010-01-01T00:00:00 | 2020-06-06T00:00:00 |
| visit_occurrence_id |  |  |
| concept_id | [44805437](https://athena.ohdsi.org/search-terms/terms/44805437) | [4214956](https://athena.ohdsi.org/search-terms/terms/4214956) |
| source_value | "46" | "2443\|1" |
| source_concept_id | 0 | 0 |
| value_as_concept_id |  | [201820](https://athena.ohdsi.org/search-terms/terms/201820) |
| value_as_number | 12.5 |  |
| value_as_string |  |  |
| value_source_value |  |  |
| unit_concept_id | [9529](https://athena.ohdsi.org/search-terms/terms/9529) |  |
| type_concept_id | [32879](https://athena.ohdsi.org/search-terms/terms/32879) | [32862](https://athena.ohdsi.org/search-terms/terms/32862) |
