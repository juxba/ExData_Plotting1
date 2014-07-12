# Data in csv2 format
f <- "household_power_consumption.txt"
DF <- read.csv2(f, na.strings="?", stringsAsFactors=FALSE)
#
st <- strptime(paste(DF$Date, DF$Time), format("%d/%m/%Y %H:%M:%S"))
# > class(st)
# [1] "POSIXlt" "POSIXt"
DF <- DF[, 3:9]     # Eliminate Date and Time columns
DF <- data.frame(Dates = st, DF)    # add Dates column to DF
#
# Extract subset of DT for plotting
limits <- c("2007-02-01 00:00:00", "2007-02-02 00:00:00")
limits <- as.Date(strptime(limits, format("%Y-%m-%d %H:%M:%S")))
DF <- subset(DF,
             (as.Date(DF$Dates) >= limits[1]) & (as.Date(DF$Dates) <= limits[2]))
#
for ( i in seq(2, 8)) DF[[i]] <- as.numeric(DF[[i]])
#
png("plot4.png")
par(mfrow = c(2, 2), mar = c(4, 4, 1, 1))
with(DF, {
    # 1
    plot(Global_active_power ~ Dates, type="l",
         ylab="Global active power", xlab="")
    # 2
    plot(Voltage ~ Dates, type="l", ylab="Voltage", xlab="datetime")
    # 3
    {plot(Sub_metering_1 ~ Dates, type="l", ylab="Energy sub metering", xlab="")
     points(Dates, Sub_metering_2, type="l", col="red")
     points(Dates, Sub_metering_3, type="l", col="blue")
     legend("topright", lty=1, col = c("black", "blue", "red"),
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
            bty="n", cex=0.40)
        }
    # 4
    plot(Dates, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
    })
dev.off()