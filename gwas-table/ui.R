library(shiny)
source("helper.R")

shinyUI(fluidPage(
  titlePanel("GWAS Overlap Table"),
  DT::dataTableOutput("gwastable")
))
