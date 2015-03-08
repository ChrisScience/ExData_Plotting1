## Read in the data
library(dplyr)
dfepower <- read.table("household_power_consumption.txt", sep = ";",
                       colClasses = c(rep("character", 2), 
                                      rep("numeric", 7)), 
                       header = TRUE, 
                       na.strings = "?")
## Left the Date and Time fields as character to allow easy subsetting based 
## on string matches
dfdays <- dfepower[dfepower$Date == "1/2/2007" | dfepower$Date == "2/2/2007", ]
## Merge the Date and Time columns to prepare to convert to POSIX type
dfdays <- mutate(dfdays, date.time = paste(Date, Time))
## Use the strptime function to convert to POSIXlt data type
dfdays$date.time <- strptime(dfdays$date.time, "%d/%m/%Y %H:%M:%S")
## Plot 4
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2), mar = c(5, 4, 4, 1))
with(dfdays, {
      plot(dfdays$date.time, dfdays$Global_active_power, 
           type = "l", 
           xlab = "", 
           ylab = "Global Active Power");
      plot(dfdays$date.time, dfdays$Voltage, 
           type = "l", 
           xlab = "datetime", 
           ylab = "Voltage");
      plot(dfdays$date.time, dfdays$Sub_metering_1, type = "l", col = "black",
           xlab = "", 
           ylab = "Energy sub metering")
      lines(dfdays$date.time, dfdays$Sub_metering_2, 
            type = "l", 
            col = "red")
      lines(dfdays$date.time, dfdays$Sub_metering_3, 
            type = "l", 
            col = "blue")
      legend("topright", 
             lty = 1,
             bty = "n",
             col = c("black", "red", "blue"), 
             legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"));
      plot(dfdays$date.time, dfdays$Global_reactive_power, 
           type = "l", 
           xlab = "datetime",
           ylab = "Global_reactive_power")
})
dev.off()
