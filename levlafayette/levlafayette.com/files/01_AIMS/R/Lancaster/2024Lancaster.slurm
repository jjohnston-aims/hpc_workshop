#!/bin/bash

# Originally from the Barry Rowlingson, University of Lancaster
# https://www.maths.lancs.ac.uk/~rowlings/HPC/RJobs/
# Converted to Slurm, Lev Lafayette. 20210217

# To give your job a name, replace "MyJob" with an appropriate name
#SBATCH --job-name=RLancaster
# SBATCH --partition=physical
# SBATCH -t 0:15:00

# Load the environment variables for R
module purge
module load foss/2022a
module load R/4.2.2 

# Start the job
echo Starting task $SLURM_JOB_ID

# The command to actually run the job
R CMD BATCH runJob.R > Output/R-${SLURM_JOB_ID}.Rout

