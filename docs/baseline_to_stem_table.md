## Baseline to stem table

The Baseline table contains one row per person and a column for each field. There can be thousands of columns. Each column name is structured as `field_id-instance.array` (e.g. 53-1.0). The `field_id` encodes the variable, the `instance` indicates one of the four assessment centre visits (ranging from 0 to 3) and with the `array` index multiple values can be given for the same field_id at the same visit.

To map all these columns to individual events, we map them first to a staging table: the stem table. Depending on the domain of the target concepts, the events are then mapped to their respective tables.

The input for this transformation are mapping tables for given prioritised `field_id`s (n=519). Each field can have multiple values, for which a separate mapping is made. The mappings are made using a modified version of Usagi, allowing for mapping of values and having different target types. They are saved as default Usagi save files, here [resources/baseline_field_mapping](resources/baseline_field_mapping). 

Each field or field/value combination can have a mapping to an event, unit and/or value. Also, each field is associated to a date field_id. Based the mappings given, both the semantic mapping and structural mapping is made. The field is considered discrete if it has mappings for its values, numeric if it has no values and value can be converted to float and text if the value cannot be converted to a float.

The process is as follows:
- Loop through all rows of the baseline table:
  - Loop through all columns in the row (except for the `eid`):
    1. If the value is empty, go to next column.
    1. From the column name, extract `field_id` and `instance` index (we can ignore the array index)
    2. Look up `target` concepts by `field_id` and value.
    2. If target is empty (=ignored field), go to next column.
    3. Look up date_field_id by `field_id`. Create the column name, using the extracted `instance` and array '0'. (e.g. `53-1.0`, if the date_field_id is '53' and the instance is '1')
    4. Map record to stem table according to below overview.

Notes:
 - The field is considered numeric if it has no value mappings
 - For numeric fields, -1 and -3 are filtered out.
 - A field can also be 'ignored' meaning it should not map to an event
 - Fields not given in the mapping tables are also ignored (these are fields not prioritised)
 - Mappings that have not been approved will be mapped to a 0 (see the mapping status column in the mapping tables). 
 - If a field has no value mappings, but the value can't be converted to a float, then it is treated as free-text and populates the value_as_string field.

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| id |  |  |  |
| domain_id |  |  |  |
| person_id | eid |  |  |
| start_date | `date_field` |  |  |
| start_datetime | `date_field` |  |  |
| visit_occurrence_id |  |  | TBD |
| provider_id |  |  |  |
| concept_id | target.event_concept_id |  |  |
| source_value |  | If value numeric: `field_id`<br>If discrete: `field_id`|`value` |  |
| source_concept_id |  | 0 |  |
| value_as_concept_id | target.value_as_concept_id | If discrete |  |
| value_as_number | target.value_as_number | If numeric |  |
| value_as_string | target.value_as_string | If text |  |
| value_source_value |  |  |  |
| unit_concept_id | target.unit_concept_id | If numeric |  |
| unit_source_value |  |  |  |
| type_concept_id |  | 32883 | Survey |
| end_date |  |  |  |
| end_datetime |  |  |  |
| verbatim_end_date |  |  |  |
| days_supply |  |  |  |
| dose_unit_source_value |  |  |  |
| lot_number |  |  |  |
| modifier_concept_id |  |  |  |
| modifier_source_value |  |  |  |
| operator_concept_id |  |  |  |
| modifier_source_value |  |  |  |
| quantity |  |  |  |
| range_high |  |  |  |
| range_low |  |  |  |
| refills |  |  |  |
| route_concept_id |  |  |  |
| route_source_value |  |  |  |
| sig |  |  |  |
| stop_reason |  |  |  |
| unique_device_id |  |  |  |
| anatomic_site_concept_id |  |  |  |
| disease_status_concept_id |  |  |  |
| specimen_source_id |  |  |  |
| anatomic_site_source_value |  |  |  |
| disease_status_source_value |  |  |  |
| condition_status_concept_id |  |  |  |
| condition_status_source_value |  |  |  |
| qualifier_concept_id |  |  |  |
| qualifier_source_value |  |  |  |

### Example
Given te following baseline row:

| eid | 53-0.0 | 53-1.0 | 46-0.0 | 2443-1.0 |
| --- | --- | --- | --- | --- |
| 123 | 2010-01-01 | 2020-06-06 | 12.5 | 1 |
| ... |  |  |  |  |

Loop through columns:
- Both columns with field_id 53 are ignored, this is used as date for other fields
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
     
| Destination Field | Record 1 | Record 2 | Record 3 |
| --- | --- | --- |--- |
| person_id | 123 | 123 |  |
| start_date | 2010-01-01 | 2020-06-06 |  |
| start_datetime | 2010-01-01T00:00:00 | 2020-06-06T00:00:00 |  |
| visit_occurrence_id |  |  |  |
| concept_id | [44805437](https://athena.ohdsi.org/search-terms/terms/44805437) | [4188893](https://athena.ohdsi.org/search-terms/terms/4188893) |  |
| source_value | "46" | "2443|1" |  |
| source_concept_id | 0 | 0 |  |
| value_as_concept_id |  | [201820](https://athena.ohdsi.org/search-terms/terms/201820) |  |
| value_as_number | 12.5 |  |  |
| value_as_string |  |  |  |
| value_source_value |  |  |  |
| unit_concept_id | [9529](https://athena.ohdsi.org/search-terms/terms/9529) |  |  |
| type_concept_id | [32883](https://athena.ohdsi.org/search-terms/terms/32883) | [32883](https://athena.ohdsi.org/search-terms/terms/32883) | [32883](https://athena.ohdsi.org/search-terms/terms/32883) |
