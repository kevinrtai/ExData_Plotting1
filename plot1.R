# First read in the data from the current working directory
power <- read.table('household_power_consumption.txt', sep=';', skip=66637, nrows=2880)
headers <- read.table('household_power_consumption.txt', sep=';', nrows=1)
names(power) <-lapply(headers, as.character)
power$Date <- as.Date(power$Date, '%d/%m/%Y')
power[power$Date == as.Date('2007-02-02') | power$Date == as.Date('2007-02-01'), ]

# Send to png device
png(filename='plot1.png')

# Generate the Global Active Power plot
active <- as.numeric(power$Global_active_power)
hist(active, breaks=12, col='red', main='Global Active Power', 
     xlab='Global Active Power (kilowatts)')

# Save the plot to disk as 'plot1.png'
dev.off()