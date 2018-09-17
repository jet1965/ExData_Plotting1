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
    
    # Plot PNG graphic # 3
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
           col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           lwd = 1,
           inset = c(0.1,0),
           bty = "n")
    
    # Save to 480 x 480 .png file
    dev.copy(png, file = "plot3.png", width = 480, height = 480)    
    dev.off()
}
