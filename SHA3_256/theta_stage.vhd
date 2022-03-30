library ieee;
use ieee.std_logic_1164.all;

entity theta_stage is
port(
	rst, clk : in std_logic;
	in0 : in std_logic_vector(63 downto 0);
	in1 : in std_logic_vector(63 downto 0);
	in2 : in std_logic_vector(63 downto 0);
	in3 : in std_logic_vector(63 downto 0);
	out0 : out std_logic_vector(63 downto 0);
	out1 : out std_logic_vector(63 downto 0);
	out2 : out std_logic_vector(63 downto 0);
	out3 : out std_logic_vector(63 downto 0)
	);
end theta_stage;

architecture imp of theta_stage is
	component flipflop64
		port(
			clk, rst : in std_logic;
			d : in std_logic_vector(63 downto 0);
			q : out std_logic_vector(63 downto 0));
	end component;
	
	signal cin0,cin1,cin2,cin3 : std_logic_vector(63 downto 0);
	signal cout0,cout1,cout2,cout3 : std_logic_vector(63 downto 0);
	signal shft0,shft1,shft2,shft3 : std_logic_vector(63 downto 0);
	signal din0,din1,din2,din3 : std_logic_vector(63 downto 0);
	signal dout0,dout1,dout2,dout3 : std_logic_vector(63 downto 0);
	signal s10,s11,s12,s13 : std_logic_vector(63 downto 0);
	signal s20,s21,s22,s23 : std_logic_vector(63 downto 0);
	signal tin0,tin1,tin2,tin3 : std_logic_vector(63 downto 0);

begin
	cin0(63 downto 0) <= in0(63 downto 0) xor in1(63 downto 0);
	cin1(63 downto 0) <= in1(63 downto 0) xor in2(63 downto 0);
	cin2(63 downto 0) <= in2(63 downto 0) xor in3(63 downto 0);
	cin3(63 downto 0) <= in3(63 downto 0) xor in0(63 downto 0);
	
	shft0(63 downto 0) <= cout0(62 downto 0) & cout0(63);
	shft1(63 downto 0) <= cout1(62 downto 0) & cout1(63);
	shft2(63 downto 0) <= cout2(62 downto 0) & cout2(63);
	shft3(63 downto 0) <= cout3(62 downto 0) & cout3(63);
	
	din0(63 downto 0) <= cout3(63 downto 0) xor shft1(63 downto 0);
	din1(63 downto 0) <= cout0(63 downto 0) xor shft2(63 downto 0);
	din2(63 downto 0) <= cout1(63 downto 0) xor shft3(63 downto 0);
	din3(63 downto 0) <= cout2(63 downto 0) xor shft0(63 downto 0);
	
	tin0(63 downto 0) <= dout0(63 downto 0) xor s20(63 downto 0);
	tin1(63 downto 0) <= dout1(63 downto 0) xor s21(63 downto 0);
	tin2(63 downto 0) <= dout2(63 downto 0) xor s22(63 downto 0);
	tin3(63 downto 0) <= dout3(63 downto 0) xor s23(63 downto 0);
	
	creg0:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => cin0(63 downto 0),
		q(63 downto 0) => cout0(63 downto 0)
	);
	
	creg1:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => cin1(63 downto 0),
		q(63 downto 0) => cout1(63 downto 0)
	);
	
	creg2:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => cin2(63 downto 0),
		q(63 downto 0) => cout2(63 downto 0)
	);
	
	creg3:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => cin3(63 downto 0),
		q(63 downto 0) => cout3(63 downto 0)
	);
	
	dreg0:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => din0(63 downto 0),
		q(63 downto 0) => dout0(63 downto 0)
	);
	
	dreg1:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => din1(63 downto 0),
		q(63 downto 0) => dout1(63 downto 0)
	);
	
	dreg2:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => din2(63 downto 0),
		q(63 downto 0) => dout2(63 downto 0)
	);
	
	dreg3:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => din3(63 downto 0),
		q(63 downto 0) => dout3(63 downto 0)
	);
	
	treg0:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => tin0(63 downto 0),
		q(63 downto 0) => out0(63 downto 0)
	);
	
	treg1:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => tin1(63 downto 0),
		q(63 downto 0) => out1(63 downto 0)
	);
	
	treg2:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => tin2(63 downto 0),
		q(63 downto 0) => out2(63 downto 0)
	);
	
	treg3:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => tin3(63 downto 0),
		q(63 downto 0) => out3(63 downto 0)
	);
	
	s1reg0:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => in0(63 downto 0),
		q(63 downto 0) => s10(63 downto 0)
	);
	
	s1reg1:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => in1(63 downto 0),
		q(63 downto 0) => s11(63 downto 0)
	);
	
	s1reg2:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => in2(63 downto 0),
		q(63 downto 0) => s12(63 downto 0)
	);
	
	s1reg3:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => in3(63 downto 0),
		q(63 downto 0) => s13(63 downto 0)
	);
	
	s2reg0:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => s10(63 downto 0),
		q(63 downto 0) => s20(63 downto 0)
	);
	
	s2reg1:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => s11(63 downto 0),
		q(63 downto 0) => s21(63 downto 0)
	);
	
	s2reg2:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => s12(63 downto 0),
		q(63 downto 0) => s22(63 downto 0)
	);
	
	s2reg3:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => s13(63 downto 0),
		q(63 downto 0) => s23(63 downto 0)
	);

end imp;