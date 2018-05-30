# Do stuff with Returns
library(dplyr)
library(ggplot2)
library(alphavantager)

# Using alphavantage here for more current info, quandl isn't always to date

market <- av_get(symbol = "SPY", av_fun = "TIME_SERIES_DAILY_ADJUSTED", 
<<<<<<< HEAD
                outputsize = "full") 
=======
                outputsize = "full")
>>>>>>> 753ad823dd94feb02b0ffe4d3134f32f5b39ee7a
market$return <- (market$adjusted_close - lag(market$adjusted_close))/ 
  lag(market$adjusted_close) * 100
market$return[1] <- 0

# Returns chart allowing user to map price, return, volume, expected return, and
#market return on either axis 
return_chart <- function(ticker_in, x_axis, y_axis){
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
  q <- ggplot(stock, aes_string(x = x_axis, y = y_axis)) +
    geom_point()
  q
}
test <- return_chart("AAPL", "price", "volume")


