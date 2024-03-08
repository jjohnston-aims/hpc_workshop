#!/bin/bash
#SBATCH --job-name="Search"
#SBATCH --time=0-00:5:00
#SBATCH --array=1-5

module load python37
python3 search.py random${SLURM_ARRAY_TASK_ID}.txt
