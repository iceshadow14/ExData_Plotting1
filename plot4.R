# set Aspects of the Locale
Sys.setlocale(category = "LC_ALL", locale = "English_United States.1252")

# load data
if(!file.exists("PowerData.zip")) {
  fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL,"PowerData.zip")
  unzip("PowerData.zip")
}

# read data
data <- read.csv("household_power_consumption.txt", sep = ";")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# filter data
data <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
dateTime <- paste(data$Date, data$Time)
data <- cbind(data, as.POSIXct(dateTime))
names(data)[ncol(data)] <- "datetime"

# set layouts
par(mfrow = c(2,2))

# left top
plot(x = data$datetime, y = data$Global_active_power, type = "l", col = "black", xlab = "", ylab = "Global Active Power")

# right top
plot(x = data$datetime, y = data$Voltage, type = "l", col = "black", xlab = "datetime", ylab = "Voltage")

# left bottom
plot(x = data$datetime, y = data$Sub_metering_1, type = "l", col = "black", xlab = "" , ylab = "Energy sub metering")
lines(x = data$datetime, y = data$Sub_metering_2, type = "l", col = "red")
lines(x = data$datetime, y = data$Sub_metering_3,  type = "l", col = "blue")
legend("topright", legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd = 1, bty = "n",  col = c("black", "red", "blue"))

# right bottom
plot(x = data$datetime, y = data$Global_reactive_power, type = "l", col = "black", xlab = "datetime", ylab = "Global_reactive_power")

# write to png
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
