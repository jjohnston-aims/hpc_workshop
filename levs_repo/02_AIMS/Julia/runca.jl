# A distributed version of Rule 30 cellular automaton.

# Derived from Przemysław Szufel, Bogumił Kamiński
# Julia 1.0 Programming Cookbook, 2018
# Invoke distributed paralellism
using Distributed
addprocs(4)

import Pkg; Pkg.add("ParallelDataTransfer")
@everywhere using ParallelDataTransfer


# Define Rule 30
@everywhere function rule30(ca::Array{Bool})
    lastv = ca[1]
    for i in 2:(length(ca)-1)
        current = ca[i]
        ca[i] = xor(lastv, ca[i] || ca[i+1])
        lastv = current
    end
end


# Define the function that can be used by an individual worker to acquire data from its neighbors
@everywhere function getsetborder(ca::Array{Bool},
                                  neighbours::Tuple{Int64,Int64})
    ca[1] = (@fetchfrom neighbours[1] caa[end-1])
    ca[end] = (@fetchfrom neighbours[2] caa[2])
end

# function to visualize the cellular automaton state
function printsimdist(workers::Array{Int})
    for w in workers
        dat = @fetchfrom w caa
        for b in dat[2:end-1]
            print(b ? "#" : " ")
        end
    end
    println()
end

# function for iterating over the cellular automaton state
function runca(steps::Int, visualize::Bool)
    @sync for w in workers()
        @async @fetchfrom w fill!(caa, false)
    end
    @fetchfrom wks[Int(nwks/2)+1] caa[2]=true
    visualize && printsimdist(workers())
    for i in 1:steps
        @sync for w in workers()
            @async @fetchfrom w getsetborder(caa, neighbours)
        end
        @sync for w in workers()
            @async @fetchfrom w rule30(caa)
        end
        visualize && printsimdist(workers())
    end
end

# define the simulation state variables for each worker node, along with information about its neighbors

wks = workers()
nwks = length(wks)
for i in 1:nwks
    sendto(wks[i],neighbours=(i==1 ? wks[nwks] : wks[i-1],
                              i==nwks ? wks[1] : wks[i+1]))
fetch(@defineat wks[i] const caa = zeros(Bool,15+2));
end

# run the distributed cellular automaton
runca(20,true)
