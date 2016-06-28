rm(list=ls())
setwd("G:/Sem3/ADS/Assignment2/Part2/")
#install.packages("tree")
library (tree)
library (MASS)
library (ISLR)
model1 <- na.omit(read.csv("Hourly_filled_data.csv",stringsAsFactors = FALSE))

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

#Sampling Data
train = sample (1:nrow(model3), nrow(model3)/2)
tree.model3 = tree(kwh~+DayOfWeek+Weekday+Hour+PeakHour+temp,model3,subset=train)
summary (tree.model3)
plot (tree.model3)
text (tree.model3, pretty = 0)
cv.model3 = cv.tree (tree.model3)
plot (cv.model3$size, cv.model3$dev, type='b')

# prune.model3 =prune.tree(tree.model3, best = 5)
# plot(prune.model3)
# text(prune.model3, pretty = 0)

forecastTestInput <- na.omit(read.csv("forecastInput2.csv",stringsAsFactors = FALSE))
yhat=predict (tree.model3, newdata =model3 [-train,])
test=model3 [-train,"kwh"]
plot(yhat,test)
abline (0,1)
mean((yhat -test)^2)

#MergeData
dataToMerge <- na.omit(read.csv("forecastNewData2.csv",stringsAsFactors = FALSE))
predictionResults <- data.frame(dataToMerge, kwh = yhat)
write.csv(predictionResults,"forecastOutput_26435791004_regressionTree2.csv",row.names = FALSE)

yhat=predict (tree.model3, newdata =model3 [-train,])
boston.test=model3 [-train,"kwh"]
plot(yhat,tree.model3)
abline (0,1)
mean((yhat -tree.model3)^2)
library(forecast)
accuracy(yhat, boston.test)
p = accuracy(yhat, boston.test)
p = t(p)
write.csv(p,"PerformanceMatrix_part2a.csv")