### Procssing MAF files after Mutect2 analysis
### https://www.bioconductor.org/packages/devel/bioc/vignettes/maftools/inst/doc/maftools.html

### Process Mutation Annotation Format (MAF) files for individual patients and merge them into MAF object for analysis using MAF tools

setwd("")

# Loop multiple files and assign name
list_files <- dir()
for (i in list_files) {
  
  # read the data
  file <- read.maf(i)
  file_data <- file@data
  maf_data <- read.maf(file_data)
  
  # create object name based on filename
  dataframe_name <- sub("\\-.*", "", i) # example name of an original file is PAZ***-**-filtered.annotated.maf
  
  # name the object
  assign(dataframe_name, maf_data)
}

# create mergerd MAF object
list <- mget(ls(pattern="PAZ")) # PAZ is a shared pattern across names of all samples
maf <- merge_mafs(list)

# Analyse merged MAF object using MAFtools
library(maftools)
plotmafSummary(maf = maf, rmOutlier = TRUE, addStat = 'median', dashboard = TRUE, titvRaw = FALSE)

oncoplot(maf = maf, top = 30, barcode_mar=8, gene_mar=7)

somaticInteractions(maf = maf, top = 25, pvalue = c(0.05, 0.1))

maf.titv = titv(maf = maf, plot = FALSE, useSyn = TRUE)
#plot titv summary
plotTiTv(res = maf.titv)
