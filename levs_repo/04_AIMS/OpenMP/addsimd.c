#include <omp.h>
#include <stdio.h>

int main() {
    int i;
    int a[100000], b[100000], c[100000];

    #pragma omp parallel for
    for (i = 0; i < 100000; i++) {
        a[i] = i;
        b[i] = i * 2;
        c[i] = a[i] + b[i];
    }

    printf("First element of array c: %d\n", c[0]);
    printf("Last element of array c: %d\n", c[99999]);

    return 0;
}
