/// @file cube.h

#ifndef CUBE_H
#define CUBE_H

/*********
*typedefs*
*********/

/// Les noms des faces.
typedef enum FaceName {
    UP, LEFT, FRONT, RIGHT, BACK, DOWN
} FaceName;
/// Les noms des facettes.
typedef enum FaceletName {
    F1, F2, F3, F4, F5, F6, F7, F8, F9
} FaceletName;
/// Les couleurs, nommées suivant la face sur laquelle est le centre de cette couleur.
typedef FaceName Color;
/// Une facette du cube.
typedef struct Facelet {
    FaceName face;
    FaceletName facelet;
    Color color;
} Facelet;
/// Un mouvement, composé de la face et de la direction du mouvement.
typedef struct Movement {
    FaceName face;
    int dir;
} Movement;
/// Un coin du cube.
typedef struct Corner {
    Facelet f1;
    Facelet f2;
    Facelet f3;
} Corner;
/// Une arête du cube.
typedef struct Edge {
    Facelet f1;
    Facelet f2;
};
/// Un cube.
typedef Facelet Cube[6][9];
/// Orientation du cube.
typedef struct Orientation {
    FaceName upFace;
    FaceName frontFace;
} Orientation;
/**********
*functions*
**********/

/// Renvoie la facette demandée.
Facelet getFacelet(Cube *cube, FaceName face, FaceletName facelet);
/// Change la facette demandée.
void setFacelet(Cube *cube, FaceName face, FaceletName facelet, Color color);
/// Effectue une rotation sur une face du cube.
void moveCube(Cube *cube, Movement movement, Orientation orientation);
/// Cherche un coin possédant les couleurs demandées.
Corner findCorner(Cube *cube, Color c1, Color c2, Color c3);
/// Cherche une arête possédant les couleurs demandées.
Edge findEdge(Cube *cube, Color c1, color c2);
/// Renvoie le mouvement à faire si le cube était vu de face.
Movement movementIfFaced(Movement movement, Orientation orientation);
/// Vérifie que toutes les pièces sont présentes.
int checkCube(Cube *cube);

#endif
