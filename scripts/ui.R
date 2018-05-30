library("shiny")
library(plotly)
library(dplyr)
library(DT)
library(shinythemes)


my_ui <- navbarPage(
  "Stock Data",
  # Give the page a title
  tabPanel("Price",

           titlePanel("Stock price"),
           
           # Generate a row with a sidebar
           sidebarLayout(      
             
             # Define the sidebar with one input
             sidebarPanel(
               textInput("ticker", label = h3("Enter Stock Ticker:"),
                         value = "AAPL"),
               textInput("start_date", label = h3("Start Date (YYYY-MM-DD):"),
                         value = "NA"),
               # textInput("end_date", label = h3("End Date (YYYY-MM-DD):"),
               #           value = Sys.Date()),
               #dateInput("start_date", h3("Start Date (YYYY-MM-DD):"), value = "2010-05-30", format = 'yyyy-mm-dd'),
               dateInput("end_date", h3("End Date (YYYY-MM-DD):"), value = Sys.Date(), format = 'yyyy-mm-dd'),
               p("Use the inputs to select what date range and stock you would 
                 like to view. Follow the suggested date format. \"NA\" can be
                 used on the Start Date to view from the stocks first IPO 
                 (Initial Public Offering, when it first came on a stock 
                 exchange).")
             ),
             
             # Create a spot for the barplot
             mainPanel(
               h1("Welcome to the Stock Data App!"),
               p("In this app we will be doing various analysis on stock prices
                 to calculate returns among other things. We use two APIs: 
                 Quandl and Alpha Vantage to gather the data. This is meant to
                 give beginners an easy look in to how a stock and all of its
                 data interacts."),
               plotOutput("pricePlot")  
             )
           )
  ),
  tabPanel("Comparative Plots",
           titlePanel("Comparisons"),
           
           sidebarLayout(
             
             sidebarPanel(
               textInput("ticker2", label = h3("Enter Stock Ticker:"), 
                         value = "AAPL"),
               selectInput("yaxis", label = h3("Choose Y-axis:"), 
                           choices = list("price","volume", "return",
                                          "market", "expected")
                           ),
               selectInput("xaxis", label = h3("Choose X-axis:"), 
                           choices = list("price" = "price", 
                                          "volume" = "volume", 
                                          "return" = "return",
                                          "market" = "market", 
                                          "expected" = "expected")
                           ),
               p("Input the ticker of the stock you would like to see and then
                 select what data you would like on the x and y axes.")
             ),
             mainPanel(
               p("Here you can view how different features of a stock correlate
                 with one another."),
               plotOutput("returnsPlot")  
             )
           )
           
  ),
  tabPanel("Analytics",
      h1("Analytics for a Specific Stock:"),
      textInput("analysis", label = h3("Enter Stock Ticker:"), 
                value = "SPY"),
      h2("Analysis:"),
      
      p("Please click on each row to view it's value."),
      
      DT::dataTableOutput("dataTable"),
      
      p("From historical price data, we can calculate the expected return. 
        The expected daily return is what the change in price 
        should be for tomorrow. Another thing to consider while looking at 
        stocks is the amount of risk that is taken on by owning said stock. 
        There are two main measures that assess this risk: volatility and beta. 
        The former is a simple standard deviation of the 
        stocks historic returns, this is a great benchmark to see how risky 
        the stock's price can be in absolute terms. A stocks beta measures how 
        sensitive
        a security is compared to the market's movements. It can be used to 
        analyze a stocks volatily without the interference of market changes. 
        Finally, alpha is the difference between actual return and expected 
        return. The average of the daily alphas will show if the stock 
        consistantly exceeds, meets, or falls below expectations.")
  ),
  tabPanel("Sector Performance",
           titlePanel("Sectors"),
           sidebarLayout(
             sidebarPanel(
               selectInput("sector", label = h3("Select Time Frame:"),
                           choices = 
                             list("Real Time" = "Rank A: Real-Time Performance",
                                  "1 Day" = "Rank B: 1 Day Performance",
                                  "5 Days" = "Rank C: 5 Day Performance",
                                  "1 Month" = "Rank D: 1 Month Performance",
                                  "3 Months" = "Rank E: 3 Month Performance",
                                  "YTD" = 
                                    "Rank F: Year-to-Date (YTD) Performance",
                                  "1 Year" = "Rank G: 1 Year Performance",
                                  "3 Years" = "Rank H: 3 Year Performance",
                                  "5 Years" = "Rank I: 5 Year Performance",
                                  "10 Years" = "Rank J: 10 Year Performance")),
               p("This plot shows how each sector of the economy has grown 
                 relative to each other. Select a timeframe that you would like 
                 to view.")
             ),
             mainPanel(
               plotOutput("sectorPlot")
             )
           )
           
           ),
  theme = shinytheme("darkly")
)

shinyUI(my_ui)