# test ID range 2700-2799


declareTest(2700, 'covid19 emis gp clinical to visit occurrence 1')
add_baseline(eid = 2700)
add_covid19_emis_gp_clinical(eid = 2700, event_dt = '10/04/2012')
expect_visit_occurrence(person_id = 2700, visit_concept_id=38004453, visit_start_date = '2012-04-10', visit_end_date = '2012-04-10',
                        visit_type_concept_id = 32827)

declareTest(2701, 'covid19 emis gp clinical to visit occurrence 2')
add_baseline(eid = 2701)
add_covid19_emis_gp_clinical(eid = 2701, event_dt = '02/12/2015')
expect_visit_occurrence(person_id = 2701, visit_concept_id=38004453, visit_start_date = '2015-12-02', visit_end_date = '2015-12-02',
                        visit_type_concept_id = 32827)

declareTest(2702, 'covid19 emis gp clinical to visit occurrence - no visit without date')
add_baseline(eid = 2702)
add_covid19_emis_gp_clinical(eid = 2702, event_dt = '')
expect_no_visit_occurrence(person_id = 2702, visit_concept_id=38004453)