library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_steppers is
end test_steppers;

architecture behavioral of test_steppers is
	signal clk: std_logic := '0';
	signal step: std_logic_vector(5 downto 0);
	signal dir: std_logic_vector(5 downto 0);
	signal reset: std_logic := '1';
	signal done: std_logic;
	signal cmd: signed(3 downto 0) := (others => '0');
begin
	u_steppers: entity work.steppers
		port map(
			clk=>clk,
			step=>step,
			dir=>dir,
			reset=>reset,
			done=>done,
			cmd=>cmd
		);
	process
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	end process;
	process
	begin
		wait for 1000 ns;
		cmd <= to_signed(-6, cmd'length);
		reset <= '1';
		wait for 1000 ns;
		reset <= '0';
		wait until done='1';
		wait for 1000 ns;
		cmd <= to_signed(7, cmd'length);
		reset <= '1';
		wait for 1000 ns;
		reset <= '0';
		wait until done='1';
		wait;
	end process;
end behavioral;
