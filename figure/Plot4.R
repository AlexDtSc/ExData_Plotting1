###############################
########## General steps for all Plots
###############################

setwd("D:/Data Science/coursera_courses/4_Exploratory_data_analysis/week 1/project")

## Download and uzip file
if(!file.exists("household_power_consumption.zip")) 
{download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
               destfile = "household_power_consumption.zip", mode = "wb")}

if(!file.exists("household_power_consumption.txt"))
{unzip("household_power_consumption.zip")}

## Check the size of file to be loaded in R
object.size("household_power_consumption.txt")


## Read the file
library(data.table)
household_power_consumption <- fread("household_power_consumption.txt", header = TRUE, sep =";", na.strings = "?")

head(household_power_consumption)
View(household_power_consumption)
str(household_power_consumption)

## Define the classes of Date and Time columns 
class(household_power_consumption$Date)
# [1] "character"

class(household_power_consumption$Time)
# [1] "character"


################################
#### For Plot ¹ 2 (plot A)
###############################


####### Add a column with concatenated Date and time
DateTime <- strptime(paste(household_power_consumption$Date, household_power_consumption$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
household_power_consumption_2 <- cbind(household_power_consumption, DateTime)

View(household_power_consumption_2)
class(household_power_consumption_2$DateTime)
# [1] "POSIXct" "POSIXt"  # Time format for column DateTime 

#### transforming columns Date from character into date and Time into time
household_power_consumption_2$Date <- as.Date(household_power_consumption_2$Date, format="%d/%m/%Y")
household_power_consumption_2$Time <- format(household_power_consumption_2$Time, format="%H:%M:%S")


class(household_power_consumption_2$Date)
# [1] "Date"
class(household_power_consumption_2$Time)
# [1] "character"


## Subset data.frame only with necessary dates  2007-02-01, 2007-02-02
household_power_consumption_2.1 <- subset(household_power_consumption_2, Date == "2007-02-01" | Date == "2007-02-02")
table(household_power_consumption_2.1$Date)


### Plot 2 building (Plot A)
A <- with(household_power_consumption_2.1, plot(DateTime, Global_active_power, type="l", xlab = " ", ylab="Global Active Power (kilowatts)"))



###############################################
####### For Plot ¹ 3 (Plot B)
###############################################

####### Add a column with concatenated Date and time 
DateTime <- strptime(paste(household_power_consumption$Date, household_power_consumption$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
household_power_consumption_3 <- cbind(household_power_consumption, DateTime)

View(household_power_consumption_3)
class(household_power_consumption_3$DateTime)
# [1] "POSIXct" "POSIXt"  # Time format for column DateTime 

#### transforming columns Date from character into date and Time into time
household_power_consumption_3$Date <- as.Date(household_power_consumption_2$Date, format="%d/%m/%Y")
household_power_consumption_3$Time <- format(household_power_consumption_2$Time, format="%H:%M:%S")


class(household_power_consumption_3$Date)
# [1] "Date"
class(household_power_consumption_3$Time)
# [1] "character"


## Subset data.frame only with necessary dates  2007-02-01, 2007-02-02
household_power_consumption_3.1 <- subset(household_power_consumption_3, Date == "2007-02-01" | Date == "2007-02-02")
table(household_power_consumption_3.1$Date)


##### Plot 3 building (Plot B)

# type = "n" means that we don't build graphs, just making preparations
# lines() means that we have to plot() graphs according to preparations made
# legend () gives an explanation about the data on the plot


B <- with(household_power_consumption_3.1, 
     { plot(DateTime, Sub_metering_1, type = "n", col = "black", xlab = " ", ylab = "Energy sub metering", ylim = c(0,40))
         plot(DateTime, Sub_metering_2, type = "n", col = "red", xlab = " ", ylab = "Energy sub metering", ylim = c(0,40))
         plot(DateTime, Sub_metering_3, type = "n", col = "blue", xlab = " ", ylab = "Energy sub metering", ylim = c(0,40))
         
         lines(DateTime, Sub_metering_1, col = "black", xlab = " ", ylab = "Energy sub metering", ylim = c(0,40))
         lines(DateTime, Sub_metering_2, col = "red", xlab = " ", ylab = "Energy sub metering", ylim = c(0,40))
         lines(DateTime, Sub_metering_3, col = "blue", xlab = " ", ylab = "Energy sub metering", ylim = c(0,40))
         
         legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                lty = 1, col = c("black", "red", "blue"))
     })




###########################
#### For plot ¹ 4 (Plot C)
###########################

household_power_consumption_4.1 <- household_power_consumption_3.1

identical(household_power_consumption_3.1, household_power_consumption_4.1)
# [1] TRUE - whether both datasets are identical


##### Plot 4 building (Plot C)
C <- with(household_power_consumption_4.1, plot(DateTime, Voltage, xlab  = "datetime", type = "l"))


###########################
#### For plot ¹ 5 (Plot D)
###########################

household_power_consumption_5.1 <- household_power_consumption_4.1

identical(household_power_consumption_4.1, household_power_consumption_5.1)
# [1] TRUE - whether both datasets are identical


##### Plot 5 building (Plot D)
D <- with(household_power_consumption_5.1, plot(DateTime, Global_reactive_power, xlab  = "datetime", type = "l"))



################################################
###### Let's asssociate all plots (A,B,C,D) in one solid graph
################################################


par(mfcol = c(2,2))

A <- with(household_power_consumption_2.1, plot(DateTime, Global_active_power, type="l", xlab = " ", ylab="Global Active Power"))

B <- plot(household_power_consumption_3.1$DateTime, household_power_consumption_3.1$Sub_metering_1, 
          type = "n", col = "black", xlab = " ", ylab = "Energy sub metering", ylim = c(0,40))
            
     with(household_power_consumption_3.1, lines(DateTime, Sub_metering_1, col = "black"))
     with(household_power_consumption_3.1, lines(DateTime, Sub_metering_2, col = "red"))
     with(household_power_consumption_3.1, lines(DateTime, Sub_metering_3, col = "blue"))
            
     legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))
          
     
C <- with(household_power_consumption_4.1, plot(DateTime, Voltage, xlab  = "datetime", type = "l"))
D <- with(household_power_consumption_5.1, plot(DateTime, Global_reactive_power, xlab  = "datetime", type = "l"))

dev.copy(png, "plot4.png")
dev.off()
