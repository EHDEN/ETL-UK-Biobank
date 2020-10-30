# test ID range 200-299

declareTest(201, 'Test black female')
add_baseline(eid = '201', `31-0.0` = '0', `21000-0.0` = '4', `34-0.0` = '1937', `54-0.0` = '11011')
expect_person(person_id = 201, gender_concept_id = 8532, race_concept_id = 38003598, year_of_birth = 1937, location_id = 11011)

declareTest(202, 'Test mixed race male')
add_baseline(eid = '202', `31-0.0` = '1', `21000-0.0` = '2', `34-0.0` = '1961', `52-0.0` = '3')
expect_person(person_id = 202, gender_concept_id = 8507, race_concept_id = 4212311, month_of_birth = 3, year_of_birth = 1961)

add_baseline(eid = '301')
add_baseline(eid = '302')
add_baseline(eid = '303')
add_baseline(eid = '304')