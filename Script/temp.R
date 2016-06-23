setwd("G:/Sem3/ADS/Assignment 1/output")
data1 <- read.csv("sampleformat.csv")

# library(weatherData)
# temperature <- getWeatherForDate("BOS", "2014-01-01",end_date = "2014-12-31", opt_detailed=TRUE)
# write.csv(temperature,"temperature2014.csv")

temp <- read.csv("temperature2014.csv",stringsAsFactors = FALSE)
noOfRows <- dim(temp)[1] #Number of rows
temperature <- data.frame(Date = character(), hour= numeric(),tph = numeric(),stringsAsFactors = FALSE)
for(x in 1:noOfRows){
  
  dateObject <- as.POSIXct(temp[x,]$Time, format="%m/%d/%Y %H:%M")
  new.dateObject <- as.POSIXlt(dateObject)
  
  newdata <-     data.frame(
    Date <- as.Date(dateObject),
    Hour = new.dateObject$hour,
    tph = temp[x,]$TemperatureF
  )
  temperature <- rbind(temperature,newdata)
  
}


temperature <- aggregate(temperature,list(temperature$Date,temperature$Hour),mean)
temperature <- temperature[order(temperature$Group.1, temperature$Group.2),]
temperature <- data.frame(Date = temperature$Group.1,Hour = temperature$Hour,temp = temperature$tph)

write.csv(temperature,"SortedTemperature.csv",row.names = FALSE)
data2 <- read.csv("SortedTemperature.csv")
data3 <- merge(data1, data2, by=c("Date","Hour"))
mergedData <- data3[order(data3$Date, data3$Hour),]
mergedData <- mergedData[c("Account", "Date", "kwh","Month","Day","Year","Hour","DayOfWeek","Weekday","PeakHour","temp")]
write.csv(mergedData,"sampleformat_temp.csv",row.names = FALSE)
