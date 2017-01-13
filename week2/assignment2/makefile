OPTGCC = -g -O3
OPTSUN = -g -fast
CCSUN = suncc
CCGCC = gcc
WARN = 
OMPGCC = -fopenmp
OMPSUN = -xopenmp
XFLAGSSUN = -xinstrument=datarace -xvpara
XFLAGSGCC =
OMP = $(OMPSUN)
OPT = $(OPTSUN)
CC = $(CCSUN)
XFLAGS = $(XFLAGSSUN)
CFLAGS = -std=c99 $(OMP) $(OPT) $(WARN)

all:
	$(MAKE) clean
	$(MAKE) driver

driver: poisson.o main2.o
	$(CC) $(CFLAGS) -o driver main2.o poisson.o -lm 

clean:
	@rm -f *.o poisson
