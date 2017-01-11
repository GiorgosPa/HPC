#include "poisson.h"
#include <stdio.h>
#include <math.h>
#include <omp.h>
#include <stdlib.h>
#include <stdbool.h>

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
double initialize(int N, double** u, double** f){
	double coords[N];
	double step = discretize(N, -1, 1, coords);
	double x,y;
	for(int i=0; i<N; i++){
		for(int j=0; j<N; j++){
			x = coords[i];
			y = coords[N-j];
			f[j][i] = func(x, y);
			//s[j][i] = testsolution(x, y);
		}
	}

	boundaries(N, u);

	return(step);
}


/* __________________________________________________________________________ */

int main(int argc, char** argv){
	int N;
	int kmax;
	char function_to_use;
	bool print = false;

	// command line argument sets method, grid dimensions, and max iterations
  	if (argc < 4){
		printf("Error: Wrong number of arguments\n");
		return(1);
	}

	function_to_use = *argv[1];
	N = atoi(argv[2]);
	kmax = atoi(argv[3]);

	if(argc == 5){
		print = *argv[4] == 'T' || *argv[4] == 't';
	}


	double start_time, elapsed_time;
	start_time = omp_get_wtime();

	double** u = malloc_2d(N);
	double** f = malloc_2d(N);
	//double** s = malloc_2d(N);
	double step = initialize(N, u, f);
	int k;

	switch (function_to_use) {
		case 'j': k = jaccobi(N, kmax, step, f, u); break;
		case 'g': k = gauss(N, kmax, step, f, u);   break;
	}

	elapsed_time = omp_get_wtime() - start_time;

	printf("Elapsed Time: %f secs\n", elapsed_time );
	double Memory = (double)N*(double)N*2*8/1000;
	printf("Memory FootPrint: %f KB\n", Memory);
	printf("Iteratipns/ sec: %f\n", (double)k/elapsed_time);


	if (print){
		/* F Output */
		printf("F\n");
		for(int i=0; i<N; i++){
		  for(int j=0; j<N; j++){
		      printf("%f\t", f[i][j]);
		  }
		  printf("\n");
		}

		/* U Output */
		printf("U\n");
		for(int i=0; i<N; i++){
		  for(int j=0; j<N; j++){
		      printf("%f\t", u[i][j]);
		  }
		  printf("\n");
		}

		/* S Output */
		// printf("Solution\n");
		// for(int i=0; i<N; i++){
		// for(int j=0; j<N; j++){
		//   printf("%f\t", s[i][j]);
		// }
		// printf("\n");
		// }
		free_2d(u);
		free_2d(f);
	}

	return(0);
}
