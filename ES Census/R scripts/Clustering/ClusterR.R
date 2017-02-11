setwd("C:/Users/aysrivastava/Documents/my/Assignment3")

model1 <- (read.csv("USCensus1990.data.csv"))
data<- model1[1:50000,]
pc <- princomp(data)

plot(pc)
plot(pc, type='l')
summary(pc)
mar <- par()$mar
par(mar=mar+c(0,5,0,0))
barplot(sapply(data, var), horiz=T, las=1, cex.names=0.8)
barplot(sapply(data, var), horiz=T, las=1, cex.names=0.8, log='x')
par(mar=mar)
data2 <- data.frame(scale(data))
plot(sapply(data2, var))

pc1 <- princomp(data2)
summary(pc1)
plot(pc1)
plot(pc1, type='l')


pc <- prcomp(data2)
comp <- data.frame(pc$x[,1:6])
plot(comp, pch=16, col=rgb(0,0,0,0.5))

k <- kmeans(comp, 12, nstart=30, iter.max=1000)
library(RColorBrewer)
library(scales)
palette(alpha(brewer.pal(9,'Set1'), 0.5))
plot(comp, col=k$clust, pch=16)


# Cluster sizes
sort(table(k$clust))
clust <- names(sort(table(k$clust)))

# First cluster
row.names(data[k$clust==clust[1],])
# Second Cluster
row.names(data[k$clust==clust[2],])
# Third Cluster
row.names(data[k$clust==clust[3],])
# Fourth Cluster
row.names(data[k$clust==clust[4],])
row.names(data[k$clust==clust[5],])
row.names(data[k$clust==clust[6],])
row.names(data[k$clust==clust[7],])
row.names(data[k$clust==clust[8],])
row.names(data[k$clust==clust[9],])
row.names(data[k$clust==clust[10],])
row.names(data[k$clust==clust[11],])
row.names(data[k$clust==clust[12],])

data[k$clust==clust[1],30:33]
data[k$clust==clust[2],30:33]