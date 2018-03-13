/// @file main.c

#include "stdio.h"
#include "string.h"

#include "solve.h"
#include "conversion.h"
#include "motors.h"
//pour initpruning au démarrage
#include "coordcube.h"

void commande_solve(char* s);

int main() {
	printf("start\n");
	//initPruning("cache");
	while(1) {
		printf("ready\n");
		char fac[1024];
		fgets(fac, sizeof(fac), stdin);
		fac[strlen(fac)-1] = '\0';
		char command[256];
		char option[256];
		sscanf(fac, "%s %s", command, option);
		switch() {
			case "solve":
				command_solve(option);
				break;
			case "move":
				break;
			default:
				printf("unknown command\n");
				break;
		}
	}
	printf("end\n");
	return 0;
}

void commande_solve(char* s) {
	char* sol = solve(s);
	if(!sol) {
		printf("cube insoluble\n");
		return -1;
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
