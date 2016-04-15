
shinyServer(function(input, output) {
  
  output$gwastable <- DT::renderDataTable({
    prepTable(gwas_table)
  }, 
  escape = FALSE, # allow HTML in table
  rownames = FALSE,
  options = list(
    lengthMenu = list(c(10, 25, 50, -1), c(10, 25, 50, "All")),
    search = list(regex = TRUE, caseInsensitive = TRUE)
    )
  )
})