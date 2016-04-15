library(shiny)
source('helper.R')

shinyUI(fluidPage(
  
  titlePanel("Differential Gene Expression Tables"),
  sidebarPanel(
    ## selectize is a really, really nice UI but shiny can't handle the 40k choices very well
    # selectizeInput("gene",
    #                label = "Select Gene:",
    #                choices = gene_names),
    textInput("gene",
              label = "Enter Gene:",
              value = "WASH7P"),
    withTags(div(
      HTML("<p>We identified differentially expressed (DE) genes using the software 
           <a href='https://bioconductor.org/packages/release/bioc/html/DESeq2.html'>
           DESeq2</a> (version 1.8.1, run using R version 3.2.1). 
           To better estimate the dispersion parameters, the DESeq2 model was fit on all 
           sequencing data from a single plate simultaneously. For each treatment, we contrasted 
           to the matched control using the default DEseq Wald test for each transcript."))
    )),
  mainPanel(
    DT::dataTableOutput("degtable")
  )
))
