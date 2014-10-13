library(affy)

# Note on platform:
# GEO platform GPL1355 [RAT230_2] is the relevant chip data for Affymetrix Rat
# Genome 230 2.0 Array

### Testing usage options for RMA preprocessing of CEL files ###
################################################################

## First check whether ReadAffy creates any inter-sample dependencies

# Read one file only
cel_names <- "data/139445.CEL"
raw1_cel <- ReadAffy(filenames = cel_names)
raw1_expr <- exprs(raw1_cel)
dim(raw1_expr) # returns 695556x1

# Read two files
cel_names <- c("data/139445.CEL", "data/38633.CEL")
raw12_cel <- ReadAffy(filenames = cel_names)
raw12_expr <- exprs(raw12_cel)
dim(raw12_expr) # returns 695556x2

# Check whether raw values are equal for first CEL file
sum(raw1_expr[, 1] != raw12_expr[, 1]) # returns 0



# RMA processing with default parameters
rma_eset <- rma(raw_cel)
rma_expr <- exprs(rma_eset)
