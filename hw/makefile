all:
	ghdl -a compteur_mod.vhd compteur_sat.vhd verrou.vhd steppers.vhd servos.vhd motors.vhd motors_test.vhd
	ghdl -e motors_test
	ghdl -r motors_test --fst=fst --ieee-asserts=disable-at-0 --stop-time=300ms

show:
	gtkwave fst

clean:
	rm -f work-obj93.cf *.o motors_test fst fst.hier
