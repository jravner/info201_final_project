library("shiny")
library(plotly)
library(dplyr)
library(shinythemes)

my_ui <- navbarPage(
  "Stock Data",
  # Give the page a title
  tabPanel("Price",
           titlePanel("stock price"),
           
           # Generate a row with a sidebar
           sidebarLayout(      
             
             # Define the sidebar with one input
             sidebarPanel(
               textInput("start_date", label = h3("Date input (YYYY-MM-DD)"),
                         value = "NA"),
               textInput("end_date", label = h3("Date input (YYYY-MM-DD)"),
                         value = Sys.Date()),
               selectInput("y-axis", label = h3("y-axis"), 
                           choices = list("Choice 1" = "price", "Choice 2" = "returns"), 
                           selected = 1),
               textInput("ticker", label = h3("Choose ticker symbol (XXXX)"), value = "AAPL")
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