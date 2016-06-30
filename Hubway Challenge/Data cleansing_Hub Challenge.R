setwd("C:/Users/aysrivastava/Desktop/hub/hubway_2011_07_through_2013_11")
library(ISLR)
library(MASS)
library(leaps)
library(corrplot)
model1 <- (read.csv("hubway_trips.csv",na.strings = c("", "NA")))
model1 =  na.omit(model1)
str(model1)
summary(model1)
model1 <- subset(model1,duration>0)

a1=as.vector(quantile(model1$duration,c(.01)))
model2=model1[which(model1$duration>=a1 & model1$strt_statn!=model1$end_statn),]
# remove outrageously high trips. anything above 99% percentile:
a9=as.vector(quantile(model2$duration,c(.99)))
model3=model2[which(model2$duration<=a9),]
model4=model3[which(as.date(model3$start_date)!=as.date(model3$end_date)),]




write.csv(model3,"model1.csv",row.names = FALSE)