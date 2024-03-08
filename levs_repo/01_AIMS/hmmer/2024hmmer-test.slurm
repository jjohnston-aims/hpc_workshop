#!/bin/bash

#SBATCH --job-name=HMMER-test.slurm

# One task, multi-threaded by default
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4

# set your minimum acceptable walltime=days-hours:minutes:seconds
#SBATCH -t 0:15:00

# Load the environment variables
module load hmmer/3.3.2

# Build a profile from a basic Stockholm alignment file
hmmbuild globins4.hmm globins4.sto

# Searche a profile against a sequence database.
hmmsearch globins4.hmm globins45.fa > searchresults.txt

