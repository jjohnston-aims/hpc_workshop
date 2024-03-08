# Import the tree data CSV
tree <- read.csv(file="../trees91.csv",sep=",",head=TRUE)
names(tree)

# Import the W1 data
w1 <- read.csv(file="../w1.dat", sep=",",head=TRUE)
names(w1)

# Histograms
# Histograms plot the frequency that data is within a certain range. 
hist(w1$vals,main='Histogram: Leaf BioMass in High CO2 Environment',xlab='BioMass of Leaves')

