#define THRESHOLD 0.00000001
#include "poisson.h"
#include <stdlib.h>
#include <stdio.h>
#include <math.h>


/* Routine for allocating two-dimensional array */
double **
malloc_2d(int n)
{
    int i;

    if (n <= 0)
	return NULL;

    double **A = malloc(n * sizeof(double *));
    if (A == NULL)
	return NULL;

    A[0] = malloc(n*n*sizeof(double));
    if (A[0] == NULL) {
	free(A);
	return NULL;
    }
    for (i = 1; i < n; i++)
	A[i] = A[0] + i * n;

    return A;
}

void
free_2d(double **A) {
    free(A[0]);
    free(A);
}

/* Routine for copying content to u_old from u matrices without changing u */
void copy(int N, double** A, double** B){
	for(int i=0; i<N; i++){
		for(int j=0; j<N; j++){
			B[i][j] = A[i][j];
		}
	}
}

double frobenius_of_diff(int N, double** A, double** B){
	double frob = 0;
	for(int i=0; i<N; i++){
		for(int j=0; j<N; j++){
			frob += pow(B[i][j] - A[i][j], 2);
		}
	}
	return frob;
}


/* Jaccobi Method */
int jaccobi(int N, int kmax, double delta, double** f, double** u){

	int k = 0;

	double** u_old = malloc_2d(N);
	double d;

	do {
		copy(N, u, u_old);

		for(int i=1; i<N-1; i++){
			for(int j=1; j<N-1; j++){
				u[i][j] = 0.25 *(u_old[i-1][j] + u_old[i+1][j] + u_old[i][j-1] + u_old[i][j+1] + delta*delta*f[i][j]);
			}
		}

		d = frobenius_of_diff(N, u, u_old);

		k++;
	} while(d > THRESHOLD && k < kmax);

	printf("Jaccobi: # of iterations: %d\n", k);
	free_2d(u_old);
	return(k);
}


/* Gauss-Seidel Method*/
int gauss(int N, int kmax, double delta, double** f, double** u){

	int k = 0;

	double d;
  	double temp;

	do {

    d=0;

		for(int i=1; i<N-1; i++){
			for(int j=1; j<N-1; j++){
        temp = u[i][j];

				u[i][j] = 0.25 *(u[i-1][j] + u[i+1][j] + u[i][j-1] + u[i][j+1] + delta*delta*f[i][j]);

        d = d + pow((u[i][j] - temp), 2);

			}
		}


		k++;
	} while(d > THRESHOLD && k < kmax);

	printf("Gauss: # of iterations: %d\n", k);
	return(k);
}
