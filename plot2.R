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
sDF$Date <- strptime(paste(sDF$Date, sDF$Time), format("%d/%m/%Y %H:%M:%S"))
sDF$Time <- NULL
#
#png("plot2.png")
par(mar = c(4,6,4,2))
plot(y = sDF$Global_active_power, x = sDF$Date, type="l",
         ylab="Global active power (kilowatts)", xlab="")
#dev.off()
