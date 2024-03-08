# Import the tree data CSV
tree <- read.csv(file="../trees91.csv",sep=",",head=TRUE)
names(tree)

# Import the W1 data
w1 <- read.csv(file="../w1.dat", sep=",",head=TRUE)
names(w1)

# Stripchart
# A stripchar is a the most simple charts. 
# It spreads the values on your x-axis by referencing a column. 
# One can also spread over the y-axis by using the option vertical=TRUE.
stripchart(w1$vals,method="stack",
             main='Stripchart Stack: Leaf BioMass in High CO2 Environment',
             xlab='BioMass of Leaves')

