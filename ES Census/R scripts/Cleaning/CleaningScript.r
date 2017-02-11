# Map 1-based optional input ports to variables
#dataset1 <- maml.mapInputPort(1) # class: data.frame

# Contents of optional Zip port are in ./src/
# source("src/yourfile.R");
# load("src/yourData.rdata");

data.set = read.csv("src/incomecensus.data.txt")
names(data.set) <- c("age", "workclass", "fnlwgt", "education", "education-num", "marital-status", "occupation", "relationship", "race", "sex", "capital-gain", "capital-loss", "hours-per-week", "native-country", "result")

#convert to characters
data.set$workclass = as.character(data.set$workclass)
data.set$occupation = as.character(data.set$occupation)
data.set$`native-country` = as.character(data.set$`native-country`)

#Replace with blank
data.set$workclass[data.set$workclass == ' ?'] = NA
data.set$occupation[data.set$occupation == ' ?'] = NA
data.set$`native-country`[data.set$`native-country` == ' ?'] = NA

#convert to factors
data.set$workclass = as.factor(data.set$workclass)
data.set$occupation = as.factor(data.set$occupation)
data.set$`native-country` = as.factor(data.set$`native-country`)

# Select data.frame to be sent to the output Dataset port
maml.mapOutputPort("data.set");