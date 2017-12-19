all:
	ghdl -a compteur_mod.vhd compteur_sat.vhd steppers.vhd test_steppers.vhd
	ghdl -e test_steppers
	ghdl -r test_steppers --fst=fst --stop-time=100us
	gtkwave fst

clean:
	rm -f work-obj93.cf *.o test_steppers fst
