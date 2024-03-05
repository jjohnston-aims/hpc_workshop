#!/bin/bash

# Originally from the Barry Rowlingson, University of Lancaster
# https://www.maths.lancs.ac.uk/~rowlings/HPC/RJobs/
# Converted to Slurm, Lev Lafayette. 20210217

#SBATCH --job-name=LancasterArray
# SBATCH --partition=snowy
#SBATCH --array=1-5

# Load the environment variables for R
module purge
module load foss/2022a
module load R/4.2.2 

R CMD BATCH runJobs.R Output/R-${SLURM_ARRAY_TASK_ID}.Rout

