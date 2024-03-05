#!/bin/bash
#SBATCH --ntasks=8
module purge
module load foss/2022a
time srun mpi-helloworld
