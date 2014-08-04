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
sDF = subset(DF, Date == '1/2/2007' | Date == '2/2/2007')
#
sDF$Date <- strptime(paste(sDF$Date, sDF$Time), format("%d/%m/%Y %H:%M:%S"))
sDF$Time <- NULL
#
#
#png("plot3.png")
par(mar = c(4,6,4,2))
plot(sDF$Date, sDF$Sub_metering_1, type="l", ylab="Energy sub metering", xaxt="n")
lines(sDF$Date, sDF$Sub_metering_2, type="l", col="red")
lines(sDF$Date, sDF$Sub_metering_3, type="l", col="blue")
legend("topright", lty=1, col = c("black", "red", "blue"),
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#dev.off()
