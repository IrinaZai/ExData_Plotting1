## Remove everything from the environment in case there are any old elements
rm(list = ls())

## Load packages
library(data.table)
library(stringr)

## Set up current and data directoriess
setwd("~/Documents/Coursera/Data Science in R/4 Exploratory Data Analysis/Week1/ExData_Plotting1/")
data_path <- "~/Documents/Coursera/Data Science in R/4 Exploratory Data Analysis/Week1/"

## Preliminary reading of lines 
Lines <- readLines(paste(data_path, "household_power_consumption.txt", sep = ''))

## Get column names from the first line
colNames <- as.vector(strsplit(Lines[1],"\\;")[[1]]) 

## Get indexes for the oservations from February 1-2, 2007
LinesIndex <- grep("^[12]/2/2007", Lines)

## Read only lines with those indices
hh_power_consumption <- read.table (text = Lines[LinesIndex],
                                    stringsAsFactors = FALSE, 
                                    header = FALSE, 
                                    sep = ";", 
                                    na.strings = "?",
                                    col.names = colNames)

## Create datetime column
hh_power_consumption$datetime <- as.POSIXct(paste(hh_power_consumption$Date, hh_power_consumption$Time), 
                                            format = "%d/%m/%Y %H:%M:%S")

## Remove elements not in use
rm(Lines, LinesIndex, colNames)

## Specify the output png-file and its properties
png("plot2.png", width = 480, height = 480)

## Set up plot parameters (1 column, 1 row of graphs)
par(mfrow = c(1, 1))

## Construct a graph
with(hh_power_consumption, {
        plot(x = datetime, 
             y = Global_active_power,
             type = "l",
             xlab = "", 
             ylab = "Global Active Power (kilowatts)"
        )})

## Close the file
dev.off()
