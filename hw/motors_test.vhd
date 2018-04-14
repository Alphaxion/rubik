library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity motors_test is
end motors_test;

architecture behavioral of motors_test is
	signal clk_50:      std_logic          := '0';
	signal enable:      std_logic          := '0';
	signal cmd:         signed(3 downto 0) := (others => '0');
	signal done:        std_logic;
	signal stp_step:    std_logic_vector(2 downto 0);
	signal stp_dir:     std_logic_vector(2 downto 0);
	signal stp_notenbl: std_logic_vector(2 downto 0);
	signal srv_pwm:     std_logic_vector(2 downto 0);
begin
	u_motors: entity work.motors
		port map(
			clk_50      => clk_50,
			enable      => enable,
			cmd         => cmd,
			done        => done,
			stp_step    => stp_step,
			stp_dir     => stp_dir,
			stp_notenbl => stp_notenbl,
			srv_pwm     => srv_pwm
		);
	process
	begin
		clk_50 <= '0';
		wait for 10 ns;
		clk_50 <= '1';
		wait for 10 ns;
	end process;
	process
	begin
		wait for 100 ns;
		enable <= '0';
		cmd <= to_signed(-6, cmd'length);
		wait for 100 ns;
		enable <= '1';
		wait until done='1';
		wait for 100 ns;
		enable <= '0';
		cmd <= to_signed(7, cmd'length);
		wait for 100 ns;
		enable <= '1';
		wait until done='1';
		wait for 100 ns;
		enable <= '0';
		cmd <= to_signed(-3, cmd'length);
		wait for 100 ns;
		enable <= '1';
		wait until done='1';
		wait for 100 ns;
		enable <= '0';
		cmd <= to_signed(2, cmd'length);
		wait for 100 ns;
		enable <= '1';
		wait until done='1';
		wait;
	end process;
end behavioral;
