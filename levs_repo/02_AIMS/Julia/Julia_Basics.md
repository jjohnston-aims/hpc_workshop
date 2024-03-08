# Introduction

Julia is a high-level and high-performance programming language with features well suited for numerical analysis.

It was launched in 2012 with relatively modest development; v0.3 in 2014, v0.4 in 2015, and v0.5 in 2016 etc. In 2018 v1.0 was released.

In 2020, however there was a remarkable increase in downloads and usage with an 87% increase over the previous year. It still 
has a long way to go in the popularity contests however! At the time of writing it is #29 on the Tiobe Index, well behind R 
(#11) and MATLAB (#16), for example. But it does have some features that are generating attention.

1. It is designed with parallel computing in mind and can use MPI.
2. It can directly call C and Fortran libraries.
3. It uses a "Just Ahead of Time" compiler, writing machine-code just before execution.
4. It can run on GPGPUs.

The manifesto of the creators (Jeff Bezanson, Stefan Karpinski, Viral Shah, and Alan Edelman) is illustrative:

"We want a language that's open source, with a liberal license. We want the speed of C with the dynamism of Ruby. We want a 
language that's homoiconic, with true macros like Lisp, but with obvious, familiar mathematical notation like Matlab. We want 
something as usable for general programming as Python, as easy for statistics as R, as natural for string processing as Perl, 
as powerful for linear algebra as Matlab, as good at gluing programs together as the shell. Something that is dirt simple to 
learn, yet keeps the most serious hackers happy. We want it interactive and we want it compiled."

https://julialang.org/blog/2012/02/why-we-created-julia/

Help for keywords, functions, etc can be invoked with the `?` key.


## Variables and Types

Variable types in Julia are inferred and do not need to be explicitly typed, and they are case-sensitive. Julia even allows 
built-in constants or functions (e.g., pi) to be redefined, although this is usually not recommended, and as long as they are 
not already in use. Variables must begin with A-Z or a-z, and underscore, or even Unicode (UTF8) characters greater than 00A0, 
which includes currency symbols, numbers. Explicitly prohibited variable names are the built-in keywords (e.g., else, try, 
module, begin etc). By convention, variable names are in lower-case with word separation with an underscore.

```
some_string = "This is a string"
some_integer = 42
some_real = 0.00787
print(some_string)
```

Mathematical operations can be performed on numbers and variables and the results assigned to new variables.

```
sum = some_integer + some_real
difference = some_integer - some_real
product = some_integer * some_real
quotient = some_real / some_integer
power = some_integer^3
modulus = some_real % some_integer
```

A full-list of mathematical operators is available at the following URL:

https://docs.julialang.org/en/v1/manual/mathematical-operations/index.html


Every element in Julia has a type, which operates with a hierarchial structure. The root type is Any, which all elements belong 
to. The next group includes type Number, String, etc. Within the Number type there is the Real type. Within Real there are 
AbstractFloat and Integer types. Within AbstractFloat there is Float64 and Float32. The function `typeof` can be used to 
determine the type of an element.

```
typeof(some_real)
typeof(0.00787)
```

It is possible to change the type of variable within a program, although this is usually not recommended, with the convert 
function. This isn't always compatiable.

```
convert(Float64,some_integer)
convert(Integer,some_integer)
convert(Integer,some_string)
``` 

There's more on types in the Julia documentation: https://docs.julialang.org/en/v1/manual/types/

## Functions 

Functions take input, perform operations, and optionally return output. They use the keywords `function` and `end` to establish 
scope. It is a convention to indent functions by four spaces.

```
function gst(price)
    # Add 10% to price of a good or service) 
    return price * 1.10
end
```

A short function can be presented inline. 

```
price = 23.23
gst_price(price) = price*1.10
```

Functions don't have to return a value.

```
function your_friend()
    println("The Computer is your friend")
    return
end
```

Parameters can have a default value. For example, a function can convert a person's mass to their weight, depending on their 
weight on Earth and the gravity assigned, but with an Earth default. Descriptions of functions can be added immediately 
preceeding the function itself and this will be added to the help.

``` 
""" The myWeight function takes two parameters, the weight of a person and the gravity that the weight is on. The function will return 
the conversion of the weight to mass. 
""" 
function myWeight(weightOnEarth, g=9.81)
    return weightOnEarth*g/9.81
end
```

Without a specified g, the function call myWeight(90) will return the default value. If a new parameter for g is passed it will 
recalculate.

```
myWeight(90, 3.72) # Mars
myWeight(90, 8.87) # Venus
myWeight(90, 24.79) # Jupiter
```

## Data Structures: Arrays

Julia's data structures include arrays, tuples, and dictionaries. Arrays include vectors and matricies. A vector is a 
one-dimensional array of a list of ordered data with a common datatype. The following are examples of vectors.

```
my_strings = ["This string", "That string", "Everyone loves string"]
my_reals = [3.141, 9.81, 2.718]
my_ints = [2, 10, 1729]
```

Members of an array can be accessed with the syntax: array_name[element_number], e.g., `my_strings[2]` would access "That 
string". Note that in Julia array indicies start at 1, not 0.

An `append!` function can add an element to an array, e.g., `append!(my_ints,42)`. Attempts to append elements to an array with 
a different type will result in an error. Check the type with the `typeof` function (e.g., `typeof(my_ints)`.

If one wants to specify the type of the elements included in a vector is may be defined by using a type name before the 
elements. e.g., my_strings = String["This string", "That string", "Everyone loves string"]

## Data Structures: Matricies

Matrices are two dimensional arrays. Rows are separated by semi-colons, and fields are separated by spaces. Elements are 
accessed by name[row, colum]. This can be expanded using a _slice_, expressed a colon-separated range. Note that Julia uses a 
size based on rows and columns, and this can be determined by the size() function. When a slice is applied the initial range is 
the number of rows that it applies to, and the second value the number of fields. The `:` value represents all values across 
the dimension. Used by itself it can stack all dimensions into a single vector in field order. With the transpose, `'` it 
provides a vector in row-major order. A copy of an array or matrix can be made with the copy() function.

```
matrix1 = [16 3 2 13; 5 10 11 8; 9 6 7 12; 4 15 14 1]
size(matrix1)
matrix1[2,2]
array1 = matrix1[1,:]
slice1 = matrix1[1:2,3:4]
slice2 = matrix1[:,1:4]
stack1 = matrix1[:]
stack2 = matrix1'[:]
matrix1a = copy(matrix1)
```

In this example, matrix1 is Dürer's magic square. It has some interesting features, as the sum() function, applied across rows, 
fields, and diagonals, can illustrate. Other basic reduction operations include mean() (e.g., `mean(matrix1[1,:])`), max(), and 
min().

```
sum(matrix1)
sum(matrix1')
sum(diag(matrix1))
sum(diag(matrix1'))
sum(matrix1,1)
sum(matrix1,2)
sum(matrix1'[1,:])
sum(matrix1'[:,1])
```

Matrix-scalar operations can be applied on the element level. 

```
10*matrix1
matrix1/10
matrix2 = [1 2 3 4 5; 6 7 8 9 10]
matrix3 = [11 12 13 14 15; 16 17 18 19 20]
matrix4 = matrix2 + matrix3
matrix5 = matrix2 - matrix3
```

## Data Structures: Tuples

A tuple is a fixed-size group of variables that may have differing types. Once a tuple is created, their size cannot change. 
They are created simply by providing a variable and comma-separated values, either bracketed or not (although bracketed is 
recommended). There are several functions that can be performed on tuples, including an empty check, a length, mapping, and 
reversing. Elements can be accessed in the same manner as elements in array.

```
tuple1 = (1, 2, 3, "unu", "du", "tri") 
tuple2 = reverse(tuple1) 
length(tuple1) 
map(typeof, tuple1)
isempty(tuple1)) 
tuple1[4:6]
```

Their main use case is argument lists to functions. 

```
function eo_returns()
    return 10, 11, 12
end

(dekunu, dekdu, dektri) = eo_returns()
````

## Data Structure: Dictionaries

Dictionaries are data collections, organised into keys and values. A common example is an address book, including name, email 
address, 'phone, and date-of-birth.

```
person1 = Dict("Name" => "Penguino", "Email" => "penguino@example.com", "Phone" => 67243255211, "DoB" => 19681225)
person2 = Dict("Name" => "Adele", "Email" => "adele@example.com", "Phone" => 672481622181, "DoB" => 19890714)
```

A dictionary can contain other dictionaries.

```
addressBook = Dict("Penguino" => person1, "Adele" => person2)
```

A dictionary can be appended.

```
person3 = Dict("Name" => "Gwendy", "Email" => "gwendy@example.com", "Phone" => 672455091111, "DoB" => 19990501)
addressBook["Gwendy"] = person3
print(addressBook)
```

## Conditions

Logical conditions in Julia include logical "AND", represented by `&` and logical "OR", represented by `||`.

```
if 1 < 2 & 2 < 3 & 3 > 1 
	print("Transitive logic exists!")
end
```

Conditional statements use an `if-else-elseif-end` structure. A statement evaluates as true when the first conditional is 
satisfied, otherwise it moves to test the next and so on.

```
function magnitude(metric)
	if metric < 10
	    print("$metric is ones")
	elseif metric < 100
	    print("$metric is decas")
	elseif x < 1000
	    print("$metric is kilos")
	else
	    print("$metric is really big!")
	end
end
```


## Loops

The `for` construct is the basic loop structure for Julia and be applied over ranges and lists. The following example makes use 
of the random number function to generate ten lines of a 1 by 10 array of random numbers from 1 to 20, inclusive.

```
for i in 1:10
    println(rand(1:20,1,10)
end
```

An alternative is the while loop, which will incorporate a conditional control.

```
i=1
while(i<11)
println(rand(1:20,1,10))
    i += 1
end
```

Julia supports `break` and `continue` control statements in a loop.

The `break` statement terminates a loop on the condition.

```
for i in 1:20
    if i > 3
        break
    else
        println(i)
    end
end
```

The `continue` statement skips that iteration.

```
for i in 1:20
    if i == 3 || i == 13
        continue
    else
        println(i)
    end
end
```

A handy function in loops is `enumerate()`, which will track the number of iterations performed, returning an iterator in the 
form (i, x[i]).

```
list = ["a","b","c","d","e"]
for order in enumerate(list)
    println(order)
end
```


