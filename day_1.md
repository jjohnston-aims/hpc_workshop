Day 1
======

Meeting link: https://teams.microsoft.com/_?culture=en-au&country=au#/scheduling-form/?isBroadcast=false&eventId=AAMkAGI0MTg0NTNlLTFkZGYtNGZlMy05ZjUwLTU1NzMxMjVjMTFjMgBGAAAAAAAUNLPbvTbAT4zd40IvswVzBwDPdM72SAffSKYUUpfX064IAAAAAAENAADPdM72SAffSKYUUpfX064IAAH_ijrGAAA%3D&conversationId=19:meeting_ZDhiODQ2NjktODA1Ni00NDA4LTk3ZDItYTk1NzE1YThlYjMy@thread.v2&opener=1&providerType=0&navCtx=navigateHybridContentRoute&calendarType=1

Presenter: [Lev Lafayette](https://github.com/levlafayette) (University of Melbourne)

- what is the HPC?
  - many servers in a tightly coupled network that looks like one system.
  - good for big datasets or analysis that is complicated - ie, stuff that would lock up your local machine.
- HPC is used in the command line: cmd line -> shell -> kernel (linux) -> hardware
  - this allows us to optimise the analysis
- use linux becuase it scales well.
- scheduler determines who job runs when. We are using [slurm](https://slurm.schedmd.com/quickstart.html)
- HPC versus supercomputer
  - supercomputer is a fast computer (measured in floating point operations per second, usually on of the fastest 500 computers in the world. see [top500.org](https://top500.org)). This is relative to the computers of the day.
  - HPC is designed to be fast, with high redundancy.
- Message Passing Interface (MPI) passes messages between nodes.
- high throughput computing
  - there is a trade-off been capability and capacity. ie, number of cores vs speed of interconnect.
  - this is about getting jobs completed.
  - data parallel or task parallel
    - data parallel is doing the same task on many different datasets. Slurm calls this a [job array](https://slurm.schedmd.com/job_array.html).
    - what is task parallel? In simulations, each cell needs to communicate it's state to other cells. Processors involved are talking to each other. eg, hydrodynamic modelling.
  - horse and cart analogy. How do we improve performance?
    - bigger horse = getting a more powerful computer. ie, a faster processor?
    - rearrange the load on the cart. ie cleaning up code.
    - get more horses (is this more cores / more nodes?)
- 10 year reproducable research (Nature journal?)
  - because of poor documentation on the software stack.
  - users need to keep job submission scripts
  - eg, different version of R will give slightly different results.
- throughput - total data through
- bandwith - number of lanes
- latency - delay 
- don't run jobs on the login node
  - this is not something you would do accidentally. You would need to intentionally open an interactive job when sshed into the HPC rather than submitting a job with the `sbatch` command. If you need interactivity you can request resources, then ssh into that node and run your stuff interactively there.
- nodes versus cores
  - nodes are the system units, like a laptop.
  - nodes have processors, which have cores.
  - multithreading separates the computing activity according to different threads.
  - threads are smallest execution unit. A core can run multiple threads. It only executes one at a time, but it switches between threads when it needs to wait (waiting to get data for example). A thread is an execution thread. It's usually recommended to have one thread per core.
  - jobs can be written as MPI (OpenMPI) or as multithreading (OpenMP)
    - multithreading must be on the same computer node.
- `ssh -A` is used to access another cluster from within the cluster. Do not upload your private key to a cluster to access another one.


Linux basics
------------

- ps afux | less
- info COMMAND 
- whatis ls
- man -k SEARCH_TERM
- apropos SEARCH_TERM
  - supposed to search man pages, but doesn't seem to work for me.
- cheat: https://github.com/cheat/cheat
- redirection
  - `>` and `>>`
  - `<` to read in from a file instead of from STDIN. When combined with multiple pipes, only put one `<` at the end.
- `cat -a` shows non printing characters. useful for finding dirty data.
  - also, can use vim: `/[^\x00-\x7F]`
- `wget -r --no-parent https://levlafayette.com/files/01_AIMS/`
  - `-r` recursive
  - `--no-parent` don't download the parent directory
- `cp`
  - `-u` only overwrite when the source is newer
  - `-i` prompt before overwrite 
    - I have an alias for `cp` that includes -i by default. To not use that run `\cp`.
- `diff`
  - from an old program called `ed`
- `comm`
  - 3 columns:
    1. lines unique to first file
    2. lines unique to 2nd file
    3. lines common to both
  - Good for when you have two files of short strings. Not a general alternative to `diff`
- globbing is searching by pattern. regex is a type of globbing?
  - shell has it's own flavour of regular expression. Basic Regular Expression (BRE), or extended (ERE)
- with HPCs, packages are almost always built from source. This is because these packages are usually more efficient.
- modules change that paths of installed software.
  - `module display MODULE_NAME` shows what a module does
  - `module unload MODULE_NAME`
  - `module avail [MODULE_NAME]`
  - `module list`
  - `module load MODULE_NAME`
- conda
  - Lev said using conda on an HPC was a bad idea because then you have two version management systems working together and it gets messy. However, we have conda installed on our HPC.
  - conda has the ability to store the virtual environment in a specific locaton. This command creates a virtual environment in a new directory (called `.conda-env`) relative to the one you are currently in. So when you delete the folder, the environment is deleted also. I would also add `.conda-env/` to your .gitignore file so that it is not included in source control.
    - `conda create --prefix ./conda-env python=3.10`
- Interacting with the scheduler:
  - `sinfo -s` shows partitions availability and their load nodes.
    - partitions are ways to organise HPC nodes.
  - `squeue [--partition=PARTITION]` shows jobs in the queue
  - `scontrol show job 215646 | less` to see details of a running or recently completed job.
  - `sbatch [SLURM_SCRIPT_FILE]` run a job
    - STDOUT gets redirected to a file. See which with `scontrol`
  - `seff JOB_ID` is job status command, and will work on very old jobs.
  - `srun` to run parallel jobs, in interative mode. In this way all the SBATCH flags are pass in to `srun`. See it used in 2nd session on 4th day (7/03/2024)
    - Don't do this on the login node. If you need to, reserve a node, then ssh into it from the login node, then run this command.
  - `scancel JOB_ID`
  - `watch squeue -l` so see queue info update live.
  - for more, see on HPC: 
    - ~/01_AIMS/IntroLinux/squeue.md 
    - ~/01_AIMS/IntroLinux/sinfo.md
    - ~/01_AIMS/IntroLinux/specific.slurm for how do run on a specific node. This communicates to the schedules via comments without trailing spaces. Eg, see the file for an example. `#SBATCH --exclude...` is an instruction to the scheduler, `# SBATCH --exclude...` is a comment.
  - `squeue -w hpc-c001` shows the jobs on a specific node. `showq` is a command that is popular, but not on AIMS
- examples:
  - installing your own R libraries: ~/01_AIMS/R/LIBRARY
  - folders: ~/01_AIMS/folders 

## Dependencies

You create each job script individually, requesting the resources it needs. Then you have a shell script that does something like this:

```bash
#!/bin/bash
FIRST=$(sbatch myjob1.slurm)
echo $FIRST # This will typically be something like "Submitted batch job <JobID>"
SUB1=$(echo ${FIRST##* }) # This will remove everything from the beginning of the FIRST variable up to and including the last space, leaving just the job ID.
SECOND=$(sbatch --dependency=afterany:$SUB1 myjob2.slurm)
echo $SECOND
```

See example: ~/01_AIMS/depend/. There is a README, shell scripts, and a job script in there.

## Arrays

Arrays are great when you want to have several cores run the same command on different data.

In the SLURM script, you pass an `--array` flag to the `SBATCH` command. You can provide it as:

- a range: `#SBATCH --array=0-31`
- a range with a step value: `#SBATCH --array=0-31:2`
- specific values: `#SBATCH --array=1,2,5,19,27`

Each of these will then submit a job for each item in the array. They will appear as a job ID with a sub ID. In the rest of your bash script, you will have acess to the array value in the variable SLURM_ARRAY_TASK_ID. Use this to operate on different data. For example, you might use it to get a subset of the data in a file and do some operations on it. Then at the end you can join the data back together.

Example: ~/01_AIMS/Array

You can also create a loop that submits jobs as an alternative to creating an array. This does the same thing as the array. If the logic for each job is exactly the same an array is better, otherwise you might need a loop that submits the jobs and changes the command somehow.

Links, etc
----------
- rsync - https://en.wikipedia.org/wiki/Andrew_Tridgell
- ed early text editor: https://en.wikipedia.org/wiki/Ed_(text_editor)
- grep = g/re/p
- https://swcarpentry.github.io/shell-novice/
- https://aoterodelaroza.github.io/devnotes/diskless-rpi-cluster/

Questions
---------

- what are partitions? for example in `squeue [--partition=PARTITION]`

