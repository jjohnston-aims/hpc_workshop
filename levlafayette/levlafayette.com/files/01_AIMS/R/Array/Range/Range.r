# Import the tree data CSV
tree <- read.csv(file="../trees91.csv",sep=",",head=TRUE)
names(tree)

# Import the W1 data
w1 <- read.csv(file="../w1.dat", sep=",",head=TRUE)
names(w1)


# Range (breaks)
# Change the spread of the range over the frequency by using breaks = [Number].
hist(w1$vals,main="Histogram Break Ranges 2",xlab="Biomass of Leaves", breaks = 2)
hist(w1$vals,main="Histogram Break Ranges 4",xlab="Biomass of Leaves", breaks = 8)
hist(w1$vals,main="Histogram Break Ranges 16",xlab="Biomass of Leaves", breaks = 16)

