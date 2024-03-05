# Program make a simple calculator that can add, subtract, multiply and divide using functions

# Calculator functions
add <- function(x, y) {
return(x + y)
}
subtract <- function(x, y) {
return(x - y)
}
multiply <- function(x, y) {
return(x * y)
}
divide <- function(x, y) {
return(x / y)
}

# User input for the calculator
cat("Select the calculator operation.\n")
print("1.Add")
print("2.Subtract")
print("3.Multiply")
print("4.Divide")
cat("Please enter a number please: ");
choice <- as.integer(readLines("stdin",n=1));
cat("You entered")
print(choice);
cat( "\n" )

# User input for integers
cat("Enter your first integer.\n")
num1 <- as.integer(readLines("stdin",n=1));
cat("Enter your second integer.\n")
num2 <- as.integer(readLines("stdin",n=1));
operator <- switch(choice,"+","-","*","/")
operator <- switch(choice,"add","subtract","multiply","divide")
result <- switch(choice, add(num1, num2), subtract(num1, num2), multiply(num1, num2), divide(num1, num2))
print(paste(num1, operator, num2, "=", result))
