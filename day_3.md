HPC Workshop day 3
==================

## MPI

to use MPI the program must be written for it. see `./01_AIMS/IntroLinux/mpi-helloworld.c` for an exmpla of a C program written for MPI.

Compile the c code in an MPI way, using `mpicc` to compile:

`mpicc ./01_AIMS/IntroLinux/mpi-helloworld.c -o ./01_AIMS/IntroLinux/mpi-helloworld`

Now we have an MPI executable program.

We must load the module in order to make use of MPI. So this in our slurm script:

`module load openmpi4/gcc/4.0.5`

run it with the two-core.slurm script. For example:

```bash
#!/bin/bash
#SBATCH --ntasks=2
# TODO: confirm this:
# could do:
# #SBATCH --ntasks=1
# #SBATCH --ntasks-per-node=2

module load openmpi4/gcc/4.0.5 # this knows what mpiexec is and will run it in two cores.

time mpiexec -n 2 ./mpi-helloworld
```

TODO: what happens if you had `-n 3`? **It would fail because **

two-nodes.slurm example:

```bash
#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=1

module load openmpi4/gcc/4.0.5

mpiexec -n 2 ./mpi-helloworld
```

many-core.slurm example:

```bash
#!/bin/bash
#SBATCH --ntasks=32

module load openmpi4/gcc/4.0.5

time mpiexec -n 32 ./mpi-helloworld
```

There is no order. to the processing of each core. If you need to ensure an order, you can put locks on things, but this makes it more serial in nature so there are tradeoffs to speed in ensuring order.

multi-limited.slurm example:

```bash
#!/bin/bash
#SBATCH --nodes=1-3
#SBATCH --ntasks=12

module load openmpi4/gcc/4.0.5

mpiexec -n 12 ./mpi-helloworld
```

This limits the number of nodes, If we had 12 tasks on 12 different nodes, there might be a lot of communication which limits the speed. But this has the advantage over limiting to a single node is that it might get on the queue faster.

To help determine what resources to request, we can ssh into a node and see what's available:

`free -h` to see memory

`lscpu | less` to see stats on the cpu

see ./01_AIMS/IntroLinux/*.slurm for some examples of basic MPI jobs.

### Stats in the output

Get your own stats by putting

```bash
sleep 30  # to make sure the job has finished running?
seff $SLURM_JOBID
```

and this will give you some stats at the end of the job output. it will not be 100% acurate because the job will still be running when `seff` runs, but it's a good indication of the stats.

## Python

### Virtual environments

Load a version of python with the `module load` command:

`module load python37`

If you need a version of python that is not installed, you would go to your system admin and ask for it to be installed and available as a module. Don't use conda becuase then you will have multiple way of managing installed packages on the HPC.

Create a virtaul environment:

`virtualenv ./venv-3.7.12`

Activate it:

`source ./venv-3.7.12/bin/activate`

From here anything you install will go into this virtaul environment which is tied to this version of python.

example slurm script:

```
#!/bin/bash
#SBATCH --time=0:10:0

module load python/37

source ~/virtual_envs/venvs/venv-3.7.12/bin/activate
pip install PACKAGE_NAME
python NAME_OF_SCRIPT
deactivate
```

### conda

Here is an example of a conda environment in a slurm script:

```
#!/bin/bash
#SBATCH --time=0:10:0
module load conda/anaconda3

eval "$(conda shell.bash hook)"

conda activate
conda install flask
conda list >> list.txt
conda deactivate
```

Be careful of using conda because it's often not allowed on HPCs and using modules is preferred.

### Singularity

Singularity also can be built from a Dockerfile with python by this package: https://singularityhub.github.io/singularity-cli/

Singularity is an alternative to docker, but the process doesn't run as root. You have the same rights outside the container as inside. It even uses the same docker docker images/commands?

Gere is how we would run one:

```
#!/bin/bash
#SBATCH --time=00:5:00

module load singularity/singularity.module

# Run a command from inside the container, and save it outside the container.

singularity exec vsoch-hello-world-master.simg echo "Hello from inside the container" > outside.txt
```

The `Singularity` file works similar to a docker file.

First you create your docker container recipe in a Dockerfile and build it with docker build. Then you save to a tar file.

`docker save CONTAINER_NAME -o FILENAME.tar`

Then you do a few things with temp files and directories:

```
mkdir singularity_tmpdir
export SINGULITY_TMPDIR=$PWD/singularity_tmpdir
TMPDIR=$PWD/singularity_tmpdir
```

Then you convert it to a singularity file:

`singularity build FILENAME.sif docker-archive://FILENAME.tar`

Then copy it to the HPC and you will be able to run your built container.

Diego will send details of the above summary.

## Parallel processing script speed

[Amdahl's law](https://en.wikipedia.org/wiki/Amdahl%27s_law)

There is a limit to the amount that a paraellel job can impirove the speed. That limit is related to what portion of the job can be run in parallel. If youre program is 5% serial and 95% parallel, you will never get more than 20x the speed improvement no matter how many processors you add. If you added infinite processors and the parallel part was instant, it would still take the same amount of time to run the serial part.

You can however, process more data so that the percentage of your program that is serial is less.

Thre is a good analogy for this. Pretend like you are driving Townsville to Brisbane and at Rockhampton your car gets upgraded to a "multi core" car. From Rocky onwards you are parallel. But no matter how fast your car gets after Rockhampton, you will always be at least as slow as the time it takes to drive to Rocky.

## R 

Reproducabtility in R is a problem when an old version of a library cannot be found. The [Posit Package Manager](https://docs.posit.co/rspm/admin/repositories/) has been created to solve this problem. It takes a snapshot of the CRAN repository every so often and you specify a package as of a date.

### R lesson

15:20, last session on 06/03/2024.

inside the HPC:

```
# load the singularity module
singularity exec -B .:/home/Project frk.sif R # -B is how to make a volume in singularity. this Runs fdk.sif container with a volume and then start R.
```

See: `./r_lesson/` for the files in the demo

## Multithread example

See HMMER folder
