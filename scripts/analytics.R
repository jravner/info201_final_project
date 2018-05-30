# Other analysis tab
library(dplyr)
library(ggplot2)
library(alphavantager)
library(Quandl)
library(DT)
# Using alphavantage here for more current info, quandl isn't always to date

market <- av_get(symbol = "SPY", av_fun = "TIME_SERIES_DAILY_ADJUSTED", 
                 outputsize = "full")
market$return <- (market$adjusted_close - lag(market$adjusted_close))/ 
  lag(market$adjusted_close) * 100
market$return[1] <- 0

# Funtion that returns the list of analytics
get_analytics <- function(ticker_in){
  stock <- av_get(symbol = ticker_in, av_fun = "TIME_SERIES_DAILY_ADJUSTED", 
                   outputsize = "full") %>% 
    select(timestamp, adjusted_close, volume)
  colnames(stock) <- c("date", "price", "volume")
  stock$return <- (stock$price - lag(stock$price))/ lag(stock$price) * 100
  stock$return[1] <- 0
  for (n in 1:nrow(stock)) {
    stock$expected[n] <- cumsum(stock$return)[n] / (n - 1)
  }
  stock$expected[1] <- 0
  stock$market <- (market$adjusted_close - lag(market$adjusted_close)) /
    lag(market$adjusted_close) * 100
  last <- nrow(stock)
  Analytic <- c("Ticker", "Price", "Expected Return", "Volatility", "Beta",
                "Average Alpha")
  Value <- c(ticker_in, stock$price[last], stock$expected[last], 
             sd(stock$price), 
             (sd(stock$return) * cor(stock$return, market$return)) / 
               sd(market$return), mean(stock$return - stock$expected, na.rm = T)
             )
  data <- data.frame(Analytic, Value)
}


# Function to create the sector growth plot
sector_growth <- function(timeframe){
  sector <- av_get(av_fun = "SECTOR") %>% 
    filter(rank.group == timeframe)
  
  s <- ggplot(sector, aes(x = sector, y = value)) +
    geom_col(fill = "orangered") +
    labs(title = "Sector Performance") + 
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  s
}


#testa <- get_analytics("AAPL")
#sector_growth("Rank A: Real-Time Performance")


