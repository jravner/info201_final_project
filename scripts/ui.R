library("shiny")
library(plotly)
library(dplyr)
library(shinythemes)

my_ui <- navbarPage(
  "Stock Data",
  # Give the page a title
  tabPanel("Price",
           titlePanel("Stock Price"),
           
           # Generate a row with a sidebar
           sidebarLayout(      
             
             # Define the sidebar with one input
             sidebarPanel(
               textInput("start_date", label = h3("Start date"),
                         value = "NA"),
               textInput("end_date", label = h3("End date"),
                         value = Sys.Date())
             ),
             
             # Create a spot for the barplot
             mainPanel(
               plotOutput("pricePlot")  
             )
           )
  ),
  tabPanel("Return"
           
  ),
  tabPanel("Analytics"
           
  ),
  theme = shinytheme("darkly")
)

shinyUI(my_ui)