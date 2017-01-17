#include "poisson.h"
#include <stdio.h>
#include <math.h>
#include <omp.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define M_PI 3.14159265358979323846


void testboundaries(int N, double **u){
	for(int i=0; i<N; i++){
		u[i][0] = 0;
		u[0][i] = 0;
		u[i][N-1] = 0;
		u[N-1][i] = 0;
	}
}

void boundaries(int N, double **u){
	for(int i=0; i<N; i++){
		u[i][0] = 20;
		u[0][i] = 20;
		u[i][N-1] = 20;
		u[N-1][i] = 0;
	}
}

double func(double x, double y){
	if (x <= 1.0/3.0 && x >= 0){
		if (y >= -2.0/3.0 && y <= -1.0/3.0)
			return 200.0;
	}
	return(0.0);
}

double testfunc(double x, double y){
	return 2 * M_PI * M_PI * sin(M_PI*x) * sin(M_PI*y);
}

double testsolution(double x, double y){
	return(sin(M_PI*x) * sin(M_PI*y));
}

/* Routine for creating the grid coordinates; returns step width/length */
double discretize(int N, double low, double high, double* coords){
	double region = high - low;
	double step = region / (N-1);

	for(int i=0; i<N; i++){
		coords[i] = low + i*step;
	}

	return(step);
}

/* Routine for creating and filling up f and s */
double initialize_test(int N, double** u, double** f, double** s){
	double coords[N];
	double step = discretize(N, -1, 1, coords);
	double x,y;
	for(int i=0; i<N; i++){
		for(int j=0; j<N; j++){
			x = coords[i];
			y = coords[N-j - 1];
			f[j][i] = testfunc(x, y);
			s[j][i] = testsolution(x, y);
		}
	}

	testboundaries(N, u);

	return(step);
}

/* Routine for creating and filling up f */
double initialize(int N, double** u, double** f){
	double coords[N];
	double step = discretize(N, -1, 1, coords);
	double x,y;
	for(int i=0; i<N; i++){
		for(int j=0; j<N; j++){
			x = coords[i];
			y = coords[N-j];
			f[j][i] = func(x, y);
			u[j][i] = 0;
		}
	}

	boundaries(N, u);

	return(step);
}

void print_matrix(int N, double** A){
	for(int i=0; i<N; i++){
	  for(int j=0; j<N; j++){
	      printf("%f\t", A[i][j]);
	  }
	  printf("\n");
	}
}

/* __________________________________________________________________________ */

int main(int argc, char** argv){
	int N;
	int kmax;
	char* algorithm;
	bool print = false, test = false;
	int iterations;
	double MFLOPS;
	double** u;
	double** f;

	// command line argument sets method, grid dimensions, and max iterations
  	if (argc < 5){
		printf("Error: Wrong number of arguments\n usage: %s algorithm N kmax maxiterations [print|p|test|t]\n", argv[0]);
		return(1);
	}

	algorithm = argv[1];
	N = atoi(argv[2]);
	kmax = atoi(argv[3]);
	iterations = atoi(argv[4]);

	if(argc > 5){
		if (*argv[5] == 'P' || *argv[5] == 'p')
			print = true;
		if (*argv[5] == 'T' || *argv[5] == 't')
			test = true;
	}

	double start_time, elapsed_time;
	start_time = omp_get_wtime();

	
	int k = 0;

	char jac[] = "jac";
	char gaus[] = "gauss";
	char jacomp[] = "jacomp";
	char jacompsimple[] = "jacompsimple";
	char jacompdatarace[] = "jacompdatarace";

	int (*function_to_use)(int, int, double, double**, double**);

	if (!strcmp(algorithm, jac)) {
		function_to_use = &jaccobi;
	} else if (!strcmp(algorithm, gaus)) {
		function_to_use = &gauss;
	} else if (!strcmp(algorithm, jacomp)){
		function_to_use = &jaccobiOMP;
	} else if (!strcmp(algorithm, jacompsimple)){
		function_to_use = &jaccobiOMP_simple;
	} else if (!strcmp(algorithm, jacompdatarace)){
		function_to_use = &jaccobiOMP_datarace;
	} else {
		printf("Invalid algorithm choice, available choices [jac|jacomp|gauss]\n");
		return(1);
	}

	if (test){
		u = malloc_2d(N);
		f = malloc_2d(N);
		double** s = malloc_2d(N);
		double** diff = malloc_2d(N);
		double step = initialize_test(N, u, f, s);

		function_to_use(N, kmax, step, f, u);
		printf("F\n");
		print_matrix(N, f);

		for (int i=0; i<N; i++)
			for (int j=0; j<N; j++)
				diff[i][j] = s[i][j] - u[i][j];

		printf("U\n");
		print_matrix(N, u);

		printf("S\n");
		print_matrix(N, s);

		printf("Diff\n");
		print_matrix(N, diff);

		free_2d(f);
		free_2d(u);
		free_2d(s);
		free_2d(diff);
		
		return(0);
	}

	for (int iter=0; iter < iterations - 1; iter++){
		u = malloc_2d(N);
		f = malloc_2d(N);
		double step = initialize(N, u, f);
		k += function_to_use(N, kmax, step, f, u);
		free_2d(u);
		free_2d(f);
	}
	u = malloc_2d(N);
	f = malloc_2d(N);
	double step = initialize(N, u, f);
	k += function_to_use(N, kmax, step, f, u);
	
	elapsed_time = omp_get_wtime() - start_time;
	MFLOPS = 11*0.000001*(double)N*(double)N*(double)k/elapsed_time;
	double time_per_iteration = elapsed_time / iterations;
	double Memory = (double)N*(double)N*2*8/1000;
	double iterations_per_sec = (double)k/elapsed_time;

	printf("%f %f %f %f %f #%s \n", Memory, MFLOPS, iterations_per_sec, time_per_iteration, elapsed_time, algorithm);

	if (print){
		/* F Output */
		printf("F\n");
		print_matrix(N, f);

		/* U Output */
		printf("U\n");
		print_matrix(N, u);
	}
	free_2d(u);
	free_2d(f);
	return(0);
}
