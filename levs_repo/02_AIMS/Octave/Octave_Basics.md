# GNU Octave Fundamentals

GNU Octave is a high-level language primarily useful for numerical computations. Numerical computations are those which use 
numerical, rather than symbolic, expressions.

An Octave program will usually run without modification on MATLAB, although the reverse is slightly less the case, as MATLAB has a 
larger collection of specialised and propertiary libraries, along with being a little looser in its formatting.

Octave provides an interactive command line interface and may also be used as a batch-oriented language for data processing. It is 
written in C++ and can be used with GNU Plot or Grace for plotting.

In the new build system, Octave can be invoked (e.g., in an interactive job), or included in a job script, with:

$ sinteractive --time=6:00:00 -X

$ module load octave/4.2.1

For the old build system, use:

$ source /usr/local/module/spartan_old.sh
$ module load Octave/3.8.2-goolf-2015a

OR

$ source /usr/local/module/spartan_old.sh
$ module load Octave/4.2.1-goolf-2015a

Octave Forge (https://octave.sourceforge.io/) is a community project for collaborative development of Octave packages. A modest 
collection of extensions are installed in the default (4.2.1) version. These include the control, general, io, signal, and 
statistics packages. To install a package from the Octave Forge, enter `pkg install -forge package_name` on the Octave prompt. This 
requires an internet connection. 

# Data and Argumentation Types

Octave does not require declaration of data-types or dimension statement. Memory is managed by the language. Built-in data types 
include real and complex numbers, and strings. By default numeric constants are represented within Octave in double-precision 
floating point format. A string constant consists of a sequence of characters, of any length, enclosed in either double-quote or 
single-quote marks. As the single quotation mark is also used as the transpose operator most Ocatve users consider the double quotation 
marks to be preferable.

Variables must begin with a letter or a underscore and can be followed by letters, numbers, or underscores. However, variables that 
begin and end with two underscores are reserved for internal use by Octave; as a result it is usually best just to start with a 
letter. Variables are also case-sensitive. The maximum length for a variable can be determined by invoking the function 
namelengthmax. Note that the built-in variable ans will always contain the result of the last computation.

Octave primaily operates on scalars, vectors, and matrices. An scalar is a number with magnitude (e.g., [10]), a vector is magnitude 
and direction ([10, 20, 30]) and a matrix is an array ([10, 20, 30; 1, 2, 3)]. Note that a vector can be expressed as row or field 
(e.g., [10, 20, 30] or [10;20;30], and a matrix can have one or more rows, or one or more fields. A vector can be considered to be a 
matrix with an array of 1, and a scalar can be considered as an array with one element. Thus scalars, vectors, and matricies are all 
matrices (of a sort). The size of a matrix is determined automatically. but it is up to the user to ensure that the rows 
and columns match.

```
octave:1> octa = [1, 2; 3, 4]
(snip)
octave:2> [octa, octa ]
octave:3>  [octa, 1 ]
error: horizontal dimensions mismatch (2x2 vs 1x1)
```

Whitespace is important, sometimes. For example, where there is no ambiguity in meaning Octave will simply consider whitespace as 
unimportant. However there is possibility that the whitespace could be interepreted as part of a calculation and the lack of 
whitespace as a value.

```
octave:3>  octa = [ 1 2
>            3 4 ]
..
octave:4> [ 1 - 1 ]
..
octave:5>   [ 1 -1 ]
..
```

A string in Octave is an array of characters. Internally the string "ddddd" is actually a row vector of length 5 containing the 
value 100 in all places (because 100 is the ASCII code of "d"). Using a matrix of characters, it is possible to represent a 
collection of same-length strings in one variable. The convention used in Octave is that each row in a character matrix is a 
separate string, but letting each column represent a string is equally possible.

The escape sequences in Octave are the same used in the C programming language, so users familiar with both will readily adapt. In 
double-quoted strings, the backslash character is used to introduce escape sequences that represent other characters.  In 
single-quoted strings however, the backslash is not a special character.  Consider the application of the toascii() function which 
converts a value to ASCII in a matrix.

```
octave:17> toascii ("\n") 
ans =  10 
octave:18> toascii ('\n') 
ans = 
   92   110 
```

The following is a table of all the escape sequences.

| Escape Cod	| Result					|
|:--------------|:----------------------------------------------|
| \\ 		| A literal backslash, ‘\’			|	
| \" 		| A literal double-quote character, ‘"’		|
| \' 		| A literal single-quote character, ‘'’		|
| \0 		| The “nul” character, control-@, ASCII code 0	|
| \a 		| The “alert” character, control-g, ASCII code 7|
| \b 		| A backspace, control-h, ASCII code 8		|
| \f 		| A formfeed, control-l, ASCII code 12		|
| \n 		| A newline, control-j, ASCII code 10		|
| \r 		| A carriage return, control-m, ASCII code 13	|
| \t 		| A horizontal tab, control-i, ASCII code 9	|
| \v 		| A vertical tab, control-k, ASCII code 11	|

With a single-quoted string there is only one escape sequence: two single quote characters in succession with generate a literal 
single quote.

The easiest way to create a character matrix is to put several strings together into a matrix.

`charmat = [ "String #1" " String #2" ; "String #3" " String #4" ];`

If a character matrix is created from strings of different length (as in the above example) Octave puts blank characters at the end 
of strings shorter than the longest string. It isn't possible to represent strings of different lengths, although it is possible to 
have a cell array of strings.
                 
Since a string is a character array, comparisons between strings work element by element. The strcmp(s1,s2) function will compare 
complete strings with case sensitivity. In comparison strncmp(s1,s2,N) compares only the first N characters. Case-insentive 
functions which are equivalent are strcmpi and strncmpi. As a search function, of sorts, validatestring(str,strarray) will validate 
the existence of a case insenstive string with the strotest match.
                 
```
octave:24> validatestring ("RED", {"redrum", "red", "green", "blue", "black", "reddish"})
ans = red
```
           
There is a variety of functions for string manipulation and conversions. Because a string is just a matrix standard operators can be 
used for a variety of changes. e.g., search and replace

```
octave:44> quote="The quick brown fox jumps over the lazy dog"
quote = The quick brown fox jumps over the lazy dog
octave:45> quote(quote==" ") = "_"
quote = The_quick_brown_fox_jumps_over_the_lazy_dog
```

Other functions like deblank(s) removes trailing whitespaces s, strtrim(s) removes leading and trailing whitespace, strtrunc (s, n) 
will truncate the string s to length n. Useful conversion functions include bin2dec(s), which will convert binary to decimal or 
dec2bin(s) which conducts the reverse. A more elaborate version is dec2base(s,base) which will convert a string of digits in a 
variable base to a decimal integer, and dec2base(d,base) which will do the reverse. The function str2double(s) will convert a string 
to a real or complex number.

Numbers in Octave are expressed in standard decimal notation optional decimal and positive or negative signs. Scientific notation 
uses the standard e to representa a power of 10 notation, and imaginary numbers use i or j as a suffix. Standard notion (+, -, *, /, 
^) and precedence (functions, transpose, exponent., logical not., multiply and divide., addition and subtraction., logical and and 
logical or., assignment) rules apply. Less typical notatiuon includes "left division" (\) for linerar algebra, ' (complex conjugate 
transpose), power operations (**).

Simple arithematic, trigonomic, inverse trigonomic, natural and base 10 logarithms, and absolute values can be carried out with 
Octave with sin, cos, tan, asin, acos, and atan. For logorithms, use log or log10. For absolute values use abs. The following 
examples illustrate these functions:

```
octave:5> 6 / 2 * 3
octave:6> 6 / (2 * 3)
octave:8> log10(100)/log10(10)
octave:9> sqrt(3^2 + 4^2)
octave:10> floor((1+tan(1.2)) / 1.2)
```

Various constants are also pre-defined: pi, e (Euler's number), i and j (for the imaginary number sqrt(-1)), inf (Infinity), NaN 
(Not a Number - resulting from undefined operations, such as Inf/Inf). e.g.,

```
octave:14> e^(i*pi)
```

Increment operators increase (++) or decrease (--) the value of a variable by one. If the expression is on the left hand side of the 
variable (++x, --x) the value of the expression is the new value of the variable (equivalent to x = x +1 or x = x -1). If it is on 
the right-hand side (x++, x--), the value of the expression is the old value of x.

Octave also includes standard comparison operations, less than (<), less than or equal (<=), equal (==), equal or greater than (>=), 
greater than (>), and not equal (~=, !=). Boolean operator are also in use for "or" (|), and (&), and not (!)..

## Matrix Mathematics

Matrices are either entered as an explicit list, generated by functions, created in .m files, or loaded from external files. 
Consider, for example, the "magic square" of Albrecht Dürer included in his famous engraving of 1514, Melencolia I (the simpler Lo 
Shu Square of China dates back up to 650 BCE!). In what way is it magic? This will illustrate some matrix operations.

Firstly, the matrix of the magic square is entered. The the sum of fields, or columns, is calculated. To provide a calculation of 
the sum of rows a transpose is required, of which there are two operators. The apostrophe operator (AD') will perform a complex 
conjugate trasnposition flips the matrix on the main diagonal and also changes the sign of any complex elemnts. The dot-apostrophe 
operator (AD.') peforms the flip, but keeps the sign. For matricies containing all reals, both operators provide the same result. 
The sum of the transpose of a transpose produces a field vector containing the sum of each row. The `diag` command will provide the 
elements on the main diagonal, which can be combined with sum. The opposite diagonal can be ascertained with the fliplr function, 
which flips a function from left to right.

```
octave:5> AD = [16 3 2 13; 5 10 11 8; 9 6 7 12; 4 15 14 1]
octave:5> sum(AD)
octave:5> AD'
octave:5> sum(AD')'
octave:5> diag(AD)
octave:10> sum(diag(AD))
octave:11> sum(diag(fliplr(AD)))
```

When there are two matrices of the same size, element by element operations can be performed on them. Whilst a simple example in 
terms of arithmatic, illustrates matrix addition of subelements, being the addition of the elements (row 1, column 4) plus (row 2, 
column 4) plus (row 3, column 4), and (row 4, column 4). Then, the following divides each element of A by the corresponding element 
in B:


```
octave:7> A(1,4)+A(2,4)+A(3,4)+A(4,4)
octave:11> A1 = [1, 6, 3; 2, 7, 4]
octave:12> A2 = [2, 7, 2; 7, 3, 9]
octave:13> A1 ./ A2
```

The dot divide (./) operator is used perform element by element division. There are similar operators for addition (.+), subtraction 
(.-), multiplication (.*) and exponentiation (.^). In addition Octave also has a syntax for left division (\), which is equivalent 
of inverse(x) * y, and element-by-element left division (.\), and transpose (.'). Note that when a potentially ambigious statement 
is made (e.g., 1./m) Octave by default treats the dot as part of the operator, rather than the constant i.e., (1)./m, rather than 
(1.)/m.

Octave includes support for two different mechanisms to contain arbitrary data types in the same variable. These are (i) Structures 
which are indexed with named fields, and (ii) cell arrays, where each element of the array can have a different data type and or 
shape. A structure contains elements, and the elements can be of any type. Structures may be copied and structure elements 
themselves may contain structures (which can contain structures and so forth). However Octave will not display to standard output 
all levels of a nested structure. In contrast, with a cell array several variables of different size and value can be stored in one 
variable. Cells are indexed by the { and } operators and can be inserted, retrieved, or changed from from this index.

```
octave:1> x.a = 1; 
octave:2> x.b = [1, 2; 3, 4]; 
octave:3> x.c = "string"; 
octave:4> x 
(snip)
octave:5:> y = {"a string", rand(2, 2)};
octave:5:> y{1:2}
(snip)
octave:6:> y{3} = 3;
(snip)
```

Automatic generation of vectors with a consistent increment takes the form of Start[:Increment]:End. For example;

```
octave:15> rv = [1:2:11]
octave:16> rv2 = [1:11]
```

Note the use of the colon; this can vary in Octave. In the above case it acts as a delimiter for increments, or for an automatic 
incrementor. In subscript it can be used to refer to incremented portions of a matrix, for example the sum of the first four elements 
of column 4, or all the elements of column 4 (in this case that's the same).

```
octave:17> sum(AD(1:4,4))
octave:18> sum(AD(:,end))
```

Octave can also carry out set operations. There are different core set operations in octave basically Octave can use vector, cell 
arrays or matrix as its set input operation. Given two simple matricies, union, intersection, can be illustrated as follows:

```
octave:19> Aset=[1 2 3]
..
octave:19> Bset=[3 4 5]
..
octave:19> union(Aset,Bset)  
ans =
   1   2   3   4   5
octave:26> intersect(Aset,Bset)
ans =  3
```

The difference operation, also called as the a-b operation, returns those element of a that are not in b. The Octave function 
ismember compared and the those elements that are present in the second set are marked as true rest are marked as false. Finally, 
the function setxor returns the elements exclusive to the sets listed in ascending order.

```
octave:27> setdiff(Aset,Bset)
octave:28> ismember(Aset,Bset)
octave:29> setxor(Aset,Bset)
```

## Manipulating Matrices

The following is a list of some of the common functions for matrix manipulation available in Octave. 

| Function	| Result					|
|:--------------|:----------------------------------------------|
| tril(A)	| Returns the lower triangular part of A	|
| triu(A)	| Returns the upper triangular part of A	|
| eye(n)  	| Returns the n\times n identity matrix. You can also use eye(m, n) to return m\times n rectangular identity matrices	|
| ones(m, n)	| Returns an m\times n matrix filled with 1s. Similarly, ones(n) returns n\times n square matrix. |
| zeros(m, n)	| Returns an m\times n matrix filled with 0s. Similarly, zeros(n) returns n\times n square matrix. |
| rand(m, n)	| Returns an m\times n matrix filled with random elements drawn uniformly from [0, 1). Similarly, rand(n) returns n\times n square matrix.	|
| randn(m, n)	| Returns an m\times n matrix filled with normally distributed random elements.	|
| randperm(n)	| Returns a row vector containing a random permutation of the numbers 1, 2, \ldots, n.	|
| diag(x) or diag(A).	| For a vector, x, this returns a square matrix with the elements of x on the diagonal and 0s everywhere else. For a matrix, A, this returns a vector containing the diagonal elements of A.	|

Index expressions in Octave permit the referencing or extracting selected elements of a matrix or vector. Indices can be scalars, 
vectors, ranges, or the special operator ‘:’, which can be used to select entire rows or columns, or elements in order of row then 
column. For example, given a simple matrix, the following basic selections can be easily established.

```
octave:22> z=[4 3 ; 2 1]
(snip)
octave:25> z(1,3)
error: A(I,J): column index out of bounds; value 3 out of bound 2
octave:26> z(2,1)
ans =  2
octave:27> z(2,2)
ans =  1
octave:28> z(1)
ans =  4
```

Additional bracketing within the selection ([x, y]) provides column selections. All of the following expressions are equivalent and 
select the first row of the matrix. The colon operator (:) can be used to select all rows or columns from a matrix.

```
octave:29> z(1, [1, 2])  # row 1, columns 1 and 2
octave:30> z(1, 1:2)     # row 1, columns in range 1-2
octave:31> z(1, :)       # row 1, all columns
```

A range of rows or columns can also be selected from a matrix in the general form of: start:step:stop

The first number in the range is start, the second is start+step, the third, start+2*step, etc. The last number is less than or 
equal to stop.

Rows and columns can be deleted from an Octave matrix using square brackets [] to represent null. Applying this to specific rows and 
columns can be achieved by using the colon as a separator between rows and columns, and the comma to distinguish particular colums. 
For example to remove column 3 then row 1.

```
octave:32> X=A
(snip)
octave:33> X(:,3)=[]
(snip)
octave:34> X(1,:)=[]
(snip)
```
A single element cannot be deleted from a matrix (e.g., X(1,2)=[]), because that would mean it is no longer a matrix! 

Finally, there is the keyword `end` that can be used when indexing into a matrix or vector. It refers to the last element in the row 
or column (e.g., x(end-2:end)).


## Polynomials

A polynomial expressions in Octave is represented by its coefficients in descending order. Consider the vector expression p:

`octave:31> p = [-2, -1, 0, 1, 2];`

The polynominal itself can be displayed by using the function output polyout, which displays the the polynominal in the variable 
specified (e.g., 'x'). The function polyval returns p(x), depending on the value assigned to x. If x is a vector or matrix, the 
polynomial is evaluated at each of the elements of x.

```
octave:31> polyout(p, 'x')
-2*x^4 - 1*x^3 + 0*x^2 + 1*x^1 + 2
octave:34> y=polyval(p, 5)
y = -1368
```

Polynominal multiplication is carried out by vector convolutions. This can be determined by r=conv(p,q). The two variables, p and q, 
are vectors containing the coefficients of two polynominals, and the result r contains the coefficients of their product.

```
octave:31> q = [1, 1];
octave:37> r = conv(p, q)
(snip)
```

Division is represented by deconvolving two vectors such that where [b, r] = deconv (y, a) solves for b and r such that y = conv (a, 
b) + r . If y and a are polynomial coefficient vectors, b will contain the coefficients of the polynomial quotient and R will be a 
remainder polynomial of lowest order.

Addition of polynomials in Octave has the issue that they are represented by vectors of their coefficients. As a result, addition of 
vectors of different lengths will fail. For example, for the polynominals p(x) = x^2 - 1 and q(x) = x + 1, addition will fail. To 
work around this, you have to add some leading zeroes to q, which does not change the polynomial.

```
octave:38> p = [1, 0, -1];
octave:39> q = [1, 1];
octave:40> p + q
error: operator +: nonconformant arguments (op1 is 1x3, op2 is 1x2)
error: evaluating binary operator `+' near line 22, column 3
octave:41> q = [0, 1, 1];
octave:42> p + q
(snip)
octave:43> polyout(ans, 'x')
1*x^2 + 1*x^1 + 0
```

Other simple functions include: 

roots(p), which returns a vector of all the roots of the polynomial with coefficients in p. The derivatives function; q = 
polyderiv(p), returns the coefficients of the derivative of the polynominal whose coefficients are given by the vector p.

q = polyint(p), which returns the coefficients of the integral of the polynomial whose coefficients are represented by the vector p. 
The constant of integration is set to 0.

p = polyfit(x, y, n), which returns the coefficients of a polynomial p(x) of degree n that best fits the data (x_i, y_i) in the 
least squares sense.
                
## Functions

The simple structure of a function in Octave is simply a function declation, name, body, and end of function declaration. The name 
of the function follows the same rules as a variable. The body will define what the function actually does. Normally, this will 
require an argument message to be parsed to the function after the name which is invoked from the function. If information is wanted 
from the function, as it is from most cases, the ret-var (return variable) is added. Multiple return values take the form of a 
bracketed list. There are also special parameters for variable length input argments (varargin) and return lists (varargout). As 
with other programming languages it is often considered good practise to assign default values to some input arguments.

function [ret-list] = name(arg1= val1, arg2 = val2 ...)
        body
endfunction

The following example of a function returns two values, the maximum element of a vector and the index where it first occurs.

```
     function [max, idx] = vmax (v)
       idx = 1;
       max = v (idx);
       for i = 2:length (v)
         if (v (i) > max)
           max = v (i);
           idx = i;
         endif
       endfor
     endfunction
```

As with blocks in other languages, a return statement can exit the function and return to the main program. Values must be assigned 
to the list of the return variables that are part of the function. This example function checks to see if any elements of a vector 
are nonzero:

```
     function retval = any_nonzero (v)
       retval = 0;
       for i = 1:length (v)
         if (v (i) != 0)
           retval = 1;
           return;
         endif
       endfor
       printf ("no nonzero elements found\n");
     endfunction
```

Normally an Octave user will want to save the functions that they written for later use. Such files, with a .m suffix, can be simply 
included in an invoked path from the Octave interpreter. When a function is called, Octave searches the current working directory 
and the Ocatve installation directory for the function. The path command will display this directory listing. New paths can be 
included with the addpath() function, the genpath() function for directories and subdirectories, and rmpath() to remove paths.

```
octave:12> path 
Octave's search path contains the following directories: 
(snip)
octave:14> addpath("~/mathsprog/octave") 
octave:12> path 
(path)
```

A function file may include functions in its own right, as subfunctions. An alternative is a function that calls another function in 
the path, or private functions. The advantage of the latter is that it is accessible by any number of functions, whereas a a 
subfunction is contained within the main function. Such private functions often take the role of "helper functions" carrying out 
generic tasks. With such variation there also needs to be some precedence within functions – it is possible that multiple versions 
of a function may be defined within a particular scope. Precedence is then assigned to subfunctions, private functions, command-line 
functions, autoload functions, and finally built-in functions.

Functions can also have function handles, effectively a pointer to another function. The general syntax is simply; handle = @function. As a similar variation, functions can also be anonymous using the syntax; handle = @(argumentlist) expression. A function can also be created from a string with the inline function.

```
octave:1> f = @sin; 
octave:2> quad (f, 0, pi) 
ans =  2 
octave:13> f = inline("x^2 + 2"); 
octave:14> f(6) 
ans =  38 
```

Because Octave is a programming and scripting language it is possible to turn octave scripts into commands that can be invoked from 
the command line rather than using the interpreter. This is conducted in a very similar manner to the scripting commands for shell 
scripts or even PBS. This is very useful for batch processing of data files. An algorithm that has been tested successfully in an 
interactive Octave session can then be saved as a script and executed independently (although, please don't do so on the login 
node).

Unlike a function file, a script must not begin with the function keyword – although it is possible to work around this by calling a 
statement that has no effect (e.g.. 1;). Further, the variable named within are not local, but are of the same scope of any other 
variable from the command line.

The first line of an Octave script, following the standard '#!' prefix, will to provide the path to the particular Octave binary.  
This can vary according to which version of Octave one wishes to use e.g.,

`#! /path/to/octave/bin/octave -qf`

The -qf is a standard option when launching Octave not to include any initialisation files and not to print start-up messages. The 
file can be executed either by modifying its permissions to make it executable or by invoking 'octave filename'. There is also the 
built-in function source(file).

It is useful to be able to save Octave commands and rerun them later on.  These should should be saved with a .m extension. To run 
an existing script in Octave, the path needs to be specified unless the environment is in the same directory as the script file.  
For example, if I have a script called myscript.m in an octave directory, the following two commands will execute the script.

``octave55>chdir('~/mathsprog/octave'); % This changes to the octave directory
octave56>myscript;``

## Global Variables, Conditions, and Loops

A variable may be declared and initialised as global, meaning that it can be accessed from within a function body without having to 
pass it as a formal parameter. It is, however, necessary declare a variable as global within a function body in order to access it.

```
global g
function f ()
  g = 1; # does NOT set the value of the global variable g to 1.
  global g = 1; # This will however
endfunction
f ()
```

As with other programming languages, Ocatve provides the faciility for instructions that conditional branching and loops. These 
include the if statement, the switch statement, the while statement, the do-until statement, the for statement, the break and 
continue statements.

The if statement statement takes the basic form of : if (condition) then-body endif. The if statement can have additional branching 
with else; if (condition) then-body else else-body endif, and even more branching with elseif. The following is a fairly simple 
example:

```
d100=fix(101*rand(1))
if (rem (d100, 2) == 0)
        printf ("d100 is even\n");
elseif (rem (d100, 3) == 0)
        printf ("d100 is odd and divisible by 3\n");
else
        printf ("d100 is odd\n");
endif
```

Elaborate if-elseif-else statement can however become unwieldly. As a result, Octave offers the switch statement as an alternative 
with the basic structure of switch(expression) case condition (body) case condition (body) case condition (body) … otherwise (body) 
endswitch. Note that, unlike in C for example, case statements in Octave are exclusive and command bodies are not optional.

```
d100=fix(101*rand(1))
switch d100
        case (rem (d100, 2) == 0)
                printf ("d100 is even\n");
        case (rem (d100, 3) == 0)
                printf ("d100 is odd and divisible by 3\n");
        otherwise
                printf ("d100 is odd\n");
endswitch                       
```

The while statement is the simplest sort of loop. It repeats a statement as long as an initial condition remains true. The general 
structure is: while (condition) body endwhile. If the condition is true, the body is executed. Then the condition is tested again. 
The following example uses the while statement for the first ten elements of the Fibonacci sequence in the variable fib.

```
fib = ones (1, 10);
        i = 3;
while (i <= 10)
        fib (i) = fib (i-1) + fib (i-2);
        i++;
endwhile
fib
(snip)
```

A variation is the do-until statement with the main difference is the conditional test occurs after an initial execution of the 
body. The general structure is: do body until (condition). The Fibonacci sequence is illustrated again:

```
fib = ones (1, 10);
i = 2;
do
        i++;
        fib (i) = fib (i-1) + fib (i-2);
until (i == 10)
fib
```

The basic structure of an Octave for loop is; for (var = expression) (body) endfor. The assignment expression assigns each column of 
the expression to var in turn. If expression is a range, a row vector, or a scalar, the value of var will be a scalar each time the 
loop body is executed. If var is a column vector or a matrix, var will be a column vector each time the loop body is executed.  
Again, using the Fibonacci sequence:

```
fib = ones (1, 10);
for i = 3:10
        fib (i) = fib (i-1) + fib (i-2);
endfor
```

Within Octave is it also possible to iterate over matrices or cell arrays using the for statement. 

```
# Matrix loop
for i = [1,3;2,4]
        i
endfor
(snip)
# Cell array loop
for i = {1,"two";"three",4}
         i
endfor
(snip)
```

Loops can be escaped with the break statement, which exits the innermost loop that encloses it. Naturally enough, it can only be 
used within the body of a loop. The following example finds the smallest divisor of a given integer, and identifies prime numbers. 
It uses a break statement to escape the first while statement when the remainder equals zero, proceeding immediately to the next 
statement following the loop.

```
num = 103;
div = 2;
while (div*div <= num)
  if (rem (num, div) == 0)
    break;
  endif
  div++;
endwhile
if (rem (num, div) == 0)
  printf ("Smallest divisor of %d is %d\n", num, div)
  else
  printf ("%d is prime\n", num);
endif
```

The continue statement is also used only inside loops. Where a condition is met, it skips over the rest of the loop body, causing 
the next cycle around the loop to begin immediately. In the following example, if one of the elements of vec is an odd number, this 
example skips the print statement for that element, and continues back to the first statement in the loop.

```
vec = round (rand (1, 10) * 100);
for x = vec
  if (rem (x, 2) != 0)
    continue;
  endif
    printf ("%d\n", x);
endfor
```



