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

# use plot to create graph of relatonship between Global Active Power (y lab) and datetime (x lab)
plot(power_data$Global_active_power ~ power_data$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

# create png file 480x480
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off() 