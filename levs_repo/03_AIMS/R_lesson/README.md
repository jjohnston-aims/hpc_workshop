# Preamble

This set of commands assumes you have
[Docker](https://docs.docker.com/engine/install/) and
[Singularity](https://apptainer.org/admin-docs/master/installation.html)
installed on your machine. It also assumes you have `sudo` root-level admin
rights. Also, please familiarise yourselves with the concepts of
[images vs. container](https://aws.amazon.com/compare/the-difference-between-docker-images-and-containers/).

The link above takes one to the old version of Singularity, which is the
version we used during the workshop. However, we recommend people to install
the new version of Singularity which is a called
[Apptainer](https://apptainer.org/docs/admin/main/installation.html).
We're hoping that the AIMS HPC will have the new version of Apptainer installed
soon. On the HPC, the main difference will be to replace commands such as
`singularity your_command` with `apptainer your_command`. Then,
the `module load` command will also change `module load singularity` to
`module load apptainer`.

# Building a Docker container and then creating a singularity image

### 1 - Create the docker group and add your user (it may already exist)

```
sudo groupadd docker
```

### 2 - Add your user to the docker group

```
sudo usermod -aG docker dbarnech
```

### 3 - Pick or write your own `Dockerfile`
Please look at the `Dockerfile` within this repository as an example.
For other examples please go to [Docker Hub](https://hub.docker.com/).
For existing R recipes, see [rocker](https://rocker-project.org/).
For a more thorough lesson on building Docker images, see
our own [open-AIMS GitHub page](https://github.com/open-AIMS/docker-example).

### 4 - Build Docker image

```
docker build . --tag frk -f Dockerfile
```

The tag `frk` can be replaced by whatever name you want to give your container.

### 5 - Test / execute Docker container

```
docker run --rm -v "`pwd`":/home/Project -it --entrypoint /bin/bash frk
```

The `-v` flag allows us to mount the home directory `/home/Project` in the
container to our local directory (`pwd`). This is really convenient as it
allows us to see / manipulate the local files in `pwd` from within the
container. Any new files created in the container will also be saved in `pwd`.

### 6 - Save `.tar` which is then used to create Singularity image

```
docker save frk -o frk.tar
```

### 7 - Additional requirements to create Singularity image

```
mkdir singularity_tmpdir
export SINGULARITY_TMPDIR=$PWD/singularity_tmpdir
TMPDIR=$PWD/singularity_tmpdir
```

### 8 - Create Singularity image from Docker image

```
singularity build frk.sif docker-archive://frk.tar
```

Again, the choice of name `frk` for the `.sif` was arbitrary. One can name it
whatever they want. I just chose to keep the names consistent. They do not
need to be the same between the Docker and Singularity images.

### 9 - Things to watch for
If no space is available, consider clearing all of the Docker / Singularity
images from the cache before creating the target new Singularity image
(**be extremely careful though, as this will wipe out everything**):

```
docker system prune -a
rm -rf ~/.singularity/cache/*
rm -rf singularity_tmpdir
```

Then retry steps 4--8 above.

### 10 - Move things over to the HPC

I'm first going to jump onto the HPC to create a target directory where
I want to store my Singularity image:

```
ssh YOUR_AIMS_USER@hpc-l001.aims.gov.au
mkdir r_lesson
exit
```

Now I can transfer it over

```
scp frk.sif YOUR_AIMS_USER@hpc-l001.aims.gov.au:~/r_lesson/
exit
```

`ssh` back into the HPC and run the Singularity container for a local test

```
ssh YOUR_AIMS_USER@hpc-l001.aims.gov.au
cd r_lesson
singularity exec -B .:/home/Project frk.sif R
```

The above command opens R from within the container. The `-B` flag is
analogous to the `-v` flag we saw above in Step 5. Use `dir()` to see files
in your local HPC `r_lesson` directory.

*You can copy the above image `frk.sif` from (make sure you're in `r_lesson`):*

```
cp -r /export/scratch/frksing/frk.sif .
```

# The R lesson

Please see file `parallel_r_code.R` for a step by step build up of the lesson
from a simple for loop to a parallelised loop.

# Send a job over to SLURM

We moved the last part of the lesson above to the file `slurm_loop.R`
and then created a SLURM call in `slurm_loop.slurm`. Then to submit the task,
simply run:

```
sbatch slurm_loop.slurm
squeue -u YOUR_AIMS_USER
```

Then check the job execution specs based on your `JOBID`:

```
seff JOBID
```

And the total run time of the loop, which should be 5--6 seconds:

```
less run_time.txt
```
