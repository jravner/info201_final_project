# Other analysis tab
library(dplyr)
library(ggplot2)
library(alphavantager)
library(Quandl)
source("../api_keys.R")
# Using alphavantage here for more current info, quandl isn't always to date

market <- av_get(symbol = "SPY", av_fun = "TIME_SERIES_DAILY_ADJUSTED", 
                 outputsize = "full")
market$return <- (market$adjusted_close - lag(market$adjusted_close))/ 
  lag(market$adjusted_close) * 100
market$return[1] <- 0

# Funtion that returns the list of analytics
get_analytics <- function(ticker_in){
  ret <- list()
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
  ret$price <- stock$price[last]
  ret$expected_ret <- stock$expected[last]
  ret$risk <- sd(stock$price)
  ret$beta <- (sd(stock$return) * cor(stock$return, market$return)) / 
    sd(market$return)
  ret$alpha_avg <- mean(stock$return - stock$expected, na.rm = T)
  ret
}


# Function to create the sector growth plot
sector_growth <- function(timeframe){
  sector <- av_get(av_fun = "SECTOR") %>% 
    filter(rank.group == timeframe)
  
  s <- ggplot(sector, aes(x = sector, y = value)) +
    geom_col(fill = "orangered")
  s
}

test_get_analytics <- get_analytics(ticker_in)




