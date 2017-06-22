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

# Plot Submetering_1
plot(x=data$datetime, y=data$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")

# Plot sub_metering_2
lines(x=data$datetime, y=data$Sub_metering_2, type="l", col="red")

# Plot sub_metering_3
lines(x=data$datetime,y=data$Sub_metering_3,type="l", col="blue")

# add annotation
legend("topright", legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd=1, col=c("black", "red", "blue"))

# write png file
dev.copy(png, filename="plot3.png", width=480, height=480)
dev.off()
