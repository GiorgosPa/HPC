OPT = -g -O3
CC = gcc
WARN = -Wall
MM = data.o mm.o
MV = data.o mv.o
CFLAGS = $(OPT) $(WARN)

all:
	$(MAKE) clean
	$(MAKE) mm
	$(MAKE) mv

mm: $(MM)
	$(CC) $(CFLAGS) -o mm $(MM)

mv: $(MV)
	$(CC) $(CFLAGS) -o mv $(MV)

clean:
	@rm -f *.o mm mv
