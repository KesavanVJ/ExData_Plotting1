library(data.table)
library(sqldf)

datafile4_1 <- file("household_power_consumption.txt")
attr(datafile4_1, "file.format") <- list(header=T, row.names=F, sep=";")

df4_1_2 <- sqldf("select * from datafile4_1 where Date = '1/2/2007' or Date = '2/2/2007'", 
               stringsAsFactors = F)

close(datafile4_1)

df4_1_2$Date <- as.Date(df4_1_2$Date, format = "%d/%m/%Y")
df4_1_2$Global_active_power <- as.numeric(df4_1_2$Global_active_power)
df4_1_2 <- cbind(df4_1_2, 
                 DT = as.POSIXlt(paste(df4_1_2$Date, " ", df4_1_2$Time), 
                                format = "%Y-%m-%d %H:%M:%S")
                )

png(filename = "figure/plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA)

plot(df4_1_2$DT, df4_1_2$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)",
     xlab = "")


## TO DO - Write the plot to plot2.png (480x480) w/ appropriate margins
dev.off()