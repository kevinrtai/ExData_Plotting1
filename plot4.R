# Import the lubridate package
library(lubridate)

# First read in the data from the current working directory
power <- read.table('household_power_consumption.txt', sep=';', skip=66637, nrows=2880)
headers <- read.table('household_power_consumption.txt', sep=';', nrows=1)
names(power) <-lapply(headers, as.character)
power$date_time <- dmy_hms(paste(as.character(power$Date), as.character(power$Time)))
power$Date <- as.Date(power$Date, '%d/%m/%Y')
power[power$Date == as.Date('2007-02-02') | power$Date == as.Date('2007-02-01'), ]

# Send to png device
png(filename='plot4.png')

# Create 4 subplots
par(mfcol=c(2, 2))

# Generate the Global Active Power timeseries plot
active <- as.numeric(power$Global_active_power)
plot(x=power$date_time, y=active, type='l', 
     ylab='Global Active Power', xlab='')

# Generate the sub metering plot 
plot(x=power$date_time, y=power$Sub_metering_1, type='l', col='black', 
     ylab='Energy sub metering', xlab='')
lines(x=power$date_time, y=power$Sub_metering_2, col='red')
lines(x=power$date_time, y=power$Sub_metering_3, col='blue')
legend(x='topright', 
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       col=c('black', 'red', 'blue'), lty=c(1, 1, 1), bty='n')

# Generate the Voltage plot
voltage <- as.numeric(power$Voltage)
plot(x=power$date_time, y=voltage, type='l',
     ylab='Voltage', xlab='datetime')

# Generate the Global reactive power plot
reactive <- as.numeric(power$Global_reactive_power)
plot(x=power$date_time, y=reactive, type='l',
     ylab='Global_reactive_power', xlab='datetime')

# Save the plot to disk as 'plot1.png'
dev.off()