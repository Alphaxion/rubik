library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity compteur_sat is
	generic(
		size: integer := 8
	);
	port(
		en:    in  std_logic;
		reset: in  std_logic;
		clk:   in  std_logic;
		n:     in  unsigned(size-1 downto 0);
		q:     out unsigned(size-1 downto 0);
		done:  out std_logic
	);
end compteur_sat;

architecture behavioral of compteur_sat is
	signal cnt: unsigned(size-1 downto 0):=(others => '0');
begin
	process(clk)
	begin
		if rising_edge(clk)
		then
			if (reset='1')
			then
				cnt <= (others=>'0');
			elsif (en='1' and cnt/=n)
			then
				cnt <= cnt+1;
			end if;
		end if;
	end process;
	q <= cnt;
	done <= '1' when cnt=n else '0';
end behavioral;
