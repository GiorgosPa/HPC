#include "data.h"
#include <stdlib.h>
#include <stdio.h>
#include <float.h>

void initializeMM(double* restrict A, double* restrict B, int m, int n, int k){

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

/* Routine for allocating two-dimensional array */
double **
malloc_2d(int m, int n)
{
    int i;

    if (m <= 0 || n <= 0)
	return NULL;

    double **A = malloc(m * sizeof(double *));
    if (A == NULL)
	return NULL;

    A[0] = malloc(m*n*sizeof(double));
    if (A[0] == NULL) {
	free(A);
	return NULL;
    }
    for (i = 1; i < m; i++)
	A[i] = A[0] + i * n;

    return A;
}

void
free_2d(double **A) {
    free(A[0]);
    free(A);
}
