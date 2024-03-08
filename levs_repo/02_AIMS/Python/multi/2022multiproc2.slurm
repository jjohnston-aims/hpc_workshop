#!/bin/bash
#SBATCH --ntasks=4



module load python37

srun -n 4 python3 multiproc2.py
