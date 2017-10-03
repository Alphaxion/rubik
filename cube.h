/*! @file cube.h
*/

#ifndef _CUBE_H_
#define _CUBE_H_

typedef enum Face {
    U, L, F, R, B, D
} Face;
typedef enum Facelet {
    N1, N2, N3, N4, N5, N6, N7, N8, N9
} Facelet;
typedef Face Color;
typedef Color Cube[6][9];

/*! Renvoie la couleur de la facette demandée.
*/
Color getColor(Cube *cube, Face face, Facelet facelet);


void moveCube(Cube *cube, Face face, int dir);

#endif
