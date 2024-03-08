#!/bin/bash
#SBATCH --nodes=1-3
#SBATCH --ntasks=12

module load openmpi4/gcc/4.0.5

mpiexec -n 12 ./mpi-helloworld
