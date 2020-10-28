# test ID range 400-499


declareTest(400, 'GP clinical to visit occurrence 1')
add_baseline(eid = 400, `34-0.1` = 1990)
add_gp_clinical(eid = 400, event_dt = '10/04/2012')
expect_visit_occurrence(person_id = 400, visit_concept_id=38004453, visit_start_date = '2012-04-10', visit_end_date = '2012-04-10',
                        visit_type_concept_id = 44818518)
