#!/bin/bash
#SBATCH --job-name="octave-array"
#SBATCH --ntasks=1
#SBATCH --time=0-00:15:00

# This is the array
#SBATCH --array=1-10

module purge
module load foss/2022a
module load Octave/7.1.0 

octave file-${SLURM_ARRAY_TASK_ID}.oct


##DO NOT ADD/EDIT BEYOND THIS LINE##
##Job monitor command to list the resource usage
my-job-stats -a -n -s

