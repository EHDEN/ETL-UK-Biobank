# test ID range 800-899

declareTest(800, 'Test nasopharyngeal swab, positive')
add_covid(eid = 800, spectype = 31, specdate = '04/05/2020', result = 1)
add_baseline(eid = 800)
expect_observation(person_id = 800, observation_concept_id = '4122259', observation_date = '2020/05/04',
                   value_as_concept_id = '45884084')

declareTest(801, 'Test tissue, negative')
add_covid(eid = 801, spectype = 16, result = 0, specdate = '11/09/2020')
add_baseline(eid = 801)
expect_observation(person_id = 801, observation_concept_id = '4002890', observation_datetime = '2020/09/11',
                   value_as_concept_id = '45878583')

declareTest(802, 'Test blood, missing date')
add_covid(eid = 802,spectype = 28, specdate = '')
add_baseline(eid = 802)
expect_observation(person_id = 802, observation_concept_id = '4001225', observation_datetime = '1970/01/01',
                   observation_type_concept_id = '38000279')

declareTest(803, 'Test visit_id, wound (surgical)')
add_covid(eid = 803, spectype = 36, specdate = '19/04/2020', laboratory = 52)
add_baseline(eid = 803)
expect_visit_occurrence(person_id = 803, visit_start_date = '2020/04/19')
expect_observation(person_id = 803, observation_concept_id = '42535872',
                   visit_occurrence_id = lookup_visit_occurrence('visit_occurrence_id', person_id='803', visit_start_date = '2020/04/19'))