# A neural network classifier.
# The data was downloaded from http://archive.ics.uci.edu/ml/datasets/seeds#
# 2017-06-04
getwd()

dat <- read.table("./DataScience/NN/seeds_dataset.txt",sep="")
names(dat) <- c("Area","Perimeter","Compactness","Length","Width","AsymmetryCoef","KernelGrooveLength","Label")

dim(dat)

trainIndex <- sample(1:dim(dat)[1], dim(dat)[1]*0.7) # Get the index of train data, 0.7 for training data
trainIndex

testIndex <- setdiff(1:dim(dat)[1], trainIndex)      # Get the index of test data
testIndex

library(nnet)
# # The function is currently defined as
# class.ind <- function(cl)
# {
#   n <- length(cl)
#   cl <- as.factor(cl)
#   x <- matrix(0, n, length(levels(cl)) )
#   x[(1:n) + n*(unclass(cl)-1)] <- 1
#   dimnames(x) <- list(names(cl), levels(cl))
#   x
# }

# ideal: a matrix which is zero except for the column corresponding to the class
ideal <- class.ind(dat$Label)                        # Generates a class indicator function from a given factor
# Fit single-hidden-layer neural network, possibly with skip-layer connections
datANN <- nnet(dat[trainIndex, -8], ideal[trainIndex, ], size=10, softmax=TRUE) # Using Neural Network to Obtain the Model of Training Data Set

testLabel <- predict(datANN, dat[testIndex, -8], type="class")

my_table <- table(dat[testIndex, ]$Label, testLabel)
test_error <- 1 - sum(diag(my_table)) / sum(my_table)
test_error
