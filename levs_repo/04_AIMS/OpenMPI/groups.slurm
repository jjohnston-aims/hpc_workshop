#!/bin/bash
#SBATCH --ntasks=8

module load openmpi4/gcc/4.0.5

# Compile mpi-helloworld executable with
# $ module load openmpi4/gcc/4.05
# $ mpicc mpi-helloworld.c -o mpi-helloworld

time mpiexec -n 8 ./mpi-group
