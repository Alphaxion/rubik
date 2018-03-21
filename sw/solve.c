/// @file solve.c

#include "solve.h"

char* solve(char *facelets) {
    return solution(facelets, 24, 1000, 0, "cache");
}
