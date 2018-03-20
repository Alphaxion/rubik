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
		srv_pwm:  out std_logic_vector(2 downto 0)
	);
end motors;

architecture behavioral of motors is
	signal stp_done: std_logic;
	signal srv_done: std_logic;
begin
	u_steppers: entity work.steppers
		port map(
			clk_50 => clk_50,
			enable => enable,
			cmd    => cmd,
			done   => stp_done,
			step   => stp_step,
			dir    => stp_dir
		);
	u_servos: entity work.servos
		port map(
			clk_50 => clk_50,
			enable => enable,
			cmd    => cmd,
			done   => srv_done,
			pwm    => srv_pwm
		);
	done <= stp_done and srv_done;
end behavioral;
