library("shiny")
library(plotly)
library(dplyr)



my_server <- function(input, output) {
  
  # Render a plot
  output$pricePlot <- renderPlot({
    price_chart(input$ticker, input$start_date, input$end_date, input$y_axis)
  })

  
}

shinyServer(my_server)
