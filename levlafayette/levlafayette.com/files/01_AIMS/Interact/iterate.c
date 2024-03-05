/* iterate.c */
/* ------------------------------------------------------------------- */
/* A deliberately computationally-intensive task for an interative job */
/* sinteractive */
/* Compile with gcc iterate.c -o iterate, using your prefered compiler */
/* Run with time ./iterate for single core */
/* Original from https://stackoverflow.com/questions/21161175/example-of-very-cpu-intensive-c-function-under-5-lines-of-code */
/* -----------------------------------------*/
/* Multi-threaded version */
/* Now includes pragma for OMP multithreaded */
/* sinteractive --ntasks=1 --cpus-per-task=2 */
/* export OMP_NUM_THREADS=2 */
/* Compile with gcc -fopenmp iterate.c -o iterate with your preferred compiler */
/* time ./iterate */
/* Compare the difference! */
/* ----------------------- */

#include <stdio.h>

int 
main (void)
{
  printf("start\n");

  volatile unsigned long long i;
  #pragma omp parallel for
  for (i = 0; i < 1000000000000ULL; ++i);

  printf("stop\n");

  return 0;
}
