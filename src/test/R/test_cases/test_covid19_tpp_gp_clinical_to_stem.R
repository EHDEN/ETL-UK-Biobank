declareTest(2300, 'Covid19 TPP GP clinical to stem, correct date')
add_baseline(eid = 2300)
add_3_covid19_tpp_gp_clinical(eid = 2300, event_dt = '19/04/2020', code_type = 0, code = '5372.', value = 0.0)
expect_measurement(person_id = 2300, measurement_concept_id = 4060831,  measurement_date='2020-04-19')

# source_concept_id needs update
declareTest(2301, 'Covid19 TPP GP clinical to stem, CTV3 code')
add_baseline(eid = 2301)
add_3_covid19_tpp_gp_clinical(eid = 2301, event_dt = '05/04/1995', code_type = 0, code = 'XaF8d', value = 0.0)
expect_measurement(person_id = 2301, measurement_concept_id = 4200295,  measurement_source_concept_id = 0, measurement_source_value = 'XaF8d')

# needs update when code1 are implemented
# also source_concept_id
declareTest(2302, 'Covid19 TPP GP clinical to stem, local TPP code')
add_baseline(eid = 2302)
add_3_covid19_tpp_gp_clinical(eid = 2302, event_dt = '12/03/1999', code_type = 1, code = '242..', value = 10.0)
expect_measurement(person_id = 2302, measurement_concept_id = 0,  measurement_source_concept_id = 0, measurement_source_value = '242..')

# Removed because source_concept_id is above
# declareTest(2303, 'Covid19 TPP GP clinical to stem, source concept id check')
# add_baseline(eid = 2303)
# add_gp_clinical(eid = 2303, event_dt = '23/09/2015', code_type = 0, code = '5372.', value = 0.0)
# expect_measurement(person_id = 2303, measurement_concept_id = 4060831,  measurement_source_concept_id = 45468573, measurement_source_value = '5372.')