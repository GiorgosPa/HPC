//Sequential version: One thread does it all. AKA--> Launch configuration <<<1,1,>>>
__global__
void gpu1(int *m, int *n, int *k, double* d_A, double* d_B, double* d_C ){
    for (int i = 0; i < *m; i++){
        for (int j = 0; j < *n; j++){
            d_C[i*(*n) + j] = 0;
            for (int rc = 0; rc < *k; rc++){
                d_C[i*(*n) + j] += d_A[i*(*k) + rc] * d_B[rc*(*n) + j];
            }
        }
    }
}

void matmult_gpu1(int m, int n, int k, double* h_A, double* h_B, double* h_C ){

    double* d_A; cudaMalloc((void**)&d_A, m*k*sizeof(double));
    double* d_B; cudaMalloc((void**)&d_B, k*n*sizeof(double));
    double* d_C; cudaMalloc((void**)&d_C, m*n*sizeof(double));
    int *d_m, *d_n, *d_k;

    // Transfer data from host to device
    cudaMemcpy(d_m, &m, sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_n, &n, sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_k, &k, sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_A, h_A, m*k*sizeof(double), cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, h_B, k*n*sizeof(double), cudaMemcpyHostToDevice);

    // Kernel launch
    gpu1<<<1,1>>>(d_m, d_n, d_k, d_A, d_B, d_C);
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