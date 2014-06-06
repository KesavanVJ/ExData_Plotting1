## Load data.table and sqldf libraries
library(data.table)
library(sqldf)

# Initialize Data File & Set file attributes - Header, Column separator
datafile4_1 <- file("household_power_consumption.txt")
attr(datafile4_1, "file.format") <- list(header=T, row.names=F, sep=";")

# Using SQL read only data for Feb 1 & 2 2007 (2 Days)
df4_1_4 <- sqldf("select * from datafile4_1 where Date = '1/2/2007' or Date = '2/2/2007'", 
                 stringsAsFactors = F)

# Close the Data File 
close(datafile4_1)

# Co-erce Raw file data into appropriate Column types
df4_1_4$Date <- as.Date(df4_1_4$Date, format = "%d/%m/%Y")
df4_1_4$Global_active_power <- as.numeric(df4_1_4$Global_active_power)
df4_1_4$Global_reactive_power <- as.numeric(df4_1_4$Global_reactive_power)
df4_1_4$Voltage <- as.numeric(df4_1_4$Voltage)
df4_1_4$Sub_metering_1 <- as.numeric(df4_1_4$Sub_metering_1)
df4_1_4$Sub_metering_2 <- as.numeric(df4_1_4$Sub_metering_2)
df4_1_4$Sub_metering_3 <- as.numeric(df4_1_4$Sub_metering_3)
# Merge Date & Time to add a new column DT - co-erced as POSIXlt
df4_1_4 <- cbind(df4_1_4, 
                 DT = as.POSIXlt(paste(df4_1_4$Date, " ", df4_1_4$Time), 
                                 format = "%Y-%m-%d %H:%M:%S")
                )

# Initialize Graphic Device (output) file under ./figure directory
png(filename = "figure/plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA)

# Set Margins and divide plot area in 2 rows & 2 cols (mfrow)
par(mar = c(5,4,1,1))
par(mfrow = c(2,2))

#1 Global Active Power ~ DT
plot(df4_1_4$DT, df4_1_4$Global_active_power, type = "l", 
     cex.lab = "0.9", cex.axis = "0.8",
     ylab = "Global Active Power",
     xlab = "")

#2 Voltage ~ DT
plot(df4_1_4$DT, df4_1_4$Voltage, type = "l", 
     cex.lab = "0.9", cex.axis = "0.8",
     ylab = "Voltage",
     xlab = "datetime")

#3 Sub_metering (1,2,3) ~ DT
plot(df4_1_4$DT, df4_1_4$Sub_metering_1, type = "n", 
     cex.lab = "0.9", cex.axis = "0.8",
     ylab = "Energy sub metering",
     xlab = "")
lines(df4_1_4$DT, df4_1_4$Sub_metering_1, col = "black")
lines(df4_1_4$DT, df4_1_4$Sub_metering_2, col = "red")
lines(df4_1_4$DT, df4_1_4$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lwd = 1, lty= c(1,1,1), cex=0.8, bty = "n")

#4 Global Reactive Power ~ DT
plot(df4_1_4$DT, df4_1_4$Global_reactive_power, type = "l", 
     cex.lab = "0.9", cex.axis = "0.8",
     ylab = "Global_reactive_power",
     xlab = "datetime")

## Close the Graphic device
dev.off()