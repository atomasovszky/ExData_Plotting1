
# READ DATA -------------------------------------------------------------------------------------------------------

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!dir.exists("data")) dir.create("data")
if (!file.exists("data/data.zip")) download.file(url, "data/data.zip")
unzip("data/data.zip", exdir = "data")
data <- read.csv("data/household_power_consumption.txt", sep = ";", stringsAsFactors = F)



# FILTERING DATA --------------------------------------------------------------------------------------------------

data$datetime <- as.POSIXct(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S", tz = "UTC")
data <- data[data$datetime >= "2007-02-01 00:00:00" & data$datetime < "2007-02-03 00:00:00", ]



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
