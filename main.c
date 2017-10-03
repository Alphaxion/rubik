#include "cube.h"
#include "solve.h"

int main() {
    Cube cube = {
        {U, U, U, U, U, U, U, U, U},
        {L, L, L, L, L, L, L, L, L},
        {F, F, F, F, F, F, F, F, F},
        {R, R, R, R, R, R, R, R, R},
        {B, B, B, B, B, B, B, B, B},
        {D, D, D, D, D, D, D, D, D}
    };
    Face color = getColor();
    return 0;
};
