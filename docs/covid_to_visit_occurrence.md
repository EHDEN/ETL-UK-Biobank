---
layout: default
title: covid to visit_occurrence
parent: covid19 registry
nav_order: 2
---

## Table name: visit_occurrence

### Reading from covid

<!-- ![](md_files/image9.png) -->

Take all rows with unique eid and specdate. If the laboratory field is different, the first is taken at random.

```mermaid
flowchart LR
    eid --> visit_occurrence_id
    eid --> person_id
    specdate --> visit_occurrence_id
    specdate --> visit_start_date
    specdate --> visit_start_datetime
    specdate --> visit_end_date
    specdate --> visit_end_datetime
    laboratory --> care_site_id
    S1[ ] -->|32693 - Health examination| visit_concept_id
    S2[ ] -->|32856 - Lab| visit_type_concept_id
    
    subgraph COVID
        eid
        specdate
        laboratory
    end
    subgraph Visit Occurrence
        visit_occurrence_id
        person_id
        visit_start_date
        visit_start_datetime
        visit_end_date
        visit_end_datetime
        care_site_id
        visit_concept_id
        visit_type_concept_id
    end
    
    style S1 fill:#FFFFFF, stroke:#FFFFFF;
    style S2  fill:#FFFFFF, stroke:#FFFFFF;
```

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| visit_occurrence_id | eid<br>specdate | Concatenate '2', eid and specdate in YYYYMMDD format|  |
| person_id | eid |  |  |
| visit_concept_id |  |  | 32693 - Health examination |
| visit_start_date | specdate |  |  |
| visit_start_datetime | specdate |  |  |
| visit_end_date | specdate |  |  |
| visit_end_datetime | specdate |  |  |
| visit_type_concept_id |  |  | 32856 - Lab |
| provider_id |  |  |  |
| care_site_id | laboratory |  |  |
| visit_source_value |  |  |  |
| visit_source_concept_id |  |  |  |
| admitting_source_concept_id |  |  |  |
| admitting_source_value |  |  |  |
| discharge_to_concept_id |  |  |  |
| discharge_to_source_value |  |  |  |
| preceding_visit_occurrence_id |  |  |  |

