## R installation
if (!require("devtools")) install.packages("devtools")
if (!require("DatabaseConnector")) install.packages("DatabaseConnector")
if (!require("SqlRender"))("SqlRender")
if (!require("rJava"))install.packages("rJava")
if (!require("yaml")) install.packages("yaml")

library(DatabaseConnector)
library(SqlRender)
library(rJava)
library(yaml)

# Install DataQualityDashboard from v6_extensions branch
devtools::install_github(repo="OHDSI/DataQualityDashboard")

# Set working directory to directory of this R script
setwd("c:/myPath/dqd_achilles")

# Load configuration settings
config <- yaml.load_file('config.yml')
connectionConfig <- config$connectionDetails

## Executing Data Quality Checks

# fill out the connection details -----------------------------------------------------------------------
connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = connectionConfig$dbms, 
                                                                server = connectionConfig$server,
                                                                user = connectionConfig$user,
                                                                password = connectionConfig$password, 
                                                                schema = connectionConfig$schema,
                                                                port = connectionConfig$port,
                                                                extraSettings = "")


cdmDatabaseSchema <- connectionConfig$schema # the fully qualified database schema name of the CDM
resultsDatabaseSchema <- paste0(connectionConfig$schema, "_results_dqd") # the fully qualified database schema name of the results schema (that you can write to)
cdmSourceName <- config$cdmSourceName

# determine how many threads (concurrent SQL sessions) to use ----------------------------------------
numThreads <- 1 # on Redshift, 3 seems to work well

# specify if you want to execute the queries or inspect them ------------------------------------------
sqlOnly <- FALSE # set to TRUE if you just want to get the SQL scripts and not actually run the queries

# where should the logs go? -------------------------------------------------------------------------
outputFolder <- "output_dqd"

# logging type -------------------------------------------------------------------------------------
verboseMode <- TRUE # set to TRUE if you want to see activity written to the console

# write results to table? ------------------------------------------------------------------------------
writeToTable <- TRUE # set to FALSE if you want to skip writing to a SQL table in the results schema

# which DQ check levels to run -------------------------------------------------------------------
checkLevels <- c("TABLE", "FIELD", "CONCEPT")

# which DQ checks to run? ------------------------------------
checkNames <- c("measurePersonCompleteness", "cdmField", "isRequired", "cdmDatatype", "isPrimaryKey",
                "isForeignKey", "fkDomain", "fkClass", "isStandardValidCOncept", "measureValueCompleteness",
                "standardConceptRecordCompleteness", "sourceConceptRecordCompleteness", "sourceValueCompleteness",
                "plausibleValueLow", "plausibleValueHigh", "plausibleTemporalAfter", "plausibleDuringLife",
                "plausibleValueLow", "plausibleValueHigh", "plausibleGender") # Names can be found in inst/csv/OMOP_CDM_v5.3.1_Check_Desciptions.csv

# which CDM version --------------------------------------------------------------------------------
cdmVersion = config$cdmVersion

# run the job --------------------------------------------------------------------------------------
DataQualityDashboard::executeDqChecks(connectionDetails = connectionDetails, 
                                      cdmDatabaseSchema = cdmDatabaseSchema, 
                                      resultsDatabaseSchema = resultsDatabaseSchema,
                                      vocabDatabaseSchema = connectionConfig$vocabDatabaseSchema,
                                      cdmSourceName = cdmSourceName, 
                                      numThreads = numThreads,
                                      sqlOnly = sqlOnly, 
                                      outputFolder = outputFolder, 
                                      verboseMode = verboseMode,
                                      writeToTable = writeToTable,
                                      checkLevels = checkLevels,
                                      checkNames = checkNames,
                                      cdmVersion = cdmVersion)

# inspect logs ----------------------------------------------------------------------------
ParallelLogger::launchLogViewer(logFileName = file.path(outputFolder, cdmSourceName, 
                                                        sprintf("log_DqDashboard_%s.txt", cdmSourceName)))

# (OPTIONAL) if you want to write the JSON file to the results table separately -----------------------------
jsonFilePath <- ""
DataQualityDashboard::writeJsonResultsToTable(connectionDetails = connectionDetails, 
                                              resultsDatabaseSchema = resultsDatabaseSchema, 
                                              jsonFilePath = jsonFilePath)

## Viewing Results
# Launching Dashboard as Shiny App
DataQualityDashboard::viewDqDashboard(jsonPath = file.path(getwd(), outputFolder, cdmSourceName, sprintf("results_%s.json", cdmSourceName)))

# View Checks
View(read.csv(system.file("csv","OMOP_CDMv5.3.1_Check_Descriptions.csv",package="DataQualityDashboard"),as.is=T))
