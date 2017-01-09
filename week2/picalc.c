#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

double integ(double x){
   return(4 / (1 + pow(x, 2)));
}

int main(){
  double pi =  0;
  int N  = 100;
  double sum = 0;
  double x;
  double cpu_time;
  clock_t T1, T2;

  T1 = clock();

  for (int i=1; i<N+1 ; i++){
    x = (i - 0.5)/N;
    sum += integ(x);
  }

  T2 = clock();
  cpu_time = ((double)(T2-T1))/CLOCKS_PER_SEC;

  pi = sum / N;
  printf("%f\n", pi);
  printf("%f\n", cpu_time);
  return (0);
}
