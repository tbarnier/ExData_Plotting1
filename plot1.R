#########################
## First plot assignment 
#########################
library(lubridate)

# Cleaning environment

#rm(list=ls())

# Read the CSV file and returns a clean dataframe
loadData<- function()
{
  ## Big trick: Piping grep UNIX command to fasten the CSV READ
  d<-read.csv(pipe('grep "^[12]/2/2007\\|^Date" household_power_consumption.txt'),stringsAsFactors = F, sep=';', na.strings = '?')
  
  # Coerce the comumns names to lowercase witouh spaces
  names(d)<-gsub('_|\\.', '', tolower(names(d)))
  
  #Aggregate the date and time into a single field
  d$date<-as.POSIXlt(strptime(paste(d$date, d$time), "%d/%m/%Y %H:%M:%S"))
  d
}

###### 
# Build the plot from data
#
# PARAMS:
# data: The dataset to draw
# RETURNS:
# a plot
plot1<-function(data)
{
  hist(data$globalactivepower, col='red', main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)')
}

###### 
# Makes a plot into a PNG file
#
# PARAMS:
# data: The dataset to draw
# filename : name of PNG file, without '.png' suffix
# RETURNS:
# a plot
plot12Png<-function(data, filename)
{
  png(paste0(filename, '.png'))
  plot1(data)
  dev.off()
}

### AUTO EXECUTION
#plot12Png(loadData(),'plot1')
