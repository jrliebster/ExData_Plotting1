# Loading the dataless 
# When loading the dataset into R, please consider the following:
#     
#     The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate of how much memory the dataset will require in memory before reading into R. Make sure your computer has enough memory (most modern computers should be fine).
# We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.
# You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime()  and as.Date() functions.
# Note that in this dataset missing values are coded as ?.

library(ggplot2, lattice)

power_data = read.table("household_power_consumption.txt",header=TRUE, na.strings="?", sep=";")
power_data <- power_data[(power_data$Date=="1/2/2007" | power_data$Date=="2/2/2007" ), ]

# convert date to as.Date class and date and time to posixct
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")
dateTime <- paste(power_data$Date, power_data$Time)
power_data$DateTime <- as.POSIXct(dateTime)


# 4 figures arranged in 2 rows and 2 columns
# same sub metering and global active power over days plots
# plus 2: voltage over datetime and global reactive power over datetime

attach(power_data)
par(mfrow=c(2,2))
plot(power_data$Global_active_power ~ power_data$DateTime, type="l", ylab="Global Active Power", xlab="")
plot(power_data$Voltage ~ power_data$DateTime, type="l", ylab="Voltage", xlab="datetime")
with(power_data, {
    plot(Sub_metering_1~DateTime, type="l",
         ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2~DateTime, col='Red')
    lines(Sub_metering_3~DateTime, col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(power_data$Global_reactive_power~ power_data$DateTime, type="l", ylab="Global_reactive_power", xlab="datetime")

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()  
