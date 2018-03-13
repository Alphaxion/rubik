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
	signal tick:     std_logic;
	signal q:        unsigned(23 downto 0);
	signal position: std_logic_vector(2 downto 0);
begin
	u_tick: entity work.compteur_mod
		generic map( n => 5000 )--5000
		port map(
			clk  => clk_50,
			tick => tick--100us
		);
	u_pwm: entity work.compteur_mod
		generic map( n => 200 )
		port map(
			clk   => tick,
			q     => q
		);
	u_wait: entity work.compteur_sat
		generic map( size => 24 )
		port map(
			en    => tick,
			reset => "not"(enable),
			clk   => clk_50,
			n     => to_unsigned(2500, 24),
			done  => done
		);
	u_verrou: entity work.verrou
		port map(
			clk      => clk_50,
			cmd      => cmd,
			enable   => enable,
			position => position,
			q        => q
		);
	pwm(2) <= '1' when (0<q and q<16 and position(2)='1') or (0<q and q<11 and position(2)='0') else '0';--pince gauche
	pwm(1) <= '1' when (0<q and q<16 and position(1)='1') or (0<q and q<11 and position(1)='0') else '0';--pince droite
	pwm(0) <= '1' when (0<q and q<16 and position(0)='1') or (0<q and q<11 and position(0)='0') else '0';--pince centre
end behavioral;
