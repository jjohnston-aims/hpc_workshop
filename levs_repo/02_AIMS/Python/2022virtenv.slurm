#!/bin/bash
#SBATCH --time=0:15:0

module purge
module load foss/2022a
module load Python/3.10.4

# mkdir ~/virtualenv/
virtualenv ~/virtualenv/Python3.10.4
source ~/virtualenv/Python3.10.4/bin/activate
pip install flask
deactivate

