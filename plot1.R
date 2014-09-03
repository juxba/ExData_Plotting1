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
#png("plot1.png")
par(mar = c(6,6,4,2))
hist(sDF$Global_active_power, breaks=15, col="red",
     xlab="Global active power (kilowatts)", main = "Global active power")
#dev.off()