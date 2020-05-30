library(readr)
library(lubridate)
library(dplyr)
library(ggplot2)

Bus_Count <- read_csv("Bus_Count_StevensWay.csv", 
                      col_names = FALSE, col_types = cols(X2 = col_time(format = "%H:%M")))
colnames(Bus_Count) <- c("Line", "Time")
Line_factor <- as.factor(Bus_Count$Line)

waiting_time <- c(0)
for(i in 1:49){
  temp <- Bus_Count$Time[i+1] - Bus_Count$Time[i]
  waiting_time <- c(waiting_time, temp)
}
waiting_time_levels <- as.factor(waiting_time)

Bus_Count = cbind(Bus_Count, waiting_time)

ggplot(Bus_Count, aes(x = waiting_time)) +
  geom_histogram() +
  labs(title="Waiting Time",
       x="Waiting Time",
       y="Frequency") +
  theme_set(theme_classic())

