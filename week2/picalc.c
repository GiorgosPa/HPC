#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(){
  int pi =  0;
  int N  = 10;
  int sum = 0;
  int i;
    for (i=1; i<N+1 ; N++){
      sum += 4 / (1 + (pow((i - 0.5)/N, 2)));
  }
  pi = sum / N;
  return (pi);
}
