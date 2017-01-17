#ifndef __POISSON_H
#define __POISSON_H
int jaccobi(int N, int kmax, double delta, double** f, double** u);
int jaccobiOMP(int N, int kmax, double delta, double** f, double** u);
int jaccobiOMP_simple(int N, int kmax, double delta, double** f, double** u);
int jaccobiOMP_datarace(int N, int kmax, double delta, double** f, double** u);
int gauss(int N, int kmax, double delta, double** f, double** u);
void free_2d(double **A);
double ** malloc_2d(int n);
#endif
