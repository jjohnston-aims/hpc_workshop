#!/bin/bash
#SBATCH --time=0:10:0
module load conda/anaconda3

eval "$(conda shell.bash hook)"

conda activate
conda install flask
conda list >> list.txt
conda deactivate
