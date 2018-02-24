# Variables
download_url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
target_file <- './power_data.zip'

# Only download file once
if (!file.exists(target_file)) {
    download.file(download_url,target_file)
}

# Load file, subset of 01/02/2007 -> 02/02/2007, set headers
raw <- read.table(
    unz(target_file, "household_power_consumption.txt"),
    skip=66637, nrows=2880, header=F, sep=";",
    col.names=c(
        'Date',
        'Time',
        'Global Active Power',
        'Global Reactive Power',
        'Voltage',
        'Global Intensity',
        'Sub-metering 1',
        'Sub-metering 2',
        'Sub-metering 3'
    )
)

# Create DateTime column to plot on
library(dplyr)
library(lubridate)

# Load file, subset of 01/02/2007 -> 02/02/2007, set headers
data <- as_tibble(raw) %>%
    mutate(DateTime = dmy_hms(paste(as.character(raw$Date),
                                    as.character(raw$Time))
                              )
           )
# Open PNG
png(file = "plot4.png", width = 480, height = 480)

# Set up par needs
par(mfrow = c(2,2))

# Global Active Power (as per plot 2)
plot(x = data$DateTime, y=data$Global.Active.Power,
     type = 'l', xlab = '', ylab = 'Global Active Power'
)

# Voltage
plot(x = data$DateTime, y=data$Voltage,
     type = 'l', xlab = 'datetime', ylab = 'Voltage'
)

# Sub metering (as per plot 3)
plot(x = data$DateTime, y=data$Sub.metering.1,
     xlab = '', ylab = 'Energy sub metering',
     type = 'n'
)
points(x=data$DateTime,y=data$Sub.metering.1,type='l',col='black')
points(x=data$DateTime,y=data$Sub.metering.2,type='l',col='red')
points(x=data$DateTime,y=data$Sub.metering.3,type='l',col='blue')
legend('topright',
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col = c('black', 'red', 'blue'), lty = 1
)

# Global reactive power
# Voltage
plot(x = data$DateTime, y=data$Global.Reactive.Power,
     type = 'l', xlab = 'datetime', ylab = 'Global_reactive_power'
)

# Close PNG
dev.off()