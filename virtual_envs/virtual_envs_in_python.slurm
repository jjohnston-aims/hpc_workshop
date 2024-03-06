#!/bin/bash
#SBATCH --time=0:10:0

module load python/37

source ~/virtual_envs/venvs/venv-3.7.12/bin/activate
pip install PACKAGE_NAME
python NAME_OF_SCRIPT
deactivate
