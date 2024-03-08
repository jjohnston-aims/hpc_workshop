#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4

module load julia/1.9.3
export JULIA_NUM_THREADS=4

julia --threads 4
