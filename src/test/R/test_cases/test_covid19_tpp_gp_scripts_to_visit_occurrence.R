# test IDs 3000-3099

declareTest(3000, 'covid19 tpp gp scripts to visit occurrence 1')
add_baseline(eid = 3000)
add_covid19_tpp_gp_scripts(eid = 3000, issue_date = '23/07/2012')
expect_visit_occurrence(person_id = 3000, visit_concept_id=38004453, visit_start_date = '2012-07-23', visit_end_date = '2012-07-23',
                        visit_type_concept_id = 32827)

declareTest(3001, 'covid19 tpp gp scripts to visit occurrence 2')
add_baseline(eid = 3001)
add_covid19_tpp_gp_scripts(eid = 3001, issue_date = '24/05/2016')
expect_visit_occurrence(person_id = 3001, visit_concept_id=38004453, visit_start_date = '2016-05-24', visit_end_date = '2016-05-24',
                        visit_type_concept_id = 32827)

declareTest(3002, 'covid19 tpp gp scripts to visit occurrence - no visit without date')
add_baseline(eid = 3002)
add_covid19_tpp_gp_scripts(eid = 3002, issue_date = '')
expect_no_visit_occurrence(person_id = 602, visit_concept_id=38004453)