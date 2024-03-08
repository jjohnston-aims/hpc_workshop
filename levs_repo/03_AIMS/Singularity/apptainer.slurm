#!/bin/bash
#SBATCH --time=00:5:00

module purge
module load GCCcore/11.3.0
module load Apptainer/1.1.8

# Run a command from inside the container, and save it outside the container.

apptainer exec vsoch-hello-world-master.simg echo "Hello from inside the container" > outside.txt


##DO NOT ADD/EDIT BEYOND THIS LINE##
##Job monitor command to list the resource usage
my-job-stats -a -n -s

