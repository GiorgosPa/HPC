OPT = -g -O3
CC = gcc
WARN = 
CFLAGS = -std=c99 $(OPT) $(WARN)

all:
	$(MAKE) clean
	$(MAKE) poisson

libmatmult: matmult.o
	$(CC) $(CFLAGS) -o libmatmult.so matmult.o -shared

poisson: poisson.o main.o
	$(CC) $(CFLAGS) -o poisson main.o poisson.o	-lm

clean:
	@rm -f *.o poisson
