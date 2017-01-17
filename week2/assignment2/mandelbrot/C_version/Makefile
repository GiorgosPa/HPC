TARGET	= mandelbrot
OBJS	= main.o mandelOMP.o  

OPT	= -g -fast
ISA	= 
PARA	= 
OMPSUN = -xopenmp
CCSUN = suncc
OMP = $(OMPSUN)
WARN = 


PNGWRITERPATH = pngwriter
ARCH	      = $(shell uname -p)
PNGWRTLPATH   = $(PNGWRITERPATH)/lib/$(ARCH)
PNGWRTIPATH   = $(PNGWRITERPATH)/include
PNGWRITERLIB  = $(PNGWRTLPATH)/libpngwriter.a

CCC	= suncc
CXX	= CC
CXXFLAGS= -I $(PNGWRTIPATH)
CFLAGS = -std=c99 $(OMP) $(OPT) $(WARN)

# CFLAGS	= $(OPT) $(ISA) $(PARA) $(XOPT)

F90C  	= f90

LIBS	= -L $(PNGWRTLPATH) -lpngwriter -lpng 


all: $(PNGWRITERLIB) $(TARGET)

$(TARGET): $(OBJS) 
	$(CCC) $(CFLAGS) -o $@ $(OBJS) $(LIBS)

$(PNGWRITERLIB):
	@cd pngwriter/src && $(MAKE)

clean:
	@/bin/rm -f *.o core

realclean: clean
	@cd pngwriter/src && $(MAKE) clean
	@rm -f $(PNGWRITERLIB)
	@rm -f $(TARGET)
	@rm -f mandelbrot.png

# dependencies
#
main.o  : main.c mandel.h
mandelOMP.o: mandelOMP.c
