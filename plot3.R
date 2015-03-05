## Read in the data
library(dplyr)
dfepower <- read.table("Exdata_data/household_power_consumption.txt", sep = ";",
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
## Plot 3
png(filename = "plot3.png", width = 480, height = 480)
plot(dfdays$date.time, dfdays$Sub_metering_1, type = "l", col = "black",
     xlab = "", 
     ylab = "Energy sub metering")
lines(dfdays$date.time, dfdays$Sub_metering_2, type = "l", col = "red")
lines(dfdays$date.time, dfdays$Sub_metering_3, type = "l", col = "blue")
legend("topright", 
       lty = 1, 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
