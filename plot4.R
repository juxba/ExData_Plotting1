# Get the file if not already here
if (!file.exists("household_power_consumption.txt")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile = "hpc.zip", method = "wget")
    unzip("hpc.zip")
    file.remove("hpc.zip")
}
# Data in csv2 format
DF <- read.csv2("household_power_consumption.txt",
                colClasses=c(rep("character", 2), rep("numeric", 7)),
                na.strings="?", dec=".", stringsAsFactors=FALSE)
#
# Extract plotting subset
sDF = subset(DF, Date=='1/2/2007' | Date =='2/2/2007')
#
# Convert
sDF$Date <- strptime(paste(sDF$Date, sDF$Time), format("%d/%m/%Y %H:%M:%S"))
sDF$Time <- NULL
#
#png("plot4.png")
par(mfrow = c(2, 2), mar = c(4, 4, 1, 1))

    # 1
    plot(y = sDF$Global_active_power, x = sDF$Date, type="l",
         ylab="Global active power", xlab="")
    # 2
    plot(y = sDF$Voltage, x = sDF$Date, type="l", ylab="Voltage", xlab="datetime")
    # 3
    plot(y = sDF$Sub_metering_1, x = sDF$Date, type="l", ylab="Energy sub metering", xlab="")
    points(sDF$Date, sDF$Sub_metering_2, type="l", col="red")
    points(sDF$Date, sDF$Sub_metering_3, type="l", col="blue")
    legend("topright", lty=1, col = c("black", "blue", "red"),
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        bty="n", cex=0.60)
    # 4
    par(yaxs = "r")
    plot(sDF$Date, sDF$Global_reactive_power, type="l",
        ylab="Global_reactive_power", xlab="datetime")

#dev.off()
