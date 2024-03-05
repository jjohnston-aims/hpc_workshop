#!/bin/bash
# One task, one core, default partition, ten minutes walltime
module purge
module load MATLAB/2023a_Update_1

matlab -nodesktop -nodisplay -nosplash< polar-plot.m

##DO NOT ADD/EDIT BEYOND THIS LINE##
##Job monitor command to list the resource usage
my-job-stats -a -n -s

