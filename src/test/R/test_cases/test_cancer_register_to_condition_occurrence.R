# test IDs 1900-1999

declareTest(1900, 'Instance 0 -- Tumor codes present: histology(40011), behaviour(40012) & ICD10(40006)')
add_baseline(eid = 1900, `40005-0.0` = '2013-06-04', `40011-0.0` = 8140, `40012-0.0` = 3, `40006-0.0` = 'C509')
expect_condition_occurrence(person_id = 1900, condition_start_date = '2013-06-04', condition_start_datetime = '2013-06-04',
                            condition_concept_id = 44501483, condition_source_value = '8140/3-C509')

declareTest(1901, 'Instance 0 -- Tumor codes present: histology(40011), behaviour(40012) & ICD10(40006) -- ICD10 code of two digits')
add_baseline(eid = 1901, `40005-0.0` = '2011-08-31', `40011-0.0` = 8000, `40012-0.0` = 1, `40006-0.0` = 'C20')
expect_condition_occurrence(person_id = 1901, condition_start_date = '2011-08-31', condition_start_datetime = '2011-08-31',
                            condition_concept_id = 44504402, condition_source_value = '8000/1-C20')

declareTest(1902, 'Instance 0 -- Tumor codes present: ICD10(40006)')
add_baseline(eid = 1902, `40005-0.0` = '2010-11-17', `40011-0.0` = '', `40012-0.0` = '', `40006-0.0` = 'C509')
expect_condition_occurrence(person_id = 1902, condition_start_date = '2010-11-17', condition_start_datetime = '2010-11-17',
                            condition_concept_id = 42511408, condition_source_value = 'NULL-C509')

declareTest(1903, 'Instance 0 -- Tumor codes present: histology(40011) & ICD10(40006)')
add_baseline(eid = 1903, `40005-0.0` = '2013-11-26', `40011-0.0` = '9020', `40012-0.0` = '', `40006-0.0` = 'C509')
expect_condition_occurrence(person_id = 1903, condition_start_date = '2013-11-26', condition_start_datetime = '2013-11-26',
                            condition_concept_id = 44505324, condition_source_value = '9020/1-C50.9')

declareTest(1904, 'Instance 0 -- Tumor codes present: histology(40011) & behaviour(40012)')
add_baseline(eid = 1904, `40005-0.0` = '2011-03-09', `40011-0.0` = '8140', `40012-0.0` = '2', `40006-0.0` = '')
expect_condition_occurrence(person_id = 1904, condition_start_date = '2011-03-09', condition_start_datetime = '2011-03-09',
                            condition_concept_id = '42513094', condition_source_value = '8140/2-NULL')

declareTest(1905, 'Instance 0 -- Tumor codes present: behaviour(40012) & ICD10(40006)')
add_baseline(eid = 1905, `40005-0.0` = '2014-05-28', `40011-0.0` = '', `40012-0.0` = '3', `40006-0.0` = 'C446')
expect_condition_occurrence(person_id = 1905, condition_start_date = '2014-05-28', condition_start_datetime = '2014-05-28',
                            condition_concept_id = 42514406, condition_source_value = 'NULL-C446')

declareTest(1906, 'Instance 0 -- Tumor codes present: behaviour(40012)')
add_baseline(eid = 1906, `40005-0.0` = '2008-02-19', `40011-0.0` = '', `40012-0.0` = '3', `40006-0.0` = '')
expect_no_condition_occurrence(person_id = 1906, condition_start_date = '2008-02-19')

declareTest(1907, 'Instance 0 -- Tumor codes present: histology(40011)')
add_baseline(eid = 1907, `40005-0.0` = '2007-07-10', `40011-0.0` = '8050', `40012-0.0` = '', `40006-0.0` = '')
expect_condition_occurrence(person_id = 1907, condition_start_date = '2007-07-10', condition_start_datetime = '2007-07-10',
                            condition_concept_id = 42514339, condition_source_value = '8050/1-NULL')

declareTest(1908, 'Instance 0 -- No tumor codes present')
add_baseline(eid = 1908, `40005-0.0` = '2010-08-02', `40011-0.0` = '', `40012-0.0` = '', `40006-0.0` = '')
expect_no_condition_occurrence(person_id = 1908, condition_start_datetime = '2010-08-02')

declareTest(1909, 'Instance 0 -- Date missing')
add_baseline(eid = 1909, `40005-0.0` = '', `40011-0.0` = '8263', `40012-0.0` = '3', `40006-0.0` = 'C153')
expect_condition_occurrence(person_id = 1909, condition_start_date = '1970-01-01', condition_start_datetime = '1970-01-01',
                            condition_concept_id = 36517394, condition_source_value = '8263/3-C15.3')

declareTest(1910, 'Instanse 0 -- Tumor codes present: histology(40011); histology/1 does not exist')
add_baseline(eid = 1910, `40005-0.0` = '2007-04-23', `40011-0.0` = '8077', `40012-0.0` = '', `40006-0.0` = '')
expect_no_condition_occurrence(person_id = 1910, condition_start_date = '2007-04-23')

declareTest(1911, 'Instance 0 -- Tumor codes present: ICD10(40006) -- D-code not included in ICDO3 vocabulary')
add_baseline(eid = 1911, `40005-0.0` = '2007-03-21', `40011-0.0` = '', `40012-0.0` = '', `40006-0.0` = 'D414')
expect_condition_occurrence(person_id = 1911, condition_start_date = '2007-03-21', condition_start_datetime = '2007-03-21',
                            condition_concept_id = , condition_source_value = '')

declareTest(1912, 'Instanse 0 -- Tumor codes present: ICD10(40006) -- C-code not included in ICDO3 vocabulary')
add_baseline(eid = 1912, `40005-0.0` = '2013-07-31', `40011-0.0` = '', `40012-0.0` = '', `40006-0.0` = 'C833')
expect_condition_occurrence(person_id = 1912, condition_start_date = '2013-07-31', condition_start_datetime = '2013-07-31',
                            condition_concept_id = 44508485, condition_source_value = 'C833')

declareTest(1913, 'Instanse 1 -- Tumor codes present: histology(40011) & behaviour(40012)')
add_baseline(eid = 1913, `40005-0.0` = '2005-01-27', `40011-0.0` = '8077', `40012-0.0` = '2', `40006-0.0` = '')
expect_condition_occurrence(person_id = 1913, condition_start_date = '2005-01-27', condition_start_datetime = '2005-01-27',
                            condition_concept_id = 42513051, condition_source_value = '8077/2-NULL')

declareTest(1914, 'Instanse 2 -- Tumor codes present: histology(40011)')
add_baseline(eid = 1914, `40005-0.0` = '1999-02-27', `40011-0.0` = '9560', `40012-0.0` = '', `40006-0.0` = '')
expect_condition_occurrence(person_id = 1914, condition_start_date = '1999-02-27', condition_start_datetime = '1999-02-27',
                            condition_concept_id = 42511270, condition_source_value = '9560/1-NULL')

declareTest(1915, 'Instanse 3 -- Tumor codes present: ICD10(40006)')
add_baseline(eid = 1915, `40005-0.0` = '2012-03-30', `40011-0.0` = '', `40012-0.0` = '', `40006-0.0` = 'C320')
expect_condition_occurrence(person_id = 1915, condition_start_date = '2012-03-30', condition_start_datetime = '2012-03-30',
                            condition_concept_id = 42511304, condition_source_value = 'NULL-C320')

declareTest(1916, 'Instanse 5 -- No tumor codes present')
add_baseline(eid = 1916, `40005-0.0` = '2009-10-20', `40011-0.0` = '', `40012-0.0` = '', `40006-0.0` = '')
expect_no_condition_occurrence(person_id = 1916, condition_start_datetime = '2009-10-20')

declareTest(1917, 'Instanse 8 -- Tumor codes present: histology(40011), behaviour(40012) & ICD10(40006)')
add_baseline(eid = 1917, `40005-0.0` = '2018-09-11', `40011-0.0` = '8800', `40012-0.0` = '0', `40006-0.0` = 'C712')
expect_condition_occurrence(person_id = 1917, condition_start_date = '2018-09-11', condition_start_datetime = '2018-09-11',
                            condition_concept_id = 36520989, condition_source_value = '8800/0-C712')

declareTest(1918, 'Instanse 13 -- Date missing')
add_baseline(eid = 1918, `40005-0.0` = '', `40011-0.0` = '8263', `40012-0.0` = '3', `40006-0.0` = 'C530')
expect_condition_occurrence(person_id = 1918, condition_start_date = '1970-01-01', condition_start_datetime = '1970-01-01',
                            condition_concept_id = , condition_source_value = '8263/3-C530')

#declareTest(1919, 'Instanse 0 -- Use code ICD9(40013) instead of ICD10(40006)')
#add_baseline(eid = 1919, `40005-0.0` = '', `40011-0.0` = '', `40012-0.0` = '', `40013-0.0` = '')
#expect_condition_occurrence(person_id = 1919, condition_start_date = '', condition_start_datetime = '',
#                            condition_concept_id = , condition_source_value = '')