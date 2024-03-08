# Resources

Run seff to determine a job's resources *after* the job has completed.

This will help you a lot when determining the resources for the next job.

e.g.,

$ sbatch many-core.slurm
Submitted batch job 215918
...
$ seff 215918
Job ID: 215918
Cluster: aims-hpc
Use of uninitialized value $user in concatenation (.) or string at /cm/shared/a
pps/slurm/current/bin/seff line 154, <DATA> line 602.
User/Group: /systemd-resolve
State: COMPLETED (exit code 0)
Nodes: 1
Cores per node: 8
CPU Utilized: 00:00:00
CPU Efficiency: 0.00% of 00:08:08 core-walltime
Job Wall-clock time: 00:01:01
Memory Utilized: 4.07 MB
Memory Efficiency: 0.02% of 16.00 GB


If a job has an out-of-memory error or similar, memory can be increased either per job or per cpu e.g.,

# 16G for the entire job
#SBATCH --ntasks=1
#SBATCH --mem=16G

or

# 16G for each core
#SBATCH --ntasks=2
#SBATCH --mem-per-cpu=16G


Nodes on the AIMS cluster have roughly 8GB per core.

$ ssh hpc-c001
..
..
$ free -h
              total        used        free      shared  buff/cache   available
Mem:          503Gi       252Gi       1.6Gi       0.0Ki       249Gi       247Gi
Swap:          15Gi       6.3Gi       9.7Gi

$ lscpu | less
..
CPU(s):                          64
..

$ bc -l <<< 503/64
7.85937500000000000000

