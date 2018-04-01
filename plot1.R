
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
