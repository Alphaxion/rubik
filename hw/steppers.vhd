library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity steppers is
	port(
		clk_50:   in  std_logic;
		enable:   in  std_logic;
		cmd:      in  signed(3 downto 0);
		done:     out std_logic;
		step:     out std_logic_vector(2 downto 0);
		dir:      out std_logic_vector(2 downto 0)
	);
end steppers;

architecture behavioral of steppers is
	signal tick:  std_logic;
	signal q:     unsigned(7 downto 0);
begin
	u_tick: entity work.compteur_mod
		generic map( n => 50000 )--50000
		port map(
			clk  => clk_50,
			tick => tick--1000us
		);
	u_creneau: entity work.compteur_sat
		generic map( size => 8 )
		port map(
			clk   => clk_50,
			en    => tick,
			reset => "not"(enable),
			n     => to_unsigned(100, 8),
			q     => q,
			done  => done
		);
	dir(2) <= '1' when cmd=-1 or cmd=-7 else '0';--moteur gauche
	dir(1) <= '1' when cmd=-3 or cmd=-7 else '0';--moteur droite
	dir(0) <= '1' when cmd=-5 else '0';          --moteur centre
	step(2) <= q(0) when cmd=1 or cmd=-1 or cmd=7 or cmd=-7 else '0';
	step(1) <= q(0) when cmd=3 or cmd=-3 or cmd=7 or cmd=-7 else '0';
	step(0) <= q(0) when cmd=5 or cmd=-5 else '0';
end behavioral;
