# Import the tree data CSV
tree <- read.csv(file="../trees91.csv",sep=",",head=TRUE)
names(tree)

# Import the W1 data
w1 <- read.csv(file="../w1.dat", sep=",",head=TRUE)
names(w1)

# Boxplot
# Provides a graphical view of the median, quartiles, maximum, and minimum of a data set. 
# The y-axis is the default plot direction. One can change this to the x-axis with the following option horizontal=TRUE.

boxplot(w1$vals, 
          main='Leaf BioMass in High CO2 Environment',
          ylab='BioMass of Leaves', horizontal=TRUE)

