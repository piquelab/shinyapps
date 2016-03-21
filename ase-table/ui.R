library(shiny)

shinyUI(fluidPage(
  headerPanel('ASE Data Tables'),

  fluidRow(
    column(4,
           helpText('Select the data table you would like to view. The tables can be filtered on 
                row values using the inputs under each row. To download a table, click the 
                    "Download" button after selecting the desired table.'),
           br(),
           selectInput("dataset", "Select Table:", c("ASE", "cASE", "iASE")),
           downloadButton('downloadData', 'Download Table')
           ),
    column(8,
           imageOutput("heatmap", height="300px")
           )
  ),
  hr(),
  DT::dataTableOutput("table")
))
