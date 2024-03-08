# R Program to remove 
# objects from Memory
  
# Creating a vector
vec <- c(1, 2, 3, 4)
  
# Creating a list
list1 = list("Number" = c(1, 2, 3),
             "Characters" = c("a", "b", "c"))
  
# Creating a matrix
mat <- matrix(c(1:9), 3, 3)
  
# Calling rm() Function
# to remove all objects
rm(list = ls())
  
# Calling ls() to check object list
ls()
