#ifndef __POISSON_H
#define __POISSON_H
void jaccobi(int N, int kmax, double delta, double** f, double** u);
void gauss(int N, int kmax, double delta, double** f, double** u);
void free_2d(double **A);
double ** malloc_2d(int n);
#endif
