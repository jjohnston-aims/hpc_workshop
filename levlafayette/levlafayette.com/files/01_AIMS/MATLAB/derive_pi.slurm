#!/bin/bash
#SBATCH -p physicaltest
#SBATCH --ntasks=1
module purge
module load matlab
matlab -nodesktop -nodisplay -nosplash< mypi.m

