# test ID range 2900-2999


declareTest(2900, 'covid19 tpp gp clinical to visit occurrence 1')
add_baseline(eid = 2900)
add_covid19_tpp_gp_clinical(eid = 2900, event_dt = '10/04/2012')
expect_visit_occurrence(person_id = 2900, visit_concept_id=38004453, visit_start_date = '2012-04-10', visit_end_date = '2012-04-10',
                        visit_type_concept_id = 32827)

declareTest(2901, 'covid19 tpp gp clinical to visit occurrence 2')
add_baseline(eid = 2901)
add_covid19_tpp_gp_clinical(eid = 2901, event_dt = '02/12/2015')
expect_visit_occurrence(person_id = 2901, visit_concept_id=38004453, visit_start_date = '2015-12-02', visit_end_date = '2015-12-02',
                        visit_type_concept_id = 32827)

declareTest(2902, 'covid19 tpp gp clinical to visit occurrence - no visit without date')
add_baseline(eid = 2902)
add_covid19_tpp_gp_clinical(eid = 2902, event_dt = '')
expect_no_visit_occurrence(person_id = 2902, visit_concept_id=38004453)