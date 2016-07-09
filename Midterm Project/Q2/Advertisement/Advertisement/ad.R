library(ISLR)
library(MASS)
library(leaps)

#====================================================================================================

#Read data and names file and combine
setwd("G:/Sem3/ADS/Midterm/Advertisement/")
adtable <- read.table("ad.data",header = FALSE, sep = ",",fileEncoding = "UTF-8")

header <- read.csv("ad.names",header = TRUE,sep=":")
header <- data.frame(row.names(header))

headerNew <- data.frame(header[-c(1,6,464,960,1433,1545),])
write.csv(headerNew,"header.csv",row.names = FALSE)
adtableHead<-read.csv("header.csv",header = FALSE)

adtableHead<- data.frame(adtableHead[-c(1),])

write.csv(adtableHead,"header.csv",row.names = FALSE)
adtableHead<-read.csv("header.csv",header = FALSE,skip=1)

headerRow <- t(adtableHead)
headerRow<- data.frame(headerRow,"ad|NonAd")
names(headerRow) = as.character(unlist(headerRow[1,]))

names(adtable)<-c(names(headerRow))
write.csv(adtable,"ad.data1.csv",row.names = FALSE)

#=====================================================================================================
addata <- na.omit(read.csv("ad.data1.csv",stringsAsFactors = FALSE))
#Replace ? with NA
addata$height[addata$height == "   ?"] <- NA
addata$width[addata$width == "   ?"] <- NA
addata$aratio[addata$aratio == "     ?"] <- NA

#Convert characters to numerics to calculate mean
addata$ad.NonAd <- as.factor(addata$ad.NonAd)
addata$height <- as.numeric(addata$height)
addata$width <- as.numeric(addata$width)
addata$aratio <- as.numeric(addata$aratio)

#calculating mean
meanHeight <- mean(addata$height, na.rm=TRUE)
meanWidth <- mean(addata$width, na.rm=TRUE)

#replacing missing data with mean
addata$height[is.na(addata$height)] = meanHeight
addata$width[is.na(addata$width)] = meanWidth
addata$aratio[is.na(addata$aratio)] = meanWidth/meanHeight

write.csv(addata,"cleaneddata.csv",row.names = FALSE)
#plotting histogram to see the frequncy of data to remove outliers
#par(mfrow=c(1, 2))
hist(addata$aratio,xlab = "aratio",main = paste("Histogram with outliers"))
addata<-addata[(addata$aratio <=15),]
hist(addata$aratio,xlab = "aratio",main = paste("Histogram without outliers"))

#Convert to zoo series and apply locf to replace missing values
#library(zoo)
# cz <- zoo(addata$height)
# addata$height <- na.locf(cz)
# 
# cz <- zoo(addata$width)
# addata$width <- na.locf(cz)

# cz <- zoo(addata$aratio)
# addata$aratio <- na.locf(cz)

#Remove the zoo series and convert back to numeric for add in model
# addata$ad.NonAd <- as.factor(addata$ad.NonAd)
# addata$height <- as.numeric(addata$height)
# addata$width <- as.numeric(addata$width)
# addata$aratio <- (addata$width/addata$height)


#Sampling the data
smp_size <- floor(0.75 * nrow(addata))
set.seed(123)
train_ind <- sample(seq_len(nrow(addata)), size = smp_size)

train <- addata[train_ind, ]
test <- addata[-train_ind, ]

#Build Logistic Regression
glm.fit <- glm(ad.NonAd~+url.ad+alt.click+url.images.home+height+ancurl.com+ancurl.exe+url.ads+alt.net+width+ancurl.click+ancurl.http.www,data=train, family=binomial(link="logit"))
summary(glm.fit)

prob <- predict(glm.fit, newdata=test, type="response")
pred <- rep("nonad.",length(prob))
pred[prob<=0.5] <- "ad."

# Confusion MAtrix
library(caret)
library(e1071)
confusionMatrix(pred,test$ad.NonAd)


#Plotting ROC Curve
library(ROCR)
prediction <- prediction(prob,test$ad.NonAd)
performance <- performance(prediction, measure = "tpr", x.measure = "fpr")
plot(performance, main="ROC curve",xlab="1-Specificity", ylab="Specificity",col=bluered(10))

# ROC area under the curve
prediction <- prediction(prob,test$ad.NonAd)
auc.tmp <- performance(prediction,"auc")
auc <- as.numeric(auc.tmp@y.values)
print(auc)

#Precision Recall graph
prediction <- prediction(prob,test$ad.NonAd)
performance <- performance(prediction,"prec","rec")
plot(performance, avg= "threshold", colorize=T, lwd= 3,
     main= "... Precision/Recall graphs ...")

#Lift curve
test$probs=prob
test$prob=sort(test$probs,decreasing = T)
lift <- lift(ad.NonAd ~ prob, data = test)
xyplot(lift,plot = "gain")

#====================================================================================================

#Use variables to fit a classification tree
library(tree)
tree.train = tree(ad.NonAd~+url.ad+alt.click+url.images.home+height+ancurl.com+ancurl.exe+url.ads+alt.net+width+ancurl.click+ancurl.http.www,data=train)
summary(tree.train)


#Display the tree structure and node labels
plot(tree.train)
text(tree.train, pretty =0) #Pretty=0 includes the category names

#FancyRPlot
library(rpart)
library(rattle)
tree <- rpart(ad.NonAd~.,data=train,method="class")
fancyRpartPlot(tree)

tree.pred = predict(tree.train, test, type ="class")
table(tree.pred, test$ad.NonAd)

#Confusion Matrix
library(caret)
library(e1071)
confusionMatrix(tree.pred,test$ad.NonAd)

#Plotting ROC Curve
library(ROCR)
tree.pred = predict(tree.train, test, type ="vector") #use vector type to get probablities for ad and nonad as vectors
prediction <- prediction(tree.pred[,2],test$ad.NonAd)
performance <- performance(prediction, measure = "tpr", x.measure = "fpr")
plot(performance, main="ROC curve",xlab="1-Specificity", ylab="Specificity",col=bluered(10))

# ROC area under the curve
tree.pred = predict(tree.train, test, type ="vector")
prediction <- prediction(tree.pred[,2],test$ad.NonAd)
auc.tmp <- performance(prediction,"auc")
auc <- as.numeric(auc.tmp@y.values)
print(auc)

#Precision Recall graph
tree.pred = predict(tree.train, test, type ="vector")
prediction <- prediction(tree.pred[,2],test$ad.NonAd)
performance <- performance(prediction,"prec","rec")
plot(performance, avg= "threshold", colorize=T, lwd= 3,
     main= "... Precision/Recall graphs ...")

#Lift curve
tree.pred = predict(tree.train, test, type ="vector")
test$probs=tree.pred[,2]
test$prob=sort(test$probs,decreasing = T)
lift <- lift(ad.NonAd ~ prob, data = test)
xyplot(lift,plot = "gain")

#=========================================================================================================
#Neural Network
library(nnet)
library(NeuralNetTools)

#Build the model
fitnn <- nnet(ad.NonAd~url.ad+alt.click+url.images.home+ancurl.com+height+ancurl.exe+url.ads+alt.net
              +width+ancurl.click+ancurl.http.www,data=train, size=4, 
               hess = T, dk=15e-4, maxit = 200)
summary(fitnn)

#Predict for test data
pred = predict(fitnn, newdata=test, type="class")

#Confusion Matrix
library(caret)
library(e1071)
confusionMatrix(pred,test$ad.NonAd)

##plot network
#green line indiciating positive connection weights
#red line indicating negative connection weights
plotnet(fitnn,circle_col = "lightblue", circle_cex = 3,pos_col = "darkgreen", neg_col = "red")

#Plot for fitted vs residual
df_nnet <- data.frame(residuals = fitnn$residuals, fitted = fitnn$fitted.values)
ggplot(data=df_nnet, aes(x=fitted, y=residuals)) + geom_point()

#Plotting ROC Curve
library(ROCR)
pred = predict(fitnn, newdata=test, type="raw") #use raw type to get probablities for ad/nonad
prediction <- prediction(pred,test$ad.NonAd)
performance <- performance(prediction, measure = "tpr", x.measure = "fpr")
plot(performance, main="ROC curve",xlab="1-Specificity", ylab="Specificity",col=bluered(10))

# ROC area under the curve
pred = predict(fitnn, newdata=test, type="raw")
prediction <- prediction(pred,test$ad.NonAd)
auc.tmp <- performance(prediction,"auc")
auc <- as.numeric(auc.tmp@y.values)
print(auc)

#Precision Recall graph
pred = predict(fitnn, newdata=test, type="raw")
prediction <- prediction(pred,test$ad.NonAd)
performance <- performance(prediction,"prec","rec")
plot(performance, avg= "threshold", colorize=T, lwd= 3,
     main= "... Precision/Recall graphs ...")

#Lift curve
pred = predict(fitnn, newdata=test, type="raw")
test$probs=pred
test$prob=sort(test$probs,decreasing = T)
lift <- lift(ad.NonAd ~ prob, data = test)
xyplot(lift,plot = "gain")

#histogram of residuals and fitted values
par(mfrow=c(1, 2))
hist(fitnn$residuals,xlab = "Residual",main = paste("Histogram of Resdiuals"))
hist(fitnn$fitted.values,xlab = "Fitted Values",main = paste("Histogram of Fitted Values"))

#========================================================================================================
