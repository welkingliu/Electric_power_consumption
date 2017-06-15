library(lubridate)

original <- read.table("D:\\coursera\\proj4\\household_power_consumption.txt",header = TRUE,sep=";")
original$Datetime <- paste(original$Date, original$Time, seq = " ")
original$Datetime <- strptime(original$Datetime, "%d/%m/%Y %H:%M:%S")

using <- subset(original, Datetime >= as.Date("2007-02-01") & Datetime <= as.Date("2007-02-03"))
str(using)
names(using)

using$Global_active_power <- as.numeric(as.character(using$Global_active_power))
setwd("D:\\coursera\\proj4")
png("plot1.png", width = 480, height = 480)
with(using, hist(Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", 
                 main = "Global Active Power"))
dev.off()

png("plot2.png", width = 480, height = 480)
with(using, plot(Datetime, Global_active_power,
                 type = "l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()

png("plot3.png", width = 480, height = 480)
using$Sub_metering_1 <- as.numeric(as.character(using$Sub_metering_1))
using$Sub_metering_2 <- as.numeric(as.character(using$Sub_metering_2))
with(using, plot(Datetime, Sub_metering_1, type = "l", xlab = "", col = "black",
                 ylab = "Energy sub metering", ylim = c(0,40)))
lines(using$Datetime, using$Sub_metering_2, col = "red")
lines(using$Datetime, using$Sub_metering_3, col = "blue")
legend("topright", legend =  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = "solid", col = c("black","red","blue"))
dev.off()

png("plot4.png", width = 480, height = 480)
using$Voltage <- as.numeric(as.character(using$Voltage))
using$Global_reactive_power <- as.numeric(as.character(using$Global_reactive_power))
par(mfrow = c(2,2))
with(using, plot(Datetime, Global_active_power,
                 type = "l", xlab="", ylab="Global Active Power"))
with(using, plot(Datetime, Voltage,
                 type = "l", xlab="datetime", ylab="Voltage"))
with(using, plot(Datetime, Sub_metering_1, type = "l", xlab = "", col = "black",
                 ylab = "Energy sub metering", ylim = c(0,40)))
lines(using$Datetime, using$Sub_metering_2, col = "red")
lines(using$Datetime, using$Sub_metering_3, col = "blue")
legend("topright", legend =  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = "solid", col = c("black","red","blue"))
with(using, plot(Datetime, Global_reactive_power, ylab = "Global_reactive_power", 
                 xlab = "datetime", type = "l"))
dev.off()