#!/bin/bash
#SBATCH --job-name="octave-array"
#SBATCH --ntasks=1
#SBATCH --time=0-00:15:00

# This is the array
#SBATCH --array=1-10

# Uses singularity!
module load octave/8.4.0 

# Arrays don't need to be based on data, it can be programs as well.
octave file-${SLURM_ARRAY_TASK_ID}.oct


