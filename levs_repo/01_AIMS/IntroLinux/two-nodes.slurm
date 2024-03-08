#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=4

module load openmpi4/gcc/4.0.5

# This asks for 9 cores, but only 8 cores requested!
# This job will fail!
mpiexec -n 9 ./mpi-helloworld
