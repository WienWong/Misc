# Application of classification methods in modern medical diagnosis
# The data was downloaded from http://archive.ics.uci.edu/ml/datasets/Vertebral+Column
# 2017-06-05

getwd()

weka2C <- read.csv("./DataScience/NN/vertebral_column_data/column_2C_weka.arff", header=FALSE, comment.char = "@")
names(weka2C) <- c("pelvicIncidence","pelvicTilt", "lumbarLordosisAngle","sacralSlope","pelvicRadius","gradeOfSpondylolisthesis","class")

summary(weka2C)

set.seed(2)
# The first 210 are Abnormal while the last 100 are Normal. Randomly selected half as training data, the other half as test data
samp <- c( sample(1:210,105), sample(211:310,50) )

# Decision Tree
library(rpart) 

weka2C.rp <- rpart(class ~ ., weka2C[samp, ]) 

plot(weka2C.rp, branch=1, margin=0.2, main="Classification Tree")

text(weka2C.rp, col="blue")

table( weka2C$class[-samp], predict(weka2C.rp, weka2C[-samp, ], type="class") )
test_error <- 1 - (89+37)/(89+16+13+37)
test_error

table( weka2C$class[samp], predict(weka2C.rp, weka2C[samp,], type="class"))
train_error <- 1 - (96+43)/(96+9+7+43)
train_error

# Bagging
library(adabag)
library(rpart)

weka.bag <- bagging(class~., data=weka2C[samp,], mfinal=25, control=rpart.control(maxdepth=5))

weka.pred <- predict.bagging(weka.bag, newdata=weka2C[-samp, ]) # test set

weka.pred[-1]$error; weka.pred[-1]$confusion                    # test error

weka.predt <- predict.bagging(weka.bag, newdata=weka2C[samp, ]) # train set

weka.predt[-1]$error; weka.predt[-1]$confusion                  # train error

barplot(weka.bag$importance)

# Adaboost
library(mlbench)
library(adabag)
library(rpart)

weka.adab <- boosting(class~., data=weka2C[samp,], mfinal=15, control=rpart.control(maxdepth=5))
                    
weka.pred <- predict.boosting(weka.adab, newdata=weka2C[-samp,])
                    
weka.pred[-1]$error; weka.pred[-1]$confusion     # test error
                    
weka.predt <- predict.boosting(weka.adab, newdata=weka2C[samp,])
                    
weka.predt[-1]$error; weka.predt[-1]$confusion   # train error

barplot(weka.adab$importance)

# Neural Network
library(nnet)

weka.nn1 <- nnet(class~., data=weka2C, subset=samp, size=10, rang=0.1, decay=5e-4, maxit=1000)

table(weka2C$class[-samp], predict(weka.nn1,weka2C[-samp,], type="class"))
test_error <- 1 - (86+42)/(86+19+8+42)
test_error

table(weka2C$class[samp], predict(weka.nn1, weka2C[samp,], type="class"))
train_error <- 1 - (91+47)/(91+14+3+47)
train_error

# Weighted k-Nearest Neighbor Classifier 
library(kknn)

weka.knn <- kknn(class~., k=20, weka2C[samp,], weka2C[-samp,], distance=1, kernel="triangular")

summary(weka.knn)

fit <- fitted(weka.knn)

table(weka2C[-samp,]$class, fit)
test_error <- 1 - (90+37)/(90+15+13+37)
test_error

# Random Forest
library(randomForest)

weka.rf <- randomForest(class~., data=weka2C[samp,], importance=TRUE, proximity=TRUE)
  
table(weka2C[-samp,]$class, predict(weka.rf,weka2C[-samp,]))
test_error <- 1 - (92+41)/(92+13+9+41)
test_error

table(weka2C[samp,]$class, predict(weka.rf,weka2C[samp,]))
train_error <- 1 - (105+50)/(105+50)
train_error

# Support Vector Machine
library(class)
library(e1071)

model <- svm(class~., data=weka2C[samp,], kernal="sigmoid")

table(pred.train <- fitted(model), weka2C[samp,]$class)
train_error <- 1 - (101+33)/(101+17+4+33)
train_error

table(predict(model, weka2C[-samp,-7]), weka2C[-samp,]$class)
test_error <- 1 - (91+36)/(91+14+14+36)
test_error
