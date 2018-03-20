library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity verrou is
	port(
		clk:      in std_logic;
		cmd:      in signed(3 downto 0);
		enable:   in std_logic;
		position: out std_logic_vector(2 downto 0);
		q:        in unsigned(23 downto 0)
	);
end verrou;

architecture behavioral of verrou is
	signal memin:  std_logic_vector(2 downto 0) := (others => '0');
	signal memout: std_logic_vector(2 downto 0) := (others => '0');
begin
	process(clk)
	begin
		if rising_edge(clk)
		then
			if enable='1'
			then
				if cmd=2
				then
					memin(2) <= '1';
				elsif cmd=-2
				then
					memin(2) <= '0';
				elsif cmd=4
				then
					memin(1) <= '1';
				elsif cmd=-4
				then
					memin(1) <= '0';
				elsif cmd=6
				then
					memin(0) <= '1';
				elsif cmd=-6
				then
					memin(0) <= '0';
				end if;
			end if;
			if q=0
			then
				memout <= memin;
			end if;
		end if;
	end process;
	position <= memout;
end behavioral;
