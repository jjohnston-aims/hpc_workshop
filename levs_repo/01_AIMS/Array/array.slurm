#!/bin/bash
#SBATCH --job-name="file-array"
#SBATCH --ntasks=1
#SBATCH --time=0-00:15:00
#SBATCH --array=1-5

mkdir ${SLURM_ARRAY_TASK_ID}
