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
              
               textInput("ticker", label = h3("Choose ticker symbol (XXXX)"), value = "AAPL")
             ),
             
             # Create a spot for the barplot
             mainPanel(
               plotOutput("pricePlot")  
             )
           )
  ),
  tabPanel("Return",
           titlePanel("returns"),
           
           sidebarLayout(
             
             
             sidebarPanel(
               textInput("ticker2", label = h3("Choose ticker symbol (XXXX)"), 
                         value = "AAPL"),
               selectInput("yaxis", label = h3("yaxis"), 
                           choices = list("price","volume", "return",
                                          "market", "expected")
                           ),
               selectInput("xaxis", label = h3("xaxis"), 
                           choices = list("price" = "price", "volume" = "volume", "return" = "return",
                                          "market" = "market", "expected" = "expected")
                           )
             ),
             mainPanel(
               plotOutput("returnsPlot")  
             )
           )
           
  ),
  tabPanel("Analytics"
           
  ),
  theme = shinytheme("darkly")
)

shinyUI(my_ui)