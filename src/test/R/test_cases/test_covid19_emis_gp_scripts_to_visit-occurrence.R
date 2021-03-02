# test IDs 2800-2899

declareTest(2800, 'covid19 emis gp scripts to visit occurrence 1')
add_baseline(eid = 2800)
add_covid19_emis_gp_scripts(eid = 2800, issue_date = '23/07/2012')
expect_visit_occurrence(person_id = 2800, visit_concept_id=38004453, visit_start_date = '2012-07-23', visit_end_date = '2012-07-23',
                        visit_type_concept_id = 32827)

declareTest(2801, 'covid19 emis gp scripts to visit occurrence 2')
add_baseline(eid = 2801)
add_covid19_emis_gp_scripts(eid = 2801, issue_date = '24/05/2016')
expect_visit_occurrence(person_id = 2801, visit_concept_id=38004453, visit_start_date = '2016-05-24', visit_end_date = '2016-05-24',
                        visit_type_concept_id = 32827)

declareTest(2802, 'covid19 emis gp scripts to visit occurrence - no visit without date')
add_baseline(eid = 2802)
add_covid19_emis_gp_scripts(eid = 2802, issue_date = '')
expect_no_visit_occurrence(person_id = 2802, visit_concept_id=38004453)