# test IDs 2000-2099

declareTest(2000, 'Instance 0 - ICDO3 code type 111')
add_baseline(eid = 2000, `40005-0.0` = '2013-06-04', `40011-0.0` = 8140, `40012-0.0` = 3, `40006-0.0` = 'C509')
expect_condition_occurrence(person_id = 2000, condition_start_date = '2013-06-04', condition_start_datetime = '2013-06-04',
                            condition_concept_id = 44501483, condition_source_value = '8140/3-C50.9')

declareTest(2001, 'Instance 0 - ICDO3 code type 111 (three digit icd10)')
add_baseline(eid = 2001, `40005-0.0` = '2011-08-31', `40011-0.0` = 8000, `40012-0.0` = 1, `40006-0.0` = 'C20')
expect_condition_occurrence(person_id = 2001, condition_start_date = '2011-08-31', condition_start_datetime = '2011-08-31',
                            condition_concept_id = 442141, condition_source_value = '8000/1-C20.9')

declareTest(2002, 'Instance 0 - ICDO3 code type 001')
add_baseline(eid = 2002, `40005-0.0` = '2010-11-17', `40011-0.0` = '', `40012-0.0` = '', `40006-0.0` = 'C509')
expect_condition_occurrence(person_id = 2002, condition_start_date = '2010-11-17', condition_start_datetime = '2010-11-17',
                            condition_concept_id = 81251, condition_source_value = 'NULL-C50.9')

declareTest(2003, 'Instance 0 - ICDO3 code type 101 & Instance 2 - ICDO3 code type 100')
add_baseline(eid = 2003, `40005-0.0` = '1999-02-27', `40011-0.0` = '9020', `40012-0.0` = '', `40006-0.0` = 'C509',
             `40005-2.0` = '2013-11-26', `40011-2.0` = '9560', `40012-2.0` = '', `40006-2.0` = '')
expect_count_condition_occurrence(person_id = 2003, rowCount = 2)
expect_condition_occurrence(person_id = 2003, condition_start_date = '1999-02-27', condition_start_datetime = '1999-02-27',
                            condition_concept_id = 4175847, condition_source_value = '9020/1-C50.9')
expect_condition_occurrence(person_id = 2003, condition_start_date = '2013-11-26', condition_start_datetime = '2013-11-26',
                            condition_concept_id = 4300674, condition_source_value = '9560/1-NULL')

declareTest(2004, 'Instance 0 & 1 - ICDO3 code type 110')
add_baseline(eid = 2004, `40005-0.0` = '2011-03-09', `40011-0.0` = '8140', `40012-0.0` = '2', `40006-0.0` = '',
             `40005-1.0` = '2012-01-27', `40011-1.0` = '8077', `40012-1.0` = '2', `40006-1.0` = '')
expect_count_condition_occurrence(person_id = 2004, rowCount = 2)
expect_condition_occurrence(person_id = 2004, condition_start_date = '2011-03-09', condition_start_datetime = '2011-03-09',
                            condition_concept_id = 42513094, condition_source_value = '8140/2-NULL')
expect_condition_occurrence(person_id = 2004, condition_start_date = '2012-01-27', condition_start_datetime = '2012-01-27',
                            condition_concept_id = 42513051, condition_source_value = '8077/2-NULL')

declareTest(2005, 'Instance 0 - ICDO3 code type 011')
add_baseline(eid = 2005, `40005-0.0` = '2014-05-28', `40011-0.0` = '', `40012-0.0` = '3', `40006-0.0` = 'C446')
expect_condition_occurrence(person_id = 2005, condition_start_date = '2014-05-28', condition_start_datetime = '2014-05-28',
                            condition_concept_id = 42514406, condition_source_value = 'NULL-C44.6')

declareTest(2006, 'Instance 0 - ICDO3 code type 010')
add_baseline(eid = 2006, `40005-0.0` = '2008-02-19', `40011-0.0` = '', `40012-0.0` = '3', `40006-0.0` = '')
expect_no_condition_occurrence(person_id = 2006, condition_start_date = '2008-02-19')

declareTest(2007, 'Instance 0 - ICDO3 code type 100')
add_baseline(eid = 2007, `40005-0.0` = '2007-07-10', `40011-0.0` = '8050', `40012-0.0` = '', `40006-0.0` = '')
expect_condition_occurrence(person_id = 2007, condition_start_date = '2007-07-10', condition_start_datetime = '2007-07-10',
                            condition_concept_id = 42514339, condition_source_value = '8050/1-NULL')

declareTest(2008, 'Instance 0 - ICDO3 code type 000')
add_baseline(eid = 2008, `40005-0.0` = '2010-08-02', `40011-0.0` = '', `40012-0.0` = '', `40006-0.0` = '')
expect_no_condition_occurrence(person_id = 2008, condition_start_datetime = '2010-08-02')

declareTest(2009, 'Instance 0 - Date missing')
add_baseline(eid = 2009, `40005-0.0` = '', `40011-0.0` = '8263', `40012-0.0` = '3', `40006-0.0` = 'C153')
expect_condition_occurrence(person_id = 2009, condition_start_date = '1970-01-01', condition_start_datetime = '1970-01-01',
                            condition_concept_id = 36517394, condition_source_value = '8263/3-C15.3')

declareTest(2010, 'Instance 0 - ICDO3 code type 100 (histology/1 does not exist)')
add_baseline(eid = 2010, `40005-0.0` = '2007-04-23', `40011-0.0` = '8077', `40012-0.0` = '', `40006-0.0` = '')
expect_condition_occurrence(person_id = 2010, condition_start_date = '2007-04-23', condition_start_datetime = '2007-04-23',
                            condition_concept_id = 0, condition_source_value = '8077/1-NULL')

# Instance 0 - ICDO3 code type 001 (code not included in ICD10 to ICDO3 mapping) &
# Instance 1 - ICDO3 code type 001 &
# Instance 2 - ICDO3 code type 000 &
# Instance 4 - ICDO3 code type 111 &
# Instance 13 - Date missing
declareTest(2011, 'Instance 0,1,2,4,13 - Four valid and one skipped')
add_baseline(eid = 2011, `40005-0.0` = '2007-03-21', `40011-0.0` = '', `40012-0.0` = '', `40006-0.0` = 'D414',
             `40005-1.0` = '2009-10-20', `40011-1.0` = '', `40012-1.0` = '', `40006-1.0` = 'C320',
             `40005-2.0` = '2012-03-30', `40011-2.0` = '', `40012-2.0` = '', `40006-2.0` = '',
             `40005-4.0` = '2018-09-11', `40011-4.0` = '8800', `40012-4.0` = '0', `40006-4.0` = 'C712',
             `40005-5.0` = '', `40011-5.0` = '8263', `40012-5.0` = '3', `40006-5.0` = 'C530')
expect_count_condition_occurrence(person_id = 2011, rowCount = 4)
expect_condition_occurrence(person_id = 2011, condition_start_date = '2007-03-21', condition_start_datetime = '2007-03-21',
                            condition_concept_id = 198401, condition_source_value = 'D41.4')
expect_condition_occurrence(person_id = 2011, condition_start_date = '2009-10-20', condition_start_datetime = '2009-10-20',
                            condition_concept_id = 4129253, condition_source_value = 'NULL-C32.0')
expect_no_condition_occurrence(person_id = 2011, condition_start_datetime = '2012-03-30')
expect_condition_occurrence(person_id = 2011, condition_start_date = '2018-09-11', condition_start_datetime = '2018-09-11',
                            condition_concept_id = 36520989, condition_source_value = '8800/0-C71.2')
expect_condition_occurrence(person_id = 2011, condition_start_date = '1970-01-01', condition_start_datetime = '1970-01-01',
                            condition_concept_id = 36526003, condition_source_value = '8263/3-C53.0')

declareTest(2012, 'Instance 0 - ICDO3 code type 001 (code not included in ICD10 to ICDO3 mapping)')
add_baseline(eid = 2012, `40005-0.0` = '2013-07-31', `40011-0.0` = '', `40012-0.0` = '', `40006-0.0` = 'C833')
expect_condition_occurrence(person_id = 2012, condition_start_date = '2013-07-31', condition_start_datetime = '2013-07-31',
                            condition_concept_id = 4300704, condition_source_value = 'C83.3')

declareTest(2013, 'Instance 0 - No concept found; use code ICD9(40013) instead')
add_baseline(eid = 2013, `40005-0.0` = '1995-03-19', `40013-0.0` = '2331')
expect_condition_occurrence(person_id = 2013, condition_start_date = '1995-03-19', condition_start_datetime = '1995-03-19',
                            condition_concept_id = 194611, condition_source_value = '233.1')















