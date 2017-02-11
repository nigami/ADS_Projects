setwd("G:/Sem3/ADS/Assignment2/")
data1 <- read.csv("Part1/nonzeroa.csv")

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

write.csv(temperature,"Part1/SortedTemperature.csv",row.names = FALSE)
data2 <- read.csv("Part1/SortedTemperature.csv")
data3 <- merge(data1, data2, by=c("Date","Hour"))
mergedData <- data3[order(data3$Date, data3$Hour),]
mergedData <- mergedData[c("Account", "Date", "kwh","Month","Day","Year","Hour","DayOfWeek","Weekday","PeakHour","temp")]

for(i in 1:nrow(mergedData)) {
  if((mergedData$temp[i]) < (mean(mergedData$temp) - (1.5)*sd(mergedData$temp)) &&
     (mergedData$temp[i]) > (mean(mergedData$temp) + (1.5)*sd(mergedData$temp))) {
    mergedData$temp[i] <- mergedData$temp[i-1];
  }
}
write.csv(mergedData,"Part1/sampleformat_nonzero_tempa.csv",row.names = FALSE)
