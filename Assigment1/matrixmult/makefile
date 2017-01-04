OPT = -g -O3
CC = gcc
WARN = -Wall
CFLAGS = -std=c99 $(OPT) $(WARN) -fPIC

all:
	$(MAKE) clean
	$(MAKE) matmult_nat
	$(MAKE) matmult_lib
	$(MAKE) cblas
	$(MAKE) cblas_test

matmult_nat: matmult_nat.o
	$(CC) $(CFLAGS) -o matmult_nat matmult_nat.o -shared

matmult_lib: matmult_lib.o
	$(CC) $(CFLAGS) -o matmult_nat matmult_lib.o -shared

cblas: matmult_lib.o matmult_nat.o
	$(CC) $(CFLAGS) -o libmatmult.so matmult_lib.o matmult_nat.o -L /usr/lib64/atlas -lcblas -shared

cblas_test: data.o cblas_test.o
	$(CC) $(CFLAGS) -o cblas_test data.o cblas_test.o -L /usr/lib64/atlas -lcblas


clean:
	@rm -f *.o matmult_nat
