declareTest(900, 'Baseline - Hand grip to measurement')
add_baseline(eid = '801', `53-0.0`='2010-10-10', `47-0.0`='11.3')
expect_measurement(person_id = 900, measurement_date = '2010-10-10', measurement_concept_id = 44805438,
                   unit_concept_id = 9529, value_as_number = 11.3)

declareTest(901, 'Baseline - Alcohol use, daily to observation')
add_baseline(eid = '802', `1558-0.0`='1')
expect_observation(person_id = 901, observation_concept_id = 4052351, value_as_concept_id = 45879676)

declareTest(902, 'Baseline - Alcohol use, not answered')
add_baseline(eid = '803', `1558-0.0`='-3')
expect_no_observation(person_id = 902, observation_concept_id = 4052351)

declareTest(903, 'Baseline - White blood cell count')
add_baseline(eid = '804', `30000-0.0`='5.55', `30002-0.0`='2020-11-01')
expect_measurement(person_id = 903, measurement_date = '2020-11-01', measurement_concept_id = 3010813,
                   unit_concept_id = 4175206, value_as_number = 5.55)

declareTest(904, 'Baseline - History of diabetes')
add_baseline(eid = '805', `53-0.0`='2020-11-02', `20002-0.0`='1220', `30002-0.0`='2020-11-01')
expect_observation(person_id = 904, observation_date = '2020-11-02', observation_concept_id = 4188893, value_as_concept_id = 201820)

# TODO: tests for instance and array numbers
