library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity servos is
	port(
		clk_50:   in  std_logic;
		enable:   in  std_logic;
		cmd:      in  signed(3 downto 0);
		done:     out std_logic;
		pwm:      out std_logic_vector(2 downto 0)
	);
end servos;

architecture behavioral of servos is
	signal tick:  std_logic;
	signal q:     unsigned(23 downto 0);
begin
	u_tick: entity work.compteur_mod
		generic map( n => 5 )--5000
		port map(
			clk  => clk_50,
			tick => tick--100us
		);
	u_pwm: entity work.compteur_mod
		generic map( n => 1000 )
		port map(
			clk   => tick,
			q     => q
		);
	pwm(2) <= '1' when (0<q and q<16 and cmd=2) or (0<q and q<11 and cmd=-2) else '0';--pince gauche
	pwm(1) <= '1' when (0<q and q<16 and cmd=4) or (0<q and q<11 and cmd=-4) else '0';--pince droite
	pwm(0) <= '1' when (0<q and q<16 and cmd=6) or (0<q and q<11 and cmd=-6) else '0';--pince centre
end behavioral;
