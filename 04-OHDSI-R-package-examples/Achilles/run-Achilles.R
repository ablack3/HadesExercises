# Execute Achilles 
library(Achilles)

username <- Sys.info()["user"]
# Create scratch schema and achilles results schema. This only needs to be done once.
# renderTranslateExecuteSql(conn, 
#                           sql = "create schema @scratchSchema; 
#                           create schema @resultsSchema;",
#                           scratchSchema = paste0("scratch_", username),
#                           resultsSchema = paste0("results_", username))

scratchDatabaseSchema <- paste0("mycdm.scratch_", username)
resultsDatabaseSchema <- paste0("mycdm.results_", username)

connectionDetails <- createConnectionDetails(dbms = "redshift",
                                             user = "master",
                                             server = Sys.getenv("DB_SERVER"),
                                             password = Sys.getenv("DB_PASSWORD"),
                                             port = "5439")

achillesResults <- achilles(connectionDetails, 
                            cdmDatabaseSchema = "mycdm.synthea1k", 
                            resultsDatabaseSchema = resultsDatabaseSchema,
                            scratchDatabaseSchema = scratchDatabaseSchema,
                            vocabDatabaseSchema = "mycdm.synthea1k",
                            numThreads = 1,
                            sourceName = "Synthea1k", 
                            cdmVersion = "5.3",
                            # analysisIds = c(0,1), 
                            runHeel = F,
                            runCostAnalysis = F,
                            outputFolder = "~/HadesExercises/04-OHDSI-R-package-examples/Achilles/output")

