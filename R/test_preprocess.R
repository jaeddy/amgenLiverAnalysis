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


## Check whether RMA creates any inter-sample dependencies

# 1)
# RMA processing with default parameters, one file
rma1_eset <- rma(raw1_cel)
rma1_expr <- exprs(rma1_eset)
dim(rma1_expr)

# RMA processing with default parameters, two files
rma12_eset <- rma(raw12_cel)
rma12_expr <- exprs(rma12_eset)
dim(rma12_expr)

# Check whether raw values are equal for first array
sum(rma1_expr[, 1] != rma12_expr[, 1]) # returns 31099 -> all different!

# 2)
# RMA processing with normalization off, one file
rma1_eset <- rma(raw1_cel, normalize = FALSE)
rma1_expr <- exprs(rma1_eset)
dim(rma1_expr)

# RMA processing with normalization off, two files
rma12_eset <- rma(raw12_cel, normalize = FALSE)
rma12_expr <- exprs(rma12_eset)
dim(rma12_expr)

# Check whether raw values are equal for first array
sum(rma1_expr[, 1] != rma12_expr[, 1]) # returns 29689 -> mostly different!

# 3)
# RMA processing with bg correction, normalization off, one file
rma1_eset <- rma(raw1_cel, normalize = FALSE, background = FALSE)
rma1_expr <- exprs(rma1_eset)
dim(rma1_expr)

# RMA processing with bg correction, normalization off, two files
rma12_eset <- rma(raw12_cel, normalize = FALSE, background = FALSE)
rma12_expr <- exprs(rma12_eset)
dim(rma12_expr)

# Check whether raw values are equal for first array
sum(rma1_expr[, 1] != rma12_expr[, 1]) # returns 29570 -> mostly different!

# 4)
# RMA processing with destructive, bg correction, normalization off, one file
rma1_eset <- rma(raw1_cel, normalize = FALSE, background = FALSE, 
                 destructive = FALSE)
rma1_expr <- exprs(rma1_eset)
dim(rma1_expr)

# RMA processing with distructive, bg correction, normalization off, two files
rma12_eset <- rma(raw12_cel, normalize = FALSE, background = FALSE,
                  destructive = FALSE)
rma12_expr <- exprs(rma12_eset)
dim(rma12_expr)

# Check whether raw values are equal for first array
sum(rma1_expr[, 1] != rma12_expr[, 1]) # returns 29570 -> mostly different!
