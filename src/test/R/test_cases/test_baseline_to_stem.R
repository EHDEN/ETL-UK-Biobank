declareTest(900, 'Baseline - Hand grip to measurement')
add_baseline(eid = '900', `53-0.0`='10/10/2010', `47-0.0`='11.3')
expect_measurement(person_id = 900, measurement_date = '2010-10-10', measurement_concept_id = 44805438,
                   unit_concept_id = 9529, value_as_number = 11.3)

declareTest(901, 'Baseline - Alcohol use, daily to observation')
add_baseline(eid = '901', `1558-0.0`='1')
expect_observation(person_id = 901, observation_concept_id = 4052351, value_as_concept_id = 45879676)

declareTest(902, 'Baseline - Alcohol use, not answered')
add_baseline(eid = '902', `1558-0.0`='-3')
expect_no_observation(person_id = 902, observation_concept_id = 4052351)

declareTest(903, 'Baseline - White blood cell count')
add_baseline(eid = '903', `30000-0.0`='5.55', `30002-0.0`='2020-11-01')
expect_measurement(person_id = 903, measurement_date = '2020-11-01', measurement_concept_id = 3010813,
                   unit_concept_id = 4175206, value_as_number = 5.55)

declareTest(904, 'Baseline - History of diabetes')
add_baseline(eid = '904', `53-0.0`='2020-11-02', `20002-0.0`='1220', `30002-0.0`='2020-11-01')
expect_observation(person_id = 904, observation_date = '2020-11-02', observation_concept_id = 4188893, value_as_concept_id = 201820)

declareTest(905, 'Baseline - Chestpain absent, with source value')
add_baseline(eid = '905', `53-0.0`='10/10/2010', `2335-0.0`='0')
expect_observation(person_id = 905, observation_date = '2010-10-10', observation_concept_id = 4211787,
                   value_as_concept_id = 4133044, observation_source_value = '2335|0')

declareTest(906, 'Baseline - Chestpain present, repeat visit')
add_baseline(eid = '906', `53-1.0`='11/12/2013', `2335-1.0`='1')
expect_observation(person_id = 906, observation_date = '2013-12-11', observation_concept_id = 4188893,
                   value_as_concept_id = 4133044, observation_source_value = '2335|0')

declareTest(907, 'Baseline - Chestpain present, imaging visit')
add_baseline(eid = '907', `53-1.0`='11/12/2014', `2335-2.0`='1')
expect_observation(person_id = 907, observation_date = '2014-12-11', observation_concept_id = 4188893)

declareTest(908, 'Baseline - Chestpain present, imaging repeat visit')
add_baseline(eid = '908', `53-1.0`='11/12/2015', `2335-3.0`='1')
expect_observation(person_id = 908, observation_date = '2015-12-11', observation_concept_id = 4188893)

declareTest(909, 'Baseline - Chestpain ignored')
add_baseline(eid = '909', `53-0.0`='5/9/2013', `2335-0.0`='-1')
expect_no_observation(person_id = 909, observation_date = '2013-9-5', observation_concept_id = 4188893)

# TODO: tests for array numbers
