/// @file main.c

#include "stdio.h"
#include "string.h"

#include "solve.h"
#include "conversion.h"
#include "motors.h"
//pour initpruning au démarrage
#include "coordcube.h"

#define BUFSIZE 256

void input(char* s, int lenght);
void command_solve(int debug);
void command_move();

int main() {
    printf("start\n");
    while(1) {
        printf("commande ?\n");
        char command[BUFSIZE];
        input(command, BUFSIZE);
        if     (strcmp(command, "solve")==0) {
            command_solve(0);
        }
        else if(strcmp(command, "debug")==0) {
            command_solve(1);
        }
        else if(strcmp(command, "move")==0) {
            command_move();
        }
        else if(strcmp(command, "init")==0) {
            initPruning("cache");
        }
        else if(strcmp(command, "test")==0) {
            printf("test\n");
        }
        else if(strcmp(command, "quit")==0) {
            break;
        }
        else {
            printf("unknown command\n");
        }
    }
    printf("end\n");
    return 0;
}

void input(char* s, int lenght) {
    fgets(s, lenght, stdin);
    s[strlen(s)-1] = '\0';
    int c;
    while((c = getchar()) != '\n' && c != EOF);
}

void command_solve(int debug) {
    char cube_state[BUFSIZE];
    printf("état du cube ?\n");
    input(cube_state, BUFSIZE);
    if(strcmp(cube_state, "auto")==0) {
        //détection par caméra
    }
    char* sol = solve(cube_state);
    if(!sol) {
        printf("cube insoluble\n");
        return;
    }
    printf("%s\n", sol);
    int* moves = conversion(sol, strlen(sol));
    for (int i = 0; i<sizeof(moves); i++) {
        if(moves[i]==0) {
            break;
        }
        if(debug) {
            //faire pas-à-pas
        }
        move_motor(moves[i]);
    }
    free(sol);
    free(moves);
}

void command_move() {
    char cmd_str[BUFSIZE];
    printf("mouvement ?\n");
    input(cmd_str, BUFSIZE);
    int cmd;
    sscanf(cmd_str, "%d", &cmd);
    move_motor(cmd);
}
