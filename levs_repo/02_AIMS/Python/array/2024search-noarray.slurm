#!/bin/bash
#SBATCH --job-name="Search No Array"
#SBATCH --time=0-00:5:00

module load python37

for item in random*.txt; do python3 search.py "$item"; done

