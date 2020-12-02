# Source Data Mapping Approach to CDMV5.3.1

![](md_files/image25.png)

## Clinical data

#### Person:
- [from_baseline](baseline_to_person.md)

#### Observation_period: 
- [from_gp_registrations](gp_registrations_to_observation_period.md)

#### Visit_occurrence:
- [from_baseline](baseline_to_visit_occurrence.md)
- [from_covid](covid_to_visit_occurrence.md)
- [from_gp_clinical](gp_clinical_to_visit_occurrence.md)
- [from_gp_prescriptions](gp_prescriptions_to_visit_occurrence.md)
    
#### Visit_detail:
- [from_hesin](hesin_to_visit_detail.md)

#### Condition_occurrence:
- [from_death](death_to_condition_occurrence.md)
- [from_hesin_diag](hesin_diag_to_condition_occurrence.md)
- [from_cancer_registry](cancer_register_to_condition_occurrence.md)

#### Drug_exposure:
- [from_gp_prescriptions](gp_prescriptions_to_drug_exposure.md)

#### Procedure_occurrence:
- [from_hesin_oper](hesin_oper_to_procedure_occurrence.md)

#### Observation:
- [from_covid](covid_to_observation.md)
- [from_gp_clinical](gp_clinical_to_observation.md)

#### Death:
- [death](death_to_death.md)

## Health System data

#### Care_site:
- [from_baseline](baseline_to_care_site.md)
- [from_covid](covid_to_care_site.md)

## Stem_table:
- [from_baseline](baseline_to_stem_table.md)
- [from_gp_clinical](gp_clinical_to_stem_table.md)

## Stem_to_clinical_event:
![](md_files/stem_image.png)

The stem table is mapped to the respective OMOP domains based on the domain_id.
The following rules are applied, in this order:

1. If `stem_table.domain_id` given, then read target domain from `stem_table.domain_id`
2. If `stem_table.concept_id` not 0, then read target domain from `concept.domain_id`
3. Else, the target domain is Observation.

- [to_condition_occurrence](stem_to_condition_occurrence.md)
- [to_drug_exposure](stem_to_drug_exposure.md)
- [to_procedure_occurrence](stem_to_procedure_occurrence.md)
- [to_device_exposure](stem_to_device_exposure.md)
- [to_measurement](stem_to_measurement.md)
- [to_specimen](stem_to_specimen.md)
    
## Appendix:
- [source_appendix](source_appendix.md)
- [baseline_appendix](baseline_source_appendix.md)

