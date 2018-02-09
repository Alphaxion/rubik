library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_unsigned.all;

entity compteur_mod is
	generic(
		n: integer := 10;--10000000;
		size: integer := 24
	);
	port(
		clk: in std_logic;
		tick: out std_logic
	);
end compteur_mod;

architecture behavioral of compteur_mod is
	signal q: unsigned(size-1 downto 0) := (others => '0');
begin
	process(clk)
	begin
		if rising_edge(clk)
		then
			if(q=n-1)
			then
				q <= (others=>'0');
			else
				q <= q+1;
			end if;
		end if;
	end process;
	tick <= '1' when q=n-1 else '0';
end behavioral;
