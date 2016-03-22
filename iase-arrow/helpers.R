## I don't know why but loading the data in the helper
## script works better than putting it in server.R
load('data/iase_data.Rd')

## For the iase/arrow plots
threshLines <- data.frame( x = seq(0, 1, 0.01),
                           y = seq(1, 0, -0.01))

## Prepare the data to display
prepTable <- function(data) {
  
  ## Drop unwanted columns
  keep_cols <- c("rsID", "gene.name", "cell.type", "Treatment", "Control", "snplfc",
                 "beta.t", "se.t", "qval.cov.t",
                 "ref.adj.t", "ref.adj.c", "alt.adj.t", "alt.adj.c")
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
      th(HTML("logFC<sup>&dagger;</sup>"), rowspan="2"),
      th(colspan = 3, "Treatment ASE", class="th-center"),
      th(colspan = 2, "Reference Allele", class="th-center"),
      th(colspan = 2, 'Alternate Allele', class="th-center")
    ),
    ## Bottom Row
    tr(
      ## Treatment ASE
      th(HTML("&beta;"), class="alt"), 
      th("Std Err", class="alt"),
      th(HTML("<em>q</em>-value"), class="alt"), 
      ## Reference Allele
      th("Treatment"), 
      th("Control"),
      ## Alternate Allele
      th("Treatment", class="alt"),
      th("Control", class="alt")
    )
  )
))
