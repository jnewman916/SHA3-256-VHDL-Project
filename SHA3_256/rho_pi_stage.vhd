library ieee;
use ieee.std_logic_1164.all;

entity rho_pi_stage is
port(
	in0 : in std_logic_vector(63 downto 0);
	in1 : in std_logic_vector(63 downto 0);
	in2 : in std_logic_vector(63 downto 0);
	in3 : in std_logic_vector(63 downto 0);
	out0 : out std_logic_vector(63 downto 0);
	out1 : out std_logic_vector(63 downto 0);
	out2 : out std_logic_vector(63 downto 0);
	out3 : out std_logic_vector(63 downto 0)
	);
end rho_pi_stage;

architecture imp of rho_pi_stage is 

begin
	
	out0(63 downto 0) <= in0(62 downto 0) & in0(63);
	out1(63 downto 0) <= in1(61 downto 0) & in1(63 downto 62);
	out2(63 downto 0) <= in2(60 downto 0) & in2(63 downto 61);
	out3(63 downto 0) <= in3(59 downto 0) & in3(63 downto 60);

end imp;