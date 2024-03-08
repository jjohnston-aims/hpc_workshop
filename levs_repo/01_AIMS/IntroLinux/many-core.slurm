#!/bin/bash
#SBATCH --ntasks=2
#SBATCH --mem=16G

module load openmpi4/gcc/4.0.5

time mpiexec -n 2 ./mpi-helloworld
