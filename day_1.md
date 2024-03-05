Day 1
======

Presenter: Lev Lafayette (University of Melbourne)

- what is the HPC?
  - many servers in a tightly coupled network that looks like one system.
  - good for big datasets or analysis that is complicated - ie, stuff that won't run on a laptop.
- use in the command line: cmd line -> shell -> kernel (linux) -> hardware
  - allows us to optimise the analysis
- why use linux?
  - scales well
  - latency is low (not great for graphics)
- scheduler determines who goes when
- HPC versus supercomputer
  - supercomputer is a fast computer (usually on of the fastest 500 compuers in the world. see [top500.org](https://top500.org)). This is relative to the computers of the day.
    - measured in floating point operations per second.
  - HPC is designed to be fast, with high redundancy.
- Message Passing Interface (MPI) passes messages between nodes.
- high throughput computing
  - there is a tradoff been capability and capacity. ie, number of cores vs speed of interconnect.
  - this is about getting jobs completed.
  - single core app like python or R, 
  - data parallel or task parallel
    - data parallel is doing the same task on many different datasets. (job arrays?)
    - what is task parallel? In simulations, each cell needs to communicate it's state to other cells. Processors involved are talking to each other. eg, hydrodynamic modelling.
  - horse and cart analogy. How do we improve performance?
    - bigger horse = getting a more powerful computer. ie, a faster processor?
    - rearrange the load on the cart. ie cleaning up code.
    - get more horses (is this more cores / more nodes?)
- 10 year reproducable research (Nature journal?)
  - because of poor documentation on the software stack.
  - keep job submission scripts
  - eg, different version of R will give slightly different results.
- throughput - total data through
- bandwith - number of lanes
- latency - delay 
- don't run jobs on the login node
  - how would one go about running a job on the login node?
- nodes versus cores
  - nodes are the system units, eg a laptop.
  - inside nodes are sockets?, which have processors, which have cores.
  - multithreading separates the computing activity according to different threads.
  - threads are smallest execution unit. A core can run multiple threads. It only executes one at a time, but it switches between threads when it needs to wait (waiting to get data for example).
  - jobs can be written as MPI or as multithreading
    - multithreading must be on the same computer node.
    - MPI is easier to write in general, but more difficult to write on a single (node?), but it scales.
- `ssh -A` is used to access another cluster from within the cluster. Do not upload your private key to a cluster to access another one.


Linux basics
------------

- ps afux | less
  - Why does the HPC thing I'm running R inside emacs?
- info COMMAND 
- whatis ls
- man -k SEARCH_TERM
- apropos SEARCH_TERM
  - supposed to search man pages, but doesn't seem to work for me.
- redirection
  - `>` and `>>`
  - `<` to read in from a file instead of from STDIN. When combined with multiple pipes, only put one `<` at the end.
- `cat -a` shows non printing characters. useful for finding dirty data.
- `wget -r --no-parent https://levlafayette.com/files/01_AIMS/`
  - `-r` recursive
  - `--no-parent` don't download the parent directory
- `cp`
  - `-u` only overwrite when the source is newer
  - `-i` prompt before overwrite 
- `diff`
  - from an old program called `ed`
- `comm`
  - 3 columns:
    1. unique to first file?
    2. unique to 2nd file?
    3. ?
- globbing is searching by pattern. regex is a type of globbing?
  - shell has it's own flavour of regular expression.
- with HPCs, packages are almost always built from source. This is because these packages are usually more efficient.
- modules change that paths of installed software.
  - `module display MODULE_NAME` shows what a module does
  - `module unload MODULE_NAME`
  - `module avail [MODULE_NAME]`
  - `module list`
  - `module load MODULE_NAME`
- Interacting with the scheduler:
  - `sinfo -s`
  - `squeue [--partition=PARTITION]` shows jobs in the queue
  - `sbatch [FILE]` run a job
  - `scancel JOB_ID`
  - `watch squeue`
  - for more, see on HPC: 
    - ~/01_AIMS/IntroLinux/squeue.md 
    - ~/01_AIMS/IntroLinux/sinfo.md
    - ~/01_AIMS/IntroLinux/specific.slurm for how do run on a specific node. This communicates to the schedules via comments without trailing spaces. Eg, see the file for an example. `#SBATCH --exclude...` is an instruction to the scheduler, `# SBATCH --exclude...` is a comment.
  - `squeue -w hpc-c001` shows the jobs queued. `showq` is a command that is popular, but not on AIMS
  - `scancel JOB_ID`
- examples:
  - installing your own R libraries: ~/01_AIMS/R/LIBRARY
  - dependency example: ~/01_AIMS/depend/. There is a README and shell script in there
  - Arrays: ~/01_AIMS/Array
  - folders: ~/01_AIMS/folders 


Links, etc
----------
- rsync - https://en.wikipedia.org/wiki/Andrew_Tridgell
- ed early text editor: https://en.wikipedia.org/wiki/Ed_(text_editor)
- grep = g/re/p
- https://swcarpentry.github.io/shell-novice/
- https://aoterodelaroza.github.io/devnotes/diskless-rpi-cluster/

Questions
---------

- what are the point of arrays? **to have several cores run the same command on different data**
  - can we do a real example?
- what are partitions? for example in `squeue [--partition=PARTITION]`

