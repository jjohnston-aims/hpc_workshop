#!/bin/bash
#SBATCH --job-name="Sed Array"
#SBATCH --nodes=1
#SBATCH --time=0-00:15:00
#SBATCH --array=1-5

# First, create a file of random alphanumeric ASCII characters. 

shuf -n10000 /usr/share/dict/words > random${SLURM_ARRAY_TASK_ID}.txt

# Run the command; call a sed script
sed -i -f changes.sed random${SLURM_ARRAY_TASK_ID}.txt

