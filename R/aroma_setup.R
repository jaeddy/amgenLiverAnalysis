library(aroma.affymetrix)
verbose <- Arguments$getVerbose(-8, timestamp = TRUE)


# Set up aroma files

# Create/modify directory structure for annotation files (CDF)
annotationDir <- file.path(".", "data", "annotationData")
chipTypesDir <- file.path(annotationDir, "chipTypes")
chipType <- "Rat230_2" # "RaGene-1_0-st-v1"

if (!file.exists(file.path(chipTypesDir, chipType))) {
    dir.create(annotationDir)
    dir.create(chipTypesDir)
    dir.create(file.path(chipTypesDir, chipType))
}

# Download CDF for rat gene array
cdfFile <- "Rat230_2.cdf" # "RaGene-1_0-st-v1,r3.cdf"
cdfPath <- file.path(chipTypesDir, chipType, cdfFile)


http://www.aroma-project.org/data/annotationData/chipTypes/Rat230_2/Rat230_2.cdf.gz

if (!file.exists(cdfPath)) {
    cdfGzFile <- paste0(cdfFile, ".gz")
    cdfAddress <- file.path("http://www.aroma-project.org/data",
                            "annotationData/chipTypes",
                            chipType, cdfGzFile)
    download.file(cdfAddress, file.path(chipTypesDir, chipType, cdfGzFile),
                  method = "curl")
    gunzip(file.path(chipTypesDir, chipType, cdfGzFile))
}

# Create/modify directory structure for raw data files (CEL)
rawDataDir <- file.path(".", "data", "rawData")
dataSetDir <- file.path(rawDataDir, "amgenLiver")
chipDir <- file.path(dataSetDir, chipType)
if (!file.exists(rawDataDir)) {
    dir.create(rawDataDir)
    dir.create(dataSetDir)
    dir.create(chipDir)
}
