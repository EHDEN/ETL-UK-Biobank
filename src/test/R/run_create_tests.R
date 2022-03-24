# Copyright 2020 The Hyve
#
# Licensed under the GNU General Public License, version 3,
# or (at your option) any later version (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# https://www.gnu.org/licenses/
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

library(yaml)
config <- yaml.load_file('config.yml')

# Initialize the framework once -------------------------------------------
# NOTE: remove initFramework() from TestFramework.R, otherwise it resets with every import!
source('TestFramework_ukbb.R')
initFramework()

# Import test cases ------------------------------------------------------------
source('test_cases/test_assessment_center_to_care_site.R')             # test IDs    1-99
# source('test_cases/test_covid_to_care_site.R')                       # test IDs 100-199
source('test_cases/test_baseline_to_person.R')                         # test IDs 200-299
# source('test_cases/test_gp_registrations_to_obs_period.R')           # test IDs 300-399
source('test_cases/test_gp_clinical_to_visit_occurrence.R')            # test IDs 400-499
source('test_cases/test_covid_to_visit_occurrence.R')                  # test IDs 500-599
source('test_cases/test_gp_prescriptions_to_visit_occurrence.R')       # test IDs 600-699
source('test_cases/test_baseline_to_visit_occurrence.R')               # test IDs 700-799
source('test_cases/test_covid_to_observation.R')                       # test IDs 800-899
source('test_cases/test_baseline_to_stem.R')                           # test IDs 900-999
source('test_cases/test_hes_diag_to_condition_occurrence.R')           # test IDs 1000-1099
source('test_cases/test_hesin_to_visit_occurrence.R')                  # test IDs 1100-1199
source('test_cases/test_gp_prescriptions_to_drug_exposure.R')          # test IDs 1200-1299
source('test_cases/test_death_to_death.R')                             # test IDS 1400-1499
source('test_cases/test_hes_oper_to_procedure_occurrence.R')           # test IDs 1500-1599
source('test_cases/test_death_to_condition_occurrence.R')              # test IDs 1600-1699
source('test_cases/test_gp_clinical_to_stem.R')                        # test IDs 1700-1799
source('test_cases/test_hesin_to_visit_detail.R')                      # test IDs 1800-1899
source('test_cases/test_baseline_to_death.R')                          # test IDs 1900-1999
source('test_cases/test_cancer_register_to_condition_occurrence.R')    # test IDs 2000-2099
source('test_cases/test_drug_era.R')                                   # test IDs 2100-2199
source('test_cases/test_observation_period.R')                         # test IDs 2200-2299
source('test_cases/test_covid19_emis_gp_scripts_to_drug_exposure.R')   # test IDs 2300-2399
source('test_cases/test_covid19_tpp_gp_scripts_to_drug_exposure.R')    # test IDs 2400-2499
source('test_cases/test_covid19_tpp_gp_clinical_to_stem.R')            # test IDs 2500-2599
source('test_cases/test_covid19_emis_gp_clinical_to_stem.R')           # test IDs 2600-2699
source('test_cases/test_covid19_emis_gp_clinical_to_visit_occurrence.R') # test IDs 2700-2799
source('test_cases/test_covid19_emis_gp_scripts_to_visit-occurrence.R')  # test IDs 2800-2899
source('test_cases/test_covid19_tpp_gp_clinical_to_visit_occurrence.R')  # test IDs 2900-2999
source('test_cases/test_covid19_tpp_gp_scripts_to_visit_occurrence.R')   # test IDs 3000-3099
source('test_cases/test_baseline_to_condition_occurrence.R')                      # test IDs 3100-3199
source('test_cases/test_covid_to_measurement.R')                         # test IDs 3200-3299

# Generate source csv files -----------------------------------------------------
dir.create(config$sourceDataDir, recursive=T, showWarnings = F)
writeSourceCsv(config$sourceDataDir)
print(paste0('Test source tables written to ', config$sourceDataDir))

# Create test query -------------------------------------------------------
testSql <- generateTestSql(config$cdmSchema)
dir.create(dirname(config$testQueryFileName), recursive=T, showWarnings = F)
write(testSql, config$testQueryFileName)
print(paste0('Test queries written to ', config$testQueryFileName))

# Test coverages -----------------------------------------------------------
print(summaryTestFramework())
print(getUntestedSourceFields())
print(getUntestedTargetFields())

# List all test cases ----------------------------------------------------------
exportTestsOverviewToFile('all_test_cases.csv')