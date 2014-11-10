setwd("data/")

# Define chip annotation file input
chipType <- "Rat230_2" # "RaGene-1_0-st-v1"
cdf <- AffymetrixCdfFile$byChipType(chipType)
print(cdf)

# Define the CEL set
cs <- AffymetrixCelSet$byName("amgenLiver", cdf = cdf)
