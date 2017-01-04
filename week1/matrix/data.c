#include "data.h"

void initializeMM(double* restrict A, double* restrict B, int m, int n, int k){
int x; 
    for (int i = 0; i < m; i++){
        for (int j = 0; j < k; j++){
            A[i * k + j] = 10 * (i + 1) + j + 1;
        }
    }

    for (int i = 0; i < k; i++){
        for (int j = 0; j < n; j++){
            B[i * n + j] = 20 * (i + 1) + j + 1;
        }
    }
}

void initializeMV(double* restrict A, double* restrict b, int m, int k){

    for (int i = 0; i < m; i++){
        for (int j = 0; j < k; j++){
            A[i * k + j] = 10 * (i + 1) + j + 1;
        }
    }

    for (int i = 0; i < k; i++){
        b[i] = 20 * (i + 1) + 1;
    }
}
