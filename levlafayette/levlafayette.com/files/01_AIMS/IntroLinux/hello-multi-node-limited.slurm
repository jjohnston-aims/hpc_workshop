#!/bin/bash
#SBATCH --ntasks=16

# This directive limits the number of nodes
#SBATCH --nodes=1-4

# This directive allows for multiple partitions separated by commas
#SBATCH --partition=sapphire

module purge
module load foss/2022a
time srun mpi-helloworld


