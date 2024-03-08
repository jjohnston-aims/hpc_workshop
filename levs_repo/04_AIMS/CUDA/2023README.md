# Setup

All examples in this directory with a numerical prefix, 01-, 02- etc are from NVidia.

To run a sample CUDA job start with interactive job. Unlike the old LIEF GPGPU platform, you do not need to specify a QoS in 
your Slurm submit scripts. Remove any QoS before you submit, or set it to "normal".

$ sinteractive --partition=gpu-a100 --gres=gpu:4 --time=6:00:00

Load a CUDA module. Note that we have cudacore, cuda, gcccuda, fosscuda. These different modules determine what else is 
loaded with CUDA.

For example:

$ module load gcccuda/2020b
$ module list

Currently Loaded Modules:
  1) slurm/latest (S)   3) gcccore/10.2.0   5) binutils/2.35   7) cudacore/11.1.1   9) gcccuda/2020b
  2) showq/0.15   (S)   4) zlib/1.2.11      6) gcc/10.2.0      8) cuda/11.1.1


Copy the CUDA directory to home and enter:

$ cd ~; cp -r /usr/local/common/CUDA . ; cd CUDA

# Structure of CUDA Code

As with all parallel programming, start with serial code, engage in decomposition, then generate parallel code.

General CPU/GPU code with CUDA will look like:

void CPUFunction()
{
	printf("This function is defined to run on the CPU.\n");
}
__global__ void GPUFunction()
{
	printf("This function is defined to run on the GPU.\n");
}
int main()
{
	CPUFunction();
	GPUFunction<<<1, 1>>>();
	cudaDeviceSynchronize();
}

The __global__ keyword indicates that the following function will run on the GPU, and can be invoked globally, which in this context means either by
the CPU, or, by the GPU.

Often, code executed on the CPU is referred to as host code, and code running on the GPU is referred to as device code.

# Hello World from CPU and GPU

A CUDA program can run portions of the code on the CPU and portions on the GPU.

Review the non-CUDA code:

$ less 01-hello-gpu.cu

Compile and execute:

$ nvcc 01-hello-gpu.cu -o helloCUDA -gencode arch=compute_80,code=sm_80

./helloCUDA

Refactor the code to take advantage of CUDA functions, recompile, and execute.

$ nvcc 01-hello-gpu-solution.cu -o helloCUDA -gencode arch=compute_80,code=sm_80

$ ./helloCUDA

Compare the two examples with sdiff.

$ sdiff 01-hello-gpu.cu 01-hello-gpu-solution.cu

# Supported Gencode variations for sm and compute

What are those gencode requirements?

Below are the supported sm variations and sample cards from that generation

Supported on CUDA 7 and later

Fermi (CUDA 3.2 until CUDA 8) (deprecated from CUDA 9):
	SM20 or SM_20, compute_30 – Older cards such as GeForce 400, 500, 600, GT-630

Kepler (CUDA 5 and later):
        SM30 or SM_30, compute_30 – Kepler architecture (generic – Tesla K40/K80, GeForce 700, GT-730)
        Adds support for unified memory programming
        SM35 or SM_35, compute_35 – More specific Tesla K40
        Adds support for dynamic parallelism. Shows no real benefit over SM30 in my experience.
        SM37 or SM_37, compute_37 – More specific Tesla K80
        Adds a few more registers. Shows no real benefit over SM30 in my experience

Maxwell (CUDA 6 and later):
        SM50 or SM_50, compute_50 – Tesla/Quadro M series
        SM52 or SM_52, compute_52 – Quadro M6000 , GeForce 900, GTX-970, GTX-980, GTX Titan X
        SM53 or SM_53, compute_53 – Tegra (Jetson) TX1 / Tegra X1

Pascal (CUDA 8 and later)
        SM60 or SM_60, compute_60 – GP100/Tesla P100 – DGX-1 (Generic Pascal)
        SM61 or SM_61, compute_61 – GTX 1080, GTX 1070, GTX 1060, GTX 1050, GTX 1030, Titan Xp, Tesla P40, Tesla P4, Discrete GPU on the NVIDIA Drive PX2
        SM62 or SM_62, compute_62 – Integrated GPU on the NVIDIA Drive PX2, Tegra (Jetson) TX2

Volta (CUDA 9 and later)
        SM70 or SM_70, compute_70 – Tesla V100, GTX 1180 (GV104)
        SM71 or SM_71, compute_71 – probably not implemented
        SM72 or SM_72, compute_72 – currently unknown

Turing (CUDA 10 and later)
        SM75 or SM_75, compute_75 – RTX 2080, Titan RTX, Quadro R8000

Ampere (CUDA 11.1 and later)
	SMS80, compute_80 - NVIDIA A100, NVIDIA DGX-A100
	SM86 or SM_86, compute_86 – (from CUDA 11.1 onwards). Tesla GA10x cards, RTX Ampere – RTX 3080, GA102 – RTX 3090, 
RTX A2000, A3000, RTX A4000, A5000, A6000, NVIDIA A40, GA106 – RTX 3060, GA104 – RTX 3070, GA107 – RTX 3050, RTX A10, RTX 
A16, RTX A40, A2 Tensor Core GPU 
	SM87 or SM_87, compute_87 – (from CUDA 11.4 onwards, introduced with PTX ISA 7.4 / Driver r470 and newer) – for 
Jetson AGX Orin and Drive AGX Orin only

(c.f., http://arnon.dk/matching-sm-architectures-arch-and-gencode-for-various-nvidia-cards/)

How do you know what GPU you're using? Run the nvidia-smi (Systems Management Interface) command on the node in question. e.g.,

[lev@spartan-gpgpu111 ~]$ nvidia-smi 
Thu Mar  2 17:08:41 2023       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 515.65.01    Driver Version: 515.65.01    CUDA Version: 11.7     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  NVIDIA A100 80G...  On   | 00000000:CA:00.0 Off |                    0 |
| N/A   29C    P0    54W / 300W |      0MiB / 81920MiB |      0%      Default |
|                               |                      |             Disabled |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+

# Parallel Kernels

Review the non-CUDA code:

$ less 01-first-parallel.cu

Compile and execute:

$ nvcc 01-first-parallel.cu -o firstCUDA -gencode arch=compute_80,code=sm_80
$ ./firstCUDA

Refactor the code to take advantage of CUDA functions, recompile, and execute.

$ nvcc 01-first-parallel-solution.cu -o firstCUDA -gencode arch=compute_80,code=sm_80
$ ./firstCUDA

Modify the distribution of kernels as desired.

# Thread and Block Indices

Each thread is assigned an index within its thread block, starting at 0. Each thread block is assigned an index, also 
starting at 0. Just as threads form thread blocks, thread blocks form a grid, and grid is the highest level entity in 
CUDA thread hierarchy. In short, the CUDA kernel function executes in a grid of one or more thread blocks, each of which 
contains the same number of threads.

CUDA kernel function can access the special variables that can identify the following two indexes: the index of the 
thread executing the kernel function (in the thread block) and the index of the thread block (in the grid). The two 
variables are threadIdx.x and blockIdx.x.

The 01-thread-and-block-idx.cu file contains a kernel function that is printing the execution of the failed message.

$ less 01-thread-and-block-idx.cu
$ nvcc 01-thread-and-block-idx.cu -o indexCUDA -gencode arch=compute_80,code=sm_80
$ ./indexCUDA
$ nvcc 01-thread-and-block-idx-solution.cu -o indexCUDA -gencode arch=compute_80,code=sm_80
$ ./indexCUDA
$ sdiff 01-thread-and-block-idx.cu 01-thread-and-block-idx-solution.cu

# Accelerating For Loops

Consider the non-accelerated (CPU-based) loop, compile and run.

$ nvcc 01-single-block-loop.cu -o loopCUDA -gencode arch=compute_80,code=sm_80
$ ./loopCUDA

Refactor, recompile, and execute.

$ nvcc 01-single-block-loop-solution.cu -o loopCUDA -gencode arch=compute_80,code=sm_80
$ ./loopCUDA

Modify the number of iterations as desired.

# Debug with printf

Calling printf from a CUDA kernel function is no different than calling printf on CPU code. In the vector addition example, 
edit vec_add.cu and insert the following code after line 18:

if(threadIdx.x == 10)
    printf("c[%d] = %dn", id, c[id]);

# CUDA Error Handling

Most CUDA functions return a value of type cudaError_t, which can be used to check for errors when calling a function.

e.g.,

```
cudaError_t err;
err = cudaMallocManaged(&a, N)
// Assume the existence of `a` and `N`.
if (err != cudaSuccess)
// `cudaSuccess` is provided by CUDA.
	{
	printf("Error: %s\n", cudaGetErrorString(err)); // `cudaGetErrorString` is provided by CUDA.
	}
```

See the file `errormacro.cu`.


The program 01-add-error-handling-raw.cu prints the elements of the array were not successfully doubled. The program does not, 
however, indicate that there are any errors within it. 

Debugging information needs to be included, checking for both synchronous errors potentially created when calling CUDA 
functions, as well as asynchronous errors potentially created while a CUDA kernel is executing. Once this is done the 
code can be modified for the final version.

$ nvcc 01-add-error-handling-raw.cu -o adderrorCUDA -gencode arch=compute_80,code=sm_80
$ ./adderrorCUDA
$ sdiff 01-add-error-handling-raw.cu 01-add-error-handling.cu
$ nvcc 01-add-error-handling.cu -o adderrorCUDA -gencode arch=compute_80,code=sm_80
$ ./adderrorCUDA
$ nvcc 01-add-error-handling-solution.cu -o adderrorCUDA -gencode arch=compute_80,code=sm_80
$ ./adderrorCUDA
$ sdiff 01-add-error-handling.cu 01-add-error-handling-solution.cu


# Array Manipulation on both the Host and Device

The 01-double-elements.cu program allocates an array, initializes it with integer values on the host, and attempts to 
double each of these values in parallel on the GPU, and then confirms the success of the doubling operation on the host. 
However, the program will not be able to execute because it is trying to interact with the array pointed to by pointer 
a on the host and device, but only allocates arrays accessible on the host (using malloc).

$ nvcc 01-double-elements.cu -o doubleelementsCUDA -gencode arch=compute_80,code=sm_80
$ ./doubleelementsCUDA 
All elements were doubled? FALSE

The code needs to be refactored so that there is a pointer available for host and device codes and the memory of the
pointer a should be properly freed.

$ nvcc 01-double-elements-solution.cu -o doubleelementsCUDA -gencode arch=compute_80,code=sm_80
$ ./doubleelementsCUDA 
All elements were doubled? TRUE

$ sdiff 01-double-elements.cu 01-double-elements-solution.cu


# Multiple Blocks of Threads

Consider the non-accelerated (CPU-based) loop, compile and run.

$ less 02-multi-block-loop.cu
$ nvcc 02-multi-block-loop.cu -o loop2CUDA -gencode arch=compute_80,code=sm_80
$ ./loop2CUDA

Refactor, recompile, and execute for multiple blocks.

$ nvcc 02-multi-block-loop-solution.cu -o loop2CUDA -gencode arch=compute_80,code=sm_80
$ ./loop2CUDA

Note the order of returns.

# Loop with a Mismatched Execution

The program in 02-mismatched-config-loop.cu uses cudaMallocManaged to allocate memory for an integer array of 1000 elements, and 
then attempts to initialize all the values in the array in parallel using CUDA kernel function.

$ less 02-mismatched-config-loop.cu
$ nvcc 02-mismatched-config-loop.cu -o mismatchCUDA -gencode arch=compute_80,code=sm_80
$ ./mismatchCUDA

Refactor, recompile, and execute for multiple blocks.

$ nvcc 02-mismatched-config-loop-solution.cu -o mismatchCUDA -gencode arch=compute_80,code=sm_80
$ ./mismatchCUDA

# Grid-Stride Loops

Grid span cycle: the number of data elements is often greater than the number of threads in the grid. In this case, the thread 
cannot process only one element, or the work will not be completed. One of the ways to solve this problem programmatically is to use 
the grid span cycle. In the grid span cycle, the first element of the thread is still calculated by 
threadIdx.x+blockIdx.x*blockDim.x, and then the thread will move forward according to the number of threads in the grid (blockDim.x 
* gridDim.x),

$ less 03-grid-stride-double.cu
$ nvcc 03-grid-stride-double.cu -o gridstrideCUDA -gencode arch=compute_80,code=sm_80
$ ./gridstrideCUDA

$ less 03-grid-stride-double-solution.cu
$ nvcc 03-grid-stride-double-solution.cu -o mismatchCUDA -gencode arch=compute_80,code=sm_80
$ ./gridstrideCUDA

