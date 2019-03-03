
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
household_power_consumption <- fread("household_power_consumption.txt", na.strings = "?")

head(household_power_consumption)
View(household_power_consumption)
str(household_power_consumption)

## Define the classes of Date and Time columns 
class(household_power_consumption$Date)
# [1] "character"

class(household_power_consumption$Time)
# [1] "character"



## Transform Date and Time columns into date and time formats
lct <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME", "C") # Get details and set aspects of the locale for the R process

household_power_consumption$Date <- as.Date(household_power_consumption$Date, "%d/%m/%Y")
class(household_power_consumption$Date)
# [1] "Date"


## Subset data.frame only with necessary dates  2007-02-01, 2007-02-02

library(lubridate)
a <- ymd("2007-02-01")
b <- ymd("2007-02-02")
a
class(a) # [1] "Date"
class(b) # [1] "Date"

household_power_consumption_1 <- subset(household_power_consumption, Date == a | Date == b)

View(household_power_consumption_1)
unique(household_power_consumption_1$Date)
table(household_power_consumption_1$Date)


# just another variant of subsetting - the result will be the same
household_power_consumption_1 <- subset(household_power_consumption, Date == "2007-02-01" | Date == "2007-02-02")

View(household_power_consumption_1)
unique(household_power_consumption_1$Date)
table(household_power_consumption_1$Date)


## check whether there are NA, how many and in which columns  
sum_is_na <- function(x) {sum(is.na(x))}
sapply(household_power_consumption_1, sum_is_na) 

sum(is.na(household_power_consumption_1[,]))
# [1] 0  - there is no NA in the subset dataset



## transform character vector of time into Time format
library(lubridate)
household_power_consumption_1$Time <- format(household_power_consumption_1$Time, format = "%H:%M:%S")
class(household_power_consumption$Time)


## building Plot 1
names(household_power_consumption_1)

hist(household_power_consumption_1$Global_active_power, 
                                         col = "red",
                                         xlab = "Global Active Power (kilowatts)",
                                         main = "Global Active Power")

## copying plot 1 to png file
dev.copy(png, file = "plot1.png", width=480, height=480)     
dev.off()



    


