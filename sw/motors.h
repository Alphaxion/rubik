/// @file motors.h

#ifndef MOTORS_H
#define MOTORS_H

#define PIO_CMD_BASE    0xFF200000
#define PIO_DONE_BASE   0xFF200010
#define PIO_ENABLE_BASE 0XFF200020

void move_motor(int cmd);
void set_enable(int enable);
int get_done();
void set_cmd(int cmd);

#endif
