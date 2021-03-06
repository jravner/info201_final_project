# Do stuff with Returns
library(dplyr)
library(ggplot2)
library(alphavantager)


# Using alphavantage here for more current info, quandl isn't always to date



# Returns chart allowing user to map price, return, volume, expected return, and
#market return on either axis 
return_chart <- function(ticker_in, x_axis, y_axis){
  market <- av_get(symbol = "SPY", av_fun = "TIME_SERIES_DAILY_ADJUSTED", 
                   outputsize = "full")
  stock <- av_get(symbol = ticker_in, av_fun = "TIME_SERIES_DAILY_ADJUSTED", 
                  outputsize = "full") %>% 
    select(timestamp, adjusted_close, volume)
  colnames(stock) <- c("date", "price", "volume")
  stock$return <- (stock$price - lag(stock$price))/ lag(stock$price) * 100
  stock$return[1] <- 0
  for (n in 1:nrow(stock)) {
    stock$expected[n] <- cumsum(stock$return)[n] / (n - 1)
  }
  stock$expected[0] <- 0
  stock$market <- (market$adjusted_close - lag(market$adjusted_close)) /
                    lag(market$adjusted_close) * 100
  q <- ggplot(stock, aes_string(x_axis, y_axis)) +
    geom_point(color = "red", size = 0.33) +
    labs(title = "Stock Data Analysis")
  q
}
test <- return_chart("AAPL", "return", "volume")


