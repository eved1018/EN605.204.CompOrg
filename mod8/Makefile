all: libConversions
CC = gcc

libConversions: libConversions.o 
	$(CC) $@.o -g -o $@
.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@
