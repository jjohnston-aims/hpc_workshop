#!/bin/bash -l
#SBATCH --reservation=courseq
#SBATCH --partition=gpuq
#SBATCH --constraint=p100
#SBATCH --gres=gpu:1
#SBATCH --time=00:15:00
#SBATCH --export=NONE

module load pgi/18.3

cmd='time -p srun --export=all -n 1'

${cmd} pgprof --cpu-profiling-scope instruction --cpu-profiling-mode top-down --openacc-profiling on ./heat_eq_acc_v2 

##DO NOT ADD/EDIT BEYOND THIS LINE##
##Job monitor command to list the resource usage
my-job-stats -a -n -s

