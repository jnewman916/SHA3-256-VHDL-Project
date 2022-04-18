library ieee;
use ieee.std_logic_1164.all;

entity flipflop is
port(
	clk, rst, d : in std_logic;
	q : out std_logic);
end flipflop;

architecture imp of flipflop is
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				q <= '0';
			else
				q <= d;
			end if;
		end if;
	end process;
end imp;
