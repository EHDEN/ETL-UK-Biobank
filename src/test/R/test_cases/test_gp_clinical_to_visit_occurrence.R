# test ID range 400-499


declareTest(400, 'GP clinical to visit occurrence 1')
add_baseline(eid = 400)
add_gp_clinical(eid = 400, event_dt = '10/04/2012')
expect_visit_occurrence(person_id = 400, visit_concept_id=38004453, visit_start_date = '2012-04-10', visit_end_date = '2012-04-10',
                        visit_type_concept_id = 44818518)

declareTest(401, 'GP clinical to visit occurrence 2')
add_baseline(eid = 401)
add_gp_clinical(eid = 401, event_dt = '02/12/2015')
expect_visit_occurrence(person_id = 401, visit_concept_id=38004453, visit_start_date = '2015-12-02', visit_end_date = '2015-12-02',
                        visit_type_concept_id = 44818518)