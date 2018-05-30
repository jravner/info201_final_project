# Creates Daily Price Chart: by company and scrub for date
# Set Up

library(dplyr)
library(ggplot2)
source("../api_keys.R")


# Test parameters
ticker_in <- "MMM"
start_in <- "2002-01-01"
end_in <- "2010-01-01"
y_axis_in <- "price"

# Function returns plot of givens stocks price or returns over time, can enter 
#in beginning and ending periods
price_chart <- function(ticker_in, start_in = NA, end_in = Sys.Date(),
                        y_axis = "price"){
  stock <- Quandl.datatable("WIKI/PRICES", ticker = ticker_in,
                            paginate = TRUE) %>% 
    select(date, adj_close)
  colnames(stock) <- c("date", "price")
  stock$return <- (stock$price - lag(stock$price))/ lag(stock$price) * 100
  stock$return[1] <- 0
  p <- ggplot(stock, aes_string(x = "date", y = y_axis)) +
    geom_line() +
    scale_x_date(limits = c(as.Date(start_in), as.Date(end_in)), 
                 date_minor_breaks = "1 year")
  p
}

<<<<<<< HEAD
test_price <- price_chart("MMM", y_axis = "return")
=======
price_chart("MMM", "2000-01-01", "2005-01-01", y_axis = "price")
>>>>>>> 20e8e08b1a1ff981f6d660a051d5295f9ae12e4c