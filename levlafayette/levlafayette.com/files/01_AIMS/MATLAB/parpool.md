# Managing MATLAB Parpool

## What is a parpool
Short for 'Parallel Pool', it allows MATLAB to parallelise certain operations, reducing computation times. More info can be found at [https://www.mathworks.com/help/parallel-computing/parpool.html](https://www.mathworks.com/help/parallel-computing/parpool.html)

## Create a parpool in your MATLAB code
Firstly, let's create a MATLAB .m file

```
$ vim test-parpool.m
```

Then add

```
pc = parcluster('local')
pc.JobStorageLocation = getenv('SCRATCH')
parpool(pc, str2num(getenv('SLURM_CPUS_PER_TASK')))
```

For information about what parpools can do, see [https://hpc.nih.gov/apps/Matlabdct.html](https://hpc.nih.gov/apps/Matlabdct.html)

## Create a batch file

```
vim test-parpool.slurm
```

Add to this file

```
#!/bin/bash
#SBATCH --cpus-per-task=8
#SBATCH --time=01:00:00

module load matlab/2021a

export SCRATCH="/tmp/${SLURM_JOB_ID}_${SLURM_ARRAY_TASK_ID}"
mkdir -p $SCRATCH
matlab -nodesktop -nosplash < test-parpool.m
```

You can use `sbatch` to submit it to the queue

```
sbatch test-parpool.slurm
```

