#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=1:0:0

module purge
module load MATLAB/2023a_Update_1

time matlab -nodesktop -nodisplay -nosplash < tictoc.m
time matlab -nodesktop -nodisplay -nosplash < tictoc-p.m
