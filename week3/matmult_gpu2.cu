#include <stdio.h>
#include <helper_cuda.h>




//Naive version: One thread per element in C
__global__
void gpu2( int m, int n, int k, double*  d_A, double* d_B, double* d_C) {

    int i = blockIdx.y*blockDim.y+threadIdx.y;  //row thead id
    int j = blockIdx.x*blockDim.x+threadIdx.x;  //column thread id
    double temp = 0;

    if (i<m && j<n) {
        for (int rc = 0; rc < k; rc++){
            temp += d_A[i*k + rc] * d_B[rc*n + j];
        }
        d_C[i*n + j]  = temp;
    }

}

extern "C" {
    #include <cblas.h>
void matmult_gpu2(int m, int n, int k, double* h_A, double* h_B, double* h_C){
          cudaSetDevice(3);
          double* d_A; cudaMalloc((void**)&d_A, m*k*sizeof(double));
          double* d_B; cudaMalloc((void**)&d_B, k*n*sizeof(double));
          double* d_C; cudaMalloc((void**)&d_C, m*n*sizeof(double));


// Transfer data from host to device
cudaMemcpy(d_A, h_A, m*k*sizeof(double), cudaMemcpyHostToDevice);
cudaMemcpy(d_B, h_B, k*n*sizeof(double), cudaMemcpyHostToDevice);

//Q: IS THIS OKAY? one thread per element in d_C(mxn)
dim3 NUM_BLOCKS = dim3((m/32 + 1), (n/32 + 1), 1);
dim3 NUM_THREADS =  dim3(32, 32, 1);

if (m*n <= 1024) {
    NUM_BLOCKS = dim3(1, 1, 1);
    NUM_THREADS =  dim3(m, n, 1);
}


 // Kernel launch
 gpu2<<<NUM_BLOCKS, NUM_THREADS>>>(m, n, k, d_A, d_B, d_C);
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

} /* from extern "C" */
