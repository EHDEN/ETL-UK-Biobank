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

library(DatabaseConnector)
library(yaml)
config <- yaml.load_file('config.yml')
options(width=150)  # Preventing wrapping when printing dataframe

source('TestFramework.R')

# Run and output test queries ---------------------------------------------
connectionConfig <- config$connectionDetails
connectionDetails <- createConnectionDetails(dbms = connectionConfig$dbms,
                                             user = connectionConfig$user,
                                             password = connectionConfig$password,
                                             server = connectionConfig$server,
                                             port = connectionConfig$port)
connection <- connect(connectionDetails)

testSql <- readLines(config$testQueryFileName)
testSql[1] <- sprintf('DROP TABLE IF EXISTS %s.test_results;', config$cdmSchema) # Replace existing SQL server specific table drop
executeSql(connection, paste(testSql, collapse='\n'))

# Display test results ----------------------------------------------------
outputTestResultsSummary(connection, config$cdmSchema)

# Write full test results to file ---------------------------------------
df_results <- DatabaseConnector::querySql(connection, gsub('@cdm_database_schema', config$cdmSchema, 'SELECT * FROM @cdm_database_schema.test_results;'))
write.csv(df_results, "unittest_results.csv", row.names = FALSE, quote = c(1))
disconnect(connection)
