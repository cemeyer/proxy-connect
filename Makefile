# Basic Makefile for connect

WARNFLAGS = -Wall -Wextra
OPTFLAGS = -O2 -g -pipe -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -mtune=generic

connect: connect.c
	gcc -o $@  $(OPTFLAGS) $(WARNFLAGS) $^
