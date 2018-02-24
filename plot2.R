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
        'Global Intensity',
        'Voltage',
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
png(file = "plot2.png", width = 480, height = 480)

# Set up par needs
par(mfrow = c(1,1))

# Draw plot
plot(x = data$DateTime, y=data$Global.Active.Power,
     type = 'l', xlab = '', ylab = 'Global Active Power (kilowatts)'
     )

# Close PNG
dev.off()