library("shiny")
library(plotly)
library(dplyr)
source("get_price_chart.R")
source("returns.R")
source("analytics.R")


my_server <- function(input, output) {
  
  # Render a plot
  output$pricePlot <- renderPlot({
    test <- price_chart(input$ticker, as.character(input$start_date), as.character(input$end_date))
    return(test)
  })

  output$returnsPlot <- renderPlot({
    test2 <- return_chart(input$ticker2, input$xaxis, input$yaxis)
    return(test2)

  })
  
  output$sectorPlot <- renderPlot({
    test3 <- sector_growth(input$sector)
    return(test3)

  })  
  
  output$dataTable <- DT::renderDataTable({
    get_analytics(input$analysis)
  })

}

shinyServer(my_server)

