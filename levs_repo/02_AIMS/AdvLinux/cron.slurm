#!/bin/bash
#SBATCH --job-name=cron
#SBATCH --begin=now+7days
#SBATCH --dependency=singleton
#SBATCH --time=00:10:00

sh backup2.sh

## Resubmit the job for the next execution
sbatch $0
