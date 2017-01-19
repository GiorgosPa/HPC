#include <stdio.h>
#include <helper_cuda.h>
#define BLOCK_SIZE 32
//Sequential version: One thread does it all. AKA--> Launch configuration <<<1,1,>>>
__global__
void gpu1(int m, int n, int k, double* d_A, double* d_B, double* d_C ){
    for (int i = 0; i < m; i++){
        for (int j = 0; j < n; j++){
            d_C[i*(n) + j] = 0.0;
            for (int rc = 0; rc < k; rc++){
                d_C[i*(n) + j] += d_A[i*(k) + rc] * d_B[rc*(n) + j];
            }
        }
    }
}

//Naive version: One thread per element in C
__global__
void gpu2( int m, int n, int k, double*  d_A, double* d_B, double* d_C) {

    int j = blockIdx.y*blockDim.y+threadIdx.y;  //column thead id
    int i = blockIdx.x*blockDim.x+threadIdx.x;  //row thread id
    
    if (i<m && j<n) {
        d_C[i*n + j] = 0.0;
        for (int rc = 0; rc < k; rc++){
            d_C[i*n + j] += d_A[i*k + rc] * d_B[rc*n + j];
        }
    }
}

//one thread every 2 elements of C
__global__
void gpu3(int m, int n, int k, double* d_A, double* d_B, double* d_C ){
    int j = blockIdx.y*2*blockDim.y+threadIdx.y;  //column thead id
    int i = blockIdx.x*blockDim.x+threadIdx.x;  //row thread id
    int j2 = j + blockDim.y;

    if (i<m && j<n && j2 < n) {
        d_C[i*n + j2] = 0.0;
        d_C[i*n + j] = 0.0;
        for (int rc = 0; rc < k; rc++){
            d_C[i*n + j2] += d_A[i*k + rc] * d_B[rc*n + j2];
            d_C[i*n + j] += d_A[i*k + rc] * d_B[rc*n + j];
        }
    } else if (i<m && j<n) {
        d_C[i*n + j] = 0.0;
        for (int rc = 0; rc < k; rc++){
            d_C[i*n + j] += d_A[i*k + rc] * d_B[rc*n + j];
        }
    }
}

//one thread every 4 elements of C
__global__
void gpu4(int m, int n, int k, double* d_A, double* d_B, double* d_C ){
    int j = blockIdx.y*4*blockDim.y+threadIdx.y;  //column thead id
    int i = blockIdx.x*blockDim.x+threadIdx.x;  //row thread id
    int j2 = j + blockDim.y;
    int j3 = j2 + blockDim.y;
    int j4 = j3 + blockDim.y;

    if (i<m && j<n && j2 < n && j3 < n && j4 < n) {
        d_C[i*n + j4] = 0.0;
        d_C[i*n + j3] = 0.0;
        d_C[i*n + j2] = 0.0;
        d_C[i*n + j] = 0.0;
        for (int rc = 0; rc < k; rc++){
            d_C[i*n + j4] += d_A[i*k + rc] * d_B[rc*n + j4];
            d_C[i*n + j3] += d_A[i*k + rc] * d_B[rc*n + j3];
            d_C[i*n + j2] += d_A[i*k + rc] * d_B[rc*n + j2];
            d_C[i*n + j] += d_A[i*k + rc] * d_B[rc*n + j];
        }
    } else if (i<m && j<n && j3 < n) {
        d_C[i*n + j3] = 0.0;
        d_C[i*n + j2] = 0.0;
        d_C[i*n + j] = 0.0;
        for (int rc = 0; rc < k; rc++){
            d_C[i*n + j3] += d_A[i*k + rc] * d_B[rc*n + j3];
            d_C[i*n + j2] += d_A[i*k + rc] * d_B[rc*n + j2];
            d_C[i*n + j] += d_A[i*k + rc] * d_B[rc*n + j];
        }
    } else if (i<m && j<n && j2 < n) {
        d_C[i*n + j2] = 0.0;
        d_C[i*n + j] = 0.0;
        for (int rc = 0; rc < k; rc++){
            d_C[i*n + j2] += d_A[i*k + rc] * d_B[rc*n + j2];
            d_C[i*n + j] += d_A[i*k + rc] * d_B[rc*n + j];
        }
    } else if (i<m && j<n) {
        d_C[i*n + j] = 0.0;
        for (int rc = 0; rc < k; rc++){
            d_C[i*n + j] += d_A[i*k + rc] * d_B[rc*n + j];
        }
    }
}

//blocked version with shared memory
__global__
void gpu5(int m, int n, int k, double* d_A, double* d_B, double* d_C ){
    __shared__ double A[BLOCK_SIZE][BLOCK_SIZE];
    __shared__ double B[BLOCK_SIZE][BLOCK_SIZE];
    __shared__ double C[BLOCK_SIZE][BLOCK_SIZE];
    int j = blockIdx.y*blockDim.y+threadIdx.y;  //column thead id
    int i = blockIdx.x*blockDim.x+threadIdx.x;  //row thread id

    C[threadIdx.x][threadIdx.y] = 0.0;
    for (int rc = 0; rc < k; rc+=BLOCK_SIZE){

        A[threadIdx.x][threadIdx.y] = d_A[i*k + rc + threadIdx.y];
        B[threadIdx.x][threadIdx.y] = d_B[(rc + threadIdx.x)*n + j];
        
        __syncthreads();

        for (int rc2 = 0; rc2 < BLOCK_SIZE; rc2++){
            C[threadIdx.x][threadIdx.y] += A[threadIdx.x][rc2] * B[rc2][threadIdx.y];
        }
        __syncthreads();
    }
    d_C[i*n + j] = C[threadIdx.x][threadIdx.y];
}

extern "C" {
    #include <cblas.h>
    void matmult_lib(int m, int n, int k,double* A, double* B, double* C){
        cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, m, n, k, 1.0, A, k, B, n, 0.0, C, n);
        //cblas_dgemm(CblasColMajor, CblasNoTrans, CblasNoTrans, n, m, k, 1.0, B, n, A, k, 0.0, C, n);
    }

    void matmult_gpulib(int m, int n, int k,double* A, double* B, double* C){
        cblas_dgemm(CblasColMajor, CblasNoTrans, CblasNoTrans, n, m, k, 1.0, B, n, A, k, 0.0, C, n);
    }

    void matmult_gpu5(int m, int n, int k, double* h_A, double* h_B, double* h_C){
        cudaSetDevice(6);
        double* d_A; cudaMalloc((void**)&d_A, m*k*sizeof(double));
        double* d_B; cudaMalloc((void**)&d_B, k*n*sizeof(double));
        double* d_C; cudaMalloc((void**)&d_C, m*n*sizeof(double));

        // Transfer data from host to device
        cudaMemcpy(d_A, h_A, m*k*sizeof(double), cudaMemcpyHostToDevice);
        cudaMemcpy(d_B, h_B, k*n*sizeof(double), cudaMemcpyHostToDevice);

        dim3 NUM_BLOCKS = dim3(m/32, n/32, 1);
        dim3 NUM_THREADS = dim3(32, 32, 1);

        // Kernel launch
        gpu5<<<NUM_BLOCKS, NUM_THREADS>>>(m, n, k, d_A, d_B, d_C);
        checkCudaErrors(cudaDeviceSynchronize());

        // Transfer results from device to host
        cudaMemcpy(h_C, d_C, m*n*sizeof(double), cudaMemcpyDeviceToHost);

        // Free memory
        cudaFree(d_C);
        cudaFree(d_A);
        cudaFree(d_B);
    }

    void matmult_gpu4(int m, int n, int k, double* h_A, double* h_B, double* h_C){
        cudaSetDevice(6);
        double* d_A; cudaMalloc((void**)&d_A, m*k*sizeof(double));
        double* d_B; cudaMalloc((void**)&d_B, k*n*sizeof(double));
        double* d_C; cudaMalloc((void**)&d_C, m*n*sizeof(double));

        // Transfer data from host to device
        cudaMemcpy(d_A, h_A, m*k*sizeof(double), cudaMemcpyHostToDevice);
        cudaMemcpy(d_B, h_B, k*n*sizeof(double), cudaMemcpyHostToDevice);

        int blockx = 0, blocky = 0;

        if(m%32)
            blockx = 1;
        if (n%128)
            blocky = 1; 
        dim3 NUM_BLOCKS = dim3(m/32 + blockx, n/128 + blocky, 1);
        dim3 NUM_THREADS = dim3(32, 32, 1);

        if (m*n/4 <= 1024){
            NUM_BLOCKS = dim3(1, 1, 1);
            blocky = 0;
            if (n%4)
                blocky = 1;
            NUM_THREADS = dim3(m, n/4 + blocky, 1);
        }

        // Kernel launch
        gpu4<<<NUM_BLOCKS, NUM_THREADS>>>(m, n, k, d_A, d_B, d_C);
        checkCudaErrors(cudaDeviceSynchronize());

        // Transfer results from device to host
        cudaMemcpy(h_C, d_C, m*n*sizeof(double), cudaMemcpyDeviceToHost);

        // Free memory
        cudaFree(d_C);
        cudaFree(d_A);
        cudaFree(d_B);
    }

    void matmult_gpu3(int m, int n, int k, double* h_A, double* h_B, double* h_C){
        cudaSetDevice(6);
        double* d_A; cudaMalloc((void**)&d_A, m*k*sizeof(double));
        double* d_B; cudaMalloc((void**)&d_B, k*n*sizeof(double));
        double* d_C; cudaMalloc((void**)&d_C, m*n*sizeof(double));

        // Transfer data from host to device
        cudaMemcpy(d_A, h_A, m*k*sizeof(double), cudaMemcpyHostToDevice);
        cudaMemcpy(d_B, h_B, k*n*sizeof(double), cudaMemcpyHostToDevice);

        int blockx = 0, blocky = 0;
        if(m%32)
            blockx = 1;
        if (n%64)
            blocky = 1;
        dim3 NUM_BLOCKS = dim3(m/32 + blockx, n/64 + blocky, 1);
        dim3 NUM_THREADS = dim3(32, 32, 1);

        if (m*n/2 <= 1024){
            NUM_BLOCKS = dim3(1, 1, 1);
            NUM_THREADS = dim3(m, n/2 + n % 2, 1);
        }

        // Kernel launch
        gpu3<<<NUM_BLOCKS, NUM_THREADS>>>(m, n, k, d_A, d_B, d_C);
        checkCudaErrors(cudaDeviceSynchronize());

        // Transfer results from device to host
        cudaMemcpy(h_C, d_C, m*n*sizeof(double), cudaMemcpyDeviceToHost);

        // Free memory
        cudaFree(d_C);
        cudaFree(d_A);
        cudaFree(d_B);
    }

    void matmult_gpu2(int m, int n, int k, double* h_A, double* h_B, double* h_C){
        cudaSetDevice(6);
        double* d_A; cudaMalloc((void**)&d_A, m*k*sizeof(double));
        double* d_B; cudaMalloc((void**)&d_B, k*n*sizeof(double));
        double* d_C; cudaMalloc((void**)&d_C, m*n*sizeof(double));

        // Transfer data from host to device
        cudaMemcpy(d_A, h_A, m*k*sizeof(double), cudaMemcpyHostToDevice);
        cudaMemcpy(d_B, h_B, k*n*sizeof(double), cudaMemcpyHostToDevice);

        int blockx = 0, blocky = 0;
        if(m%32)
            blockx = 1;
        if (n%32)
            blocky = 1;
        dim3 NUM_BLOCKS = dim3(m/32 + blockx, n/32 + blocky, 1);
        dim3 NUM_THREADS = dim3(32, 32, 1);

        if (m*n <= 1024){
            NUM_BLOCKS = dim3(1, 1, 1);
            NUM_THREADS = dim3(m, n, 1);
        }

        // Kernel launch
        gpu2<<<NUM_BLOCKS, NUM_THREADS>>>(m, n, k, d_A, d_B, d_C);
        checkCudaErrors(cudaDeviceSynchronize());

        // Transfer results from device to host
        cudaMemcpy(h_C, d_C, m*n*sizeof(double), cudaMemcpyDeviceToHost);

        // Free memory
        cudaFree(d_C);
        cudaFree(d_A);
        cudaFree(d_B);
    }

    void matmult_gpu1(int m, int n, int k, double* h_A, double* h_B, double* h_C ){
        cudaSetDevice(6);
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

        // Free memory
        cudaFree(d_C);
        cudaFree(d_A);
        cudaFree(d_B);
    }
} // end extern C
