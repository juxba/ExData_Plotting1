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
st <- strptime(paste(DF$Date, DF$Time), format("%d/%m/%Y %H:%M:%S"))
# > class(st)
# [1] "POSIXlt" "POSIXt"
DF <- DF[, 3:9]     # Eliminate Date and Time columns
DF <- data.frame(Dates = st, DF)    # add Dates column to DF
#
# Extract subset of DT for plotting
DF = subset(DF,
            (as.Date(DF$Dates) == as.Date("2007-02-01"))
            | (as.Date(DF$Dates) == as.Date("2007-02-02"))
)
#
png("plot2.png")
par(mar = c(4,6,4,2))
plot(DF$Global_active_power ~ DF$Dates, type="l",
         ylab="Global active power (kilowatts)", xlab="")
dev.off()
