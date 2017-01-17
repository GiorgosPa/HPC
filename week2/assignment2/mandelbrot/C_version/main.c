#include <stdio.h>
#include <stdlib.h>
#include "mandel.h"
#include <omp.h>



int
main(int argc, char *argv[]) {

    int   width, height;
    int	  max_iter;
    int   *image;

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

    double start_time, elapsed_time;
    start_time = omp_get_wtime();
    mandel(width, height, image, max_iter);
    elapsed_time = omp_get_wtime() - start_time;

    printf("Time (secs) %d\n", elapsed_time);

    //writepng("mandelbrot.png", image, width, height);

    return(0);
}
