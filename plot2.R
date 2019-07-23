library(dplyr)
library(lubridate)
library(magrittr)

hpc <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")

# select rows of two specific days
h <- filter(hpc, Date == "1/2/2007" | Date == "2/2/2007")

# combine Date and Time into a new variable datetime
h <- mutate(h, datetime= as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

# some type conversions
h$Date = as.Date(h$Date, format= "%d/%m/%Y")
h$Time = as.character(h$Time)
h$Global_active_power = as.numeric(as.character(h$Global_active_power))
h$Global_reactive_power = as.numeric(as.character(h$Global_reactive_power))


png("plot2.png", width=480, height=480)

plot(x = h$datetime,
     y = h$Global_active_power,
     type="l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)")


dev.off()
