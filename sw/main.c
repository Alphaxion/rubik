/// @file main.c

#include "stdio.h"
#include "string.h"

#include "solve.h"
#include "conversion.h"
#include "motors.h"
//pour initpruning au démarrage
#include "coordcube.h"

void input(char* s);
void command_solve();
void command_move();

int main() {
	printf("start\n");
	while(1) {
		printf("commande ?\n");
		char command[256];
		input(command);
		if(strcmp(command, "solve")==0) {
			command_solve();
		}
		else if(strcmp(command, "move")==0) {
			command_move();
		}
		else if(strcmp(command, "init")==0) {
			initPruning("cache");
		}
		else if(strcmp(command, "test")==0) {
			printf("test\n")
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

void input(char* s) {
	fgets(s, sizeof(s), stdin);
	s[strlen(s)-1] = '\0';
}

void command_solve() {
	char cube_state[256];
	printf("état du cube ?\n");
	input(cube_state);
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
		move_motor(moves[i]);
	}
	free(sol);
	free(moves);
}

void command_move() {
	char cmd_str[256];
	printf("mouvement ?\n");
	input(cmd_str);
	int cmd;
	sscanf(cmd_str, "%d", &cmd);
	move_motor(cmd);
}
