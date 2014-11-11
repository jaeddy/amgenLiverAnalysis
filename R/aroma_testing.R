library(aroma.affymetrix)
verbose <- Arguments$getVerbose(-8, timestamp = TRUE)

setwd("data/")

# Define chip annotation file input
chipType <- "Rat230_2" # "RaGene-1_0-st-v1"
cdf <- AffymetrixCdfFile$byChipType(chipType)
print(cdf)

# Define the CEL set
cs <- AffymetrixCelSet$byName("amgenLiver", cdf = cdf)
print(cs)

# Background adjustment and normalization
bc <- RmaBackgroundCorrection(cs)
csBC <- process(bc, verbose = verbose)

qn <- QuantileNormalization(csBC, typesToUpdate = "pm")
csN <- process(qn, verbose = verbose)

# Summarization
plm <- RmaPlm(csN)
print(plm)

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
