flags = -Wall -Werror -g

all: rubik

rubik:
	gcc -o rubik main.c cube.c solve.c camera.c stepper.c $(flags)

solve:
	gcc -o solve test_solve.c cube.c solve.c $(flags)

clean:
	rm -f rubik solve
