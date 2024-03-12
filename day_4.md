HPC Workshop day 4
==================

Meeting and recording:

- https://teams.microsoft.com/_?culture=en-au&country=au#/scheduling-form/?isBroadcast=false&eventId=AAMkAGI0MTg0NTNlLTFkZGYtNGZlMy05ZjUwLTU1NzMxMjVjMTFjMgBGAAAAAAAUNLPbvTbAT4zd40IvswVzBwDPdM72SAffSKYUUpfX064IAAAAAAENAADPdM72SAffSKYUUpfX064IAAH_ijrLAAA%3D&conversationId=19:meeting_M2VmZjBmMDAtOTQ0OC00ZmIzLWJiMWYtZjRjOGI2YzExODVm@thread.v2&opener=1&providerType=0&navCtx=navigateHybridContentRoute&calendarType=1
- https://teams.microsoft.com/_?culture=en-au&country=au#/scheduling-form/?isBroadcast=false&eventId=AAMkAGI0MTg0NTNlLTFkZGYtNGZlMy05ZjUwLTU1NzMxMjVjMTFjMgBGAAAAAAAUNLPbvTbAT4zd40IvswVzBwDPdM72SAffSKYUUpfX064IAAAAAAENAADPdM72SAffSKYUUpfX064IAAH_ijrKAAA%3D&conversationId=19:meeting_NDhiMTdkNzQtYTNhNS00ZDQzLWJiN2ItYTcwYTAyMjk1MjFi@thread.v2&opener=1&providerType=0&navCtx=navigateHybridContentRoute&calendarType=1

## The parallel program

`sudo apt install parallel`

GNU parallel is a shell tool for executing jobs in parallel
using one or more computers. A job can be a single command or
a small script that has to be run for each of the lines in the
input. The typical input is a list of files, a list of hosts,
a list of users, a list of URLs, or a list of tables.

Eg,

Let's say you want to `translate` a `,` to a `|` over multiple files. GNU parallel can be used to do this in parrallel, assigning one core to each file in the list that you provide. The sytnax is:

`parallel "COMMAND" ::: "FILE"`

Parallel will assign one core to each file in the list that you provide.

Eg, let's say you need to convert a bunch of mp3 files. You can do this with a look or with parallel:

```bash
for file in ./*.mp3 ; do ffmpeg -i "${file}" "${file/%mp3/ogg}" ; done
# OR
parallel ffmpeg -i {} {.}.ogg ::: *.mp3
```

I sometimes parallel is sometimes slower if there are a small number of files becuase there are overheads using parallel.


### Syntax of parallel

this is how to refer to files in the list:

{} returns a full line read from the input source.
{/} removes everything up to and including the last forward slash.
{//} returns the directory name of input line.
{.} removes any filename extension.
{/.} returns the basename of the input line without extension. It is a
combination of {/} and {.}.

## OpenMP

This is the standard for multi threaded programming.

Start with a good working sequential program, then find areas that can utilise multi threading and modify these.

`srun` to run parallel jobs in interative mode. In this way all the SBATCH flags are pass in to `srun`. See it used in 2nd session on 4th day (7/03/2024). This is how Lev demonstrated the c program below compiling and running in parallel. 

Need to set the `OMP_NUM_THREADS` variable, `export OMP_NUM_THREADS=4` for example. The interactive? shell looks for it.

A simple parallel c example:

```c
❯ cat helloomp1.c
#include <stdio.h>
#include <omp.h>

int main(void)
{
    #pragma omp parallel
    printf("Hello world.\n");
    return 0;
}
```
When you compile with `gcc` using the `-fopenmp` flag, it will use OpenMP and the `#pragme omp prallel` comment will indicate that it should do this codeblock in parallel. Not you also need to include the header files.

Here is a similar example that also shows the thread id:

```c
#include <stdio.h>
#include  "omp.h"
int main(void)
{
	int id;

	#pragma omp parallel num_threads(4) private(id)
	{
	int id = omp_get_thread_num();
	printf("Hello world %d\n", id);
	}
return 0;
}
```

The example show some scoping issues. It shows the part of the code that runs in parallel and the parts that don't. Don't forget to compile with the right flag `-fopenmp` to ensure it runs in parallel.

```c
#include <stdio.h>
#include  "omp.h"
int main(void)
{
	char greetings[] = "Hello world"; 
	printf("Before parallel section %s\n", greetings); 

	#pragma omp parallel num_threads(4) private(greetings)
	{
	char greetings[] = "Saluton mondo"; 
	printf("Inside parallel section %s\n", greetings); 
	}
	printf("After parallel section %s\n", greetings); 
return 0;
}
```
### Parallel loops

It's very common to parallelise looping structures.

You can do the same loop on each thread or split the loops:

```c
#include <omp.h>
#include <stdio.h>

int main() { int i; int sum = 0;
  
    // This part has a separate thread doing each loop
    #pragma omp parallel
    { for (i = 0; i < 100000; i++) { sum += i;
        }
    }
    printf("Sum using parallel directive: %d\n", sum);

    sum = 0;
    // This one has the single loops broken up between threads.
    #pragma omp parallel for
    for (i = 0; i < 100000; i++) { sum += i;
    }
    printf("Sum using parallel for directive: %d\n", sum); return 0;
}
```

This file (`hello3versomp.c`) do one thread per section:

```c
#include <stdio.h>
#include  "omp.h"
int main(void)
{
   char greetingsen[] = "Hello world!";
   char greetingsde[] = "Hallo Welt!";
   char greetingsfr[] = "Bonjour le monde!";
   int a,b,c;

   #pragma omp parallel sections
   {
   #pragma omp section
        {
        for ( a = 0; a < 10; a = a + 1 )
                {
                printf ("id = %d, %s\n", omp_get_thread_num(), greetingsen);
                }
        }

   #pragma omp section
        {
        for ( b = 0; b < 10; b = b + 1 )
                {
                printf ("id = %d, %s\n", omp_get_thread_num(), greetingsde);
                }
        }

   #pragma omp section
        {
        for ( c = 0; c < 10; c = c + 1 )
                {
                printf ("id = %d, %s\n", omp_get_thread_num(), greetingsfr);
                }
        }
    }
return 0;
}
```

Colorless example shows that it's not parallel becuase it goes back into single thread mode.

```c
#include <stdio.h>
#include <stdlib.h>
#include "omp.h"

int main (int argc, char *argv[])
	{
#pragma omp parallel
 { 
   #pragma omp single
   {
	printf("Colourless ");
        #pragma omp task
        {
	printf("green ");
	}
        #pragma omp task
	{	
	printf("ideas ");
	}
        #pragma omp taskwait
	printf("sleep furiously ");
   }
 }
 printf("\n");
 return(0);
}
```

Here is an example where it actually runs in parallel:

```c
#include <stdio.h>
#include <stdlib.h>
#include "omp.h"

int main (void)
{
#pragma omp parallel
 { 
	printf("Colourless ");
	printf("green ");
	printf("ideas ");
	printf("sleep furiously ");
   }
 printf("\n");
 return(0);
}
```

## OpenMPI

Below shows a bunch of examples written in C. Look into [MPY for Python](https://mpi4py.readthedocs.io/en/stable/) for python examples.

OpenMPI options are not comments as they are in OpenMP. So something written in OpenMPI cannot be compiled to run in serial.

`mpi-helloworld.c` is a simple MPI example.

```c
#include <stdio.h>
#include "mpi.h"

int main( argc, argv )
int  argc;
char **argv; // this is a placeholder for other arguments (which we are not using in this example).
{
    int rank, size;
    MPI_Init( &argc, &argv ); // only 1 per program
    MPI_Comm_size( MPI_COMM_WORLD, &size ); // sets number nodes
    MPI_Comm_rank( MPI_COMM_WORLD, &rank ); // sets rank (ie address of node)
    printf( "Hello world from process %d of %d\n", rank, size );
    MPI_Finalize(); // only 1 per program
    return 0;
}
```

the rank 0 node is the root node and tells the other notes what to do. Also does some stuff it self.

ranks are 0 indexed.

When you run `mpiexec -n 2 ./EXECUTABLE`, mpi will pass 2 into the EXECUTABLE as an argument, and the program is written to handle this (see hello world example above).

`mpi-pingpong.c` is an old program to test communication speed between cores. This can demonstrate that when cores are on different nodes they are much slower.

See mip-scatter.c and mpi-scatterv.c and mpi-particle.c for examples of what?


