setwd("G:/Sem3/ADS/Assignment 1/Part 2/")

library(ISLR)
library(MASS)
library(leaps)

model1 <- na.omit(read.csv("sampleformat_temp_part2.csv"))
forecastInputTest <- na.omit(read.csv("forecastInput.csv"))

#Forward Selection
lm.fit=regsubsets (kwh~.-Account-Date,data=model1, method ="forward") 
reg.summary =summary (lm.fit)
names(reg.summary)
reg.summary
reg.summary$adjr2

#Backward Selection
lm.fit=regsubsets (kwh~.-Account-Date,data=model1, method ="backward") 
reg.summary =summary (lm.fit)
names(reg.summary)
reg.summary
reg.summary$adjr2

#Forward Backward Selection
lm.fit=regsubsets (kwh~.-Account-Date,data=model1, method ="both") 
reg.summary =summary (lm.fit)
names(reg.summary)
reg.summary
reg.summary$adjr2

#Exhaustive Search
lm.fit=regsubsets (kwh~.-Account-Date,data=model1) 
reg.summary =summary (lm.fit)
names(reg.summary)
reg.summary
reg.summary$adjr2


#Regression Line With Outliers
par(mfrow=c(1, 2))
plot(model1$temp, model1$kwh, xlim=c(-3300, 28), ylim=c(0, 230), main="With Outliers", xlab="temp", ylab="kwh", pch="*", col="red", cex=2)
abline(lm(kwh ~ temp, data=model1), col="blue", lwd=3, lty=2)

#Regression Line Without Outliers
plot(model2$temp, model2$kwh, xlim=c(-3300, 28), ylim=c(0, 230), main="Without Outliers", xlab="temp", ylab="kwh", pch="*", col="red", cex=2)
abline(lm(kwh ~ temp, data=model2), col="blue", lwd=3, lty=2)


#Univariate approach
par(mfrow=c(1, 2))
outlier_values <- boxplot.stats(model1$temp)$out  # outlier values.
boxplot(model1$temp, main="Temp kwh", boxwex=0.1)
mtext(paste("Outliers: ", paste(outlier_values, collapse=", ")), cex=0.6)

outlier_values <- boxplot.stats(model2$temp)$out  # outlier values.
boxplot(model2$temp, main="Temp kwh", boxwex=0.1)
mtext(paste("WithoutOutliers: ", paste(outlier_values, collapse=", ")), cex=0.6)


#Multivariate Model Approach
mod <- lm(kwh ~ .-Account-Date-Year, data=model1)
cooksd <- cooks.distance(mod)

plot(cooksd, pch="*", cex=2, main="Influential Obs by Cooks distance")  # plot cook's distance
abline(h = 1.3*mean(cooksd, na.rm=T), col="red")  # add cutoff line
text(x=1:length(cooksd)+1, y=cooksd, labels=ifelse(cooksd>1.3*mean(cooksd, na.rm=T),names(cooksd),""), col="red")

influential <- as.numeric(names(cooksd)[(cooksd > 1.3*mean(cooksd, na.rm=T))])  # influential row numbers
influencers <- model1[influential, ]
head(influencers)
model2<- model1[-influential, ]

lm.fit=lm(kwh~+DayOfWeek+Weekday+PeakHour+temp+I(temp^2), data=model2)
summary(lm.fit)


smp_size <- floor(0.9 * nrow(model2))
set.seed(123)
train_ind <- sample(seq_len(nrow(model2)), size = smp_size)

train <- model2[train_ind, ]
test <- model2[-train_ind, ]

lm.fit=lm(kwh~Weekday+PeakHour+temp+I(temp^2), data=train)
summary(lm.fit)

library(forecast)
pred = predict(lm.fit, test)
accuracy(pred, train$kwh)
p = accuracy(pred, train$kwh)
p = t(p)
write.csv(p,"PerformanceMatrix_part2.csv")


#Forecast ==========================
library(forecast)
pred = predict(lm.fit, forecastInputTest)
accuracy(pred, train$kwh)
write.csv(pred,"xyz.csv")
p = accuracy(pred, train$kwh)
p = t(p)
write.csv(p,"PerformanceMatrix.csv")
str(forecastInputTest)


capture.output(summary(lm.fit),"PerformanceMatrix.")

data <- coef(lm.fit,4)
regOutput<-data.frame(c("Account No","constant","Day of Week","Weekday","Peakhour","Temperature"))
newdata1 <-     data.frame(
  Account = "26435791004",
  constant =data[[1]],
  DayOfWeek = data[[2]],
  Weekday = data[[3]],
  Peakhour = data[[4]],
  Temperature = data[[5]]
)
newdata1
new2<-t(newdata1)
write.csv(new2,"RegressionOutputs.csv")


#=========================================================
library(randomForest)
install.packages("randomForest")

rf <- randomForest(kwh~+DayOfWeek+Weekday+PeakHour+temp+I(temp^2),data=model2, mtry = 5,ntree=250)
plot(rf,log="y")




