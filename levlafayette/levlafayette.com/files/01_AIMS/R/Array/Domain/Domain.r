# Import the tree data CSV
tree <- read.csv(file="../trees91.csv",sep=",",head=TRUE)
names(tree)

# Import the W1 data
w1 <- read.csv(file="../w1.dat", sep=",",head=TRUE)
names(w1)

# Domain (xlim)
# Vary the size of the domain with the xlim option; determine the min and max range of the largest values.
# Domain spread close to the max value.

hist(w1$vals,main="Xlim Break Ranges 2",xlab="Biomass of Leaves", breaks=12,xlim=c(0,2))

