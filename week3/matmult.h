#ifndef __MATMULTCU_H
#define __MATMULTCU_H

__global__
void matmultCU( double*  d_A, double* d_B, double* d_C, int DIM);
#endif
