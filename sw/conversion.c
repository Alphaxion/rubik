/// @file conversion.c

/*The robot has 3 arms: L, R and F (for Left, Right and Front).
*   moves:
*   1 = left arm turns 90° clockwise.
*   -1 = left arm turns 90° counter-clockwise.
*   2 = left arm opens
*   -2 = left arm closes
*   3 = right arm turns 90° clockwise.
*   -3 = right arm turns 90° counter-clockwise.
*   4 = right arm opens
*   -4 = right arm closes
*   5 = front arm turns 90° clockwise.
*   -5 = front arm turns 90° counter-clockwise.
*   6 = front arm opens
*   -6 = front arm closes
*   7 = left arm turns 90° clockwise and right arm turns 90° counter-clockwise at the same time.
*   -7 = left arm turns 90° counter-clockwise and right arm turns 90° clockwise at the same time.
*/

#include <stdlib.h>

#include "conversion.h"

int* conversion(char* sol, int length) {
    int* moves = (int*)calloc(10*length, sizeof(int));
    int cur = 0;   //current position in s
    for(int i = 0; i<length; i++) {
    	if(sol[i]=='F' && (i == length-1 || sol[i+1]==' ')) {  //case F
           moves[cur++] = 5;
           moves[cur++] = 6;
           moves[cur++] = -5;
           moves[cur++] = -6;
        }
        if(i<length-1 && sol[i]=='F' && sol[i+1]== '\'') {     // case F'
            moves[cur++] = -5;
            moves[cur++] = 6;
            moves[cur++] = 5;
            moves[cur++] = -6;
        }
        if(sol[i]=='L' && (i == length-1 || sol[i+1]== ' ')) {   //case L
            moves[cur++] = 1;
            moves[cur++] = 2;
            moves[cur++] = -1;
            moves[cur++] = -2;
        }
        if(i<length-1 && sol[i]=='L' && sol[i+1]== '\'') {   //case L'
            moves[cur++] = -1;
            moves[cur++] = 2;
            moves[cur++] = 1;
            moves[cur++] = -2;
        }
        if(sol[i]=='R' && (i == length-1 || sol[i+1]== ' ')) {   //case R
            moves[cur++] = 3;
            moves[cur++] = 4;
            moves[cur++] = -3;
            moves[cur++] = -4;
        }
        if(i<length-1 && sol[i]=='R' && sol[i+1]== '\'') {   //case R'
            moves[cur++] = -3;
            moves[cur++] = 4;
            moves[cur++] = 3;
            moves[cur++] = -4;
        }
        if(sol[i]=='U' && (i == length-1 || sol[i+1]== ' ')) {   //case U
            moves[cur++] = 6;
            moves[cur++] = -7;
            moves[cur++] = -6;
            moves[cur++] = 5;
            moves[cur++] = 6;
            moves[cur++] = -5;
            moves[cur++] = 7;
            moves[cur++] = -6;
        }
        if(i<length-1 && sol[i]=='U' && sol[i+1]== '\'') {   //case U'
            moves[cur++] = 6;
            moves[cur++] = -7;
            moves[cur++] = -6;
            moves[cur++] = -5;
            moves[cur++] = 6;
            moves[cur++] = 5;
            moves[cur++] = 7;
            moves[cur++] = -6;
        }
        if(sol[i]=='D' && (i == length-1 || sol[i+1]== ' ')) {   //case D
            moves[cur++] = 6;
            moves[cur++] = 7;
            moves[cur++] = -6;
            moves[cur++] = 5;
            moves[cur++] = 6;
            moves[cur++] = -5;
            moves[cur++] = -7;
            moves[cur++] = -6;
        }
        if(i<length-1 && sol[i]=='D' && sol[i+1]== '\'') {   //case D'
            moves[cur++] = 6;
            moves[cur++] = 7;
            moves[cur++] = -6;
            moves[cur++] = -5;
            moves[cur++] = 6;
            moves[cur++] = 5;
            moves[cur++] = -7;
            moves[cur++] = -6;
        }
        if(sol[i]=='B' && (i == length-1 || sol[i+1]== ' ')) {   //case B
            moves[cur++] = 6;
            moves[cur++] = 7;
            moves[cur++] = 7;
            moves[cur++] = -6;
            moves[cur++] = -5;
            moves[cur++] = 6;
            moves[cur++] = 5;
            moves[cur++] = -7;
            moves[cur++] = -7;
            moves[cur++] = -6;
        }
        if(i<length-1 && sol[i]=='B' && sol[i+1]== '\'') {   //case B'
            moves[cur++] = 6;
            moves[cur++] = 7;
            moves[cur++] = 7;
            moves[cur++] = -6;
            moves[cur++] = 5;
            moves[cur++] = 6;
            moves[cur++] = -5;
            moves[cur++] = -7;
            moves[cur++] = -7;
            moves[cur++] = -6;
        }
    }
    int* simplifiedMoves = simplify(moves, 10*length);
    free(moves);
    return simplifiedMoves;
}

//Simplify with 2 levels of recursivity, which is enough for our problem
//parameter length is length of moves, which is 10*(length of sol)
int* simplify(int* moves, int length) {
    int* simplifiedMoves1 = simplifyOnce(moves, length);
    int* simplifiedMoves2 = simplifyOnce(simplifiedMoves1, length);
    free(simplifiedMoves1);
    return simplifiedMoves2;
}

int* simplifyOnce(int* moves, int length) {
    int* simplifiedMoves = (int*)calloc(length, sizeof(int));
    int cur = 0;
    for(int i = 0; i<length-1; i++) {
        if (moves[i] + moves[i+1] != 0) {  //not two consecutive opposite moves
        	simplifiedMoves[cur++] = moves[i];
        }
        else {
        	i++;
        }
    }
    return simplifiedMoves;
}
