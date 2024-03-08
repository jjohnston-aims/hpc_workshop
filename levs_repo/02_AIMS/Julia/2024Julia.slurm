#!/bin/bash
#SBATCH --time=00:10:00

# Load Modules
module load julia/1.9.3

# Run Example
julia simple.jl

