library(dplyr)
library(lubridate)
library(magrittr)
library(data.table)

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


png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# Plot 1
plot(x = h$datetime, y = h$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(x = h$datetime, y = h$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(x = h$datetime, y = h$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(x = h$datetime, y = h$Sub_metering_2, col="red")
lines(x = h$datetime, y = h$Sub_metering_3, col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# Plot 4
plot(x = h$datetime, y = h$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()


