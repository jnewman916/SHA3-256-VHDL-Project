library ieee;
use ieee.std_logic_1164.all;

entity SHA3_256_tb is 

end entity;

architecture imp of SHA3_256_tb is

	signal rst : std_logic := '1';
	signal clk : std_logic := '0';
	signal round_const: std_logic_vector(63 downto 0);
	signal in0 : std_logic_vector(63 downto 0);
	signal in1 : std_logic_vector(63 downto 0);
	signal in2 : std_logic_vector(63 downto 0);
	signal in3 : std_logic_vector(63 downto 0);
	signal out0 : std_logic_vector(63 downto 0);
	signal out1 : std_logic_vector(63 downto 0);
	signal out2 : std_logic_vector(63 downto 0);
	signal out3 : std_logic_vector(63 downto 0);
	
begin
clk <= not clk after 5 ns;

process begin 
	
	in0 <= "1010101010101010101010101010101010101010101010101010101010101010";
	in1 <= "1100110011001100110011001100110011001100110011001100110011001100";
	in2 <= "1111000011110000111100001111000011110000111100001111000011110000";
	in3 <= "1111111100000000111111110000000011111111000000001111111100000000";
	round_const <= "0000000000000000000000000000000000000000000000000000000000000000";
	
	wait for 1 ns;
	rst <= '0';
	
	wait for 10 ns;
	
	wait for 10 ns;
	
	wait for 10 ns;
	
	wait for 100 ns;
	
end process;

	DUT:entity work.SHA3_256 port map(
	rst => rst,
	clk => clk,
	round_const(63 downto 0) => round_const(63 downto 0),
	in0(63 downto 0) => in0(63 downto 0),
	in1(63 downto 0) => in1(63 downto 0),
	in2(63 downto 0) => in2(63 downto 0),
	in3(63 downto 0) => in3(63 downto 0),
	out0(63 downto 0) => out0(63 downto 0),
	out1(63 downto 0) => out1(63 downto 0),
	out2(63 downto 0) => out2(63 downto 0),
	out3(63 downto 0) => out3(63 downto 0)
);

end;