#ifndef __DATA_H
#define __DATA_H

void initializeMM(double* restrict, double* restrict, int, int, int);

double ** malloc_2d(int, int);
void free_2d(double **);
#endif
