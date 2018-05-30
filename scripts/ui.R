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
  tabPanel("Analytics",
      h1("Below are Analytics for a Specific Stock"),
      textInput("text", label = h3("Enter a stock ticker:"), 
                value = "SPY"),
      h2("Analysis:"),
      
      # Put table here
      
      
      p("From historical price data, we can calculate the expected return, for 
        this security, the expected daily return is what the change in price 
        should be for tomorrow. Another thing to consider while looking at 
        stocks is the amount of risk that is taken on by owning said stock. 
        There are two main measures that assess this risk: return standard 
        deviation and beta. The former is a simple standard deviation of the 
        stocks historic returns, this is a great benchmark to see how volatile 
        the stock can be in absolute terms. A stocks beta measures how sensitive
        a security is compared to the market's movements. It can be used to 
        analyze a stocks volatily without the interference of market changes. 
        Finally, alpha is the difference between actual return and expected 
        return. The average of the daily alphas will show if the stock 
        consistantly exceeds, meets, or falls below expectations.")
  ),
  theme = shinytheme("darkly")
)

shinyUI(my_ui)