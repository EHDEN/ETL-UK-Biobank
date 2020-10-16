## Table name: location

The location table is a list of unique assessment centers that are part of the study.
This can be retrieved from [UKB encoding 10](https://biobank.ctsu.ox.ac.uk/crystal/coding.cgi?id=10). 
As location_id, we use the native coding from UKB data dictionary. 
This means no lookup is necessary to retrieve the `location_id`.

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| location_id | coding |  | e.g. 11012 |
| address_1 |  |  |  |
| address_2 |  |  |  |
| city | meaning |  | e.g. 'Barts' |
| state |  |  |  |
| zip |  |  |  |
| county |  |  |  |
| location_source_value | coding |  |  |

