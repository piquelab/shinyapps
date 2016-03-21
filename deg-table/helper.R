load("data/deg_results.Rd")

# 
# treatmentKey <- read.table("/Users/gmb/Desktop/work/GxE_paper/figures/treatmentKey.txt",
#                            as.is = TRUE, sep='\t', header=TRUE, comment.char="")
# files = list.files("data/")
# deg_dat <- list()
# for( file in files) {
#   ## Load the data
#   celltype = gsub("_.*", "", file)
#   treatment = treatmentKey[gsub(".*_", "", gsub(".txt", "", file)), "Common_Name"]
#   dat <- read.table(paste0('data/', file), as.is=TRUE, header=TRUE)
#   if( is.null( deg_dat[celltype] )) {
#     deg_dat[[ celltype ]] <- list()
#   }
#   deg_dat[[ celltype ]][[ treatment ]] <- dat
# }
# 
