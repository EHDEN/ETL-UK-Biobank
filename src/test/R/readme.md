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
| test_sample_source_1_to_person.R | 1-99 |
| test_sample_source_2_to_care_site.R | 100-199 |
| test_sample_source_3_to_death.R | 200-299 |
| test_sample_source_4_to_observation.R | 300-399 |
| test_sample_source_5_to_visit_occurrence.R | 400-499 |
| test_sample_source_6_to_measurement.R | 500-599 |
| test_sample_source_7_to_drug_exposure.R | 600-699 |
| test_sample_source_8_to_condition_occurrence.R | 700-799 |
| test_sample_source_9_to_procedure_occurrence.R | 800-899 |
| test_sample_source_10_to_fact_relationship.R | 900-999 |
| test_sample_source_11_to_treatment_line.R | 1000-1099 |
| test_observation_period.R | 1100-1199 |
