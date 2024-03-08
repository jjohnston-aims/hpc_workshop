#!/bin/bash

#SBATCH --job-name=RArray
#SBATCH --array=1-9

echo "Starting task $SLURM_ARRAY_TASK_ID"
DIR=$(sed -n "${SLURM_ARRAY_TASK_ID}p" Rdirs)
cd $DIR

# Load the environment variables for R
module load R/4.1.3

# Run command
R --vanilla < *.r 


