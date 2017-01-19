#include "poissonGPU.h"
#include <stdlib.h>
#include <stdio.h>
#include <helper_cuda.h>

//when we have memory latency issues, it's because we have not enough threads (from nvcc profiler analysis)
//In Kernel Memory (guided): it would light up red if there's a bottleneck in the bandwidth (eg. L1 L2 cache etc.)

/* Jaccobi GPU Method : one thread does all <<1,1>> */
__global__
void jaccobi(int N, double delta, double* d_f, double* d_u, double* d_uold){
	for(int i=1; i<N-1; i++){
		for(int j=1; j<N-1; j++){
			d_u[i*N +j] = 0.25 *(d_uold[(i-1)*N +j] + d_uold[(i+1)*N +j] + d_uold[i*N + j-1] + d_uold[i*N + j+1] + delta*delta*d_f[i*N +j]);
		}
	}
}


__global__
void jaccobiMT(int N, double delta, double* d_f, double* d_u, double* d_uold){
	 int j = blockIdx.y*blockDim.y+threadIdx.y;  //row thead id
     int i = blockIdx.x*blockDim.x+threadIdx.x;  //column thread id
     if (i==0 || j==0 || i==N-1 || j==N-1) return;
	 if ( i < N ){
	 	d_u[i*N +j] = 0.25 *(d_uold[(i-1)*N +j] + d_uold[(i+1)*N +j] + d_uold[i*N + j-1] + d_uold[i*N + j+1] + delta*delta*d_f[i*N +j]);
	 }
}

int poisson_gpu1(int N, int kmax, double delta, double* h_f, double* h_u){

	cudaSetDevice(3);
	//allocate memory in device
	double* d_u;    cudaMalloc((void**)&d_u, N*N*sizeof(double));
	double* d_uold; cudaMalloc((void**)&d_uold, N*N*sizeof(double));
	double* d_f;    cudaMalloc((void**)&d_f, N*N*sizeof(double));
	          

	// Transfer data from host to device
	cudaMemcpy(d_u, h_u, N*N*sizeof(double), cudaMemcpyHostToDevice);
	cudaMemcpy(d_f, h_f, N*N*sizeof(double), cudaMemcpyHostToDevice);
	cudaMemcpy(d_uold, h_u, N*N*sizeof(double), cudaMemcpyHostToDevice);

	int iterations = 0;
	// Kernel launch
	while( iterations < kmax) {

		jaccobi<<<1,1>>>(N,  delta,  d_f,  d_u, d_uold);
		checkCudaErrors(cudaDeviceSynchronize());

		double* tmp;
		tmp = d_u;
		d_u = d_uold;
		d_uold = tmp;

		iterations++;
	}

	 // Transfer results from device to host
	 cudaMemcpy(h_u, d_u, N*N*sizeof(double), cudaMemcpyDeviceToHost);

	//print matrix d_C
	//print_matrix( m,  n, d_C);

	// Free memory
	cudaFree(d_u);
	cudaFree(d_uold);
 	cudaFree(d_f);
 	return(kmax);
}

int poisson_gpu2(int N, int kmax, double delta, double* h_f, double* h_u){

	cudaSetDevice(3);
	//allocate memory in device
	double* d_u;    cudaMalloc((void**)&d_u, N*N*sizeof(double));
	double* d_uold; cudaMalloc((void**)&d_uold, N*N*sizeof(double));
	double* d_f;    cudaMalloc((void**)&d_f, N*N*sizeof(double));
	          

	// Transfer data from host to device
	cudaMemcpy(d_u, h_u, N*N*sizeof(double), cudaMemcpyHostToDevice);
	cudaMemcpy(d_f, h_f, N*N*sizeof(double), cudaMemcpyHostToDevice);
	cudaMemcpy(d_uold, h_u, N*N*sizeof(double), cudaMemcpyHostToDevice);

    dim3 NUM_BLOCKS = dim3( N/32 +1 , N/32 +1 );
    dim3 NUM_THREADS = dim3( 32, 32);

    if (N <= 32 )
    {
    	NUM_BLOCKS = dim3( 1, 1, 1 );
    	NUM_THREADS = dim3( N, N, 1);
    }

	int iterations = 0;

	// Kernel launch
	while( iterations < kmax) {

		jaccobiMT<<< NUM_BLOCKS, NUM_THREADS >>>(N,  delta,  d_f,  d_u, d_uold);
		checkCudaErrors(cudaDeviceSynchronize());

		double* tmp;
		tmp = d_u;
		d_u = d_uold;
		d_uold = tmp;

		iterations++;
	}

	 // Transfer results from device to host
	 cudaMemcpy(h_u, d_u, N*N*sizeof(double), cudaMemcpyDeviceToHost);

	//print matrix d_C
	//print_matrix( m,  n, d_C);

	// Free memory
	cudaFree(d_u);
	cudaFree(d_uold);
 	cudaFree(d_f);

 	return(kmax);
}
