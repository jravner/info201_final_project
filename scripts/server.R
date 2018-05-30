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
    test2 <- return_chart(input$ticker2, input$x-axis, input$y-axis)
    return(test2)
  })  

}

shinyServer(my_server)

