library(shiny)
library(ggplot2)

shinyUI(fluidPage(

  ## Add some CSS to style the table
  tags$head(
    tags$style(HTML(".th-center { text-align: center; }"))
    ),
  
  fluidRow(
    sidebarPanel(withTags(
      h2("iASE Allele Plots")),
      h5("Click on a table entry to generate a plot in the top right corner."),
      helpText("Each iASE SNP is represented as two points (treatment and control) 
               connected by a line, plotted based on the expression of each allele. 
               Points are colored by treatment (e.g., controls in black and grey), 
               and the dotted lines represent constant expression levels. For 
               ease of display, expression of SNPs <0.01 have been set to 0.01."), 
      width=4),
    column(1),
    column(4, plotOutput("iase")),
    column(1)
  ),
  
    # fluidRow(
  #   column(6, sidebarPanel(withTags(
  #     h2("iASE Allele Plots")
  #   )), width=6),
  #   column(4, plotOutput("iase"))
  #   ),
  fluidRow(
    column(12, DT::dataTableOutput("table"))
  ),
  helpText(HTML("<sup>&dagger;</sup>SNP-based logFC"))
))