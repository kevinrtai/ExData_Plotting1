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
png(filename='plot3.png')

# Generate the sub metering plot
plot(x=power$date_time, y=power$Sub_metering_1, type='l', col='black', 
     ylab='Energy sub metering', xlab='')
lines(x=power$date_time, y=power$Sub_metering_2, col='red')
lines(x=power$date_time, y=power$Sub_metering_3, col='blue')
legend(x='topright', 
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       col=c('black', 'red', 'blue'), lty=c(1, 1, 1))


# Save the plot to disk as 'plot1.png'
dev.off()