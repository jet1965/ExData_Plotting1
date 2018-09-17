plot1 <- function(){
    # Downlpad and unzip the file.
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "hpc.zip")
    unzip(zipfile = "hpc.zip")
    
    # Read the .txt file into a data table, subset it to the dates we'll use, and format the date and time columns.
    hpc_df <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
    hpc_df <- hpc_df[hpc_df$Date %in% c("1/2/2007", "2/2/2007"), ]
    hpc_df$Date <- strptime(hpc_df$Date, "%d/%m/%Y")
    hpc_df$Time <- strptime(hpc_df$Time, "%H:$M:$S")
    
    # Plot PNG graphic # 1
    hist(hpc_df$Global_active_power, col = "red", 
         xlab = "Global Active Power (kilowatts)",
         ylab = "Frequency",
         main = "Global Active Power")

    # Save to 480 x 480 .png file
    dev.copy(png, file = "plot1.png", width = 480, height = 480)    
    dev.off()
}
