## Test framework version

Test framework created using:

| RiaH version | RiaH mapping specifications file |
| --- | --- |
| vX.X.X | `<file name>.json.gz` (last updated: XX/XX/XXXX) |

## How to run the tests

Assuming the test framework is already in place (see next section), you can execute existing tests as follows:

1. Install R and its packages `yaml` and `DatabaseConnector`.
2. Rename `config-sample.yml` in this folder to `config.yml` and update it with your desired settings.
    
    *NOTE: The provided code will generate the test data as CSV files and store them locally. 
    You can modify the scripts to store the test data in a database instead, see the 
    [test framework documentation](http://ohdsi.github.io/WhiteRabbit/riah_test_framework.html#generate_test_data)
    for more information.*
    
3. Run `run_create_tests.R` to generate the test data. These will be stored in the folder
indicated in the test configuration (e.g. `sourceDataDir` parameter).
4. Execute the ETL, using the test data as source data, 
and the same connection details as specified in the test configuration. 
The target schema for the tests should match the one for the standard CDM tables.

    *NOTE: The test scripts will create a new table `test_results` in the target schema.*
    
5. Run `run_evaluate_tests.R` to obtain a report of the test results.

You can run the R scripts in the terminal from this folder using `R -f <script_name>.R`.

## How to implement new tests

### Test Framework creation

Follow the instructions to create a test framework using the 
[Rabbit in a Hat test framework functionality](http://ohdsi.github.io/WhiteRabbit/riah_test_framework.html#creating_the_testing_framework).
Rename the file `TestFramework.R` and place it in this folder (`test/R/`).
You only need to repeat this step in case of significant changes to the original mappings - alternatively, you could edit `TestFramework.R` manually to introduce new default values or constraints.

You can easily **generate tests for custom tables** by loading a modified CDM schema into Rabbit in a Hat 
and selecting it as target CDM schema for the test framework creation; simply follow these 
[instructions](http://ohdsi.github.io/WhiteRabbit/RabbitInAHat.html#loading_in_a_custom_cdm).

### Implementing individual test cases

New tests should be defined in the `test_cases` folder.
The convention is to have **one test file per source / target table combination**, as for the transformation scripts (ideally, it should have the same file name).
You will then need to `source()` these scripts one by one in `run_create_tests.R`;
the file `test_sample_source_1_to_person.R` is provided as an example.

Available test functions are described in the [RiaH test framework documentation](http://ohdsi.github.io/WhiteRabbit/riah_test_framework.html).

In each `test_cases` script, the following conventions apply:
1. Give each test a **numerical ID within a file-specific range** (see table below); 
this helps to quickly identify the source / target table combination when evaluating test results.

2. Create a **new person for each test** within the test definition itself (rather than in the test script for the Person table) to isolate the tests from each other. 
As the person_id, use the ID of the test it belongs to, e.g. test ID `2201` -> person_id `2201`. 
This helps to quickly identify the records related to a specific (failed) test.
This convention should be used for other numerical variables whenever applicable.


#### Table: overview of test ID ranges for each test script.

**(NOTE: Please update the table below with the actual test scripts and ID ranges for your project).**

| Test file name | Test ID range |
| --- | --- |
| test_cases/test_assessment_center_to_care_site.R | 1-99 |
| test_cases/test_covid_to_care_site.R | 100-199 |
| test_cases/test_baseline_to_person.R | 200-299 |
| test_cases/test_gp_registrations_to_obs_period.R | 300-399 |
| test_cases/test_gp_clinical_to_visit_occurrence.R | 400-499 |
| test_cases/test_covid_to_visit_occurrence.R | 500-599 |
| test_cases/test_gp_prescriptions_to_visit_occurrence.R | 600-699 |
| test_cases/test_baseline_to_visit_occurrence.R | 700-799 |
| test_cases/test_covid_to_observation.R | 800-899 |
| test_cases/test_baseline_to_stem.R | 900-999 |
| test_cases/test_hes_diag_to_condition_occurrence.R | 1000-1099 |
| test_cases/test_hesin_to_visit_occurrence.R | 1100-1199 |
| test_cases/test_gp_prescriptions_to_drug_exposure.R | 1200-1299 |
| test_cases/test_death_to_death.R | 1400-1499 |
| test_cases/test_hes_oper_to_procedure_occurrence.R | 1500-1599 |
| test_cases/test_death_to_condition_occurrence.R | 1600-1699 |
| test_cases/test_gp_clinical_to_stem.R | 1700-1799 |
| test_cases/test_hesin_to_visit_detail.R | 1800-1899 |
| test_cases/test_baseline_to_death.R | 1900-1999 |
| test_cases/test_cancer_register_to_condition_occurrence.R | 2000-2099 |
| test_cases/test_drug_era.R | 2100-2199 |
| test_cases/test_observation_period.R | 2200-2299 |
| test_cases/test_covid19_emis_gp_scripts_to_drug_exposure.R | 2300-2399 |
| test_cases/test_covid19_tpp_gp_scripts_to_drug_exposure.R | 2400-2499 |
| test_cases/test_covid19_tpp_gp_clinical_to_stem.R | 2500-2599 |
| test_cases/test_covid19_emis_gp_clinical_to_stem.R | 2600-2699 |
| test_cases/test_covid19_emis_gp_clinical_to_visit_occurrence.R | 2700-2799 |
| test_cases/test_covid19_emis_gp_scripts_to_visit-occurrence.R | 2800-2899 |
| test_cases/test_covid19_tpp_gp_clinical_to_visit_occurrence.R | 2900-2999 |
| test_cases/test_covid19_tpp_gp_scripts_to_visit_occurrence.R | 3000-3099 |
| test_cases/test_baseline_to_condition_occurrence.R | 3100-3199 |
| test_cases/test_covid_to_measurement.R | 3200-3299 |
