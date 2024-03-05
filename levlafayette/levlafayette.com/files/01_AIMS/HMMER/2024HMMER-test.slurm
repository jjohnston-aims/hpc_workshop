#!/bin/bash

# To give your job a name, replace "MyJob" with an appropriate name
#SBATCH --job-name=HMMER-test.slurm

# One task, multi-threaded by default
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4

# set your minimum acceptable walltime=days-hours:minutes:seconds
#SBATCH -t 0:15:00

# Specify your email address to be notified of progress.
# SBATCH --mail-user=youremailaddress@unimelb.edu.au
# SBATCH --mail-type=ALL

# Load the environment variables
module purge
# module load foss/2022a
module load hmmer/3.3.2

# Build a profile from a basic Stockholm alignment file
hmmbuild globins4.hmm globins4.sto

# Searche a profile against a sequence database.
hmmsearch globins4.hmm globins45.fa > searchresults.txt


