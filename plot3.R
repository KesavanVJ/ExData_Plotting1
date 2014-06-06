library(data.table)
library(sqldf)

datafile4_1 <- file("household_power_consumption.txt")
attr(datafile4_1, "file.format") <- list(header=T, row.names=F, sep=";")

df4_1_3 <- sqldf("select * from datafile4_1 where Date = '1/2/2007' or Date = '2/2/2007'", 
                 stringsAsFactors = F)

close(datafile4_1)

df4_1_3$Date <- as.Date(df4_1_3$Date, format = "%d/%m/%Y")
df4_1_3$Sub_metering_1 <- as.numeric(df4_1_3$Sub_metering_1)
df4_1_3$Sub_metering_2 <- as.numeric(df4_1_3$Sub_metering_2)
df4_1_3$Sub_metering_3 <- as.numeric(df4_1_3$Sub_metering_3)
df4_1_3 <- cbind(df4_1_3, 
                 DT = as.POSIXlt(paste(df4_1_3$Date, " ", df4_1_3$Time), 
                                 format = "%Y-%m-%d %H:%M:%S")
)

png(filename = "figure/plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA)

plot(df4_1_3$DT, df4_1_3$Sub_metering_1, type = "n", 
     ylab = "Energy sub metering",
     xlab = "")
lines(df4_1_3$DT, df4_1_3$Sub_metering_1, col = "black")
lines(df4_1_3$DT, df4_1_3$Sub_metering_2, col = "red")
lines(df4_1_3$DT, df4_1_3$Sub_metering_3, col = "blue")

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lwd = 2, lty= c(1,1,1))
## TO DO - Write the plot to plot3.png (480x480) w/ appropriate margins
dev.off()