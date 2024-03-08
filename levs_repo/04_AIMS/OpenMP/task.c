#include <omp.h>
#include <stdio.h>

void task_function(int task_id) {
    printf("Task %d executed by thread %d\n", task_id, omp_get_thread_num());
}

int main() {
    #pragma omp parallel
    {
        #pragma omp single
        {
            #pragma omp task
            task_function(1);

            #pragma omp task
            task_function(2);

            #pragma omp task
            task_function(3);

            printf("Tasks created by thread %d\n", omp_get_thread_num());

            #pragma omp taskwait
            printf("All tasks completed\n");
        }
    }

    return 0;
}
