#!/bin/bash

# To give your job a name, replace "MyJob" with an appropriate name
#SBATCH --job-name=Rsample

# For R need to run on single CPU
#SBATCH --ntasks=1

# set your minimum acceptable walltime=hours:minutes:seconds
#SBATCH -t 0:15:00

# Load the environment variables for R
module load R/4.1.3

# The command to actually run the job
R --vanilla < log.r
R --vanilla < useawk.r
R --vanilla < twoaxes.r
R --vanilla < strings.r
R --vanilla < ebars.r
R --vanilla < bargraph.r
