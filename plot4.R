
 
file_path <- "C:/Bigdata/household_power_consumption.txt"


 
num_rows <- 2075259
num_cols <- 9
bytes_per_value <- 9
memory_estimate <- num_rows * num_cols * bytes_per_value / (1024^2)
cat("Estimated memory usage:", memory_estimate, "MB\n")

 
data <- read.table(file_path, sep=";", header=TRUE, na.strings="?", stringsAsFactors=FALSE)

 
str(data)

 
data$Datetime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

 
str(data)

 
filtered_data <- subset(data, as.Date(Datetime) >= as.Date("2007-02-01") & as.Date(Datetime) <= as.Date("2007-02-02"))

 
filtered_data$Global_active_power <- as.numeric(filtered_data$Global_active_power)
filtered_data$Global_reactive_power <- as.numeric(filtered_data$Global_reactive_power)
filtered_data$Voltage <- as.numeric(filtered_data$Voltage)
filtered_data$Sub_metering_1 <- as.numeric(filtered_data$Sub_metering_1)
filtered_data$Sub_metering_2 <- as.numeric(filtered_data$Sub_metering_2)
filtered_data$Sub_metering_3 <- as.numeric(filtered_data$Sub_metering_3)

 
filtered_data <- na.omit(filtered_data)

png("plot4.png", width=480, height=480)

par(mfrow=c(2, 2))


plot(filtered_data$Datetime, filtered_data$Global_active_power, type="l", col="blue",
     xlab="Datetime", ylab="Global Active Power (kilowatts)",
     main="Global Active Power Over Time")


plot(filtered_data$Datetime, filtered_data$Voltage, type="l", col="green",
     xlab="Datetime", ylab="Voltage (volts)",
     main="Voltage Over Time")


plot(filtered_data$Datetime, filtered_data$Sub_metering_1, type="l", col="black",
     xlab="Datetime", ylab="Energy Sub Metering",
     main="Energy Sub Metering Over Time")
lines(filtered_data$Datetime, filtered_data$Sub_metering_2, col="red")
lines(filtered_data$Datetime, filtered_data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1, cex=0.8)


plot(filtered_data$Datetime, filtered_data$Global_reactive_power, type="l", col="purple",
     xlab="Datetime", ylab="Global Reactive Power (kilowatts)",
     main="Global Reactive Power Over Time")

dev.off()