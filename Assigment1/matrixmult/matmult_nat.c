#include "matmult_nat.h"

void matmult_nat(int m, int n, int k, double** A, double** B, double** C){
    for (int i = 0; i < m; i++){
        for (int j = 0; j < n; j++){
            C[i][j] = 0;
            for (int rc = 0; rc < k; rc++){
                C[i][j] += A[i][rc] * B[rc][j];
            }
        }
    }
}
