#!/bin/bash
#SBATCH --job-name="Search"
#SBATCH --time=0-00:5:00

module purge
module load GCC/11.3.0
module load Python/3.10.4
python3 search.py

##DO NOT ADD/EDIT BEYOND THIS LINE##
##Job monitor command to list the resource usage
my-job-stats -a -n -s

