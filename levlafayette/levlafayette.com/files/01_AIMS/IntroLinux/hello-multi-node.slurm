#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=4
module purge
module load foss/2022a
time srun mpi-helloworld


