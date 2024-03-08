Julia users sometimes require additional packages to be installed. Unfortunately these are not available system-wide, but rather have to be installed in each user's home directory. This is a multiple-step process, which requires downloading the metadata, followed by the packages required. For example:

See the following for more details:
http://web.mit.edu/julia_v0.6.0/julia/share/doc/julia/html/en/manual/packages.html


## Add a Package and Package Status

[lev@spartan ~]$ module load julia/1.9.3
[lev@spartan ~]$ julia
julia> import Pkg
julia> Pkg.add("JuMP")
INFO: Initializing package repository /home/lev/.julia/v0.6
INFO: Cloning METADATA from https://github.com/JuliaLang/METADATA.jl
....

Pkg.add also conducts a Pkg.build(). 

And that takes a while - as the feedback says it copies the metadata for *every* package and *every* version in your home 
directory. e.g.,

$ cd ~/.julia/v1.9.3/tmpC5OSJ4/METADATA
$ ls
AbaqusReader                      ExpressionPatterns
AbbrvKW                           ExpressionUtils
AbstractAlgebra                   ExprOptimization
AbstractDomains                   ExprRules
AbstractFFTs                      ExtensibleScheduler
AbstractNumbers                   Extern
AbstractOperators                 ExtractMacro
AbstractTables                    ExtremelyRandomizedTrees
AbstractTrees                     ExtremeStats
Accumulo                          EzXML
...

julia> Pkg.status()
INFO: Initializing package repository /home/lev/.julia/v0.6
INFO: Cloning METADATA from https://github.com/JuliaLang/METADATA.jl
No packages installed

julia> Pkg.add("JuMP")
INFO: Cloning cache of BinDeps from https://github.com/JuliaLang/BinDeps.jl.git
INFO: Cloning cache of Calculus from https://github.com/JuliaMath/Calculus.jl.git
....
INFO: Installing BinDeps v0.8.8
INFO: Installing Calculus v0.4.0
INFO: Installing CommonSubexpressions v0.1.0
INFO: Installing Compat v0.65.1
INFO: Installing DataStructures v0.8.3
INFO: Installing DiffResults v0.0.3
INFO: Installing DiffRules v0.0.4
INFO: Installing ForwardDiff v0.7.5
INFO: Installing JuMP v0.18.1
INFO: Installing MathProgBase v0.7.1
INFO: Installing NaNMath v0.3.1
INFO: Installing ReverseDiffSparse v0.8.1
INFO: Installing SHA v0.5.7
INFO: Installing SpecialFunctions v0.4.0
INFO: Installing StaticArrays v0.7.0
INFO: Installing URIParser v0.3.1
INFO: Building SpecialFunctions
INFO: Package database updated


## Update and Remove

When a new versions is introducted, one can update can update with:

julia> Pkg.update("JuMP")

To remove a package (and dependencies) use rm(pkg)

julia> Pkg.rm("JuMP")
...
