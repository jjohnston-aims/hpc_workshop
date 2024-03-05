# Import the tree data CSV
tree <- read.csv(file="../trees91.csv",sep=",",head=TRUE)
names(tree)

# Import the W1 data
w1 <- read.csv(file="../w1.dat", sep=",",head=TRUE)
names(w1)

# Scatter
# A graph in which the values of two variables are plotted along two axes, the pattern of the resulting points revealing any correlation present.

plot(tree$STBM,tree$LFBM,
       main="Relationship Between Stem and Leaf Biomass",
       xlab="Stem Biomass",
       ylab="Leaf Biomass")

