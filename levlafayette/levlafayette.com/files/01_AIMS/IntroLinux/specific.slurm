#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --nodelist=hpc-c001
# Alternative to exclude specific nodes.
# SBATCH --exclude=hpc-c001

echo $(hostname ) $SLURM_JOB_NAME running $SLURM_JOBID >> hostname.txt


