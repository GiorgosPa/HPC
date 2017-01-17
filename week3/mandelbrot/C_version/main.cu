#include <stdio.h>
#include <stdlib.h>
#include "writepng.h"
#include "mandel.h"
#include <helper_cuda.h>
#include <math.h>

int
main(int argc, char *argv[]) {

    int   width, height;
    int   *d_width, *d_height;
    int	  max_iter;
    int   *d_max_iter;
    int   *image;
    int   *d_image;
    int   k = 32;

    width    = 2601;
    height   = 2601;
    max_iter = 400;

    // command line argument sets the dimensions of the image
    if ( argc == 2 ) width = height = atoi(argv[1]);

    cudaSetDevice(6);

    cudaMalloc((void**) &d_width, sizeof(int));
    cudaMalloc((void**) &d_height, sizeof(int));
    cudaMalloc((void**) &d_max_iter, sizeof(int));
    
    cudaMemcpy(d_width, &width, sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_height, &height, sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_max_iter, &max_iter, sizeof(int), cudaMemcpyHostToDevice);

    image = (int *)malloc( width * height * sizeof(int));

    if ( image == NULL ) {
       fprintf(stderr, "memory allocation failed!\n");
       return(1);
    }
    cudaMalloc((void**) &d_image, width * height * sizeof(int));

    int blockx = ceil(width / (double)k);
    int blocky = ceil(height / (double)k); 
    
    dim3 blocks = dim3(blockx,blocky,1);
    dim3 threads = dim3(k,k,1);

    mandel<<<blocks, threads>>>(d_width, d_height, d_image, d_max_iter);

    checkCudaErrors(cudaDeviceSynchronize());
    cudaMemcpy(image, d_image, width * height * sizeof(int), cudaMemcpyDeviceToHost);
    writepng("mandelbrot.png", image, width, height);

    return(0);
}
