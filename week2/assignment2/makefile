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

driver: poisson.o main.o
	$(CC) $(CFLAGS) -o driver main.o poisson.o -lm 

clean:
	@rm -f *.o poisson
