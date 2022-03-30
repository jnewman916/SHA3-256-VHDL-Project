library ieee;
use ieee.std_logic_1164.all;

entity flipflop64 is
port(
	clk, rst : in std_logic;
	d : in std_logic_vector(63 downto 0);
	q : out std_logic_vector(63 downto 0));
end flipflop64;

architecture imp of flipflop64 is
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				q(63 downto 0) <= "0000000000000000000000000000000000000000000000000000000000000000";
			else
				q(63 downto 0) <= d(63 downto 0);
			end if;
		end if;
	end process;
end imp;