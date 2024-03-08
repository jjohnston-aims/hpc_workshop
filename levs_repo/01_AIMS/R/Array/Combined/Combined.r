# Import the tree data CSV
tree <- read.csv(file="../trees91.csv",sep=",",head=TRUE)
names(tree)

# Import the W1 data
w1 <- read.csv(file="../w1.dat", sep=",",head=TRUE)
names(w1)

# Combined plots

hist(w1$vals,main="Leaf BioMass in High CO2 Environment Combined",xlab="BioMass of Leaves",ylim=c(0,16))
boxplot(w1$vals,horizontal=TRUE,at=16,add=TRUE,axes=FALSE)
stripchart(w1$vals,add=TRUE,at=15)

