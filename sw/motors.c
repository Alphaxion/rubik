/// @file motors.c

#include "stdio.h"

#include "motors.h"

#ifdef SIMULATION

void move_motor(int cmd) {
  printf("motor %d\n", cmd);
}

#else

void move_motor(int cmd) {
  printf("motor %d\n", cmd);
  set_cmd(cmd);
  set_enable(1);
  while(get_done()==0);
  set_enable(0);
}

#endif

void set_enable(int enable) {
  volatile int* v_enable = (int*)PIO_ENABLE_BASE;
  *v_enable = enable & 0b1;
}

int get_done() {
  volatile int* v_done = (int*)PIO_DONE_BASE;
  return *v_done & 0b1;
}

void set_cmd(int cmd) {
  volatile int* v_cmd = (int*)PIO_CMD_BASE;
  *v_cmd = cmd & 0b1111;
}
