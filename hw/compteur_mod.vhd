library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity compteur_mod is
	generic(
		n:    integer := 10;--10000000;
		size: integer := 24
	);
	port(
		clk:  in  std_logic;
		tick: out std_logic;
		q:    out unsigned(size-1 downto 0)
	);
end compteur_mod;

architecture behavioral of compteur_mod is
	signal cnt: unsigned(size-1 downto 0) := (others => '0');
begin
	process(clk)
	begin
		if rising_edge(clk)
		then
			if(cnt=n-1)
			then
				cnt <= (others=>'0');
			else
				cnt <= cnt+1;
			end if;
		end if;
	end process;
	q <= cnt;
	tick <= '1' when cnt=n-1 else '0';
end behavioral;
