plot1 <- function(){
    # Downlpad and unzip the file.
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "hpc.zip")
    unzip(zipfile = "hpc.zip")
    
    # Read the .txt file into a data table and subset it to the dates we'll use.
    hpc_df <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
    hpc_df <- hpc_df[hpc_df$Date %in% c("1/2/2007", "2/2/2007"), ]
    
    #Add column to consolidate Date an Time and format it as POSIXct
    hpc_df$Newdate <- paste(hpc_df$Date, hpc_df$Time)
    hpc_df$Newdate <- as.POSIXct(hpc_df$Newdate, format = "%d/%m/%Y %H:%M:%S")
    
    # Plot PNG graphic # 4
    par(mar = c(4,4,3,2), oma = c(1,1,1,1), mfrow = c(2,2))
    plot(hpc_df$Newdate, hpc_df$Global_active_power, type = "l", 
         lwd = 1.5, 
         xlab = "",
         ylab = "Global Active Power")
    plot(hpc_df$Newdate, hpc_df$Voltage, type = "l", 
         lwd = 1.5, 
         xlab = "datetime",
         ylab = "Voltage")
    plot(hpc_df$Newdate, hpc_df$Sub_metering_1, 
         type = "l", 
         col = "black",
         xlab = "",
         ylab = "Energy sub metering")
    points(hpc_df$Newdate, hpc_df$Sub_metering_2, 
           type = "l", 
           col = "red")
    points(hpc_df$Newdate, hpc_df$Sub_metering_3, 
           type = "l", 
           col = "blue")
    legend("topright", 
           bty = "n",
           col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           lwd = 1,
           inset = c(0.15, 0))
    plot(hpc_df$Newdate, hpc_df$Global_reactive_power, type = "l", 
         lwd = 1.5,
         xlab = "datetime",
         ylab = "Global_reactive_power")
    
    # Save to 480 x 480 .png file
    dev.copy(png, file = "plot4.png", width = 480, height = 480)    
    dev.off()
}
