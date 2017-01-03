#include "distcheck.h"
#include <unistd.h>

#ifdef ALL_IN_ONE

double
distcheck(particle_t *p, int n) {
    // dummy code - please change
    double sum = 0;
    for (int i = 0; i < n; i++ ){
        sum += p[i].dist;
    }
    return(sum);
}

#else

double
distcheck(double *v, int n) {
    //dummy code - please change
    double sum = 0;
    for (int i = 0; i < n; i++ ){
        sum += v[i];
    }
    return(sum);
}

#endif
