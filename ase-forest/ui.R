library(shiny)
library(ggplot2)

shinyUI(fluidPage(

  ## Add some CSS to style the table
  tags$head(
    tags$style(HTML(".th-center { text-align: center; }"))
    ),
  
  fluidRow(
    column(2),
    column(4, plotOutput("forest")),
    column(4, plotOutput("iase")),
    column(2)
    ),
  fluidRow(
    column(12, DT::dataTableOutput("table"))
  )
))