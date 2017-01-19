#include <stdio.h>
#include <helper_cuda.h>

//Sequential version: One thread does it all. AKA--> Launch configuration <<<1,1,>>>
__global__
void gpu1(int m, int n, int k, double* d_A, double* d_B, double* d_C ){
    double temp;
    for (int i = 0; i < m; i++){
        for (int j = 0; j < n; j++){
                 temp = 0;
            for (int rc = 0; rc < k; rc++){
                //C[i][j] += A[i][rc] * B[rc][j];
                //temp += d_A[i*k + rc] * d_B[rc*n + j]; //original
                temp += d_A[i*k + rc] * d_B[rc*n + j];

            }
            //d_C[i*n + j] = temp; //original
            d_C[i*n + j] = temp;
        }
    }
}


extern "C" {
    #include <cblas.h>
void matmult_gpu1(int m, int n, int k, double* h_A, double* h_B, double* h_C ){
          cudaSetDevice(3);
          double* d_A; cudaMalloc((void**)&d_A, m*k*sizeof(double));
          double* d_B; cudaMalloc((void**)&d_B, k*n*sizeof(double));
          double* d_C; cudaMalloc((void**)&d_C, m*n*sizeof(double));
          

// Transfer data from host to device
cudaMemcpy(d_A, h_A, m*k*sizeof(double), cudaMemcpyHostToDevice);
cudaMemcpy(d_B, h_B, k*n*sizeof(double), cudaMemcpyHostToDevice);

// Kernel launch
gpu1<<<1,1>>>(m, n, k, d_A, d_B, d_C);
checkCudaErrors(cudaDeviceSynchronize());

 // Transfer results from device to host
 cudaMemcpy(h_C, d_C, m*n*sizeof(double), cudaMemcpyDeviceToHost);

//print matrix d_C
//print_matrix( m,  n, d_C);

 // Free memory
 cudaFree(d_C);
 cudaFree(d_A);
 cudaFree(d_B);

}


void print_matrix(int m, int n, double* A){
	for(int i=0; i<m; i++){
	  for(int j=0; j<n; j++){
	      printf("%f\t", A[i + j]);
	  }
	  printf("\n");
	}
}






/*
//Naive version: One thread per element in C
__global__
void matmult_gpu2( double*  d_A, double* d_B, double* d_C, int DIM) {
  //where DIM is the size of the N by N (A, B, and C) square matrices


    int row = blockIdx.y*blockDim.y+threadIdx.y;
    int col = blockIdx.x*blockDim.x+threadIdx.x;
    double d_tempSum = 0;  //temporarily holds row*column sum of its respective block

    // each thread computes one element of the block (sub-matrix)
    for (int i = 0; i < DIM; i++) {
        d_tempSum += d_A[row * DIM + i] * d_B[i * DIM + col];
    }

    d_C[row * DIM + col] = d_tempSum;
}


//Improved Naive version: Each thread computes exactly 2 elements of C
__global__
void matmult_gpu3(double* d_A, double* d_B, double* d_C, ){

}

//Improved Naive version 2: Each thread computes exactly 4 elements of C
__global__
void matmult_gpu4(double* d_A, double* d_B, double* d_C, ){

}

//Shared Memory version: loads A and B (or segments of them) into shared memory to improve performance
__global__
void matmult_gpu5(double* d_A, double* d_B, double* d_C, ){

}

//non-CUDA version
    for (int i = 0; i < m; i++){
        for (int j = 0; j < n; j++){
        	C[i][j] = 0.0;
        }
    }

    for (int i = 0; i < m; i++){
        for (int j = 0; j < n; j++){
            for (int rc = 0; rc < k; rc++){
                C[i][j] += A[i][rc] * B[rc][j];
            }
        }
    }
}

*/
}
