#!/bin/bash
#SBATCH --time=0:10:0

module load python37

source ~/venvs/venv-3.7.12/bin/activate
pip install flash
deactivate
