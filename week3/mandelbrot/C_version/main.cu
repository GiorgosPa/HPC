#include <stdio.h>
#include <stdlib.h>
#include "writepng.h"
#include "mandel.h"


int
main(int argc, char *argv[]) {

    int   width, height;
    int	  max_iter;
    int   *image;
    int   *d_image;

    width    = 2601;
    height   = 2601;
    max_iter = 400;

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

    mandel<<<blocks, threads>>>(width, height, d_image, max_iter);

    cudaMemcpy(image, d_image, width * height * sizeof(int), cudaMemcpyDeviceToHost);
    writepng("mandelbrot.png", image, width, height);

    return(0);
}
