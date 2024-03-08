#!/bin/bash
#SBATCH --time=0:15:0

module purge
module load foss/2022a
module load SciPy-bundle/2022.05

python3 numpytutorial.py
