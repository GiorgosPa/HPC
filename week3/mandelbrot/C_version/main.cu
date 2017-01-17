#include <stdio.h>
#include <stdlib.h>
#include "writepng.h"
#include "mandel.h"
#include <helper_cuda.h>


int
main(int argc, char *argv[]) {

    int   width, height;
    int   *d_width, *d_height;
    int	  max_iter;
    int   *d_max_iter;
    int   *image;
    int   *d_image;

    width    = 2601;
    height   = 2601;
    max_iter = 400;

    cudaMalloc((void**) &d_width, sizeof(int));
    cudaMalloc((void**) &d_height, sizeof(int));
    cudaMalloc((void**) &d_max_iter, sizeof(int));
    
    cudaMemcpy(d_width, &width, width * height * sizeof(int), cudaMemcpyDeviceToHost);
    cudaMemcpy(d_height, &height, width * height * sizeof(int), cudaMemcpyDeviceToHost);
    cudaMemcpy(d_max_iter, &max_iter, width * height * sizeof(int), cudaMemcpyDeviceToHost);

    // command line argument sets the dimensions of the image
    if ( argc == 2 ) width = height = atoi(argv[1]);

    image = (int *)malloc( width * height * sizeof(int));

    if ( image == NULL ) {
       fprintf(stderr, "memory allocation failed!\n");
       return(1);
    }
    cudaMalloc((void**) &d_image, width * height * sizeof(int));

    dim3 blocks = dim3(64,64);
    dim3 threads = dim3(64,64);

    mandel<<<17, 153>>>(d_width, d_height, d_image, d_max_iter);

    checkCudaErrors(cudaDeviceSynchronize());
    cudaMemcpy(image, d_image, width * height * sizeof(int), cudaMemcpyDeviceToHost);
    writepng("mandelbrot.png", image, width, height);

    return(0);
}
