
shinyServer(function(input, output) {
  output$degtable <- DT::renderDataTable({
    print(input$gene)
    getDegData(input$gene)
  }, 
  escape = FALSE, # allow HTML in table
  rownames = FALSE,
  options = list(
    lengthMenu = list(c(10, 25, 50, 100, -1), c(10, 25, 50, 100, "All")),
    search = list(regex = TRUE, caseInsensitive = TRUE)
    ),
  filter = list(position = 'top', clear = FALSE)
  )

})