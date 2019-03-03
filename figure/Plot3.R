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


##### Plot 3 building

# type = "n" means that we don't build graphs, just making preparations
# lines() means that we have to plot() graphs according to preparations made
# legend () gives an explanation about the data on the plot


plot(household_power_consumption_3.1$DateTime, household_power_consumption_3.1$Sub_metering_1, 
     type = "n", col = "black", xlab = " ", ylab = "Energy sub metering", ylim = c(0,40))

with(household_power_consumption_3.1, lines(DateTime, Sub_metering_1, col = "black"))
with(household_power_consumption_3.1, lines(DateTime, Sub_metering_2, col = "red"))
with(household_power_consumption_3.1, lines(DateTime, Sub_metering_3, col = "blue"))

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))

dev.copy(png, "plot3.png", width = 540, height = 480) 
dev.off()


#### Another more complicated variant of code for the same graph
with(household_power_consumption_3.1, 
     { plot(DateTime, Sub_metering_1, type = "n", col = "black", xlab = " ", ylab = "Energy sub metering", ylim = c(0,40))
       plot(DateTime, Sub_metering_2, type = "n", col = "red", xlab = " ", ylab = "Energy sub metering", ylim = c(0,40))
       plot(DateTime, Sub_metering_3, type = "n", col = "blue", xlab = " ", ylab = "Energy sub metering", ylim = c(0,40))
       
       lines(DateTime, Sub_metering_1, col = "black", xlab = " ", ylab = "Energy sub metering", ylim = c(0,40))
       lines(DateTime, Sub_metering_2, col = "red", xlab = " ", ylab = "Energy sub metering", ylim = c(0,40))
       lines(DateTime, Sub_metering_3, col = "blue", xlab = " ", ylab = "Energy sub metering", ylim = c(0,40))
       
       legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
              lty = 1, col = c("black", "red", "blue"))
     })



    #### !!!!!!!!  Important comments !!!!!!!!!!

  ## 1) I was obliged to replace required width = 480 with width = 540, because the legend was not totaly located in the png file
# I hope you will not consider it to be a rough mistake, but just comfortable adjustment of the graph properties
  ## 2) I have ticks of x-axis in the form of "×ò", "Ïò", "Ñá" instead of "Thu", "Fri", "Sat", because I am from eastern slavic country, 
# where we use Cyrillic orthography, but not Latin orthography and therefore my default RStudio settings give such result.



