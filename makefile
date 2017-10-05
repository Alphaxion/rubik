files = -o rubik main.c cube.c solve.c
links =
flags = -Wall -Werror
relflags = -O2
dbgflags = -g

flags += $(dbgflags)

.PHONY: all clean

all: rubik

rubik:
	gcc $(files) $(links) $(flags)

clean:
	rm -f rubik
