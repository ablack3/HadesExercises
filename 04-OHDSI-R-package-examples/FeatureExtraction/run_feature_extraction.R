# Feature Extraction

# The feature extraction package provides a powerful way to characterize a cohort and is used in many other OHDSI tools.

# See vignette at https://ohdsi.github.io/FeatureExtraction/articles/UsingFeatureExtraction.html

library(FeatureExtraction)

connectionDetails <- createConnectionDetails(dbms = "redshift",
                                             user = "master",
                                             server = Sys.getenv("DB_SERVER"),
                                             password = Sys.getenv("DB_PASSWORD"),
                                             port = "5439")

covariateSettings <- createDefaultCovariateSettings()

covariateData <- getDbCovariateData(connectionDetails = connectionDetails,
                                    cdmDatabaseSchema = "synthea100k",
                                    cohortDatabaseSchema = "synthea100kresults",
                                    cohortTable = "cohort",
                                    cohortId = 22,
                                    rowIdField = "subject_id",
                                    covariateSettings = covariateSettings,
                                    aggregated = TRUE)


result <- createTable1(covariateData)
# saveCovariateData(covariateData, "~/HadesExercises/04-OHDSI-R-package-examples/FeatureExtraction/covariateData")

readr::write_csv(result, "~/HadesExercises/04-OHDSI-R-package-examples/FeatureExtraction/table1.csv")
print(result, row.names = FALSE, right = FALSE)
