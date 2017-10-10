flags = -Wall -Werror -g

all: rubik

rubik:
	gcc -o bin/rubik main.c camera.c stepper.c $(flags)

test:
	gcc -o bin/test test.c $(flags)

clean:
	rm -f bin
