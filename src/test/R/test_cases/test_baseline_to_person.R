# test ID range 1-99

declareTest(1, 'Test black female')
add_baseline(eid = 'fake1', `31-0.0` = '0', `21000-0.0` = '4', `34-0.0` = '1937.0', `54-0.0` = '11011')
expect_person(person_id = 1, gender_concept_id = 8532, race_concept_id = 38003598, year_of_birth = 1937, location_id = 11011)

declareTest(2, 'Test mixed race male')
add_baseline(eid = 'fake2', `31-0.0` = '1', `21000-0.0` = '2', `34-0.0` = '1961.0', `52-0.0` = '3')
expect_person(person_id = 2, gender_concept_id = 8507, race_concept_id = 4212311, month_of_birth = 3, year_of_birth = 1961)

