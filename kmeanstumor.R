healthy <- read.csv("healthy.csv", header=FALSE)
healthyMatrix <- as.matrix(healthy)

#kmeans clustering algorithm
k=5
set.seed(1)

KMC = kmeans(healthyVector, centers=k, iter.max=10000)

image(healthyMatrix, axes=FALSE, col=grey(seq(0,1,length=256)))

healthyVector <- as.vector(healthyMatrix)
distance <- dist(healthyVector, method="euclidean")

k=5
set.seed(1)

KMC = kmeans(healthyVector, centers=k, iter.max=10000)

healthyClusters <- KMC$cluster

dim(healthyClusters) <- c(nrow(healthyMatrix), ncol(healthyMatrix))

image(healthyClusters, axes=FALSE, col=rainbow(k))

tumor <- read.csv("tumor.csv", header=FALSE)
tumorMatrix <- as.matrix(tumor)
tumorVector <- as.vector(tumorMatrix)

install.packages("flexclust")
library(flexclust)

KMC.kcca = as.kcca(KMC, healthyVector)
tumorClusters <- predict(KMC.kcca, newdata=tumorVector)
dim(tumorClusters) = c(nrow(tumorMatrix), ncol(tumorMatrix))
image(tumorClusters, axes=FALSE, col=rainbow(k))
