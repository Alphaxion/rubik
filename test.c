/// @file test.c
/// A utiliser pour tester les fonctionnalités.

#include "cube.h"
#include "solve.h"
#include <stdio.h>

int main() {
    Cube cube = {
        { BACK,  BACK,  DOWN,  FRONT, UP,    FRONT, FRONT, FRONT, UP    },
        { RIGHT, LEFT,  RIGHT, DOWN,  LEFT,  RIGHT, DOWN,  DOWN,  FRONT },
        { UP,    DOWN,  BACK,  BACK,  FRONT, RIGHT, LEFT,  BACK,  BACK  },
        { LEFT,  UP,    BACK,  DOWN,  RIGHT, FRONT, LEFT,  LEFT,  DOWN  },
        { RIGHT, UP,    UP,    RIGHT, BACK,  BACK,  LEFT,  RIGHT, RIGHT },
        { UP,    LEFT,  DOWN,  LEFT,  DOWN,  UP,    FRONT, UP,    FRONT }
    };
    printf("%d", checkCube(&cube));
    Movement solution[1000];
    solveCube(&cube, solution);
    return 0;
};
