library(shiny)
source('helpers.R')

shinyServer(function(input, output) {
  
  ## Selectable table to display cASE results
  output$table = DT::renderDataTable(prepTable(iase), 
                                     container = sketch,   # layout (from helper.R)
                                     selection = "single", # only select 1 row at a time
                                     escape = FALSE,       # Allow HTML in table
                                     rownames = FALSE,
                                     options = list(
                                       lengthMenu = list(c(10, 25, 50, -1), c(10, 25, 50, "All")),
                                       search = list(regex = TRUE, caseInsensitive = TRUE)
                                       ),
                                     filter = list(position = 'top', clear = FALSE)
                                     )

  output$iase = renderPlot({
    
    ## Get selection (row index)
    s = input$table_rows_selected
    
    if( length(s) ) {
      
      ctCol = treatmentKey[treatmentKey$Common_Name==iase$Control[s], "DeepColor"]
      txCol = treatmentKey[treatmentKey$Common_Name==iase$Treatment[s], "DeepColor"]
      
      p1 <- ggplot(iase[s,])
      p1 +
        ## Add guide lines for expression levels
        geom_line(data = threshLines, aes(x=x, y=y), color = "#CCCCCC", linetype = 2) + 
        geom_line(data = threshLines, aes(x=x/10, y=y/10), color = "#CCCCCC", linetype = 2) + 
        geom_line(data = threshLines, aes(x=x*10, y=y*10), color = "#CCCCCC", linetype = 2) + 
        ## Add line segments that connect tx-ctrl SNPs
        geom_segment(aes( x = low.allele.c, xend = low.allele.t, 
                          y = high.allele.c, yend = high.allele.t,
                          alpha = log2(sqrt( (low.allele.t-low.allele.c)^2 + (high.allele.t-high.allele.c)^2 ))),
                     color = "#999999") +
        geom_abline(slope = 1, intercept = 0, color = "black", size = 0.5) + #color = "#999999", linetype=2) +
        ## Add points
        geom_point(aes( x = low.allele.c, y = high.allele.c), color = ctCol, size = 3) +
        geom_point(aes( x = low.allele.t, y = high.allele.t), color = txCol, size = 3) + 
        scale_alpha(guide = "none") +
        ## Adjust the scales & tickpoints (breaks). Also, plot to the edge (expand) for the polygon
        # scale_x_log10(limits = 10^c(-2.1,0.6), breaks=c(10^c(-2, -1, 0, log10(5))), expand = c(0, 0)) + 
        scale_x_log10(limits = 10^c(-2.5,1.25), breaks=c(10^(-2:1)), expand = c(0, 0)) +
        scale_y_log10(limits = 10^c(-2.5,1.25), breaks=c(10^(-2:1)), expand = c(0, 0)) + 
        xlab("Normalized Expression (Low Allele)") +
        ylab("Normalized Expression (High Allele)") +
        theme_bw() +
        theme(
          legend.position = "none",
          panel.grid = element_blank(),
          panel.border = element_blank(),
          axis.line = element_line())
    }
    
  })
  
  
})
