processTable <- function(table, type) {
  
  ## Round numeric data
  table[, grep("numeric", sapply(table, class))] <- round(
    table[, grep("numeric", sapply(table, class))], 3
  )
  
  ## Process the row names
  if(type == "ASE") {
    colnames(table) <- c("rsID", "Gene", "Cell Type", "Treatment", "Reference Reads", 
    "Alternate Reads", "ASE &beta;", "Std Err", "<em>p</em>-value", "<em>q</em>-value")
  } else if(type == "cASE") {
    colnames(table)<-c("rsID","Gene","Cell Type",
                      "Treatment", "&beta;<sub>T</sub>","Std Err<sub>T</sub>","<em>p</em>-value<sub>T</sub>","<em>q</em>-value<sub>T</sub>",
                      "Control", "&beta;<sub>C</sub>","Std Err<sub>C</sub>","<em>p</em>-value<sub>C</sub>","<em>q</em>-value<sub>C</sub>",
                      "SNP-based Expression","SNP-based <em>log<sub>2</sub></em>FC",
                      "&Delta;AST <em>Z</em>-score","&Delta;AST <em>p</em>-value","&Delta;AST corrected <em>p</em>-value","&Delta;AST <em>q</em>-value",
                      "MeSH C-only BF","MeSH C-only <em>p</em>-value","MeSH C-only <em>q</em>-value",
                      "MeSH T-only BF","MeSH T-only <em>p</em>-value","MeSH T-only <em>q</em>-value")
  } else if (type == 'iASE') {
    colnames(table) <- c("rsID", "Cell Type", "Treatment", "Control", "Gene",
                         "Reference Coverage<sub>T</sub>", "Reference Coverage<sub>C</sub>",
                         "Alternate Coverage<sub>T</sub>", "Alternate Coverage<sub>C</sub>")
  }
  
  return( table )
}