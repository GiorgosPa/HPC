#include <cblas.h>

void matmult_lib(int m, int n, int k,double** A, double** B, double** C){
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, m, n, k, 1.0, &A[0][0], k, &B[0][0], n, 0.0, &C[0][0], n);
}

void matmult_nat(int m, int n, int k, double** A, double** B, double** C){
    for (int i = 0; i < m; i++){
        for (int j = 0; j < n; j++){
            for (int rc = 0; rc < k; rc++){
                C[i][j] += A[i][rc] * B[rc][j];
            }
        }
    }
}

void matmult_mkn(int m, int n, int k, double** A, double** B, double** C){
    for (int i = 0; i < m; i++){
        for (int rc = 0; rc < k; rc++){
        	for (int j = 0; j < n; j++){
                C[i][j] += A[i][rc] * B[rc][j];
            }
        }
    }
}

void matmult_nmk(int m, int n, int k, double** A, double** B, double** C){
    for (int j = 0; j < n; j++){
        for (int i = 0; i < m; i++){
            for (int rc = 0; rc < k; rc++){
                C[i][j] += A[i][rc] * B[rc][j];
            }
        }
    }
}

void matmult_nkm(int m, int n, int k, double** A, double** B, double** C){
    for (int j = 0; j < n; j++){
        for (int rc = 0; rc < k; rc++){
        	for (int i = 0; i < m; i++){
                C[i][j] += A[i][rc] * B[rc][j];
            }
        }
    }
}

void matmult_kmn(int m, int n, int k, double** A, double** B, double** C){
    for (int rc = 0; rc < k; rc++){
        for (int i = 0; i < m; i++){
            for (int j = 0; j < n; j++){
                C[i][j] += A[i][rc] * B[rc][j];
            }
        }
    }
}

void matmult_knm(int m, int n, int k, double** A, double** B, double** C){
    for (int rc = 0; rc < k; rc++){
    	for (int j = 0; j < n; j++){
        	for (int i = 0; i < m; i++){
                C[i][j] += A[i][rc] * B[rc][j];
            }
        }
    }
}

void matmult_blk( int m, int n, int k, double** A, double** B, double** C, int bs){
    for (int j1 = 0; j1 < n; j1+=bs){
        for (int i = 0; i < m; i++){
            for (int rc = 0; rc < k; rc++){
                for (int j2 = 0; j2 < n-j1 && j2 < bs; j2++){
                    C[i][j1 + j2] += A[i][rc] * B[rc][j1 + j2];
                }
            }
        }
    }
}
