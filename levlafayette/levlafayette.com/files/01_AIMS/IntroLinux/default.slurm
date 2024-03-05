#!/bin/bash
# Uses Slurm defaults
# Default partition
# 1 node, 1 task, 1 cpu-per task
# 10 minutes walltime
# Loads no modules, just runs one command on compute node

whoami >> environment.txt
pwd >> environment.txt
ls >> environment.txt
date >> environment.txt
