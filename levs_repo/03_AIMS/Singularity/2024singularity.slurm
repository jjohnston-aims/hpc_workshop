#!/bin/bash
#SBATCH --time=00:5:00

module load singularity/singularity.module

# Run a command from inside the container, and save it outside the container.

singularity exec vsoch-hello-world-master.simg echo "Hello from inside the container" > outside.txt
