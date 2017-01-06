OPT = -g -O5 
CC = gcc
WARN = -Wall
CFLAGS = -std=c99 $(OPT) $(WARN) -fPIC

all:
	$(MAKE) clean
	$(MAKE) libmatmult
	$(MAKE) matmult_nat_test
	$(MAKE) matmult_blk_test
	$(MAKE) cblas_test

libmatmult: matmult.o
	$(CC) $(CFLAGS) -o libmatmult.so matmult.o -L /usr/lib64/atlas -lcblas -shared

cblas_test: data.o cblas_test.o matmult.o
	$(CC) $(CFLAGS) -o cblas_test data.o cblas_test.o matmult.o -L /usr/lib64/atlas -lcblas

matmult_nat_test: data.o matmult_nat_test.o matmult.o
	$(CC) $(CFLAGS) -o matmult_nat_test data.o matmult_nat_test.o matmult.o -L /usr/lib64/atlas -lcblas

matmult_blk_test: data.o matmult_blk_test.o matmult.o
	$(CC) $(CFLAGS) -o matmult_blk_test data.o matmult_blk_test.o matmult.o -L /usr/lib64/atlas -lcblas

clean:
	@rm -f *.o matmult_nat
