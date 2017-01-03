OPT = -g -O3
CC = gcc
WARN = -Wall
OBJECTS = data.o main.o io.o
CFLAGS = $(OPT) $(WARN)

excer1.exe: $(OBJECTS)
	$(CC) $(CFLAGS) -o excer1.exe $(OBJECTS)

clean:
	@rm -f *.o excer1.exe
