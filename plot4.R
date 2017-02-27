master <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

master$Date <- as.Date(master$Date, format = "%d/%m/%Y")

data <- master[(master$Date == "2007-02-01") | (master$Date == "2007-02-02"), ]

data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))

data$Voltage <- as.numeric(as.character(data$Voltage))

data$Global_intensity <- as.numeric(as.character(data$Global_intensity))

data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))

data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))

data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))

data <- transform(data, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

par(mfrow = c(2, 2))

plot(
    data$timestamp,
    data$Global_active_power, 
    type="l", 
    xlab="", 
    ylab="Global Active Power (kilowatts)"
    )

plot(
    data$timestamp,
    data$Voltage, 
    type="l", 
    xlab="datetime", 
    ylab="Voltage"
    )

plot(
    data$timestamp,
    data$Sub_metering_1, 
    type="l", 
    xlab="", 
    ylab="Energy sub metering"
    )

lines(data$timestamp, data$Sub_metering_2, col = "red")

lines(data$timestamp, data$Sub_metering_3, col = "blue")

legend(
    "topright",
    col = c("black", "red", "blue"),
    c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    lty = c(1, 1, 1),
    lwd = c(1, 1, 1),
    bty = "n",
    cex = .5
    )

plot(
    data$timestamp,
    data$Global_reactive_power, 
    type="l", 
    xlab="datetime", 
    ylab="Global_reactive_power"
    )

dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()