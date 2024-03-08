#!/bin/bash
#SBATCH --job-name="Search"
#SBATCH --time=0-00:5:00

module load python37
python3 search.py

