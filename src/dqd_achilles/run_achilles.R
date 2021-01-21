# Run Achilles and export result
if (!require("devtools")) install.packages("devtools")
if (!require("DatabaseConnector")) install.packages("DatabaseConnector")
if (!require("yaml")) install.packages("yaml")
library(DatabaseConnector)
library(yaml)
library(Achilles)

config <- yaml.load_file('config.yml')
connectionConfig <- config$connectionDetails

connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = connectionConfig$dbms, 
                                                                server = connectionConfig$server,
                                                                user = connectionConfig$user,
                                                                password = connectionConfig$password, 
                                                                schema = connectionConfig$schema,
                                                                port = connectionConfig$port,
                                                                extraSettings = "")


cdmDatabaseSchema <- connectionConfig$schema # the fully qualified database schema name of the CDM
resultsDatabaseSchema <- paste0(connectionConfig$schema, "_results_achilles") # the fully qualified database schema name of the results schema (that you can write to)
cdmSourceName <- config$cdmSourceName

outputPath <- "c:/myPath/output_achilles"

cdmVersion = config$cdmVersion

achilles(connectionDetails = connectionDetails, 
         cdmDatabaseSchema = cdmDatabaseSchema, 
         resultsDatabaseSchema = resultsDatabaseSchema,
         vocabDatabaseSchema = connectionConfig$vocabDatabaseSchema,
         cdmVersion = cdmVersion,
         runHeel = FALSE,
         runCostAnalysis = FALSE)

achillesHeel(connectionDetails=connectionDetails,
             cdmDatabaseSchema = cdmDatabaseSchema,
             resultsDatabaseSchema = resultsDatabaseSchema,
             numThreads = 1,
             cdmVersion = cdmVersion,
             outputFolder = outputPath)

exportToJson(connectionDetails = connectionDetails,
             cdmDatabaseSchema = cdmDatabaseSchema,
             resultsDatabaseSchema = resultsDatabaseSchema,
             outputPath = outputPath,
             compressIntoOneFile = TRUE)

# To see the results in AchillesWeb check the instructions on the repo:
# https://github.com/OHDSI/AchillesWeb