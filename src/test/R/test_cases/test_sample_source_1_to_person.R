# test ID range 1-99

declareTest(1, 'Add 1 person to Person table')
add_sample_source_table(subject_id = '0000001')
expect_count_person(person_id = 1, rowCount = 1)
