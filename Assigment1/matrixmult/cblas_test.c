#include "data.h"
#include <stdio.h>
#include <stdlib.h>
#include <cblas.h>

void matmult_lib(int m, int n, int k,double** A, double** B, double** C){
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, m, n, k, 1.0, &A[0][0], k, &B[0][0], n, 0.0, &C[0][0], n);
}

int main(){
    int m = 3, n = 2, k = 5;
    double** A = malloc_2d(m, k);
    double** B = malloc_2d(k, n);
    double** C = malloc_2d(m, n);
    initializeMM(*A, *B, m, n, k);                                                          
    matmult_lib( m, n, k, A, B, C);

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
