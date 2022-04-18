library ieee;
use ieee.std_logic_1164.all;

entity top_level is
	port(
	
	------------ CLOCK ------------
	CLOCK_50        	:in    	std_logic;
	
	------------ KEY ------------
	KEY             	:in    	std_logic_vector(3 downto 0);

	------------ HPS ------------
	HPS_DDR3_ADDR   	:out   	std_logic_vector(14 downto 0);
	HPS_DDR3_BA     	:out   	std_logic_vector(2 downto 0);
	HPS_DDR3_CAS_N  	:out   	std_logic;
	HPS_DDR3_CKE    	:out   	std_logic;
	HPS_DDR3_CK_N   	:out   	std_logic;
	HPS_DDR3_CK_P   	:out   	std_logic;
	HPS_DDR3_CS_N   	:out   	std_logic;
	HPS_DDR3_DM     	:out   	std_logic_vector(3 downto 0);
	HPS_DDR3_DQ     	:inout 	std_logic_vector(31 downto 0);
	HPS_DDR3_DQS_N  	:inout 	std_logic_vector(3 downto 0);
	HPS_DDR3_DQS_P  	:inout 	std_logic_vector(3 downto 0);
	HPS_DDR3_ODT    	:out   	std_logic;
	HPS_DDR3_RAS_N  	:out   	std_logic;
	HPS_DDR3_RESET_N	:out   	std_logic;
	HPS_DDR3_RZQ    	:in    	std_logic;
	HPS_DDR3_WE_N   	:out   	std_logic;
	HPS_ENET_GTX_CLK	:out   	std_logic;
	HPS_ENET_INT_N  	:inout 	std_logic;
	HPS_ENET_MDC    	:out   	std_logic;
	HPS_ENET_MDIO   	:inout 	std_logic;
	HPS_ENET_RX_CLK 	:in    	std_logic;
	HPS_ENET_RX_DATA	:in    	std_logic_vector(3 downto 0);
	HPS_ENET_RX_DV  	:in    	std_logic;
	HPS_ENET_TX_DATA	:out   	std_logic_vector(3 downto 0);
	HPS_ENET_TX_EN  	:out   	std_logic;
	HPS_SD_CLK      	:out   	std_logic;
	HPS_SD_CMD      	:inout 	std_logic;
	HPS_SD_DATA     	:inout 	std_logic_vector(3 downto 0);
	HPS_SPIM_CLK    	:out   	std_logic;
	HPS_SPIM_MISO   	:in    	std_logic;
	HPS_SPIM_MOSI   	:out   	std_logic;
	HPS_SPIM_SS     	:out   	std_logic;
	HPS_UART_RX     	:in    	std_logic;
	HPS_UART_TX     	:out   	std_logic;
	HPS_USB_CLKOUT  	:in    	std_logic;
	HPS_USB_DATA    	:inout 	std_logic_vector(7 downto 0);
	HPS_USB_DIR     	:in    	std_logic;
	HPS_USB_NXT     	:in    	std_logic;
	HPS_USB_STP     	:out   	std_logic
	);
end top_level;

architecture imp of top_level is
component hps is
			port (
            clk_clk                                 : in    std_logic                     := 'X';             -- clk
            hps_io_hps_io_emac1_inst_TX_CLK         : out   std_logic;                                        -- hps_io_emac1_inst_TX_CLK
            hps_io_hps_io_emac1_inst_TXD0           : out   std_logic;                                        -- hps_io_emac1_inst_TXD0
            hps_io_hps_io_emac1_inst_TXD1           : out   std_logic;                                        -- hps_io_emac1_inst_TXD1
            hps_io_hps_io_emac1_inst_TXD2           : out   std_logic;                                        -- hps_io_emac1_inst_TXD2
            hps_io_hps_io_emac1_inst_TXD3           : out   std_logic;                                        -- hps_io_emac1_inst_TXD3
            hps_io_hps_io_emac1_inst_RXD0           : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD0
            hps_io_hps_io_emac1_inst_MDIO           : inout std_logic                     := 'X';             -- hps_io_emac1_inst_MDIO
            hps_io_hps_io_emac1_inst_MDC            : out   std_logic;                                        -- hps_io_emac1_inst_MDC
            hps_io_hps_io_emac1_inst_RX_CTL         : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CTL
            hps_io_hps_io_emac1_inst_TX_CTL         : out   std_logic;                                        -- hps_io_emac1_inst_TX_CTL
            hps_io_hps_io_emac1_inst_RX_CLK         : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CLK
            hps_io_hps_io_emac1_inst_RXD1           : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD1
            hps_io_hps_io_emac1_inst_RXD2           : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD2
            hps_io_hps_io_emac1_inst_RXD3           : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD3
            hps_io_hps_io_sdio_inst_CMD             : inout std_logic                     := 'X';             -- hps_io_sdio_inst_CMD
            hps_io_hps_io_sdio_inst_D0              : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D0
            hps_io_hps_io_sdio_inst_D1              : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D1
            hps_io_hps_io_sdio_inst_CLK             : out   std_logic;                                        -- hps_io_sdio_inst_CLK
            hps_io_hps_io_sdio_inst_D2              : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D2
            hps_io_hps_io_sdio_inst_D3              : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D3
            hps_io_hps_io_usb1_inst_D0              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D0
            hps_io_hps_io_usb1_inst_D1              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D1
            hps_io_hps_io_usb1_inst_D2              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D2
            hps_io_hps_io_usb1_inst_D3              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D3
            hps_io_hps_io_usb1_inst_D4              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D4
            hps_io_hps_io_usb1_inst_D5              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D5
            hps_io_hps_io_usb1_inst_D6              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D6
            hps_io_hps_io_usb1_inst_D7              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D7
            hps_io_hps_io_usb1_inst_CLK             : in    std_logic                     := 'X';             -- hps_io_usb1_inst_CLK
            hps_io_hps_io_usb1_inst_STP             : out   std_logic;                                        -- hps_io_usb1_inst_STP
            hps_io_hps_io_usb1_inst_DIR             : in    std_logic                     := 'X';             -- hps_io_usb1_inst_DIR
            hps_io_hps_io_usb1_inst_NXT             : in    std_logic                     := 'X';             -- hps_io_usb1_inst_NXT
            hps_io_hps_io_uart0_inst_RX             : in    std_logic                     := 'X';             -- hps_io_uart0_inst_RX
            hps_io_hps_io_uart0_inst_TX             : out   std_logic;                                        -- hps_io_uart0_inst_TX
            hps_io_hps_io_gpio_inst_GPIO35          : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO35
            memory_mem_a                            : out   std_logic_vector(14 downto 0);                    -- mem_a
            memory_mem_ba                           : out   std_logic_vector(2 downto 0);                     -- mem_ba
            memory_mem_ck                           : out   std_logic;                                        -- mem_ck
            memory_mem_ck_n                         : out   std_logic;                                        -- mem_ck_n
            memory_mem_cke                          : out   std_logic;                                        -- mem_cke
            memory_mem_cs_n                         : out   std_logic;                                        -- mem_cs_n
            memory_mem_ras_n                        : out   std_logic;                                        -- mem_ras_n
            memory_mem_cas_n                        : out   std_logic;                                        -- mem_cas_n
            memory_mem_we_n                         : out   std_logic;                                        -- mem_we_n
            memory_mem_reset_n                      : out   std_logic;                                        -- mem_reset_n
            memory_mem_dq                           : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
            memory_mem_dqs                          : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
            memory_mem_dqs_n                        : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
            memory_mem_odt                          : out   std_logic;                                        -- mem_odt
            memory_mem_dm                           : out   std_logic_vector(3 downto 0);                     -- mem_dm
            memory_oct_rzqin                        : in    std_logic                     := 'X';             -- oct_rzqin
            round_const0_external_connection_export : out   std_logic_vector(31 downto 0);                    -- export
            round_const1_external_connection_export : out   std_logic_vector(31 downto 0);                    -- export
            sha_in0_external_connection_export      : out   std_logic_vector(31 downto 0);                    -- export
            sha_in1_external_connection_export      : out   std_logic_vector(31 downto 0);                    -- export
            sha_in2_external_connection_export      : out   std_logic_vector(31 downto 0);                    -- export
            sha_in3_external_connection_export      : out   std_logic_vector(31 downto 0);                    -- export
            sha_in4_external_connection_export      : out   std_logic_vector(31 downto 0);                    -- export
            sha_in5_external_connection_export      : out   std_logic_vector(31 downto 0);                    -- export
            sha_in6_external_connection_export      : out   std_logic_vector(31 downto 0);                    -- export
            sha_in7_external_connection_export      : out   std_logic_vector(31 downto 0);                    -- export
            sha_out0_external_connection_export     : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
            sha_out1_external_connection_export     : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
            sha_out2_external_connection_export     : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
            sha_out3_external_connection_export     : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
            sha_out4_external_connection_export     : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
            sha_out5_external_connection_export     : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
            sha_out6_external_connection_export     : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
            sha_out7_external_connection_export     : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
            flag_out_external_connection_export     : out   std_logic;                                        -- export
            flag_in_external_connection_export      : in    std_logic                     := 'X'              -- export
        );
    end component hps;
	 
	 component SHA3_256 is
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
	end component SHA3_256;
	
	component flipflop is
	port(
		clk, rst, d : in std_logic;
		q : out std_logic
	);
	end component flipflop;

	signal clk : std_logic;
	signal en, flag : std_logic;
	signal prop0,prop1,prop2 : std_logic;
	signal in0,in1,in2,in3 : std_logic_vector(63 downto 0);
	signal out0,out1,out2,out3 : std_logic_vector(63 downto 0);
	signal round_const : std_logic_vector(63 downto 0);
	
	 
begin 

	clk <= CLOCK_50 and en;

u0 : component hps
        port map (
            clk_clk => CLOCK_50,                                 --                              clk.clk
            hps_io_hps_io_emac1_inst_TX_CLK => HPS_ENET_GTX_CLK,      --hps_io.hps_io_emac1_inst_TX_CLK 
				hps_io_hps_io_emac1_inst_TXD0   => HPS_ENET_TX_DATA(0),   --.hps_io_emac1_inst_TXD0 
				hps_io_hps_io_emac1_inst_TXD1   => HPS_ENET_TX_DATA(1),   --.hps_io_emac1_inst_TXD1 
				hps_io_hps_io_emac1_inst_TXD2   => HPS_ENET_TX_DATA(2),   --.hps_io_emac1_inst_TXD2 
				hps_io_hps_io_emac1_inst_TXD3   => HPS_ENET_TX_DATA(3),   --.hps_io_emac1_inst_TXD3 
				hps_io_hps_io_emac1_inst_RXD0   => HPS_ENET_RX_DATA(0),   --.hps_io_emac1_inst_RXD0 
				hps_io_hps_io_emac1_inst_MDIO   => HPS_ENET_MDIO,         --.hps_io_emac1_inst_MDIO 
				hps_io_hps_io_emac1_inst_MDC    => HPS_ENET_MDC,          --.hps_io_emac1_inst_MDC 
				hps_io_hps_io_emac1_inst_RX_CTL => HPS_ENET_RX_DV,        --.hps_io_emac1_inst_RX_CTL 
				hps_io_hps_io_emac1_inst_TX_CTL => HPS_ENET_TX_EN,        --.hps_io_emac1_inst_TX_CTL 
				hps_io_hps_io_emac1_inst_RX_CLK => HPS_ENET_RX_CLK,       --.hps_io_emac1_inst_RX_CLK 
				hps_io_hps_io_emac1_inst_RXD1   => HPS_ENET_RX_DATA(1),   --.hps_io_emac1_inst_RXD1 
				hps_io_hps_io_emac1_inst_RXD2   => HPS_ENET_RX_DATA(2),   --.hps_io_emac1_inst_RXD2 
				hps_io_hps_io_emac1_inst_RXD3   => HPS_ENET_RX_DATA(3),   --.hps_io_emac1_inst_RXD3 
				hps_io_hps_io_sdio_inst_CMD     => HPS_SD_CMD,            --.hps_io_sdio_inst_CMD 
				hps_io_hps_io_sdio_inst_D0      => HPS_SD_DATA(0),        --.hps_io_sdio_inst_D0 
				hps_io_hps_io_sdio_inst_D1      => HPS_SD_DATA(1),        --.hps_io_sdio_inst_D1 
				hps_io_hps_io_sdio_inst_CLK     => HPS_SD_CLK,            --.hps_io_sdio_inst_CLK 
				hps_io_hps_io_sdio_inst_D2      => HPS_SD_DATA(2),        --.hps_io_sdio_inst_D2 
				hps_io_hps_io_sdio_inst_D3      => HPS_SD_DATA(3),        --.hps_io_sdio_inst_D3 
				hps_io_hps_io_usb1_inst_D0      => HPS_USB_DATA(0),       --.hps_io_usb1_inst_D0 
				hps_io_hps_io_usb1_inst_D1      => HPS_USB_DATA(1),       --.hps_io_usb1_inst_D1 
				hps_io_hps_io_usb1_inst_D2      => HPS_USB_DATA(2),       --.hps_io_usb1_inst_D2 
				hps_io_hps_io_usb1_inst_D3      => HPS_USB_DATA(3),       --.hps_io_usb1_inst_D3 
				hps_io_hps_io_usb1_inst_D4      => HPS_USB_DATA(4),       --.hps_io_usb1_inst_D4 
				hps_io_hps_io_usb1_inst_D5      => HPS_USB_DATA(5),       --.hps_io_usb1_inst_D5 
				hps_io_hps_io_usb1_inst_D6      => HPS_USB_DATA(6),       --.hps_io_usb1_inst_D6 
				hps_io_hps_io_usb1_inst_D7      => HPS_USB_DATA(7),       --.hps_io_usb1_inst_D7 
				hps_io_hps_io_usb1_inst_CLK     => HPS_USB_CLKOUT,        --.hps_io_usb1_inst_CLK 
				hps_io_hps_io_usb1_inst_STP     => HPS_USB_STP,           --.hps_io_usb1_inst_STP 
				hps_io_hps_io_usb1_inst_DIR     => HPS_USB_DIR,           --.hps_io_usb1_inst_DIR 
				hps_io_hps_io_usb1_inst_NXT     => HPS_USB_NXT,           --.hps_io_usb1_inst_NXT 
				hps_io_hps_io_uart0_inst_RX     => HPS_UART_RX,           --.hps_io_uart0_inst_RX 
				hps_io_hps_io_uart0_inst_TX     => HPS_UART_TX,           --.hps_io_uart0_inst_TX 
				hps_io_hps_io_gpio_inst_GPIO35  => HPS_ENET_INT_N,        --.hps_io_gpio_inst_GPIO35         --                                 .hps_io_gpio_inst_GPIO35
            memory_mem_a                    => HPS_DDR3_ADDR,         --memory.mem_a 
				memory_mem_ba                   => HPS_DDR3_BA,           --.mem_ba 
				memory_mem_ck                   => HPS_DDR3_CK_P,         --.mem_ck 
				memory_mem_ck_n                 => HPS_DDR3_CK_N,         --.mem_ck_n 
				memory_mem_cke                  => HPS_DDR3_CKE,          --.mem_cke 
				memory_mem_cs_n                 => HPS_DDR3_CS_N,         --.mem_cs_n 
				memory_mem_ras_n                => HPS_DDR3_RAS_N,        --.mem_ras_n 
				memory_mem_cas_n                => HPS_DDR3_CAS_N,        --.mem_cas_n 
				memory_mem_we_n                 => HPS_DDR3_WE_N,         --.mem_we_n 
				memory_mem_reset_n              => HPS_DDR3_RESET_N,      --.mem_reset_n 
				memory_mem_dq                   => HPS_DDR3_DQ,           --.mem_dq 
				memory_mem_dqs                  => HPS_DDR3_DQS_P,        --.mem_dqs 
				memory_mem_dqs_n                => HPS_DDR3_DQS_N,        --.mem_dqs_n 
				memory_mem_odt                  => HPS_DDR3_ODT,          --.mem_odt 
				memory_mem_dm                   => HPS_DDR3_DM,           --.mem_dm 
				memory_oct_rzqin                => HPS_DDR3_RZQ,          --.oct_rzqin                      --                                 .oct_rzqin
            round_const0_external_connection_export(31 downto 0) => round_const(31 downto 0), 	-- round_const0_external_connection.export
            round_const1_external_connection_export(31 downto 0) => round_const(63 downto 32), 	-- round_const1_external_connection.export
            sha_in0_external_connection_export(31 downto 0) => in0(31 downto 0),	 			--      sha_in0_external_connection.export
            sha_in1_external_connection_export(31 downto 0) => in0(63 downto 32),        	--      sha_in1_external_connection.export
            sha_in2_external_connection_export(31 downto 0) => in1(31 downto 0),         	--      sha_in2_external_connection.export
            sha_in3_external_connection_export(31 downto 0) => in1(63 downto 32),        	--      sha_in3_external_connection.export
            sha_in4_external_connection_export(31 downto 0) => in2(31 downto 0),         	--      sha_in4_external_connection.export
            sha_in5_external_connection_export(31 downto 0) => in2(63 downto 32),        	--      sha_in5_external_connection.export
            sha_in6_external_connection_export(31 downto 0) => in3(31 downto 0),         	--      sha_in6_external_connection.export
            sha_in7_external_connection_export (31 downto 0) => in3(63 downto 32),        	--      sha_in7_external_connection.export
            sha_out0_external_connection_export(31 downto 0) => out0(31 downto 0),    	  		--      sha_out0_external_connection.export
            sha_out1_external_connection_export(31 downto 0) => out0(63 downto 32),       	--      sha_out1_external_connection.export
            sha_out2_external_connection_export(31 downto 0) => out1(31 downto 0),        	--      sha_out2_external_connection.export
            sha_out3_external_connection_export(31 downto 0) => out1(63 downto 32),       	--      sha_out3_external_connection.export
            sha_out4_external_connection_export(31 downto 0) => out2(31 downto 0),        	--      sha_out4_external_connection.export
            sha_out5_external_connection_export(31 downto 0) => out2(63 downto 32),       	--      sha_out5_external_connection.export
            sha_out6_external_connection_export(31 downto 0) => out3(31 downto 0),        	--      sha_out6_external_connection.export
            sha_out7_external_connection_export(31 downto 0) => out3(63 downto 32),       	--      sha_out7_external_connection.export
            flag_out_external_connection_export     => en,    						   	--      flag_out_external_connection.export
            flag_in_external_connection_export      => flag       						--      flag_in_external_connection.export
        );
		  
u1: component SHA3_256
	port map(
		rst => KEY(0),
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
	
ff0 : component flipflop
	port map(
	clk => clk,
	rst => KEY(0),
	d => en,
	q => prop0
	);
	
ff1 : component flipflop
	port map(
	clk => clk,
	rst => KEY(0),
	d => prop0,
	q => prop1
	);
	
ff2 : component flipflop
	port map(
	clk => clk,
	rst => KEY(0),
	d => prop1,
	q => prop2
	);
	
ff3 : component flipflop
	port map(
	clk => clk,
	rst => KEY(0),
	d => prop2,
	q => flag
	);
	
end imp;	