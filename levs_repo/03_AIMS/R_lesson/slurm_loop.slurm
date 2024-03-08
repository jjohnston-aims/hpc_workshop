#!/bin/bash
#SBATCH --job-name=slurm_loop
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --partition=memq
#SBATCH --mem=1GB
#SBATCH --output=slurm_loop.log
#SBATCH --error=slurm_loop.stderr

module load singularity
singularity exec -B .:/home/Project frk.sif Rscript slurm_loop.R
