
declareTest(1700, 'GP clinical to stem, read2 blood pressure')
add_baseline(eid = 1700)
add_gp_clinical(eid = 1700, event_dt = '01/04/2020', read_2 = '246..')
expect_measurement(person_id = 1700, measurement_date = '2020-04-01', measurement_type_concept_id = 32817,
                   measurement_concept_id = 4061103, measurement_source_concept_id = 45471867, measurement_source_value = '246..00')

declareTest(1701, 'GP clinical to stem, visit lookup')
add_baseline(eid = 1701)
add_gp_clinical(eid = 1701, event_dt = '02/04/2020', read_2 = '246..')
expect_measurement(person_id = 1701, visit_occurrence_id = lookup_visit_occurrence('visit_occurrence_id', person_id = 1701, visit_start_date = '2020-04-02'))

declareTest(1702, 'GP clinical to stem, unknown read2 code')
add_baseline(eid = 1702)
add_gp_clinical(eid = 1702, event_dt = '03/04/2020', read_2 = '123abc')
expect_observation(person_id = 1702, observation_date = '2020-04-03',
                   observation_concept_id = 0, observation_source_concept_id = NULL, observation_source_value = '123abc')

declareTest(1703, 'GP clinical to stem, read3 code')
add_baseline(eid = 1703)
add_gp_clinical(eid = 1703, event_dt = '04/04/2020', read_3 = 'XE2q5')
expect_observation(person_id = 1703, observation_date = '2020-04-04',
                   observation_concept_id = 0, observation_source_concept_id = NULL, observation_source_value = 'XE2q5')

declareTest(1704, 'GP clinical to stem, missing date')
add_baseline(eid = 1704)
add_gp_clinical(eid = 1704, event_dt = '', read_2 = '246..')
expect_no_observation(person_id = 1704, observation_source_value = 'XE2q5')

declareTest(1705, 'GP clinical to stem, Serum creatinine')
add_baseline(eid = 1705)
add_gp_clinical(eid = 1705, event_dt = '15/04/2020', read_2 = '44J3.', value1 = 12, data_provider = '1')
expect_measurement(person_id = 1705, measurement_concept_id = 37392176, measurement_source_value = '44J3.', measurement_source_concept_id = 45461929,
                   value_as_number = 12)

declareTest(1706, 'GP clinical to stem, DBP')
add_baseline(eid = 1706)
add_gp_clinical(eid = 1706, event_dt = '16/04/2020', read_2 = '246A.', value1 = 80.7, data_provider = '2')
expect_measurement(person_id = 1706, measurement_concept_id = 4060831, measurement_source_value = '44J3.', measurement_source_concept_id = 45468573,
                   value_as_number = 80.7)

declareTest(1707, 'GP clinical to stem, DBP and SBP')
add_baseline(eid = 1707)
add_gp_clinical(eid = 1707, event_dt = '17/04/2020', read_2 = '246..', value1 = 123, value2 = 85, data_provider = '1')
expect_measurement(person_id = 1707, measurement_concept_id = 4060831, measurement_source_value = '246..', value_as_number = 85)
expect_measurement(person_id = 1707, measurement_concept_id = 4062019, measurement_source_value = '246..', value_as_number = 123)
