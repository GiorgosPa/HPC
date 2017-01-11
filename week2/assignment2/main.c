#include "poisson.h"
#include <stdio.h>
#include <math.h>
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

double discretize(int N, double low, double high, double* coords){
	double region = high - low;
	double step = region / N;

	for(int i=0; i<N; i++){
		coords[i] = low + i*step;
	}

	return(step);
}

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

int main(int argc, char** argv){
	int N = 10;
	int kmax = 100000000;

	double** u = malloc_2d(N);
	double** f = malloc_2d(N);
	double** s = malloc_2d(N);

	double step = initialize(N, u, f, s);

	jaccobi(N, kmax, step, f, u);

	printf("F\n");
	for(int i=0; i<N; i++){
		for(int j=0; j<N; j++){
			printf("%f\t", f[i][j]);
		}
		printf("\n");
	}

	printf("U\n");
	for(int i=0; i<N; i++){
		for(int j=0; j<N; j++){
			printf("%f\t", u[i][j]);
		}
		printf("\n");
	}

	printf("Solution\n");
	for(int i=0; i<N; i++){
		for(int j=0; j<N; j++){
			printf("%f\t", s[i][j]);
		}
		printf("\n");
	}

	return(0);
}
