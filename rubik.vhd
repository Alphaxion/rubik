library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rubik is
	port(
		clk: in std_logic;
		cpu_reset: in std_logic;
		steppers_step: out std_logic_vector(5 downto 0);
		steppers_dir: out std_logic_vector(5 downto 0)
	);
end rubik;

architecture behavioral of rubik is
	component nios_system is
		port(
			clk_clk: in std_logic;
			pio_0_export: out std_logic_vector(4 downto 0);
			pio_1_export: in std_logic;
			reset_reset_n: in std_logic
		);
	end component nios_system;
	signal steppers_cmd: signed(3 downto 0) := (others=>'0');
	signal steppers_reset: std_logic := '0';
	signal steppers_done: std_logic := '1';
begin
	u_nios: component nios_system
		port map(
			clk_clk=>clk,
			pio_1_export=>steppers_done,
			signed(pio_0_export(3 downto 0))=>steppers_cmd,
			pio_0_export(4)=>steppers_reset,
			reset_reset_n=>cpu_reset
		);
	u_steppers: entity work.steppers
		port map(
			clk=>clk,
			step=>steppers_step,
			dir=>steppers_dir,
			reset=>steppers_reset,
			done=>steppers_done,
			cmd=>steppers_cmd
		);
end behavioral;
