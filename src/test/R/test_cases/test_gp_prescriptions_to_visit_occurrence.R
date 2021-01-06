# test IDs 600-699

declareTest(600, 'GP prescriptions to visit occurrence 1')
add_baseline(eid = 600)
add_gp_prescriptions(eid = 600, issue_date = '23/07/2012')
expect_visit_occurrence(person_id = 600, visit_concept_id=38004453, visit_start_date = '2012-07-23', visit_end_date = '2012-07-23',
                        visit_type_concept_id = 32827)

declareTest(601, 'GP prescriptions to visit occurrence 2')
add_baseline(eid = 601)
add_gp_prescriptions(eid = 601, issue_date = '24/05/2016')
expect_visit_occurrence(person_id = 601, visit_concept_id=38004453, visit_start_date = '2016-05-24', visit_end_date = '2016-05-24',
                        visit_type_concept_id = 32827)