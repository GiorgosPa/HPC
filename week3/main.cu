#include <stdio.h>
#include <helper_cuda.h>

__global__
void hello(){
    int block, blocks, thread, gthread, threads_per_block;
    block = blockIdx.x;
    thread = threadIdx.x;
    threads_per_block = blockDim.x;
    gthread = block * threads_per_block + thread;
    blocks = gridDim.x;
    if (gthread == 100)
    {
        // segmentation fault
        int *a = (int*) 0x10000;
        *a = 0;
    }
    printf("Hello world! I’m thread %d out of %d in block %d. My global thread id is %d out of %d\n",
     thread, threads_per_block, block, gthread, threads_per_block*blocks);
}


int main(){
    hello<<<16,16>>>();
    checkCudaErrors(cudaDeviceSynchronize());
    return(0);
}