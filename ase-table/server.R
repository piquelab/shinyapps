library(shiny)
source('helpers.R')

load('data/ase_table_full.Rd')
load('data/case_table_full.Rd')
load('data/iase_table_full.Rd')

shinyServer(function(input, output) {
  
  output$heatmap <- renderImage({
    list(src="images/figure3_heatmap.jpg",
         alt="Heatmap of ASE per cell type and treatment",
         height=300,
         contentType="img/jpg")
  }, deleteFile = FALSE)
  
  output$filename <- renderText({
    switch(input$dataset,
           "ASE" = "ase_table_full.Rd",
           "cASE" = "case_table_full.Rd",
           "iASE" = "iase_table_full.Rd")
  })
  
  datasetInput <- reactive({
    switch(input$dataset,
           "ASE" = ase,
           "cASE" = case,
           "iASE" = iase)
  })
  
  output$table <- DT::renderDataTable(processTable(datasetInput(), input$dataset),
                                  escape = FALSE,
                                  options = list(
                                    lengthMenu = c(10, 25, 50, 100),
                                    search = list(regex = TRUE, caseInsensitive = TRUE)
                                    ),
                                  filter = list(position = 'top', clear = FALSE)
                                  )

  output$downloadData <- downloadHandler(
    filename = function() { paste(input$dataset, '_table_full.txt.gz', sep='') },
    content = function(file) {
      write.table(datasetInput(), file=gzfile(file), quote = FALSE, row.names = FALSE, sep='\t')
    }
  )
})
