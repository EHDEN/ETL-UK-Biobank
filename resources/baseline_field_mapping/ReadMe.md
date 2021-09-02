# UKB Baseline field mapping

This folder contains **Usagi save files** with mapping of prioritized fields to OMOP concepts.

## Mapping types
There are different types of files that are each mapped differently

### Numeric
_`numeric_fields_prio.csv`_

From the UKB source dictionary the `field_id`, `field_name` and `unit_name` are extracted with continuous type.
Also the `category_name` and `notes` are provided. For the frequency, the `item_count` is used.

Two mappings to standard concepts have to be made for each field_id:
 1. Event (regular), preferably from the SNOMED vocabulary and Measurement domain
 2. Unit, from the UCUM vocabulary

### Discrete
_`discrete_prio_fields.csv`_

_`discrete_boolean_prio_fields.csv`_

From the UKB source dictionary the `field_id`, `field_name`, `value_code` and `value_name` are extracted with continuous type.
Also the `category_name` and `notes` are provided. For the frequency, the `item_count` is used.

Two mappings to standard concepts have to be made for each combination of field_id and value_code:
 1. Event, e.g. 'History of clinical finding in subject'
 2. Value, e.g. the condition of which the history is recorded

In some cases a combination of field and value is only mapped to a event_concept_id. e.g. 

### Value

||||
| --- | --- | --- |
| _`discrete_20001_Cancer.csv`_ | _`discrete_20002_Non-cancer_illness.csv`_ | |
| _`discrete_20003_Treatment.csv`_ | _`discrete_20004_Operation.csv`_ | _`discrete_40011_cancer_tumour.csv`_ | |
| _`discrete_41256_main_OPCS3.csv`_ | _`discrete_41273_OPCS3.csv`_ | _`discrete_41258_secondary_OPCS3.csv`_ |

Each of these files contains all possible values of one field.

From the UKB source dictionary the `field_id`, `value_code` and `value_name` are extracted with continuous type.
The field name is not given, as this is the same within a file.
Also the `category_name` and `notes` are provided. For the frequency, the `item_count` is used.

One mappings to a standard concept has to be made for each value_code:
 1. Value

The event concept id is assigned on a file level (e.g. 'History of clinical finding in subject' for the fields 20001 and 20002).

### Other
_`other_prio_fields.csv`_

These fields are not of type continuous and do not have values associated with them. 
These should be mapped case by case.

## Approving
If the mapping appears to be correct, we can approve it with the button on the bottom right.
The row will turn green.

## Ignored and Flagged status
Besides approving mapping, we can set also set the status to ignored. 
This means that the particlar field (or field-value combination) should NOT be mapped to an event.\
An example is a value of -1, meaning 'Not provided'.

If a mapping is too complicated to map with Usagi (e.g. information from other fields is needed), then we can flag it.
This makes it easy to find field mappings that need to be discussed further.
Please provide a short comment.

## Date
We assume that value in field 53 is used as the date for all fields. 
If a different field is used as the date (e.g lab date), please indicate that in the comment.


 

