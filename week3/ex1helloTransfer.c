
#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#define N 320
#define NUM_BLOCKS 32
#define THREADS_PER_BLOCK 8 //Total of 256 threads

__global__ void hello( int *a, int *b, int *c, int *d, int *e, int N ) {
  int tid = blockIdx.x; // handle the data at this index
  if (tid < N)
    a[tid] = threadIdx.x;
    b[tid] = blockDim.x;
    c[tid] = blockIdx.x;
    d[tid] = blockIdx.x*blockDim.x+threadIdx.x;
    e[tid] = (blockIdx.x + 1) * blockDim.x;

}
//create an empty (32*8)*5 array in host and device. compute in device. copy2host. print in host
//globalThreadNum = blockNumInGrid * threadsPerBlock + threadNumInBlock
//blockIdx.x * blockDim.x + threadIdx.x

int main(int argc, char **argv)
{
 // Allocate memory space on host and device
 int* h_data1 = (int*) malloc(N*sizeof(int));
 int* h_data2 = (int*) malloc(N*sizeof(int));
 int* h_data3 = (int*) malloc(N*sizeof(int));
 int* h_data4 = (int*) malloc(N*sizeof(int));
 int* h_data5 = (int*) malloc(N*sizeof(int));
 int* d_data1; cudaMalloc((void**)&d_data1, N*sizeof(int));
 int* d_data2; cudaMalloc((void**)&d_data2, N*sizeof(int));
 int* d_data3; cudaMalloc((void**)&d_data3, N*sizeof(int));
 int* d_data4; cudaMalloc((void**)&d_data4, N*sizeof(int));
 int* d_data5; cudaMalloc((void**)&d_data5, N*sizeof(int));

 // Transfer data from host to device
 cudaMemcpy(...);
 // Kernel lauch
 hello<<<NUM_BLOCKS, THREADS_PER_BLOCK>>>(d_data1, d_data2, d_data3, d_data4, d_data5, N);
 cudaDeviceSynchronize();
 // Transfer results from device to host
 cudaMemcpy(h_data1, d_data1, N*sizeof(int), cudaMemcpyDeviceToHost);
 cudaMemcpy(h_data2, d_data2, N*sizeof(int), cudaMemcpyDeviceToHost);
 cudaMemcpy(h_data3, d_data3, N*sizeof(int), cudaMemcpyDeviceToHost);
 cudaMemcpy(h_data4, d_data4, N*sizeof(int), cudaMemcpyDeviceToHost);
 cudaMemcpy(h_data5, d_data5, N*sizeof(int), cudaMemcpyDeviceToHost);

//print results to verify success
for (int i = 0; i < 256; i++) {
  printf("Hello world! I’m thread %d out of %d in block %d. My global thread id is %d out of %d.\n", h_data1[i] h_data2[i] h_data3[i] h_data4[i] h_data5[i]);
}
 // Free memory
 free(h_data1);
 free(h_data2);
 free(h_data3);
 free(h_data4);
 free(h_dat5);
 cudaFree(d_data1);
 cudaFree(d_data2);
 cudaFree(d_data3);
 cudaFree(d_data4);
 cudaFree(d_data5);

}
