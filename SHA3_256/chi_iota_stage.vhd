library ieee;
use ieee.std_logic_1164.all;

entity chi_iota_stage is
port(
	round_const: in std_logic_vector(63 downto 0);
	in0 : in std_logic_vector(63 downto 0);
	in1 : in std_logic_vector(63 downto 0);
	in2 : in std_logic_vector(63 downto 0);
	in3 : in std_logic_vector(63 downto 0);
	out0 : out std_logic_vector(63 downto 0);
	out1 : out std_logic_vector(63 downto 0);
	out2 : out std_logic_vector(63 downto 0);
	out3 : out std_logic_vector(63 downto 0)
	);
end chi_iota_stage;


architecture imp of chi_iota_stage is

	signal c0,c1,c2,c3: std_logic_vector(63 downto 0);

begin
	
	c0 <= in1(62 downto 0) & in1(63);
	c1 <= in2(62 downto 0) & in2(63);
	c2 <= in3(62 downto 0) & in3(63);
	c3 <= in0(62 downto 0) & in0(63);
	
	out0(63 downto 0) <= c0(63 downto 0) xor round_const xor (not c1(63 downto 0) and c2(63 downto 0));
	out1(63 downto 0) <= c1(63 downto 0) xor round_const xor (not c2(63 downto 0) and c3(63 downto 0));
	out2(63 downto 0) <= c2(63 downto 0) xor round_const xor (not c3(63 downto 0) and c0(63 downto 0));
	out3(63 downto 0) <= c3(63 downto 0) xor round_const xor (not c0(63 downto 0) and c1(63 downto 0));
	
end imp;