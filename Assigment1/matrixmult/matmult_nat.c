#include "data.h"
#include <stdio.h>
#include <stdlib.h>

void matrix_mul(double* A, double* B, double* C, int m, int n, int k){
    for (int i = 0; i < m; i++){
        for (int j = 0; j < n; j++){
            C[i * n + j] = 0;
            for (int rc = 0; rc < k; rc++){
                C[i * n + j] += A[i * k + rc] * B[rc * n + j];
            }
        }
    }
}

int main(){
    int m = 3, n = 2, k = 5;
    double** A = malloc_2d(m, k);
    double** B = malloc_2d(k, n);
    double** C = malloc_2d(m, n);
    initializeMM(*A, *B, m, n, k);
    matrix_mul(*A, *B, *C, m, n, k);

    printf("A\n");
    for (int i = 0; i < m; i++){
        for (int j = 0; j < k; j++){
            printf("%f\t", A[i][j]);
        }
        printf("\n");
    }

    printf("B\n");
    for (int i = 0; i < k; i++){
        for (int j = 0; j < n; j++){
            printf("%f\t", B[i][j]);
        }
        printf("\n");
    }

    printf("C\n");
    for (int i = 0; i < m; i++){
        for (int j = 0; j < n; j++){
            printf("%f\t", C[i][j]);
        }
        printf("\n");
    }

    free_2d(A);
    free_2d(B);
    free_2d(C);

    return(0);
}
