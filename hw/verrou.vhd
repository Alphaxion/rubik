library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity verrou is
	port(
		clk:           in std_logic;
		input:         in std_logic;
		input_update:  in std_logic;
		output:        out std_logic;
		output_update: in std_logic
	);
end verrou;

architecture behavioral of verrou is
	signal mem:    std_logic := '0';
	signal sortie: std_logic := '0';
begin
	process(clk)
	begin
		if rising_edge(clk)
		then
			if input_update='1'
			then
				mem <= input;
			end if;
			if output_update='1'
			then
				sortie <= mem;
			end if;
		end if;
	end process;
	output <= sortie;
end behavioral;
