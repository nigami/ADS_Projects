setwd("G:/Sem3/ADS/Assignment 1/Part 2/")
forecastData <- read.csv("forecastNewData2.csv")
noOfRows <- dim(forecastData)[1] #Number of rows
noOfColumns <- dim(forecastData)[2] #Number of columns
weekday <- c(1:5)
peakHour <- c(7:18)

forecastInput <- data.frame(date1= character(),month= numeric(),day= numeric(),year= numeric(),hour= numeric(),DayOfWeek= numeric(),Weekday= numeric(),PeakHour= numeric(),temp= numeric())

for(x in 1:noOfRows){
  
  dateObject <- c(as.Date(forecastData[x,]$Day,"%m/%d/%Y"))
  i<-strsplit(as.character(forecastData[x,]$Day),"/",fixed = TRUE)
  weekdayNumber <- as.numeric(format(dateObject, "%w"))
  isWeekday <- 0
  isPeakHour <- 0
  
  
  if(weekdayNumber %in% weekday){
    isWeekday <- 1
  }
  
  if(forecastData[x,]$Hour %in% peakHour){
    isPeakHour <- 1
  }
  
  newdata <-     data.frame(
    date = c(as.Date(forecastData[x,]$Day,"%m/%d/%Y")),
    month = i[[1]][1],
    day = i[[1]][2],
    year = i[[1]][3],
    hour = forecastData[x,]$Hour,
    DayOfWeek = weekdayNumber,
    Weekday = isWeekday,
    PeakHour = isPeakHour,
    temp = forecastData[x,]$Temp
  )
  forecastInput <- rbind(forecastInput,newdata)
}
write.csv(forecastInput,"forecastInputNew.csv",row.names=F)
