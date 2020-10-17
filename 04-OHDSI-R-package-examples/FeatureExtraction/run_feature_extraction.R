# Feature Extraction

# The feature extraction package provides a powerful way to characterize a cohort and is used in many other OHDSI tools.

library(FeatureExtraction)

connectionDetails <- createConnectionDetails(dbms = "redshift",
                                             user = "master",
                                             server = Sys.getenv("DB_SERVER"),
                                             password = Sys.getenv("DB_PASSWORD"),
                                             port = "5439")

settings <- createCovariateSettings(useDemographicsGender = TRUE,
                                    useDemographicsAgeGroup = TRUE)

covariateData <- getDbCovariateData(connectionDetails = connectionDetails,
                                    cdmDatabaseSchema = cdmDatabaseSchema,
                                    cohortDatabaseSchema = resultsDatabaseSchema,
                                    cohortTable = "cohort",
                                    cohortId = 22,
                                    rowIdField = "subject_id",
                                    covariateSettings = covariateSettings,
                                    useConditionOccurrenceAnyTimePrior = TRUE)

summary(covariateData)

