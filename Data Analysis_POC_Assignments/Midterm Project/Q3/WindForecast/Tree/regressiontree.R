library(ISLR)
library(MASS)
library(leaps)
setwd("G:/Sem3/ADS/Midterm/EnergyForecast/")

#============================================================================================================

#Creating 7 windforecast files and adding date with hour and agrgregating based on datetime
for(i in 1:7){
  
  assign(paste0("wf"), read.csv(paste("windforecasts_wf",
                                      i, ".csv", sep=""),colClasses = c("character", "numeric","numeric","numeric","numeric","numeric")))
  
  wf$date <- as.POSIXct(wf$date,format = "%Y%m%d%H")
  wf$actualDate <- wf$date + (wf$hors * 3600)
  
  wf <- wf[,c(3:7)]
  meanU <- mean(wf$u, na.rm=TRUE)
  meanV <- mean(wf$v, na.rm=TRUE)
  meanWS <- mean(wf$ws, na.rm=TRUE)
  meanWD <- mean(wf$wd, na.rm=TRUE)
  
  wf$u[is.na(wf$u)] = meanU
  wf$v[is.na(wf$v)] = meanV
  wf$ws[is.na(wf$ws)] = meanWS
  wf$wd[is.na(wf$wd)] = meanWD
  
  wf <- aggregate(x = wf[c("u","v","ws","wd")],
                  FUN = mean,
                  by = list(Date = wf$actualDate))
  
  
  wf$hour <- as.integer(as.factor(format(wf$Date, "%H")))-1
  wf$month <- as.integer(as.factor(format(wf$Date, "%m")))
  wf$year <- as.integer(as.factor(format(wf$Date, "%Y")))
  wf$OnlyDate <- as.Date(format(wf$Date))
  
  assign(paste0("wf", i), wf)
}

#============================================================================================================

#split train.csv into date and hour
train.data.model <- read.csv(("train.csv"),colClasses = c("character", "numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
train.data.model$Date <- as.POSIXct(train.data.model$date,format = "%Y%m%d%H")
train.data.model$hour <- as.factor(format(train.data.model$Date, "%H"))
train.data.model$OnlyDate <- as.Date(format(train.data.model$Date))

#============================================================================================================

#create 7 train.data.model files to merge with windforecast files
for(i in 1:7){
  col <- i + 1
  assign(paste0("train.data.model", i), train.data.model[,c(col,9)])
}

#============================================================================================================

#Merging files based on datetime
mergedWF1  <- merge(wf1, train.data.model1, by=c("Date"))
mergedWF2  <- merge(wf2, train.data.model2, by=c("Date"))
mergedWF3 <- merge(wf3, train.data.model3, by=c("Date"))
mergedWF4  <- merge(wf4, train.data.model4, by=c("Date"))
mergedWF5  <- merge(wf5, train.data.model5, by=c("Date"))
mergedWF6  <- merge(wf6, train.data.model6, by=c("Date"))
mergedWF7  <- merge(wf7, train.data.model7, by=c("Date"))

#============================================================================================================

#Make 7 test and train data files based on dates for testing and training the model
train1 <- mergedWF1[mergedWF1$OnlyDate >="2009-07-01" & mergedWF1$OnlyDate <="2010-12-31",]
train2 <- mergedWF2[mergedWF2$OnlyDate >="2009-07-01" & mergedWF2$OnlyDate <="2010-12-31",]
train3 <- mergedWF3[mergedWF3$OnlyDate >="2009-07-01" & mergedWF3$OnlyDate <="2010-12-31",]
train4 <- mergedWF4[mergedWF4$OnlyDate >="2009-07-01" & mergedWF4$OnlyDate <="2010-12-31",]
train5 <- mergedWF5[mergedWF5$OnlyDate >="2009-07-01" & mergedWF5$OnlyDate <="2010-12-31",]
train6 <- mergedWF6[mergedWF6$OnlyDate >="2009-07-01" & mergedWF6$OnlyDate <="2010-12-31",]
train7 <- mergedWF7[mergedWF7$OnlyDate >="2009-07-01" & mergedWF7$OnlyDate <="2010-12-31",]

test1 <- mergedWF1[mergedWF1$OnlyDate >="2011-01-01" & mergedWF1$OnlyDate <="2012-06-28",]
test2 <- mergedWF2[mergedWF2$OnlyDate >="2011-01-01" & mergedWF2$OnlyDate <="2012-06-28",]
test3 <- mergedWF3[mergedWF3$OnlyDate >="2011-01-01" & mergedWF3$OnlyDate <="2012-06-28",]
test4 <- mergedWF4[mergedWF4$OnlyDate >="2011-01-01" & mergedWF4$OnlyDate <="2012-06-28",]
test5 <- mergedWF5[mergedWF5$OnlyDate >="2011-01-01" & mergedWF5$OnlyDate <="2012-06-28",]
test6 <- mergedWF6[mergedWF6$OnlyDate >="2011-01-01" & mergedWF6$OnlyDate <="2012-06-28",]
test7 <- mergedWF7[mergedWF7$OnlyDate >="2011-01-01" & mergedWF7$OnlyDate <="2012-06-28",]

#======================================================================================================== 

#Removing outlier using cooks distance for each train file
mod <- lm(wp1~.,data=train1)
cooksd <- cooks.distance(mod)

plot(cooksd, pch="*", cex=2, main="Influential Obs by Cooks distance")  # plot cook's distance
abline(h = 14*mean(cooksd, na.rm=T), col="red")  # add cutoff line
text(x=1:length(cooksd)+1, y=cooksd, labels=ifelse(cooksd>14*mean(cooksd, na.rm=T),names(cooksd),""), col="red")

influential <- as.numeric(names(cooksd)[(cooksd > 14*mean(cooksd, na.rm=T))])  # influential row numbers
influencers <- train1[influential, ]
head(influencers)
model1<- train1[-influential, ]


mod <- lm(wp2~.,data=train2)
cooksd <- cooks.distance(mod)

plot(cooksd, pch="*", cex=2, main="Influential Obs by Cooks distance")  # plot cook's distance
abline(h = 8*mean(cooksd, na.rm=T), col="red")  # add cutoff line
text(x=1:length(cooksd)+1, y=cooksd, labels=ifelse(cooksd>8*mean(cooksd, na.rm=T),names(cooksd),""), col="red")

influential <- as.numeric(names(cooksd)[(cooksd > 8*mean(cooksd, na.rm=T))])  # influential row numbers
influencers <- train2[influential, ]
head(influencers)
model2<- train2[-influential, ]


mod <- lm(wp3~.,data=train3)
cooksd <- cooks.distance(mod)

plot(cooksd, pch="*", cex=2, main="Influential Obs by Cooks distance")  # plot cook's distance
abline(h = 10*mean(cooksd, na.rm=T), col="red")  # add cutoff line
text(x=1:length(cooksd)+1, y=cooksd, labels=ifelse(cooksd>10*mean(cooksd, na.rm=T),names(cooksd),""), col="red")

influential <- as.numeric(names(cooksd)[(cooksd > 10*mean(cooksd, na.rm=T))])  # influential row numbers
influencers <- train3[influential, ]
head(influencers)
model3<- train3[-influential, ]

mod <- lm(wp4~.,data=train4)
cooksd <- cooks.distance(mod)

plot(cooksd, pch="*", cex=2, main="Influential Obs by Cooks distance")  # plot cook's distance
abline(h = 14*mean(cooksd, na.rm=T), col="red")  # add cutoff line
text(x=1:length(cooksd)+1, y=cooksd, labels=ifelse(cooksd>14*mean(cooksd, na.rm=T),names(cooksd),""), col="red")

influential <- as.numeric(names(cooksd)[(cooksd > 14*mean(cooksd, na.rm=T))])  # influential row numbers
influencers <- train4[influential, ]
head(influencers)
model4<- train4[-influential, ]

mod <- lm(wp5~.,data=train5)
cooksd <- cooks.distance(mod)

plot(cooksd, pch="*", cex=2, main="Influential Obs by Cooks distance")  # plot cook's distance
abline(h = 10*mean(cooksd, na.rm=T), col="red")  # add cutoff line
text(x=1:length(cooksd)+1, y=cooksd, labels=ifelse(cooksd>10*mean(cooksd, na.rm=T),names(cooksd),""), col="red")

influential <- as.numeric(names(cooksd)[(cooksd > 10*mean(cooksd, na.rm=T))])  # influential row numbers
influencers <- train5[influential, ]
head(influencers)
model5<- train5[-influential, ]

mod <- lm(wp6~.,data=train6)
cooksd <- cooks.distance(mod)

plot(cooksd, pch="*", cex=2, main="Influential Obs by Cooks distance")  # plot cook's distance
abline(h = 14*mean(cooksd, na.rm=T), col="red")  # add cutoff line
text(x=1:length(cooksd)+1, y=cooksd, labels=ifelse(cooksd>14*mean(cooksd, na.rm=T),names(cooksd),""), col="red")

influential <- as.numeric(names(cooksd)[(cooksd > 14*mean(cooksd, na.rm=T))])  # influential row numbers
influencers <- train6[influential, ]
head(influencers)
model6<- train6[-influential, ]

mod <- lm(wp7~.,data=train7)
cooksd <- cooks.distance(mod)

plot(cooksd, pch="*", cex=2, main="Influential Obs by Cooks distance")  # plot cook's distance
abline(h = 10*mean(cooksd, na.rm=T), col="red")  # add cutoff line
text(x=1:length(cooksd)+1, y=cooksd, labels=ifelse(cooksd>10*mean(cooksd, na.rm=T),names(cooksd),""), col="red")

influential <- as.numeric(names(cooksd)[(cooksd > 10*mean(cooksd, na.rm=T))])  # influential row numbers
influencers <- train7[influential, ]
head(influencers)
model7<- train7[-influential, ]

#===========================================================================================================

#RegressionTree
library(tree)
tree.model1 = tree(wp1~.-Date-OnlyDate,model1)
summary (tree.model1)

#plot
plot (tree.model1)
text (tree.model1, pretty = 0)
cv.model1 = cv.tree (tree.model1)
plot (cv.model1$size, cv.model1$dev, type='b')

#predict
pred=predict (tree.model1, newdata =test1)
plot(pred,test1$wp1)
abline (0,1)
accuracy(pred,test1$wp1)



#RegressionTree
library(tree)
tree.model2 = tree(wp2~.-Date-OnlyDate,model2)
summary (tree.model2)

#plot
plot (tree.model2)
text (tree.model2, pretty = 0)
cv.model2 = cv.tree (tree.model2)
plot (cv.model2$size, cv.model2$dev, type='b')

#predict
pred=predict (tree.model2, newdata =test2)
plot(pred,test2$wp2)
abline (0,1)
accuracy(pred,test2$wp2)



#RegressionTree
library(tree)
tree.model3 = tree(wp3~.-Date-OnlyDate,model3)
summary (tree.model3)

#plot
plot (tree.model3)
text (tree.model3, pretty = 0)
cv.model3 = cv.tree (tree.model3)
plot (cv.model3$size, cv.model3$dev, type='b')

#predict
pred=predict (tree.model3, newdata =test3)
plot(pred,test3$wp3)
abline (0,1)
accuracy(pred,test3$wp3)



#RegressionTree
library(tree)
tree.model4 = tree(wp4~.-Date-OnlyDate,model4)
summary (tree.model4)

#plot
plot (tree.model4)
text (tree.model4, pretty = 0)

#predict
pred=predict (tree.model4, newdata =test4)
plot(pred,test4$wp4)
abline (0,1)
accuracy(pred,test4$wp4)


#RegressionTree
library(tree)
tree.model5 = tree(wp5~.-Date-OnlyDate,model5)
summary (tree.model5)

#plot
plot (tree.model5)
text (tree.model5, pretty = 0)


#predict
pred=predict (tree.model5, newdata =test5)
plot(pred,test5$wp5)
abline (0,1)
accuracy(pred,test5$wp5)



#RegressionTree
library(tree)
tree.model6 = tree(wp6~.-Date-OnlyDate,model6)
summary (tree.model6)

#plot
plot (tree.model6)
text (tree.model6, pretty = 0)


#predict
pred=predict (tree.model6, newdata =test6)
plot(pred,test6$wp6)
abline (0,1)
accuracy(pred,test6$wp6)


#RegressionTree
library(tree)
tree.model7 = tree(wp7~.-Date-OnlyDate,model7)
summary (tree.model7)

#plot
plot (tree.model7)
text (tree.model7, pretty = 0)
cv.model7 = cv.tree (tree.model7)
plot (cv.model7$size, cv.model7$dev, type='b')

#predict
pred=predict (tree.model7, newdata =test7)
plot(pred,test7$wp7)
abline (0,1)
accuracy(pred,test7$wp7)

#=========================================================================================================

#Forecast
forecastDates <- train.data.model[,c(9)]

#creating forecast data files by removing dates of tarain.csv from each wind farm files
forecastData1 <- wf1[!(wf1$Date %in% forecastDates),]
forecastData2 <- wf2[!(wf2$Date %in% forecastDates),]
forecastData3 <- wf3[!(wf3$Date %in% forecastDates),]
forecastData4 <- wf4[!(wf4$Date %in% forecastDates),]
forecastData5 <- wf5[!(wf5$Date %in% forecastDates),]
forecastData6 <- wf6[!(wf6$Date %in% forecastDates),]
forecastData7 <- wf7[!(wf7$Date %in% forecastDates),]

#Forecast for each wind farm
forecastOutput1<-predict(tree.model1, newdata=forecastData1)
forecastOutput2<-predict(tree.model2, newdata=forecastData2)
forecastOutput3<-predict(tree.model3, newdata=forecastData3)
forecastOutput4<-predict(tree.model4, newdata=forecastData4)
forecastOutput5<-predict(tree.model5, newdata=forecastData5)
forecastOutput6<-predict(tree.model6, newdata=forecastData6)
forecastOutput7<-predict(tree.model7, newdata=forecastData7)

#forecast for regression tree
regressionTreeForecast <- data.frame(id = c(1:length(forecastOutput1)),date = forecastData1$Date,wp1 = forecastOutput1,wp2 = forecastOutput2,
                                     wp3 = forecastOutput3,wp4 = forecastOutput4,
                                     wp5 = forecastOutput5,wp6 = forecastOutput6,wp7 = forecastOutput7)

write.csv(regressionTreeForecast, "benchmark_tree.csv",row.names = FALSE);


