# Import the tree data CSV
tree <- read.csv(file="../trees91.csv",sep=",",head=TRUE)
names(tree)

# Import the W1 data
w1 <- read.csv(file="../w1.dat", sep=",",head=TRUE)
names(w1)

# Quantile plots
# The quantile-quantile (q-q) plot is a graphical technique for determining if two data sets come from populations with a common distribution. 
# A q-q plot is a plot of the quantiles of the first data set against the quantiles of the second data set.
# The qqline shows the normal distribution of the data.

qqnorm(w1$vals,
         main="Normal Q-Q Plot of the Leaf Biomass",
         xlab="Theoretical Quantiles of the Leaf Biomass",
         ylab="Sample Quantiles of the Leaf Biomass")
        qqline(w1$vals)

