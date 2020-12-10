
declareTest(1900, 'Baseline to death')
add_baseline(eid=1900, `40000-0.0`='2020-12-07', `40001-0.0`='F803')
expect_death(person_id=1900, death_date='2020-12-07', cause_concept_id=4046219, cause_source_concept_id=45547722)

declareTest(1901, 'Baseline to death, no date')
add_baseline(eid=1901, `40000-0.0`='', `40001-0.0`='F803')
expect_no_death(person_id=1901)

declareTest(1902, 'Baseline to death, no ICD10 code')
add_baseline(eid=1902, `40000-0.0`='2020-12-07', `40001-0.0`='')
expect_no_death(person_id=1902)

declareTest(1903, 'Baseline to death 2')
add_baseline(eid=1903, `40000-0.0`='2020-12-07', `40001-0.0`='Q070')
expect_death(person_id=1903, death_date='2020-12-07', cause_concept_id=4099094, cause_source_concept_id=45601954)

declareTest(1904, 'Baseline to death - already in Death table')
add_baseline(eid=1904, `40000-0.0`='2020-12-07', `40001-0.0`='Q070')
add_death(eid = 1904, ins_index = 0, date_of_death = '30/01/2020')
add_death_cause(eid = 1904, ins_index = 0, arr_index = 0, cause_icd10 = 'I10')
expect_no_death(person_id=1904, death_date = '2020-12-07')