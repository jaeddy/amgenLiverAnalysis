library(aroma.affymetrix)
verbose <- Arguments$getVerbose(-8, timestamp = TRUE)


# Set up aroma files

# Create/modify directory structure for annotation files (CDF)
annotationDir <- file.path(".", "data", "annotationData")
chipTypesDir <- file.path(annotationDir, "chipTypes")
chipType <- "RaGene-1_0-st-v1"

if (!file.exists(file.path(chipTypesDir, chipType))) {
    dir.create(annotationDir)
    dir.create(chipTypesDir)
    dir.create(file.path(chipTypesDir, chipType))
}

# Download CDF for rat gene array
cdfFile <- "RaGene-1_0-st-v1,r3.cdf"
cdfPath <- file.path(chipTypesDir, chipType, cdfFile)

if (!file.exists(cdfPath)) {
    cdfGzFile <- paste0(cdfFile, ".gz")
    cdfAddress <- file.path("http://www.aroma-project.org/data/",
                            "annotationData/chipTypes",
                            chipType, cdfGzFile)
    download.file(cdfAddress, file.path(chipTypesDir, chipType, cdfGzFile),
                  method = "curl")
    gunzip(file.path(chipTypesDir, chipType, cdfGzFile))
}


# Create/modify directory structure for raw data files (CEL)
rawDataDir <- file.path(".", "data", "rawData")
if (!file.exists(rawDataDir)) {
    dir.create(rawDataDir)
}


chipType <- "RaGene-1_0-st-v1"
cdf <- AffymetrixCdfFile$byChipType(chipType, tags = "r3")