OPT = -g -O3
CC = gcc
WARN = -Wall
MM = data.o matmult_nat.o
CFLAGS = $(OPT) $(WARN)

all:
	$(MAKE) clean
	$(MAKE) matmult_nat

matmult_nat: $(MM)
	$(CC) $(CFLAGS) -o matmult_nat $(MM)



clean:
	@rm -f *.o matmult_nat
