library(lineprof)
source("./R/aroma_testing.R")
setwd("..")

chipType <- "Rat230_2" # "RaGene-1_0-st-v1"
projectName <- "amgenLiver"
verbose <- Arguments$getVerbose(-8, timestamp = TRUE)

setwd("data/")
l1 <- lineprof(cdf <- define_chip_type(chipType))
l2 <- lineprof(cs <- define_cel_set(projectName, cdf))
l3 <- lineprof(csBC <- background_correct(cs, verbose))
l4 <- lineprof(csN <- quantile_normalize(csBC, verbose))

setwd("..")
