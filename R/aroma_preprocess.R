library(aroma.affymetrix)

# Define chip annotation file input
define_chip_type <- function(chipType) {
    cdf <- AffymetrixCdfFile$byChipType(chipType)
    cdf
}

# Define the CEL set
define_cel_set <- function(projectName, cdf) {
    cs <- AffymetrixCelSet$byName("amgenLiver", cdf = cdf)
    cs
}

# Background adjustment with RMA
background_correct <- function(cs, verbose) {
    bc <- RmaBackgroundCorrection(cs)
    csBC <- process(bc, verbose = verbose)
    csBC
}

# Quantile normalization
quantile_normalize <- function(csBC, verbose) {
    qn <- QuantileNormalization(csBC, typesToUpdate = "pm")
    csN <- process(qn, verbose = verbose)
    csN
}

# Define inputs
chipType <- "Rat230_2"
projectName <- "amgenLiver"
verbose <- Arguments$getVerbose(-8, timestamp = TRUE)

# Move to data directory
mainDir <- getwd()
setwd("data/")

# Run all preprocessing steps
cdf <- define_chip_type(chipType)
cs <- define_cel_set(projectName, cdf)
csBC <- background_correct(cs, verbose)
csN <- quantile_normalize(csBC, verbose)

# Reset working directory
setwd(mainDir)