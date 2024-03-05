#!/bin/bash

# To give your job a name, replace "MyJob" with an appropriate name
#SBATCH --job-name=RArray
#SBATCH --array=1-9

echo "Starting task $SLURM_ARRAY_TASK_ID"
DIR=$(sed -n "${SLURM_ARRAY_TASK_ID}p" Rdirs)
cd $DIR

# Load the environment variables for R
module purge
module load foss/2022a
module load R/4.2.2

R --vanilla < *.r 

