TARGET	= mandelbrot
OBJS	= main.o mandel.o writepng.o

OPT	= -g
PIC	=
XOPTS = -G -Xptxas=-v
ARCH  = -arch=sm_30
OMP   = -fopenmp

CXX	= nvcc
CXXFLAGS= --compiler-options "$(OPT) $(PIC) $(OMP)" $(ARCH) $(XOPTS) -I $(PNGWRTIPATH)

CUDA_PATH ?= /appl/cuda/8.0
INCLUDES = -I$(CUDA_PATH)/include -I$(CUDA_PATH)/samples/common/inc

SOFLAGS =
XLIBS	=

PNGWRITERPATH = pngwriter
# ARCH	      = $(shell uname -p)
PNGWRTLPATH   = $(PNGWRITERPATH)/lib/x86_64
PNGWRTIPATH   = $(PNGWRITERPATH)/include
PNGWRITERLIB  = $(PNGWRTLPATH)/libpngwriter.a

LIBS	= -L $(PNGWRTLPATH) -lpngwriter -lpng

$(TARGET): $(OBJS)
	$(CXX) -o $@ $(CXXFLAGS) $(SOFLAGS) $(INCLUDES) $^ $(LIBS)

.SUFFIXES: .cu
.cu.o:
	$(CXX) -o $*.o -c $*.cu $(CXXFLAGS) $(SOFLAGS) $(INCLUDES)

clean:
	@/bin/rm -f $(TARGET) $(OBJS)

$(PNGWRITERLIB):
	@cd pngwriter/src && $(MAKE)

all: $(PNGWRITERLIB) $(TARGET)

# OPT	= -g -fast
# ISA	=
# PARA	=

# PNGWRITERPATH = pngwriter
# ARCH	      = $(shell uname -p)
# PNGWRTLPATH   = $(PNGWRITERPATH)/lib/$(ARCH)
# PNGWRTIPATH   = $(PNGWRITERPATH)/include
# PNGWRITERLIB  = $(PNGWRTLPATH)/libpngwriter.a

# CCC	= CC
# CXX	= CC
# CXXFLAGS= -I $(PNGWRTIPATH)

# CFLAGS	= $(OPT) $(ISA) $(PARA) $(XOPT)

# F90C  	= f90

# LIBS	= -L $(PNGWRTLPATH) -lpngwriter -lpng


# all: $(PNGWRITERLIB) $(TARGET)

# $(TARGET): $(OBJS)
# 	$(CCC) $(CFLAGS) -o $@ $(OBJS) $(LIBS)

# $(PNGWRITERLIB):
# 	@cd pngwriter/src && $(MAKE)

# clean:
# 	@/bin/rm -f *.o core

# realclean: clean
# 	@cd pngwriter/src && $(MAKE) clean
# 	@rm -f $(PNGWRITERLIB)
# 	@rm -f $(TARGET)
# 	@rm -f mandelbrot.png

# # dependencies
# #
# main.o  : main.c mandel.h
# mandel.o: mandel.c
# writepng.o: writepng.h writepng.cc
