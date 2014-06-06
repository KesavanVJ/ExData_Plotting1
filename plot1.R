library(data.table)
library(sqldf)

datafile4_1 <- file("household_power_consumption.txt")
attr(datafile4_1, "file.format") <- list(header=T, row.names=F, sep=";")

df4_1_1 <- sqldf("select * from datafile4_1 where Date = '1/2/2007' or Date = '2/2/2007'", 
              stringsAsFactors = F)

close(datafile4_1)

df4_1_1$Date <- as.Date(df4_1_1$Date, format = "%d/%m/%Y")
df4_1_1$Global_active_power <- as.numeric(df4_1_1$Global_active_power)

png(filename = "figure/plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA)

hist(df4_1_1$Global_active_power, freq = 200, col = "red",
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")

dev.off()