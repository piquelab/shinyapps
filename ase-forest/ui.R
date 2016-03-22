library(shiny)
library(ggplot2)

shinyUI(fluidPage(

  ## Add some CSS to style the table
  tags$head(
    tags$style(HTML(".th-center { text-align: center; }"))
    ),
  
  fluidRow(
    sidebarPanel(withTags(
      h2("cASE Forest Plots")),
      h5("Click on a table entry to generate a plot in the top right corner."),
      helpText(HTML("<br />
                    <p>Left plot: Forest plot of ASE &beta;s for selected cASE SNP. The 
                    ASE &beta; is displayed for each treatment in which the SNP was tested
                    for that cell type. Error bars indicate the 95% confidence interval from 
                    <a href='https://github.com/piquelab/quasar'>QuASAR</a>.</p>
                    <br />
                    <p>Right plot: The selected cASE SNP is represented as two points
                    (treatment and control) connected by a line, plotted based on the
                    expression of each allele. The dotted lines represent constant
                    expression levels.</p>")), 
      width=4),
    column(4, plotOutput("forest")),
    column(4, plotOutput("iase")),
    column(2)
    ),
  fluidRow(
    column(12, DT::dataTableOutput("table"))
  )
))