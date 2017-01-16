#include <stdio.h>

__global__
void hello(){
    int block, thread, gthread, threads_per_block;
    block = blockIdx.x;
    thread = threadIdx.x;
    threads_per_block = blockDim.x;
    gthread = block * threads_per_block + thread;
    printf("Hello world! I’m thread %d out of %d in block %d. My global thread id is %d out of %d\n",
     thread, threads_per_block, block, gthread, threads_per_block);
}


int main(){
    hello<<<16,16>>>()
    return(0);
}