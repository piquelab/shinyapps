
shinyServer(function(input, output) {
  
  output$ui <- renderUI({
    selectInput("treatment", 
                label = "Select Treatment:",
                choices = sort(names(deg_dat[[input$celltype]]))
                )
  })
  output$degtable <- DT::renderDataTable({
    data <- deg_dat[[input$celltype]][[input$treatment]]
    data <- data[, c("g.id", "t.id", "logFC", "pval", "padj")]
    colnames(data) <- c("Gene", "Transcript", "<em>log</em><sub>2</sub>(fold change)", "<em>p</em>-value", "BH-adj <em>p</em>-value")
    data[,3:5] <- round(data[,3:5], 3)
    data
  }, 
  escape = FALSE, # allow HTML in table
  rownames = FALSE,
  options = list(
    lengthMenu = c(10, 25, 50, 100),
    search = list(regex = TRUE, caseInsensitive = TRUE)
    ),
  filter = list(position = 'top', clear = FALSE)
  )
})