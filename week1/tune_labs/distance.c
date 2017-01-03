#include "distance.h"
#include <unistd.h>
#include <math.h>

#ifdef ALL_IN_ONE

double
distance(particle_t *p, int n) {
    // dummy code - please change
    double sum = 0;
    for (int i = 0; i < n; i++ ){
        p[i].dist = sqrt(pow(p[i].x, 2) + pow(p[i].y, 2) + pow(p[i].z, 2));
        sum += p[i].dist;
    }
    return(sum);
}

#else

double
distance(particle_t *p, double *v, int n) {
    // dummy code - please change
    double sum = 0;
    for (int i = 0; i < n; i++ ){
        v[i] = sqrt(pow(p[i].x, 2) + pow(p[i].y, 2) + pow(p[i].z, 2));
        sum += v[i];
    }
    return(sum);
}

#endif
