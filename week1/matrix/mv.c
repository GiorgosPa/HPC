#include "data.h"
#include <stdio.h>

void matrix__vector_mul(double* A, double* b, double* c, int m, int k){
    for (int i = 0; i < m; i++){
        c[i] = 0;
        for (int rc = 0; rc < k; rc++){
            c[i] += A[i * k + rc] * b[rc];
        }
    }
}

void matrix_vector_mul(){

}

int main(){
    int m = 3, k = 5;
    double A[m][k];
    double b[k];
    double c[m];
    initializeMV(*A, b, m, k);
    matrix__vector_mul(*A, b, c, m, k);

    printf("A\n");
    for (int i = 0; i < m; i++){
        for (int j = 0; j < k; j++){
            printf("%f\t", A[i][j]);
        }
        printf("\n");
    }

    printf("b\n");
    for (int i = 0; i < k; i++){
        printf("%f\n", b[i]);
    }

    printf("c\n");
    for (int i = 0; i < m; i++){
        printf("%f\n", c[i]);
    }

    return(0);
}