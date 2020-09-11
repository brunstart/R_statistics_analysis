library(sampling)
library(doBy)

data <- read.csv('data/titanic_data.csv')

sample_data <- sample_by(data=data, formula=~1, frac=.8, replace=T, systematic = T)
sample_data
nrow(sample_data)

dim(data)[1]

idx <- sample(1:dim(data)[1], size=100)
data[idx,]

idx <- sample(2, nrow(data), replace=T, prob = c(0.8, 0.2))

trData <- data[idx == 1, ]
nrow(trData)

trData
teData <- data[idx == 2, ]
teData

nrow(trData)
nrow(teData)

table(data$Pclass)
table(data$Survived)

data1 <- xtabs(~Pclass ,data=data)
data2 <- xtabs(~Survived, data=data)
data1; data2

prop.table(data1)
prop.table(data2)

chisq.test(xtabs(~ Fare + Survived, data=data))

m <- lm(data$Fare ~ data$Survived)
m

residuals(m)
deviance(m)/length(data$Survived)
summary(m)
