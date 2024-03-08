# General Structure of OpenACC

main()
{
 <CPU code>
 #pragma acc kernels
 //automatically runs on GPU
 {
  <GPU code>
 }
}

# Decomposition and Compilation

Examples exercises and solutions from Pawsey Supercomputing Centre.

1. Start an interactive job, load the module.

e.g.,

$ srun --partition=gpuq --nodes=1 --ntasks-per-node=1 --export=ALL --pty /bin/bash

$ module load nvhpc/22.3

2. The Importance of Profiling

Excample here from ComputeCanada

$ cd ~/OpenACC/Profile
$ make

Check profile information.

3. Run serial code 

Examples here from Pawsey Supercomputing Centre.

$ cd Exercise/exe1
$ make
$ time ./heat_eq_serial 

The output should be something like:

Stencil size: 2000 by 2000
Converged in 1000 iterations with an error of 0.0360

real	0m5.062s
user	0m5.051s
sys	0m0.008s

4. Introduce pragma statements

#pragma acc kernels directive [clause]
{
code region ..
}

cd Solution/exe2
make

Note the compiler feedback! e.g.,

50, Loop not vectorized/parallelized: contains call
84, Loop is parallelizable
85, Loop is parallelizable
    Accelerator kernel generated
    Generating Tesla code
    84, #pragma acc loop gang, vector(4) /* blockIdx.y threadIdx.y */
    85, #pragma acc loop gang, vector(32) /* blockIdx.x threadIdx.x */

etc

$ time nvprof ./heat_eq_acc_v2

Oh dear! Despite the fact regions have been parallised, the code is now *much* slower - due to to data movement. Most of the our time is spent in copying T_old and T_new from Host (CPU memory) to
Device (GPU memory).

5. Profiling Options for Detail

nvprof supports several options. For example:

--export-profile: Export the profile to a file

--analysis-metrics: Collect profiling data that can be imported to Visual Profiler

--print-gpu-trace: Show trace of function calls

--openacc-profiling on: Profile OpenACC as well (on by default)

--cpu-profiling on: Enable some CPU profiling

--csv --log-file FILE: Generate CSV output and save to FILE; handy for plots or benchmarked analysis

--metrics M1: Measure only metric M1 which is one of the NVIDIA-provided metrics which can be listed via --query-metrics.


6. Add Data construct pragmas, run the code again

cd Solution/exe3
make
$ time nvprof ./heat_eq_acc_v3
