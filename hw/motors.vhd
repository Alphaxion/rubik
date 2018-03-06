library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity motors is
	port(
		clk_50:   in  std_logic;
		enable:   in  std_logic;
		cmd:      in  signed(3 downto 0);
		done:     out std_logic;
		stp_step: out std_logic_vector(2 downto 0);
		stp_dir:  out std_logic_vector(2 downto 0);
		srv_cmd:  out std_logic_vector(2 downto 0)
	);
end motors;

architecture behavioral of motors is
	signal stp_tick:  std_logic;
	signal stp_done:  std_logic;
	signal stp_q:     unsigned(7 downto 0);
	signal srv_tick:  std_logic;
	signal srv_done:  std_logic;
	signal srv_q:     unsigned(15 downto 0);
begin
	done <= stp_done and srv_done;

	u_stp_tick: entity work.compteur_mod
		generic map( n => 50 )--50000
		port map(
			clk  => clk_50,
			tick => stp_tick--1000us
		);
	u_stp_creneau: entity work.compteur_sat
		generic map( size => 8 )
		port map(
			clk   => clk_50,
			en    => stp_tick,
			reset => "not"(enable),
			n     => to_unsigned(100, 8),
			q     => stp_q,
			done  => stp_done
		);
	stp_dir(2) <= '1' when cmd=-1 or cmd=-7 else '0';--moteur gauche
	stp_dir(1) <= '1' when cmd=-3 or cmd=-7 else '0';--moteur droite
	stp_dir(0) <= '1' when cmd=-5 else '0';          --moteur centre
	stp_step(2) <= stp_q(0) when cmd=1 or cmd=-1 or cmd=7 or cmd=-7 else '0';
	stp_step(1) <= stp_q(0) when cmd=3 or cmd=-3 or cmd=7 or cmd=-7 else '0';
	stp_step(0) <= stp_q(0) when cmd=5 or cmd=-5 else '0';

	u_srv_tick: entity work.compteur_mod
		generic map( n => 5 )--5000
		port map(
			clk  => clk_50,
			tick => srv_tick--100us
		);
	u_srv_creneau: entity work.compteur_sat
		generic map( size => 16 )
		port map(
			clk   => clk_50,
			en    => srv_tick,
			reset => "not"(enable),
			n     => to_unsigned(1000, 16),
			q     => srv_q,
			done  => srv_done
		);
	srv_cmd(2) <= '1' when (0<srv_q and srv_q<16 and cmd=2) or (0<srv_q and srv_q<11 and cmd=-2) else '0';--pince gauche
	srv_cmd(1) <= '1' when (0<srv_q and srv_q<16 and cmd=4) or (0<srv_q and srv_q<11 and cmd=-4) else '0';--pince droite
	srv_cmd(0) <= '1' when (0<srv_q and srv_q<16 and cmd=6) or (0<srv_q and srv_q<11 and cmd=-6) else '0';--pince centre
end behavioral;
