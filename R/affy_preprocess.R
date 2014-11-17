
# Trying out built in affy package functions to process and normalize raw data
# instead of aroma.affymetrix. Should be more flexible, and potentially faster.

library(affy)
?justRMA
?ReadAffy

celDir <- "data/rawData/amgenLiver/Rat230_2/"
celFiles <- list.celfiles(celDir)
t <- system.time({
    testData <- ReadAffy(filenames = celFiles, celfile.path = celDir)
})
t
