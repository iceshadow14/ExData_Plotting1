# set Aspects of the Locale 
Sys.setlocale(category = "LC_ALL", locale = "English_United States.1252")

# load data
if(!file.exists("PowerData.zip")) {
  fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL,"PowerData.zip")
  unzip("PowerData.zip")
}

# read data
data <- read.csv("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# filter data
data <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
dateTime <- paste(data$Date, data$Time)
data <- cbind(data, as.POSIXct(dateTime))
names(data)[ncol(data)] <- "datetime"

# plot histogram
hist(as.numeric(data$Global_active_power), main = "Global Active Power", xlab = "Global active power (kilowatts)", col = "red")

# write hist to png file
dev.copy(png, filename="plot1.png", height=480, width=480)
dev.off ()
