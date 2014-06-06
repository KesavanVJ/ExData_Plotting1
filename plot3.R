## Load data.table and sqldf libraries
library(data.table)
library(sqldf)

# Initialize Data File & Set file attributes - Header, Column separator
datafile4_1 <- file("household_power_consumption.txt")
attr(datafile4_1, "file.format") <- list(header=T, row.names=F, sep=";")

# Using SQL read only data for Feb 1 & 2 2007 (2 Days)
df4_1_3 <- sqldf("select * from datafile4_1 where Date = '1/2/2007' or Date = '2/2/2007'", 
                 stringsAsFactors = F)

# Close the Data File 
close(datafile4_1)

# Co-erce Raw file data into appropriate Column types
df4_1_3$Date <- as.Date(df4_1_3$Date, format = "%d/%m/%Y")
df4_1_3$Sub_metering_1 <- as.numeric(df4_1_3$Sub_metering_1)
df4_1_3$Sub_metering_2 <- as.numeric(df4_1_3$Sub_metering_2)
df4_1_3$Sub_metering_3 <- as.numeric(df4_1_3$Sub_metering_3)
# Merge Date & Time to add a new column DT - co-erced as POSIXlt
df4_1_3 <- cbind(df4_1_3, 
                 DT = as.POSIXlt(paste(df4_1_3$Date, " ", df4_1_3$Time), 
                                 format = "%Y-%m-%d %H:%M:%S")
)

# Initialize Graphic Device (output) file under ./figure directory
png(filename = "figure/plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA)

# Plot a line graph w/o drawing the line 
plot(df4_1_3$DT, df4_1_3$Sub_metering_1, type = "n", 
     ylab = "Energy sub metering",
     xlab = "")
# Add lines to the plot for 3 differenct sub metering
lines(df4_1_3$DT, df4_1_3$Sub_metering_1, col = "black")
lines(df4_1_3$DT, df4_1_3$Sub_metering_2, col = "red")
lines(df4_1_3$DT, df4_1_3$Sub_metering_3, col = "blue")
# Add legend to differential sub meter by color
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lwd = 2, lty= c(1,1,1))

# Close the Graphic Device
dev.off()