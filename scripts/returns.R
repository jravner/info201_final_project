# Do stuff with Returns
library(dplyr)
library(ggplot2)
library(alphavantager)

market <- av_get(symbol = "SPY", av_fun = "TIME_SERIES_DAILY_ADJUSTED", 
                outputsize = "full")

return_chart <- function(ticker_in, x_axis, y_axis){
  
}