## Parallel Processing

## Multithreaded Julia

Julia supports multithreaded and message passing computation.

For multithreaded applications, as with C, Fortran etc, you need to set the number of threads in the shell. This export command 
must be used in Slurm scripts and on the compute node for interactive jobs.

For example, to set 4 cores for threading in an interactive job, and launch Julia with 4 threads.

```
module load julia/1.9.3
export JULIA_NUM_THREADS=4
julia --threads 4
```

Within the Julia environment the number of threads can be confirmed with the Threads.nthreads() function, and the function 
Threads.threadid() will identify which thread one is currently on.

```
julia> Threads.nthreads()
4
julia> Threads.threadid()
1
```

As with other multithreading environments (c.f., OpenMP) the programmer is responsible for protecting against race conditions, 
including the possibility that variables can be written and read from multiple threads.

As a simple example, the following will create an array of 0s, and then runs a multithreaded command where each thread writes 
its ID to a member of the array.

```
julia> a = zeros(10)

julia> Threads.@threads for i = 1:10
           a[i] = Threads.threadid()
       end

julia> a
```

## Distributed Julia

In addition to multithreaded applications, Julia also supports message passing parallel computing. In this case the `--procs` option 
determines how many cores are in the communication world.

The following commands launch the job with four processors, invokes the Distributed package, and then checks the ID numbers of 
the master and worker processes.


```
julia --procs 4
julia> using Distributed
julia> Distributed.myid()
julia> workers()
@everywhere println("hello world")
```


