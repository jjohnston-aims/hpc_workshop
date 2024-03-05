#!/bin/bash

#SBATCH --job-name=croniterate
#SBATCH --begin=now+1minute
#SBATCH --dependency=singleton
#SBATCH --qos=hpcadmin
#SBATCH --time=10:00:00

# To give your job a name, replace "MyJob" with an appropriate name
#SBATCH --job-name=MultithreadTest
# SBATCH --partition=cascade
#SBATCH --partition=sapphire
#SBATCH --nodelist=spartan-bm145

# Run with two threads
#SBATCH --ntasks=1 
#SBATCH --cpus-per-task=64

# Load the environment variables
module purge
module load GCC/11.3.0
export OMP_NUM_THREADS=64
time ./iterate

## Resubmit the job for the next execution
sbatch $0
