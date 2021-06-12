declareTest(2500, 'Covid19 TPP GP clinical to stem, correct date')
add_baseline(eid = 2500)
add_covid19_tpp_gp_clinical(eid = 2500, event_dt = '19/04/2020', code_type = 0, code = '5372.', value = 0.0)
expect_measurement(person_id = 2500, measurement_date='2020-04-19')

declareTest(2501, 'Covid19 TPP GP clinical to stem, missing date')
add_baseline(eid = 2501)
add_covid19_tpp_gp_clinical(eid = 2501, event_dt = '', code_type = 0, code = 'XaF8d', value = 0.0)
expect_no_measurement(person_id = 2501, measurement_concept_id=4200295)

declareTest(2502, 'Covid19 TPP GP clinical to stem, CTV3 code')
add_baseline(eid = 2502)
add_covid19_tpp_gp_clinical(eid = 2502, event_dt = '05/04/1995', code_type = 0, code = 'XaF8d', value = 0.0)
expect_measurement(person_id = 2502, measurement_concept_id = 4200295,  measurement_source_concept_id = 0, measurement_source_value = 'XaF8d')

declareTest(2503, 'Covid19 TPP GP clinical to stem, local TPP code')
add_baseline(eid = 2503)
add_covid19_tpp_gp_clinical(eid = 2503, event_dt = '12/03/1999', code_type = 1, code = '242..', value = 10.0)
expect_measurement(person_id = 2503, measurement_concept_id = 0,  measurement_source_concept_id = 0, measurement_source_value = '242..')

declareTest(2504, 'Covid19 TPP GP clinical to stem, code_type is -1')
add_baseline(eid = 2504)
add_covid19_tpp_gp_clinical(eid = 2504, event_dt = '12/03/1999', code_type = -1, code = 'XaF8d', value = 10.0)
expect_no_measurement(person_id = 2504, measurement_concept_id = 4200295)

declareTest(2505, 'Covid19 TPP GP clinical to stem, missing code')
add_baseline(eid = 2505)
add_covid19_tpp_gp_clinical(eid = 2505, event_dt = '12/03/1999', code_type = 1, value = 10.0)
expect_no_measurement(person_id = 2505, measurement_concept_id = 0)

declareTest(2506, 'Covid19 TPP GP clinical to stem, value')
add_baseline(eid = 2506)
add_covid19_tpp_gp_clinical(eid = 2506, event_dt = '12/03/1999', code_type = 1, code = '242..', value = 10.0)
expect_measurement(person_id = 2506, value_as_number = 10.0)

declareTest(2507, 'Covid19 TPP GP clinical to stem, visit_occurrence_id')
add_baseline(eid = 2507)
add_covid19_tpp_gp_clinical(eid = 2507, event_dt = '12/03/1999', code_type = 1, code = '242..', value = 10.0)
expect_measurement(person_id = 2507, visit_occurrence_id="5000250719990312")

declareTest(2508, 'Covid19 TPP GP clinical to stem, local code with value')
add_baseline(eid = 2508)
add_covid19_tpp_gp_clinical(eid = 2508, event_dt = '20/03/2021', code_type = 1, code = 'Y20d2', value = '')
expect_measurement(person_id = 2508, measurement_concept_id = 756065, value_as_concept_id = 9190)

declareTest(2509, 'Covid19 TPP GP clinical to stem, no meas when future date')
add_baseline(eid = 2509)
add_covid19_tpp_gp_clinical(eid = 2509, event_dt = '01/07/2037', code=1018251000000107)
expect_no_measurement(person_id = 2509, measurement_date = '2037-07-01')