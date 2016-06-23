setwd("G:/Sem3/ADS/Assignment 1/")

data <- read.csv("rawdata.csv")
noOfRows <- dim(data)[1] #Number of rows
noOfColumns <- dim(data)[2] #Number of columns
weekday <- c(1:5)
peakHour <- c(7:19)


nodata <- data.frame(Account= numeric(), Date= character(), kWh = numeric(),
                     Month= numeric(),Day= numeric(),Year= numeric(),Hour= numeric(),
                     DayOfWeek= numeric(),Weekday= numeric(),peakHour= numeric())

for(x in 1:noOfRows){
  
  unit <- data[x,]$Units
  dateObject<-(as.Date(data[x,]$Date,"%m/%d/%Y"))
  i<-strsplit(as.character(data[x,]$Date),"/",fixed = TRUE)

  weekdayNumber <- as.numeric(format(dateObject, "%w"))
  isWeekday <- 0
  
  if(weekdayNumber %in% weekday){
    isWeekday <- 1
  }
  
  if(unit == "kWh"){
    
    row <- data[x,]
    hour <- 0
    
    for(y in seq(from=5, to=noOfColumns-11, by=12)){
      
      
      range <- 11+y
      sumOfkwh <- sum(row[,y:range])
      
      
      isPeakHour <- 0
      if(hour %in% peakHour){
        isPeakHour <- 1
      }
      
      newdata <-     data.frame(
        Account = c(data[x,]$Account),
        Date = c(as.Date(data[x,]$Date,"%m/%d/%Y")),
        kwh = sumOfkwh,
        Month = i[[1]][1],
        Day = i[[1]][2],
        Year = i[[1]][3],
        Hour = hour,
        DayOfWeek = weekdayNumber,
        Weekday = isWeekday,
        PeakHour = isPeakHour
      )
      nodata <- rbind(nodata,newdata)
      hour <- hour + 1
      
    }
    
  }
}
write.csv(nodata,"output/sampleformat.csv",row.names = FALSE)



