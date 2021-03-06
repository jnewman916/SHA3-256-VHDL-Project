library ieee;
use ieee.std_logic_1164.all;

entity SHA3_256 is
port(
	rst, clk : in std_logic;
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
end SHA3_256;

architecture imp of SHA3_256 is
	component flipflop64
		port(
			clk, rst : in std_logic;
			d : in std_logic_vector(63 downto 0);
			q : out std_logic_vector(63 downto 0));
	end component;
	
	component theta_stage
		port(
			rst, clk : in std_logic;
			in0 : in std_logic_vector(63 downto 0);
			in1 : in std_logic_vector(63 downto 0);
			in2 : in std_logic_vector(63 downto 0);
			in3 : in std_logic_vector(63 downto 0);
			out0 : out std_logic_vector(63 downto 0);
			out1 : out std_logic_vector(63 downto 0);
			out2 : out std_logic_vector(63 downto 0);
			out3 : out std_logic_vector(63 downto 0));
	end component;
	
	component rho_pi_stage
		port(
			in0 : in std_logic_vector(63 downto 0);
			in1 : in std_logic_vector(63 downto 0);
			in2 : in std_logic_vector(63 downto 0);
			in3 : in std_logic_vector(63 downto 0);
			out0 : out std_logic_vector(63 downto 0);
			out1 : out std_logic_vector(63 downto 0);
			out2 : out std_logic_vector(63 downto 0);
			out3 : out std_logic_vector(63 downto 0));
	end component;
	
	component chi_iota_stage
		port(
			round_const: in std_logic_vector(63 downto 0);
			in0 : in std_logic_vector(63 downto 0);
			in1 : in std_logic_vector(63 downto 0);
			in2 : in std_logic_vector(63 downto 0);
			in3 : in std_logic_vector(63 downto 0);
			out0 : out std_logic_vector(63 downto 0);
			out1 : out std_logic_vector(63 downto 0);
			out2 : out std_logic_vector(63 downto 0);
			out3 : out std_logic_vector(63 downto 0));
		end component;
		
		signal t0,t1,t2,t3 : std_logic_vector(63 downto 0);
		signal rp0,rp1,rp2,rp3 : std_logic_vector(63 downto 0);
		signal xi0,xi1,xi2,xi3 : std_logic_vector(63 downto 0);
		
begin

	reg0:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => in0(63 downto 0),
		q(63 downto 0) => t0(63 downto 0)
	);
	
	reg1:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => in1(63 downto 0),
		q(63 downto 0) => t1(63 downto 0)
	);
	
	reg2:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => in2(63 downto 0),
		q(63 downto 0) => t2(63 downto 0)
	);
	
	reg3:flipflop64
	port map(
		clk => clk,
		rst => rst,
		d(63 downto 0) => in3(63 downto 0),
		q(63 downto 0) => t3(63 downto 0)
	);
	
	theta:theta_stage
	port map(
		rst => rst,
		clk => clk,
		in0(63 downto 0) => t0(63 downto 0),
		in1(63 downto 0) => t1(63 downto 0),
		in2(63 downto 0) => t2(63 downto 0),
		in3(63 downto 0) => t3(63 downto 0),
		out0(63 downto 0) => rp0(63 downto 0),
		out1(63 downto 0) => rp1(63 downto 0),
		out2(63 downto 0) => rp2(63 downto 0),
		out3(63 downto 0) => rp3(63 downto 0)
	);
	
	rho_pi:rho_pi_stage
	port map(
		in0(63 downto 0) => rp0(63 downto 0),
		in1(63 downto 0) => rp1(63 downto 0),
		in2(63 downto 0) => rp2(63 downto 0),
		in3(63 downto 0) => rp3(63 downto 0),
		out0(63 downto 0) => xi0(63 downto 0),
		out1(63 downto 0) => xi1(63 downto 0),
		out2(63 downto 0) => xi2(63 downto 0),
		out3(63 downto 0) => xi3(63 downto 0)
	);
	
	chi_iota:chi_iota_stage
	port map(
		round_const(63 downto 0) => round_const(63 downto 0),
		in0(63 downto 0) => xi0(63 downto 0),
		in1(63 downto 0) => xi1(63 downto 0),
		in2(63 downto 0) => xi2(63 downto 0),
		in3(63 downto 0) => xi3(63 downto 0),
		out0(63 downto 0) => out0(63 downto 0),
		out1(63 downto 0) => out1(63 downto 0),
		out2(63 downto 0) => out2(63 downto 0),
		out3(63 downto 0) => out3(63 downto 0)
	);

end imp;