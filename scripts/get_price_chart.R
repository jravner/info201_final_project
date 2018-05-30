# Creates Daily Price Chart: by company and scrub for date
# Set Up

library(dplyr)
library(ggplot2)
library(Quandl)



# Test parameters
ticker_in <- "MMM"
start_in <- "2002-01-01"
end_in <- "2010-01-01"
y_axis_in <- "price"

# Function returns plot of givens stocks price or returns over time, can enter 
#in beginning and ending periods
price_chart <- function(ticker_in, start_in = NA, end_in = Sys.Date()
                       ){
  stock <- Quandl.datatable("WIKI/PRICES", ticker = ticker_in,
                            paginate = TRUE) %>% 
    select(date, adj_close)
  colnames(stock) <- c("date", "price")
  stock$return <- (stock$price - lag(stock$price))/ lag(stock$price) * 100
  stock$return[1] <- 0
  p <- ggplot(stock, aes_string(x = "date", y = "price")) +
    geom_line() +

    scale_x_date(limits = c(as.Date(start_in, format = "%Y-%m-%d"),
                            as.Date(end_in, format = "%Y-%m-%d")), 
                 date_minor_breaks = "1 year")
  p
}



price_chart("MMM", "2000-01-01", "2005-01-01", y_axis = "price")


