# test ID range 200-299

declareTest(200, 'Test black female')
add_baseline(eid = '200', `31-0.0` = '0', `21000-0.0` = '4', `34-0.0` = '1937', `54-0.0` = '11011')
expect_person(person_id = 200, gender_concept_id = 8532, race_concept_id = 35825567, year_of_birth = 1937, care_site_id = 11011)

declareTest(201, 'Test mixed race male')
add_baseline(eid = '201', `31-0.0` = '1', `21000-0.0` = '2', `34-0.0` = '1961', `52-0.0` = '3')
expect_person(person_id = 201, gender_concept_id = 8507, race_concept_id = 35826472, month_of_birth = 3, year_of_birth = 1961)

declareTest(202, 'Test skip when empty year of birth')
add_baseline(eid = '202', `34-0.0` = '')
expect_no_person(person_id = 202)
