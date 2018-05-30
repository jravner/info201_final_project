library("shiny")
library(plotly)
library(dplyr)
source("get_price_chart.R")
source("returns.R")
source("analytics.R")



my_server <- function(input, output) {
  
  # Render a plot
  output$pricePlot <- renderPlot({
    price_chart(input$ticker, input$start_date, input$end_date, input$y_axis)
  })

  output$test <- renderPrint({
    return(input$text)
  })
}

shinyServer(my_server)

