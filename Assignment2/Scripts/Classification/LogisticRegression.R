rm(list=ls())
setwd("G:/Sem3/ADS/Assignment2/Part2/")

library(ISLR)
library(MASS)
library(leaps)
library(lubridate)
model1 <- na.omit(read.csv("Hourly_filled_data.csv",stringsAsFactors = FALSE))
#model1$Date <- NULL
#Transform kwh into a dichotomous factor for classification
averagekwh <- mean(model1$kwh)

model1$KWH_Class[model1$kwh > averagekwh] <- 1
model1$KWH_Class[model1$kwh <= averagekwh] <- 0
model1$KWH_Class <- factor(model1$KWH_Class,
                           levels=c(0,1),
                           labels=c("Optimal","Above_Normal"))
table(model1$KWH_Class)

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

#Sampling the data
smp_size <- floor(0.75 * nrow(model3))
set.seed(123)
train_ind <- sample(seq_len(nrow(model3)), size = smp_size)

train <- model3[train_ind, ]
test <- model3[-train_ind, ]

#Build Logistic Regression
fit1 <- glm(KWH_Class~+DayOfWeek+I(temp^2)+I(Hour^2)+Hour+Weekday,data=train, family=binomial(link="logit"))
summary(fit1)

forecastTestInput <- na.omit(read.csv("forecastInput1.csv",stringsAsFactors = FALSE))
prob <- predict(fit1, newdata=forecastTestInput, type="response")
pred <- rep("Optimal",length(prob))

#Set the cutoff value =0.5
pred[prob>=0.5] <- "Above_Normal"

#MergeData
dataToMerge <- na.omit(read.csv("forecastNewData1.csv",stringsAsFactors = FALSE))
predictionResults <- data.frame(dataToMerge, KWH_Class = pred)
write.csv(predictionResults,"forecastOutput_26435791004_regressionTree1.csv",row.names = FALSE)

  #confusionMatrix
library(caret)
library(e1071)
confusionMatrix(pred,test$KWH_Class)

#ROC curve
library(ROCR)
prediction <- prediction(prob,test$KWH_Class)
performance <- performance(prediction, measure = "fpr", x.measure = "tpr")
plot(performance, main="ROC curve",xlab="1-Specificity", ylab="Sensitivity",col=bluered(10))

## precision/recall curve (x-axis: recall, y-axis: precision)
perf1 <- performance(prediction, "prec", "rec")
plot(perf1)
## sensitivity/specificity curve (x-axis: specificity,## y-axis: sensitivity)

perf1 <- performance(prediction, "sens", "spec")
plot(perf1)


# #Lift curve
# test$KWH_Class=prob
# test$prob=sort(test$KWH_Class,decreasing = T)
# lift <- lift(test$KWH_Class ~ prob, data = test)
# lift
# xyplot(lift,plot = "gain")

