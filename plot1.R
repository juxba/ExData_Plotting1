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
             (as.Date(Dates) >= limits[1]) & (as.Date(Dates) <= limits[2]))
#
for ( i in seq(2, 8)) DF[[i]] <- as.numeric(DF[[i]])
#
png("plot1.png")
with(DF, {
        par(mar = c(2,6,2,2))
        hist(Global_active_power, breaks=15, col="red",
            xlab="Global active power (kilowatts)",
            main = "Global active power")
    })
dev.off()
