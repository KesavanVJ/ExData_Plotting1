## Load data.table and sqldf libraries
library(data.table)
library(sqldf)

# Initialize Data File & Set file attributes - Header, Column separator
datafile4_1 <- file("household_power_consumption.txt")
attr(datafile4_1, "file.format") <- list(header=T, row.names=F, sep=";")

# Using SQL read only data for Feb 1 & 2 2007 (2 Days)
df4_1_1 <- sqldf("select * from datafile4_1 where Date = '1/2/2007' or Date = '2/2/2007'", 
              stringsAsFactors = F)

# Close the Data File 
close(datafile4_1)

# Co-erce Raw file data into appropriate Column types
df4_1_1$Date <- as.Date(df4_1_1$Date, format = "%d/%m/%Y")
df4_1_1$Global_active_power <- as.numeric(df4_1_1$Global_active_power)

# Initialize Graphic Device (output) file under ./figure directory
png(filename = "figure/plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA)

# Histogram w/ X axis label and Main Title
hist(df4_1_1$Global_active_power, freq = 200, col = "red",
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")

# Close the Graphic Device
dev.off()