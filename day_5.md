HPC Workshop day 5
==================

## GPUs

Originally designed to update all pixels at once to make graphics faster. Now is used for many parallel operations.

GPGPU - General purpose processing on GPSs

GPUs have low memory but high throughput and low latency.

All GPUs have CPU host, and 1 or more GPUs (AKA accelerators?).

Hoppership (Grace Hopper, nanoseconds.).

GPU and CPU on the same die (chip?).

GPUs will become more and more common.

cuda and nvhpc are applications on the AIMS HPC that are designed to run on GPUs.

use the SBATCH comman `--gres=gpu:4` to say I want 4 GPUs. It's common to request the whole node when doing GPU work.

check the GPU on the system with `nvidia-smi`.

Acceleration options:

- use 3rd party options. required min effort, has great performance, but not very flexible.
- directive based approach (like OpenACC). minimal effort required, but not super high performance (however will be benefits). can be combined with OpenMP.
- programming extensions  applications like cuda or opencl. These are the basis for 3rd party options. Harder to use presumably but very flexible.

OpenACC

Works similar to OpenMP, you mark sections in the code that should be run on GPUs.

Supported by C++ and Fortran. 

Look into [cuda-python](https://developer.nvidia.com/cuda-python).

`#pragma acc kernels` is a marker to send something to the accelerators. The example below is taken from `heat_accv1.c`

```c
		dT = 0.0;
		// Evaluate maximum temperature change and update the T_old with T_new for next iteration
		// Hint: make use of kernels directive
#pragma acc kernels
		for (i=1 ; i <=ROWS; i++){
			for(j=1; j <COLS; j++){
				dT = fmaxf(fabsf(T_new[i][j] - T_old[i][j]),dT);
				T_old[i][j] = T_new[i][j];
			}
		}
		iter++;
	}
```

Load the module, with `nvhpc/22.3` then compile with `nvcc`.

Common GPU problem is that data access is limited by getting the data form the CPU. In `heat_accv2.c` we put the data into the cpu first. In this case, we are bound by the memory limits of the GPU. Check memory of GPU with `nvidia-smi`.

