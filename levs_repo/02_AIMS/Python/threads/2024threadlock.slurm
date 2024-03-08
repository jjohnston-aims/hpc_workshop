#!/bin/bash
#SBATCH --cpus-per-task=4

module purge
module load foss/2022a
module load Python/3.10.4

srun python3 threadlock.py
