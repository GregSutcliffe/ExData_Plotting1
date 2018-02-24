# Variables
download_url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
target_file <- './power_data.zip'

# Only download file once
if (!file.exists(target_file)) {
    download.file(download_url,target_file)
}

# Load file, subset of 01/02/2007 -> 02/02/2007, set headers
data <- read.table(
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

# Open PNG
png(file = "plot1.png", width = 480, height = 480)
    
# Set up par needs
par(mfrow = c(1,1))

# Draw histogram
hist(data$Global.Active.Power,
     main = 'Global Active Power',
     xlab = 'Global Active Power (kilowatts)',
     col = 'red'
)

# Close PNG
dev.off()