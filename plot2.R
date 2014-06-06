## Load data.table and sqldf libraries
library(data.table)
library(sqldf)

# Initialize Data File & Set file attributes - Header, Column separator
datafile4_1 <- file("household_power_consumption.txt")
attr(datafile4_1, "file.format") <- list(header=T, row.names=F, sep=";")

# Using SQL read only data for Feb 1 & 2 2007 (2 Days)
df4_1_2 <- sqldf("select * from datafile4_1 where Date = '1/2/2007' or Date = '2/2/2007'", 
               stringsAsFactors = F)

# Close the Data File
close(datafile4_1)

# Co-erce Raw file data into appropriate Column types
df4_1_2$Date <- as.Date(df4_1_2$Date, format = "%d/%m/%Y")
df4_1_2$Global_active_power <- as.numeric(df4_1_2$Global_active_power)
# Merge Date & Time to add a new column DT - co-erced as POSIXlt
df4_1_2 <- cbind(df4_1_2, 
                 DT = as.POSIXlt(paste(df4_1_2$Date, " ", df4_1_2$Time), 
                                format = "%Y-%m-%d %H:%M:%S")
                )

# Initialize Graphic Device (output) file under ./figure directory
png(filename = "figure/plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA)

# Plot a line graph w/ Y axis label
plot(df4_1_2$DT, df4_1_2$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

# Close the Graphic Device
dev.off()