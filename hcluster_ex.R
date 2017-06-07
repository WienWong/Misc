# An example using 'hcluster'
# 2017-06-07 from Internet, Wang Weihua 
set.seed(1234)
x=runif(10)            
y=runif(10)
S=cbind(x,y)                                  
rownames(S)=paste("Name",1:10," ")             
out.dist=dist(S,method="euclidean")           # to distance

out.hclust=hclust(out.dist,method="complete") # cluster according to distance

plclust(out.hclust)                           # 'plclust' is deprecated.
#plot(out.hclust)                             # this also generates dendrogram, but can not run the next line of code. 
rect.hclust(out.hclust,k=3)                   # 3 sub clusters are generated using rectangular box 

out.id=cutree(out.hclust,k=3)                 # the value corresponding to each cluster

out.id
# Name 1    Name 2    Name 3    Name 4    Name 5    Name 6    Name 7    Name 8    Name 9   Name 10   
# 1         2         2         3         2         3         1         1         2         2 
table(out.id,paste("Name",1:10," "))  
# out.id Name 1   Name 10   Name 2   Name 3   Name 4   Name 5   Name 6   Name 7   Name 8   Name 9  
# 1        1         0        0        0        0        0        0        1        1        0
# 2        0         1        1        1        0        1        0        0        0        1
# 3        0         0        0        0        1        0        1        0        0        0
