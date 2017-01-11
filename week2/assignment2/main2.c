#include "poisson.h"
#include <stdio.h>
#include <math.h>
#include <omp.h>
#define M_PI 3.14159265358979323846

double boundaries(double x, double y){
	return(0.0);
}

double func(double x, double y){
	return 2 * M_PI * M_PI * sin(M_PI*x) * sin(M_PI*y);
}

double solution(double x, double y){
	return(sin(M_PI*x) * sin(M_PI*y));
}

/* Routine for creating the grid coordinates; returns step width/length */
double discretize(int N, double low, double high, double* coords){
	double region = high - low;
	double step = region / N;

	for(int i=0; i<N; i++){
		coords[i] = low + i*step;
	}

	return(step);
}

/* Routine for creating and filling up f and s */
double initialize(int N, double** u, double** f, double** s){
	double coords[N];
	double step = discretize(N, -1, 1, coords);
	double x,y;
	for(int i=0; i<N; i++){
		for(int j=0; j<N; j++){
			x = coords[i];
			y = coords[j];
			f[i][j] = func(x, y);
			s[i][j] = solution(x, y);
		}
	}

	for(int i=0; i<N; i++){
		x = coords[i];
		y = coords[0];
		u[i][0] = boundaries(x,y);
		u[0][i] = boundaries(y,x);
		x = coords[N-1];
		y = coords[i];
		u[N-1][i] = boundaries(x,y);
		u[i][N-1] = boundaries(y,x);
	}
	return(step);
}


/* __________________________________________________________________________ */

int main(int argc, char* argv[]){
	/* int N = 10;  */
	/* int kmax = 100000000;  */

	// command line argument sets method, grid dimensions, and max iterations
  if (argc != 4){
		printf("Error: Wrong number of arguments\n");
	}

	else {
		char function_to_use = argv[1];
		int N = atoi(argv[2]);
		int kmax = atoi(argv[3]);

	}

  double** u = malloc_2d(N);
  double** f = malloc_2d(N);
  double** s = malloc_2d(N);
  double step = initialize(N, u, f, s);


	double start_time, elapsed_time;
	start_time = omp_get_wtick();

  switch (function_to_use) {
  	case 'j': jaccobi(N, kmax, step, f, u); break;
    case 'g': gauss(N, kmax, step, f, u);   break;

  }
  elapsed_time = omp_get_wtick() - start_time;

	printf("Elapsed Time: %f secs\n", elapsed_time );

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
  printf("Solution\n");
  for(int i=0; i<N; i++){
    for(int j=0; j<N; j++){
      printf("%f\t", s[i][j]);
    }
    printf("\n");
  }





	return(0);
}
