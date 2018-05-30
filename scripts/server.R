library("shiny")
library(plotly)
library(dplyr)
source("get_price_chart.R")
source("returns.R")
source("analytics.R")


my_server <- function(input, output) {
  
  # Render a plot
  output$pricePlot <- renderPlot({
    test <- price_chart(input$ticker, input$start_date, input$end_date)
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
    market

  })

}

shinyServer(my_server)

