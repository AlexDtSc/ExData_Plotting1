
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


### Plot 2

png("plot2.png", width=480, height=480)
with(household_power_consumption_2.1, plot(DateTime, Global_active_power, type="l", xlab = " ", ylab="Global Active Power (kilowatts)"))
dev.off()

     #### Important comments

  # I have ticks of x-axis in the form of "×ò", "Ïò", "Ñá" instead of "Thu", "Fri", "Sat", because I am from eastern slavic country, where
# we use Cyrillic orthography, but not Latin orthography and therefore my default RStudio settings give such result.



