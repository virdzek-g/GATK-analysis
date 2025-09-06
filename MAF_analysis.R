### Procssing MAF files after Mutect2 analysis

## loop across all MAF files to create a list of all variants in a cohort


list_files <- dir() 
data = data.frame()
for (i in list_files) {
  tryCatch({
    # read the data
    file <- read.maf(i,vc_nonSyn=c('Frame_Shift_Ins','INS','DEL','Missense_Mutation','Nonsense_Mutation','Frame_Shift_Del','In_Frame_Ins','In_Frame_Del','Splice_Site',"3'UTR",'IGR',"5'UTR", 'DE_NOVO_START_IN_FRAME', 'Intron','Silent')) #,"3'UTR",'IGR',"5'UTR"
    file_data <- file@data
    maf_data <- read.maf(file_data,vc_nonSyn=c('Frame_Shift_Ins','INS','DEL','Missense_Mutation','Nonsense_Mutation','Frame_Shift_Del','In_Frame_Ins','In_Frame_Del','Splice_Site',"3'UTR",'IGR',"5'UTR", 'DE_NOVO_START_IN_FRAME', 'Intron','Silent')) #,"3'UTR",'IGR',"5'UTR"

    # create object name based on filename
    dataframe_name <- sub(".maf", "", i) #"\\-.*", "", i

    # name the object
    assign(dataframe_name, maf_data)
    maf_data <- maf_data@data[,c(1,5,6,7,9:13,16,37:42,80,81,82,141)] 
    data <- rbind(data,maf_data)
  }, error = function(e) {
    print(paste(i, "could not be read"))
  })
}
