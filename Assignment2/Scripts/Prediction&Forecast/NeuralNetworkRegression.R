rm(list=ls())

setwd("G:/Sem3/ADS/Assignment2/Part2/")
install.packages("neuralnet")
library(ISLR)
library(MASS)
library(leaps)
library(neuralnet)

library(leaps)
model1 <- na.omit(read.csv("Hourly_filled_data.csv"))
#Train the neural network
#Going to have 10 hidden layers
#Threshold is a numeric value specifying the threshold for the partial
#derivatives of the error function as stopping criteria.

#Romving Outliers
#Multivariate Model Approach
mod <- lm(kwh ~.-Account-Year, data=model1)
cooksd <- cooks.distance(mod)

plot(cooksd, pch="*", cex=2, main="Influential Obs by Cooks distance")  # plot cook's distance
abline(h = 4*mean(cooksd, na.rm=T), col="red")  # add cutoff line
text(x=1:length(cooksd)+1, y=cooksd, labels=ifelse(cooksd>4*mean(cooksd, na.rm=T),names(cooksd),""), col="red")

influential <- as.numeric(names(cooksd)[(cooksd > 4*mean(cooksd, na.rm=T))])  # influential row numbers
influencers <- model1[influential, ]
head(influencers)
model2<- model1[-influential, ]

#Multivariate Model Approach
mod <- lm(kwh ~.-Account-Year, data=model2)
cooksd <- cooks.distance(mod)

plot(cooksd, pch="*", cex=2, main="Influential Obs by Cooks distance")  # plot cook's distance
abline(h = 3*mean(cooksd, na.rm=T), col="red")  # add cutoff line
text(x=1:length(cooksd)+1, y=cooksd, labels=ifelse(cooksd>3*mean(cooksd, na.rm=T),names(cooksd),""), col="red")

influential <- as.numeric(names(cooksd)[(cooksd > 3*mean(cooksd, na.rm=T))])  # influential row numbers
influencers <- model2[influential, ]
head(influencers)
model3<- model2[-influential, ]


index <- sample(1:nrow(model1),round(0.75*nrow(model3)))
trainingdata <- model3[index,]
testdata <- model3[-index,]


library(nnet)
forecastTestInput <- na.omit(read.csv("forecastInput2.csv",stringsAsFactors = FALSE))

fml<- as.formula("trainingdata$kwh ~ +DayOfWeek+Weekday+PeakHour+temp+Month");
res <- nnet(fml, data=trainingdata,size=10, linout=TRUE, skip=TRUE, MaxNWts=10000, trace=FALSE, maxit=100)
pred<-predict(res, newdata=testdata)

rmse <- sqrt(mean((pred- testdata$kwh)^2))

#Merge Data
dataToMerge <- na.omit(read.csv("forecastNewData2.csv",stringsAsFactors = FALSE))
predictionResults <- data.frame(dataToMerge, kwh = pred)
write.csv(predictionResults,"forecastOutput_26435791004_neuralNetworkRegression2.csv",row.names = FALSE)

#table(testdata$kwh,predict(res,newdata=testdata,type="class"))


