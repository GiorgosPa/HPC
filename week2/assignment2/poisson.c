#define THRESHOLD 0.00000001
#include "poisson.h"
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <omp.h>


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
void copy(int N, double** restrict A, double** restrict B){
	int i,j;
	for(i=0; i<N; i++){
		for(j=0; j<N; j++){
			B[i][j] = A[i][j];
		}
	}
}

void copyOMP(int N, double** restrict A, double** restrict B){
	int i,j;
	#pragma omp parallel for shared(N, A, B) private(i,j) collapse(2)
	for(i=0; i<N; i++){
		for(j=0; j<N; j++){
			B[i][j] = A[i][j];
		}
	}
}

double frobenius_of_diff(int N, double** restrict A, double** restrict B){
	double frob = 0;
	int i,j;
	for(i=0; i<N; i++){
		for(j=0; j<N; j++){
			frob += pow(B[i][j] - A[i][j], 2);
		}
	}
	return frob;
}

double frobenius_of_diff_OMP(int N, double** restrict A, double** restrict B){
	double frob = 0;
	int i,j;
	#pragma omp parallel for private(i, j) collapse(2) reduction(+:frob)
	for(i=0; i<N; i++){
		for(j=0; j<N; j++){
			frob += pow(B[i][j] - A[i][j], 2);
		}
	}
	return frob;
}


/* Jaccobi Method */
int jaccobi(int N, int kmax, double delta, double** restrict f, double** restrict u){

	int k = 0;

	double** u_old = malloc_2d(N);
	copy(N, u, u_old);
	double d;

	do {

		for(int i=1; i<N-1; i++){
			for(int j=1; j<N-1; j++){
				u[i][j] = 0.25 *(u_old[i-1][j] + u_old[i+1][j] + u_old[i][j-1] + u_old[i][j+1] + delta*delta*f[i][j]);
			}
		}

		d = frobenius_of_diff(N, u, u_old);

		double** tmp = u_old;
		u_old = u;
		u = tmp;
		k++;
	} while(d > THRESHOLD && k < kmax);

	if (k % 2)
	{
		double** tmp = u_old;
		u_old = u;
		u = tmp;
	}

	free_2d(u_old);

	return(k);
}

/* Jaccobi Method OMP */
int jaccobiOMP(int N, int kmax, double delta, double** restrict f, double** restrict u){

	int k = 0;
	double** u_old = malloc_2d(N);
	copyOMP(N, u, u_old);
	double d;
	int i,j;
	
	do {
		
		d = 0;

		#pragma omp parallel for private(i,j) collapse(2)
		for(i=1; i<N-1; i++)
			for(j=1; j<N-1; j++){
				u[i][j] = 0.25 *(u_old[i-1][j] + u_old[i+1][j] + u_old[i][j-1] + u_old[i][j+1] + delta*delta*f[i][j]);
			}
		
		d = frobenius_of_diff_OMP(N, u, u_old);
		double** tmp = u_old;
		u_old = u;
		u = tmp;
		k++;
		

	} while(d > THRESHOLD && k < kmax);

	if (k % 2)
	{
		double** tmp = u_old;
		u_old = u;
		u = tmp;
	}

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
       		 	d += pow((u[i][j] - temp), 2);
			}
		}

		k++;
	} while(d > THRESHOLD && k < kmax);

	return(k);
}
