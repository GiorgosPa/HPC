#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <omp.h>

double integ(double x){
   return(4 / (1 + pow(x, 2)));
}

int main(){
  double pi =  0;
  int N  = 100000000;
  double sum = 0;
  double x;
  double local = 0.0;
  int i;

  #pragma omp parallel private(local,i,x)
  {
    #pragma omp for
    for (i=1; i<N+1 ; i++){
      x = (i - 0.5)/N;
      local += integ(x);
    }
    #pragma omp critical
    sum += local;
  } /* end opm parallel */

  pi = sum / N;
  printf("%f\n", pi);
  return (0);
}
