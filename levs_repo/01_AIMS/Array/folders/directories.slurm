#!/bin/bash
#SBATCH --array=1-4

echo "Starting task $SLURM_ARRAY_TASK_ID"
DIR=$(sed -n "${SLURM_ARRAY_TASK_ID}p" case_list)
cd $DIR

# Place the code to execute here
pwd
ls
