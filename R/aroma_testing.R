library(aroma.affymetrix)

setwd("data/")

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


# Background adjustment and normalization
background_correct <- function(cs, verbose) {
    bc <- RmaBackgroundCorrection(cs)
    csBC <- process(bc, verbose = verbose)
    csBC
}

quantile_normalize <- function(csBC, verbose) {
    qn <- QuantileNormalization(csBC, typesToUpdate = "pm")
    csN <- process(qn, verbose = verbose)
    csN
}

chipType <- "Rat230_2" # "RaGene-1_0-st-v1"
projectName <- "amgenLiver"
verbose <- Arguments$getVerbose(-8, timestamp = TRUE)

run_aroma <- function(chipType, projectName, verbose) {
    cdf <- define_chip_type(chipType)
    cs <- define_cel_set(projectName, cdf)
    csBC <- background_correct(cs, verbose)
    csN <- quantile_normalize(csBC, verbose)
    csN
}




# # Summarization
# plm <- RmaPlm(csN)
# print(plm)

# # Quality assessment of PLM fit
# qam <- QualityAssessmentModel(plm)
# plotNuse(qam)
# plotRle(qam)
# 
# # Test chip effects
# ces <- getChipEffectSet(plm)
# fit <- extractDataFrame(ces, units = 1:3, addNames = TRUE)
# 
# readUnits(csN, units = 1:2)
