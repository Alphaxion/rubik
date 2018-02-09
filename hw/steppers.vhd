library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity steppers is
	port(
		clk: in std_logic;
		step: out std_logic_vector(5 downto 0);
		dir: out std_logic_vector(5 downto 0);
		reset: in std_logic;
		done: out std_logic;
		cmd: in signed(3 downto 0)
	);
end steppers;

architecture behavioral of steppers is
	signal tick: std_logic;
	signal creneau: std_logic;
	signal q: unsigned(7 downto 0);
	signal n: unsigned(7 downto 0);
begin
	u_tick: entity work.compteur_mod
		port map(
			clk=>clk,
			tick=>tick
		);
	u_creneau: entity work.compteur_sat
		port map(
			clk=>clk,
			en=>tick,
			reset=>reset,
			n=>n,
			q=>q
		);
	dir(5) <= '1' when cmd=-1 or cmd=-7 else '0';--moteur gauche
	dir(4) <= '1' when cmd=-2 else '0';          --pince gauche
	dir(3) <= '1' when cmd=-3 or cmd=-7 else '0';--moteur droite
	dir(2) <= '1' when cmd=-4 else '0';          --pince droite
	dir(1) <= '1' when cmd=-5 else '0';          --moteur centre
	dir(0) <= '1' when cmd=-6 else '0';          --pince centre
	step(5) <= creneau when cmd=1 or cmd=-1 or cmd=7 or cmd=-7 else '0';
	step(4) <= creneau when cmd=2 or cmd=-2 else '0';
	step(3) <= creneau when cmd=3 or cmd=-3 or cmd=7 or cmd=-7 else '0';
	step(2) <= creneau when cmd=4 or cmd=-4 else '0';
	step(1) <= creneau when cmd=5 or cmd=-5 else '0';
	step(0) <= creneau when cmd=6 or cmd=-6 else '0';
	n <= to_unsigned(100, n'length) when cmd(0)='0' else to_unsigned(60, n'length);
	creneau <= q(0);
	done <= '1' when q=n else '0';
end behavioral;
