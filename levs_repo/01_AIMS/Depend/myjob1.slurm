#!/bin/bash
#SBATCH --job-name="myjob1"
#SBATCH --time=0-000:02:00
#SBATCH --ntasks=1

echo $(hostname ) $SLURM_JOB_NAME running $SLURM_JOBID >> hostname.txt
sleep 60
