OPT = -g -O3
CC = gcc
WARN = 
CFLAGS = -std=c99 $(OPT) $(WARN)

all:
	$(MAKE) clean
	$(MAKE) poisson
	$(MAKE) driver

libmatmult: matmult.o
	$(CC) $(CFLAGS) -o libmatmult.so matmult.o -shared

driver: poisson.o main2.o
	$(CC) $(CFLAGS) -o driver main2.o poisson.o -lm -lgomp

poisson: poisson.o main.o
	$(CC) $(CFLAGS) -o poisson main.o poisson.o	-lm

clean:
	@rm -f *.o poisson
