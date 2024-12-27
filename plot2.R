
 
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
png("plot2.png", width=480, height=480)
#filtered_data$DayOfWeek <- weekdays(as.Date(filtered_data$Datetime))
plot(filtered_data$Datetime, filtered_data$Global_active_power, type="l", col="blue",
     xlab="Datetime", ylab="Global Active Power (kilowatts)",
     main="Global Active Power Over Time")
dev.off()
 