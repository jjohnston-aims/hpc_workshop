#!/bin/bash
# One task, one core, default partition, ten minutes walltime
module purge
module load MATLAB/2023a_Update_1 
matlab -nodesktop -nodisplay -nosplash< sigmoid.m
