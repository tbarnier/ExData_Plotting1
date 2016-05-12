#########################
## 4th plot assignment 
#########################
library(lubridate)

# Cleaning environment

#rm(list=ls())

# Read the CSV file and returns a clean dataframe
loadData<- function()
{
  # If the datafile is not already there, download and unzip it!
  if(!file.exists('household_power_consumption.txt')){
    if(!file.exists('exdata_data_household_power_consumption.zip')){
      download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
                    destfile = 'exdata_data_household_power_consumption.zip')
      unzip('exdata_data_household_power_consumption.zip')
    }
  }
  ## Big trick: Piping grep UNIX command to fasten the CSV READ
  d<-read.csv(pipe('grep "^[12]/2/2007\\|^Date" household_power_consumption.txt'),stringsAsFactors = F, sep=';', na.strings = '?')
  
  # Coerce the comumns names to lowercase witouh spaces
  names(d)<-gsub('_|\\.', '', tolower(names(d)))
  
  #Aggregate the date and time into a single field
  d$date<-as.POSIXlt(strptime(paste(d$date, d$time), "%d/%m/%Y %H:%M:%S"))
  d
}

###### 
#
# 4th plot, mosaic of the previous plots
#
#Build the plot from data
#
# PARAMS:
# data: The dataset to draw
# RETURNS:
# a plot
# 
### 


plot4<- function(data)
{
  source('plot2.R')
  source('plot3.R')
  par(mfrow=c(2,2), mar=c(4,4,2,1))
  plot2(data);
  plot(x=data$date, y=data$voltage, type='l',col='black', ylab='Voltage');
  plot3(data);
  plot(x=data$date, y=data$globalreactivepower, type='l',col='black', ylab='Global Reactive Power');
}

###### 
# Makes a plot into a PNG file
#
# PARAMS:
# data: The dataset to draw
# filename : name of PNG file, without '.png' suffix
# RETURNS:
# a plot
plot42Png<-function(data, filename)
{
  png(paste0(filename, '.png'))
  plot4(data)
  dev.off()
}

### AUTO EXECUTION
#plot42Png(loadData(),'plot4')


