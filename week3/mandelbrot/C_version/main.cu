#include <stdio.h>
#include <stdlib.h>
#include "writepng.h"


__global__
void mandel(int disp_width, int disp_height, int *array, int max_iter) {

    double  scale_real, scale_imag;
    double  x, y, u, v, u2, v2;
    int     iter;

    scale_real = 3.5 / (double)disp_width;
    scale_imag = 3.5 / (double)disp_height;

    int tidx = blockIdx.x * blockDim.x + threadIdx.x;
    int tidy = blockIdx.y * blockDim.y + threadIdx.y;
    if ((tidx >= disp_width) || (tidy >= disp_height))
        return;

    //for(i = 0; i < disp_width; i++) {

        x = ((double)tidx * scale_real) - 2.25;

//      for(j = 0; j < disp_height; j++) {
            y = ((double)tidy * scale_imag) - 1.75;

            u    = 0.0;
            v    = 0.0;
            u2   = 0.0;
            v2   = 0.0;
            iter = 0;

            while ( u2 + v2 < 4.0 &&  iter < max_iter ) {
            v = 2 * v * u + y;
            u = u2 - v2 + x;
            u2 = u*u;
            v2 = v*v;
            iter = iter + 1;
            }

            // if we exceed max_iter, reset to zero
            iter = iter == max_iter ? 0 : iter;

            //array[i*disp_height + j] = iter;
            array[tidx*disp_height + tidy] = iter;

//      }
//    }
}



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

    cudaMemcpyDeviceToHost(image, d_image, width * height * sizeof(int), cudaMemcpyDeviceToHost);
    writepng("mandelbrot.png", image, width, height);

    return(0);
}
