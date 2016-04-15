load("data/gwas_table.Rd")

pubmedIDToUrl <- function(ids) {
  urls <- sapply(unlist(strsplit(ids, ", ")), function(id) {
    paste0("<a href='//www.ncbi.nlm.nih.gov/pubmed/", id, "'>", id, "</a>")
  })
  paste(urls, collapse=", ")
}

lookupGeneCard <- function(gene) {
  stopifnot(length(gene) == 1) # not a vector/list
  paste0("<a href='//www.genecards.org/cgi-bin/carddisp.pl?gene=", gene, "'>", gene, "</a>")
}

prepTable <- function(table) {
  table$urls <- sapply(table$Pubmed.IDs, pubmedIDToUrl)
  table$geneUrl <- sapply(table$Gene.Symbol, lookupGeneCard)
  table <- table[, c("geneUrl", "Treatment", "Cell.Type", "rsID", "iASE.or.cASE", "Traits", "urls")]
  colnames(table) <- c("Gene", "Treatment", "Cell Type", "rsID", "ASE Type", "GWAS Traits", "GWAS Studies")
  table
}