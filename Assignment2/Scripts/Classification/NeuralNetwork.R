rm(list=ls())
library(neuralnet)
setwd("G:/Sem3/ADS/Assignment2/Part2/")

library(ISLR)
library(MASS)
library(leaps)
library(lubridate)
library(caret)
library(e1071)

model1 <- na.omit(read.csv("Hourly_filled_data.csv",stringsAsFactors = FALSE))
#model1$Date <- NULL
#Transform kwh into a dichotomous factor for classification
averagekwh <- mean(model1$kwh)

model1$KWH_Class[model1$kwh > averagekwh] <- 1
model1$KWH_Class[model1$kwh <= averagekwh] <- 0
# model1$KWH_Class <- factor(model1$KWH_Class,
#                            levels=c(0,1),
#                            labels=c("Optimal","Above_Normal"))

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

#Sampling
smp_size <- floor(0.75 * nrow(model3))
set.seed(123)
train_ind <- sample(seq_len(nrow(model3)), size = smp_size)

train <- model3[train_ind, ]
test <- model3[-train_ind, ]


neuralnet <- neuralnet(train$KWH_Class ~ DayOfWeek+Hour+Weekday, data=train, 
                        hidden=c(4,4), err.fct="sse", linear.output=FALSE,threshold = 0.1,lifesign = "minimal")
##plot network
neuralnet$result.matrix
plot(neuralnet)

##Predict
temp_test <- subset(test, select = c("DayOfWeek", "Hour","Weekday"))
test.results <- compute(neuralnet, temp_test)
#test.results <- round(test.results$net.result)

results <- data.frame(actual = test$KWH_Class, prediction = test.results$net.result)
results$prediction <- round(results$prediction)
str(results)

results$prediction <- factor(results$prediction,
                       levels=c(0,1),
                       labels=c("Optimal","Above_Normal"))

results$actual <- factor(results$actual,
                       levels=c(0,1),
                       labels=c("Optimal","Above_Normal"))

confusionMatrix(results$prediction,results$actual)



#Forecast for forecastinput data
forecastTestInput <- na.omit(read.csv("forecastInput2.csv",stringsAsFactors = FALSE))
test.results <- factor(test.results,
                       levels=c(0,1),
                       labels=c("Optimal","Above_Normal"))

#MergeData
dataToMerge <- na.omit(read.csv("forecastNewData2.csv",stringsAsFactors = FALSE))
predictionResults <- data.frame(dataToMerge, KWH_Class = test.results)
write.csv(predictionResults,"forecastOutput_26435791004_neuralNetworkClassification2.csv",row.names = FALSE)
