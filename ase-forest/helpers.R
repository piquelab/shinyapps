## I don't know why but loading the data in the helper
## script works better than putting it in server.R
load('data/case_forest.Rd')

## For the iase/arrow plots
threshLines <- data.frame( x = seq(0, 1, 0.01),
                           y = seq(1, 0, -0.01))

## Ordering and other pre-plot functions
prepForForest <- function(data) {
  data$category <- substr(data$treatment,0,1) # T or C
  plotdat <- data[ order(data$rsID, data$category, data$ASE.Beta), ]
  plotdat$Treatment <- factor(plotdat$Treatment, levels=unique(plotdat$Treatment))
  return(plotdat)
}

## Prepare the data to display
prepTable <- function(data) {
  
  ## Drop unwanted columns
  # rm_cols <- sapply(c("Plate", "treatment", "Individual", "dASE.pval", "dASE.pcorr",
  #                     "mesh.cOnly.ePval", "mesh.tOnly.ePval"),
  #                   grep, colnames(data))
  # table <- data[, -rm_cols]
  keep_cols <- c("rsID", "Gene", "CellType", "Treatment", "Control", "dASE.zscore", "dASE.qval",
                 "mesh.cOnly.bf", "mesh.cOnly.eQval", "mesh.tOnly.bf", "mesh.tOnly.eQval")
  table <- data[, keep_cols]
  
  ## Round numeric values
  num_cols <- sapply(table, is.numeric)
  table[,num_cols] <- round(table[,num_cols], 3)
  return(table)
}

## Customize the table layout
sketch = htmltools::withTags(table(
  class = 'display',
  thead(
    ## Top row
    tr(
      lapply(c("rsID", "Gene", "Cell Type", "Treatment", "Control"), th, rowspan="2"),
      th(colspan = 2, HTML('&Delta;AST'), class="th-center"),
      th(colspan = 2, 'MeSH Control-only', class="th-center"),
      th(colspan = 2, 'MeSH Treatment-only', class="th-center")
    ),
    ## Bottom Row
    tr(
      th(HTML("<em>Z</em>-score")), 
      # th(HTML("<em>p</em>-value")),
      # th(HTML("Corrected <em>p</em>-value")),
      th(HTML("<em>q</em>-value")),
      th("BF"),
      # th(HTML("<em>p</em>-value")),
      th(HTML("<em>q</em>-value")),
      th("BF"),
      # th(HTML("<em>p</em>-value")),
      th(HTML("<em>q</em>-value"))
    )
  )
))
