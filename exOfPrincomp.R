# A simple Principal Components Analysis example using 'princomp' function.
# 2017-06-07 from Internet, Wang Weihua

set.seed(1000)
x1=rnorm(100)
x2=rnorm(100)
x3=rnorm(100)
data=data.frame(x1,x2,x3)
data.pr=princomp(data,cor=TRUE) # a logical value indicating whether the calculation should use the correlation matrix or the 
                                # covariance matrix. (The correlation matrix can only be used if there are no constant variables.)
data.pr
summary(data.pr,loadings=TRUE)
biplot(data.pr)
