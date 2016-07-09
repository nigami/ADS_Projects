x<-read.csv('C:/Users/ilanigam17/Desktop/default of credit card clients.csv', skip=2,header = FALSE)
head(x)

x$V7[x$V7<0]<-0
x$V8[x$V8<0]<-0
x$V9[x$V9<0]<-0
x$V10[x$V10<0]<-0
x$V11[x$V11<0]<-0
x$V12[x$V12<0]<-0
x<-data.frame(x,rowMeans(x[,7:12],na.rm = TRUE),rowMeans(x[,13:18],na.rm = TRUE),rowMeans(x[,19:24],na.rm = TRUE))
head(x)

head(x)
x<-data.frame(x[,2:6],x[,26], x[,28],x[,27],x[,25])
head(x)
names(x)<-c('LIMIT_BAL','SEX','EDUCATION','MARRIAGE','AGE','AVG_REPAY_OVERDUE','AVG_BILL_REPAY','AVG_AMT_PAID','Y')
head(x)


hist(x$AVG_REPAY_OVERDUE)

hist(x$AVG_AMT_PAID)

#Sampling the data
smp_size <- floor(0.85 * nrow(x))
set.seed(123)
train_ind <- sample(seq_len(nrow(x)), size = smp_size)

train <- x[train_ind, ]
test <- x[-train_ind, ]
names(test)
#Build Logistic Regression
glm.fit <- glm(Y~LIMIT_BAL+SEX+MARRIAGE+AVG_REPAY_OVERDUE+AVG_BILL_REPAY+AVG_AMT_PAID,data=train, family=binomial(link="logit"))
summary(glm.fit)

prob <- predict(glm.fit, newdata=test, type="response")
pred <- rep(1,length(prob))
pred[prob<=0.27] <- 0


# Confusion MAtrix
#install.packages("caret")
#install.packages("e1071")
library(caret)
library(e1071)
confusionMatrix(pred,test$Y)


#Plotting ROC Curve
#install.packages("ROCR")
library(ROCR)
prediction <- prediction(prob,test$Y)
performance <- performance(prediction, measure = "tpr", x.measure = "fpr")
plot(performance, main="ROC curve",xlab="1-Specificity", ylab="Specificity",col=bluered(10))

# ROC area under the curve
prediction <- prediction(prob,test$Y)
auc.tmp <- performance(prediction,"auc")
auc <- as.numeric(auc.tmp@y.values)
print(auc)

#Precision Recall graph
prediction <- prediction(prob,test$Y)
performance <- performance(prediction,"prec","rec")
plot(performance, avg= "threshold", colorize=T, lwd= 3,
     main= "... Precision/Recall graphs ...")


#Lift curve
test$probs=prob
test$prob=sort(test$probs,decreasing = T)
lift <- lift(as.factor(Y) ~ prob, data = test)
xyplot(lift,plot = "gain")

=====================================================================================================
  
  
  x<-read.csv('C:/Users/ilanigam17/Desktop/ila1.csv', skip=2,header = FALSE)


x$V7[x$V7<0]<-0
x$V8[x$V8<0]<-0
x$V9[x$V9<0]<-0
x$V10[x$V10<0]<-0
x$V11[x$V11<0]<-0
x$V12[x$V12<0]<-0
x<-data.frame(x,rowMeans(x[,7:12],na.rm = TRUE),rowMeans(x[,13:18],na.rm = TRUE),rowMeans(x[,19:24],na.rm = TRUE))

x<-data.frame(x[,2:6],x[,26], x[,28],x[,27],x[,25])

names(x)<-c('LIMIT_BAL','SEX','EDUCATION','MARRIAGE','AGE','AVG_REPAY_OVERDUE','AVG_BILL_REPAY','AVG_AMT_PAID','Y')


hist(x$AVG_REPAY_OVERDUE)

hist(x$AVG_AMT_PAID)




maxs <- apply(x, 2, max) 
mins <- apply(x, 2, min)

scaled <- as.data.frame(scale(x, center = mins, scale = maxs - mins))

index <- sample(1:nrow(x),round(0.90*nrow(x)))
train_ <- scaled[index,]
test_ <- scaled[-index,]
test_$Y <- as.factor(test_$Y)
train_$Y <- as.factor(train_$Y)



#Neural Network
install.packages("nnet")
library(nnet)
#Build the model
fitnn <- nnet(Y~LIMIT_BAL+SEX+MARRIAGE+AGE+AVG_REPAY_OVERDUE+AVG_AMT_PAID+AVG_BILL_REPAY,data=train_, size=15,hess = T, dk=5e-4, maxit = 200)
summary(fitnn)

#Predict for test data
pred = predict(fitnn, newdata=test_, type="class")
str(test_)
#Confusion Matrix
library(caret)
library(e1071)
confusionMatrix(pred,test_$Y)

install.packages("NeuralNetTools")
library(NeuralNetTools)
plotnet(fitnn,circle_col = "lightblue", circle_cex = 3,pos_col = "darkgreen", neg_col = "red")


#Plot for fitted vs residual
df_nnet <- data.frame(residuals = fitnn$residuals, fitted = fitnn$fitted.values)
ggplot(data=df_nnet, aes(x=fitted, y=residuals)) + geom_point()




#Plotting ROC Curve
library(ROCR)
pred = predict(fitnn, newdata=test_, type="raw") #use raw type to get probablities for ad/nonad
prediction <- prediction(pred,test_$Y)
performance <- performance(prediction, measure = "tpr", x.measure = "fpr")
plot(performance, main="ROC curve",xlab="1-Specificity", ylab="Specificity",col=bluered(10))

# ROC area under the curve
pred = predict(fitnn, newdata=test_, type="raw")
prediction <- prediction(pred,test_$Y)
auc.tmp <- performance(prediction,"auc")
auc <- as.numeric(auc.tmp@y.values)
print(auc)


#Precision Recall graph
pred = predict(fitnn, newdata=test_, type="raw")
prediction <- prediction(pred,test_$Y)
performance <- performance(prediction,"prec","rec")
plot(performance, avg= "threshold", colorize=T, lwd= 3,
     main= "... Precision/Recall graphs ...")

#Lift curve
pred = predict(fitnn, newdata=test_, type="raw")
test_$probs=pred
test_$prob=sort(test_$probs,decreasing = T)
lift <- lift(Y ~ prob, data = test_)
xyplot(lift,plot = "gain")


#histogram of residuals and fitted values
par(mfrow=c(1, 2))
hist(fitnn$residuals,xlab = "Residual",main = paste("Histogram of Resdiuals"))
hist(fitnn$fitted.values,xlab = "Fitted Values",main = paste("Histogram of Fitted Values"))

==========================================================================================================
  
  
  x<-read.csv('C:/Users/ilanigam17/Desktop/ila1.csv', skip=2,header = FALSE)


x$V7[x$V7<0]<-0
x$V8[x$V8<0]<-0
x$V9[x$V9<0]<-0
x$V10[x$V10<0]<-0
x$V11[x$V11<0]<-0
x$V12[x$V12<0]<-0
x<-data.frame(x,rowMeans(x[,7:12],na.rm = TRUE),rowMeans(x[,13:18],na.rm = TRUE),rowMeans(x[,19:24],na.rm = TRUE))

x<-data.frame(x[,2:6],x[,26], x[,28],x[,27],x[,25])

names(x)<-c('LIMIT_BAL','SEX','EDUCATION','MARRIAGE','AGE','AVG_REPAY_OVERDUE','AVG_BILL_REPAY','AVG_AMT_PAID','Y')


hist(x$AVG_REPAY_OVERDUE)

maxs <- apply(x, 2, max) 
mins <- apply(x, 2, min)

scaled <- as.data.frame(scale(x, center = mins, scale = maxs - mins))

index <- sample(1:nrow(x),round(0.90*nrow(x)))
train_ <- scaled[index,]
test_ <- scaled[-index,]
test_$Y <- as.factor(test_$Y)
train_$Y <- as.factor(train_$Y)

  #Use variables to fit a classification tree
 #install.packages("tree")
  library(tree)
tree.train = tree(Y~.,data=train_)
summary(tree.train)

#Display the tree structure and node labels
plot(tree.train)
text(tree.train, pretty =0) #Pretty=0 includes the category names

#FancyRPlot
#install.packages("rpart")
#install.packages("rattle")
library(rpart)
library(rattle)
#install.packages("rpart.plot")
tree <- rpart(Y~.,data=train_,method="class")
fancyRpartPlot(tree)

tree.pred = predict(tree.train, test_, type ="class")
table(tree.pred, test_$Y)

#Confusion Matrix
library(caret)
library(e1071)
confusionMatrix(tree.pred,test_$Y)


#Plotting ROC Curve
library(ROCR)
tree.pred = predict(tree.train, test_, type ="vector") #use vector type to get probablities for ad and nonad as vectors
prediction <- prediction(tree.pred[,2],test_$Y)
performance <- performance(prediction, measure = "tpr", x.measure = "fpr")
plot(performance, main="ROC curve",xlab="1-Specificity", ylab="Specificity",col=bluered(10))

# ROC area under the curve
tree.pred = predict(tree.train, test_, type ="vector")
prediction <- prediction(tree.pred[,2],test_$Y)
auc.tmp <- performance(prediction,"auc")
auc <- as.numeric(auc.tmp@y.values)
print(auc)

#Precision Recall graph
tree.pred = predict(tree.train, test_, type ="vector")
prediction <- prediction(tree.pred[,2],test_$Y)
performance <- performance(prediction,"prec","rec")
plot(performance, avg= "threshold", colorize=T, lwd= 3,
     main= "... Precision/Recall graphs ...")

#Lift curve
tree.pred = predict(tree.train, test_, type ="vector")
test_$probs=tree.pred[,2]
test_$prob=sort(test_$probs,decreasing = T)
lift <- lift(Y ~ prob, data = test_)
xyplot(lift,plot = "gain")
