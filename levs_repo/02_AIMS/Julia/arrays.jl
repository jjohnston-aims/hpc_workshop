using DelimitedFiles 

using Pkg
Pkg.add("SharedArrays")

@everywhere using SharedArrays

res = SharedArray(zeros(10))

@distributed for x in 1:10
    res[x] = my_func(x)
end

writelm("results.txt", res) 
