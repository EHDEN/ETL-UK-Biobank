
declareTest(3200, 'Test tissue, positive')
add_covid(eid = 3200, spectype = 16, specdate = '04/05/2020', result = 1)
add_baseline(eid = 3200)
expect_measurement(person_id = 3200, measurement_concept_id = '756055', measurement_date = '2020/05/04',
                   value_as_concept_id = '45884084')

declareTest(3201, 'Test tissue, negative')
add_covid(eid = 3201, spectype = 16, result = 0, specdate = '11/09/2020')
add_baseline(eid = 3201)
expect_measurement(person_id = 3201, measurement_concept_id = '756055', measurement_datetime = '2020/09/11',
                   value_as_concept_id = '45878583')

declareTest(3202, 'Test missing date')
add_covid(eid = 3202, specdate = '')
add_baseline(eid = 3202)
expect_measurement(person_id = 3202, measurement_concept_id = '756055', measurement_datetime = '1970/01/01')

declareTest(3203, 'Test visit_id')
add_covid(eid = 3203, specdate = '19/04/2020')
add_baseline(eid = 3203)
expect_visit_occurrence(person_id = 3203, visit_start_date = '2020/04/19')
expect_measurement(person_id = 3203, measurement_concept_id = '756055',
                   visit_occurrence_id = lookup_visit_occurrence('visit_occurrence_id', person_id='3203', visit_start_date = '2020/04/19'))