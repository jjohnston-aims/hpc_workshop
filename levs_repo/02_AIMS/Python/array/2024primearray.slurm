#!/bin/bash
#SBATCH --job-name="Prime Array"
#SBATCH --ntasks=1
#SBATCH --time=0-00:15:00
#SBATCH --array=1-2

module load python37
time python3 prime${SLURM_ARRAY_TASK_ID}.py

