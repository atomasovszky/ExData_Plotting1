
# READ DATA -------------------------------------------------------------------------------------------------------

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!dir.exists("data")) dir.create("data")
if (!file.exists("data/data.zip")) download.file(url, "data/data.zip")
unzip("data/data.zip", exdir = "data")
data <- read.csv("data/household_power_consumption.txt", sep = ";", stringsAsFactors = F)



# FILTERING DATA --------------------------------------------------------------------------------------------------

data$datetime <- as.POSIXct(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S", tz = "UTC")
data <- data[data$datetime >= "2007-02-01 00:00:00" & data$datetime < "2007-02-03 00:00:00", ]



# PLOT 1 ----------------------------------------------------------------------------------------------------------

data$Global_active_power <- as.numeric(data$Global_active_power)

png("plot1.png", width = 480, height = 480, units = "px")
hist(data$Global_active_power, 
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.off()



# PLOT 2 ----------------------------------------------------------------------------------------------------------

png("plot2.png", width = 480, height = 480, units = "px")
plot(data$datetime,
     data$Global_active_power,
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
dev.off()



# PLOT 3 ----------------------------------------------------------------------------------------------------------

png("plot3.png", width = 480, height = 480, units = "px")
plot(data$datetime,
     data$Sub_metering_1,
     type = "l",
     ylab = "Energy sub metering",
     xlab = "")
lines(data$datetime,data$Sub_metering_2, col = "red")
lines(data$datetime,data$Sub_metering_3, col = "blue")
legend(y = 40, x = 1900, 
       legend = paste0("Sub_metering_", 1:3),
       col = c("black", "red", "blue"),
       lty = rep(1, 3))
dev.off()



# PLOT 4 ----------------------------------------------------------------------------------------------------------

png("plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2))

hist(data$Global_active_power, 
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

plot(data$datetime,
     data$Voltage,
     type = "l",
     xlab = "",
     ylab = "Voltage")

plot(data$datetime,
     data$Sub_metering_1,
     type = "l",
     ylab = "Energy sub metering",
     xlab = "")
lines(data$datetime,data$Sub_metering_2, col = "red")
lines(data$datetime,data$Sub_metering_3, col = "blue")
legend(y = 40, x = 1900, 
       legend = paste0("Sub_metering_", 1:3),
       col = c("black", "red", "blue"),
       lty = rep(1, 3))

plot(data$datetime,
     data$Global_reactive_power,
     type = "l",
     xlab = "",
     ylab = "Global Reactive Power")

dev.off()




