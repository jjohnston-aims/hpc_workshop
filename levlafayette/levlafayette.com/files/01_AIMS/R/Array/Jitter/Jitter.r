# Import the tree data CSV
tree <- read.csv(file="../trees91.csv",sep=",",head=TRUE)
names(tree)

# Import the W1 data
w1 <- read.csv(file="../w1.dat", sep=",",head=TRUE)
names(w1)

# Jitter
# When to many values are densed together, apply the method jitter to spread the values out, so it is more readable.
stripchart(w1$vals,method="jitter",
             main='Stripchart Jitter: Leaf BioMass in High CO2 Environment',
             xlab='BioMass of Leaves')

