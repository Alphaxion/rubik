/// @file main.c

#include "stdio.h"
#include "string.h"

#include "solve.h"
#include "conversion.h"
#include "stepper.h"

int main() {
	printf("start\n");
	char fac[1024];
	fgets(fac, sizeof(fac), stdin);
	fac[strlen(fac)-1] = '\0';
	char* sol = solve(fac);
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
		moveStepper(moves[i]);
	}
	free(sol);
	free(moves);
	printf("end\n");
	return 0;
}
