#!/bin/sh

#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --time=1

module purge
module load foss/2022a 
module load R/4.2.1

# Always use -n 1 for the Rmpi package. It spawns additional processes
# dynamically

mpirun -n 1 R CMD BATCH --no-save --no-restore Rmpi.R

