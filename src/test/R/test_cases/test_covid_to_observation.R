# test ID range 600-699

declareTest(600, 'Test nasopharyngeal swab, positive')
add_covid(eid = 600, spectype = 31, specdate = '04/05/2020', result = 1)
add_baseline(eid = 600)
expect_observation(person_id = 600, observation_concept_id = '4122259', observation_date = '2020/05/04',
                   value_as_concept_id = '45884084')

declareTest(601, 'Test tissue, negative')
add_covid(eid = 601, spectype = 16, result = 0, specdate = '11/09/2020')
add_baseline(eid = 601)
expect_observation(person_id = 601, observation_concept_id = '4002890', observation_datetime = '2020/09/11',
                   value_as_concept_id = '45878583')

declareTest(602, 'Test blood, missing date')
add_covid(eid = 602,spectype = 28, specdate = '')
add_baseline(eid = 602)
expect_observation(person_id = 602,
                   observation_concept_id = '4001225',
                   observation_datetime = '1970/01/01',
                   observation_type_concept_id = '38000279')

#declareTest(603, 'Test visit_id, wound (surgical)')
#add_covid(eid = 603, spectype = 36)
#add_baseline(eid = 603)
#expect_observation(person_id = 603, observation_concept_id = '42535872') #visit_occurrence_id = )