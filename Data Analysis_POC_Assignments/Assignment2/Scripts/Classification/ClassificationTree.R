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
set.seed(123)
smp_size <- floor(0.75 * nrow(model3))
train_ind <- sample(seq_len(nrow(model3)), size = smp_size)

train <- model3[train_ind, ]
test <- model3[-train_ind, ]

#Use variables to fit a classification tree
library(tree)
tree.train = tree(train$KWH_Class ~+PeakHour+Hour+Month+DayOfWeek+Weekday, data=train)
summary(tree.train)

#Display the tree structure and node labels
plot(tree.train)
text(tree.train, pretty =0) #Pretty=0 includes the category names

forecastTestInput <- na.omit(read.csv("forecastInput1.csv",stringsAsFactors = FALSE))
tree.pred = predict(tree.train, forecastTestInput, type = "class")
table(tree.pred, test$KWH_Class)

library(caret)
library(e1071)
confusionMatrix(tree.pred,test$KWH_Class)
#Determine the optimal level
set.seed (3)
#FUN = prune.misclass indicate that classification error rate is used to 
#guide the cross-validation and pruning process
cv.energy = cv.tree(tree.train, FUN = prune.misclass)
names(cv.energy)
cv.energy

#Prune the tree
prune.energy = prune.misclass(tree.train, best =14)
plot(prune.energy)
text(prune.energy, pretty =0)

#The pruned tree performance
prune.pred = predict(prune.energy, forecastTestInput, type = "class")
table(prune.pred, test$KWH_Class)

#MergeData
dataToMerge <- na.omit(read.csv("forecastNewData1.csv",stringsAsFactors = FALSE))
predictionResults <- data.frame(dataToMerge, KWH_Class = prune.pred)
write.csv(predictionResults,"forecastOutput_26435791004_ClassificationTree1.csv",row.names = FALSE)

#ROC curve
library(ROCR)
prediction <- prediction(prune.pred,test$KWH_Class)
performance <- performance(prediction, measure = "tpr", x.measure = "fpr")
plot(performance, main="ROC curve", xlab="1-Specificity", ylab="Sensitivity")

# #Lift curve
# test$KWH_Class=prob
# test$prob=sort(test$KWH_Class,decreasing = T)
# lift <- lift(test$KWH_Class ~ prob, data = test)
# lift
# xyplot(lift,plot = "gain")

