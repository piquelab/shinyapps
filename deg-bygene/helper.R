load("data/gene_names.Rd") # gene_names (array)

getDegData <- function(gene) {

  ## Would be ideal to load directly w/o the unpack step
  # untar("data.tgz", paste0(g, ".Rd"))
  load(paste0("data/", gene, ".Rd"))
  # system("rm ", paste0(g, ".Rd"))
  
  gene_dat <- gene_dat[, c( "CellType", "Treatment", "g.id", "t.id", "logFC", "pval", "padj")]
  colnames(gene_dat) <- c("Cell Type", "Treatment", "Gene", "Transcript", 
                      "<em>log</em><sub>2</sub>(fold change)", "<em>p</em>-value", "BH-adj <em>p</em>-value")
  num_cols <- sapply(gene_dat, is.numeric)
  gene_dat[,num_cols] <- round(gene_dat[,num_cols], 3)
  return(gene_dat)
}