library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rubik is
	port(
		FPGA_CLK1_50     : in    std_logic;
		FPGA_CLK2_50     : in    std_logic;
		FPGA_CLK3_50     : in    std_logic;
		KEY              : in    std_logic_vector(1 downto 0);
		LED              : out   std_logic_vector(7 downto 0);
		SW               : in    std_logic_vector(3 downto 0);
		GPIO_0           : inout std_logic_vector(35 downto 0);
		GPIO_1           : inout std_logic_vector(35 downto 0);

		HPS_DDR3_ADDR    : out   std_logic_vector(14 downto 0);
		HPS_DDR3_BA      : out   std_logic_vector(2 downto 0);
		HPS_DDR3_CK_P    : out   std_logic;
		HPS_DDR3_CK_N    : out   std_logic;
		HPS_DDR3_CKE     : out   std_logic;
		HPS_DDR3_CS_N    : out   std_logic;
		HPS_DDR3_RAS_N   : out   std_logic;
		HPS_DDR3_CAS_N   : out   std_logic;
		HPS_DDR3_WE_N    : out   std_logic;
		HPS_DDR3_RESET_N : out   std_logic;
		HPS_DDR3_DQ      : inout std_logic_vector(31 downto 0);
		HPS_DDR3_DQS_P   : inout std_logic_vector(3 downto 0);
		HPS_DDR3_DQS_N   : inout std_logic_vector(3 downto 0);
		HPS_DDR3_ODT     : out   std_logic;
		HPS_DDR3_DM      : out   std_logic_vector(3 downto 0);
		HPS_DDR3_RZQ     : in    std_logic
	);
end entity rubik;

architecture rtl of rubik is
	component hps_system is
		port (
			clk_clk            : in    std_logic                     := 'X';             -- clk
			memory_mem_a       : out   std_logic_vector(14 downto 0);                    -- mem_a
			memory_mem_ba      : out   std_logic_vector(2 downto 0);                     -- mem_ba
			memory_mem_ck      : out   std_logic;                                        -- mem_ck
			memory_mem_ck_n    : out   std_logic;                                        -- mem_ck_n
			memory_mem_cke     : out   std_logic;                                        -- mem_cke
			memory_mem_cs_n    : out   std_logic;                                        -- mem_cs_n
			memory_mem_ras_n   : out   std_logic;                                        -- mem_ras_n
			memory_mem_cas_n   : out   std_logic;                                        -- mem_cas_n
			memory_mem_we_n    : out   std_logic;                                        -- mem_we_n
			memory_mem_reset_n : out   std_logic;                                        -- mem_reset_n
			memory_mem_dq      : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
			memory_mem_dqs     : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
			memory_mem_dqs_n   : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
			memory_mem_odt     : out   std_logic;                                        -- mem_odt
			memory_mem_dm      : out   std_logic_vector(3 downto 0);                     -- mem_dm
			memory_oct_rzqin   : in    std_logic                     := 'X';             -- oct_rzqin
			pio_done_export    : in    std_logic                     := 'X';             -- export
			pio_cmd_export     : out   std_logic_vector(3 downto 0);                     -- export
			reset_reset_n      : in    std_logic                     := 'X';             -- reset_n
			pio_enable_export  : out   std_logic                                         -- export
		);
	end component hps_system;
	signal motors_cmd:    signed(3 downto 0);
	signal motors_enable: std_logic;
	signal motors_done:   std_logic;
begin
	u_hps : component hps_system
		port map (
			clk_clk            => FPGA_CLK1_50,
			memory_mem_a       => HPS_DDR3_ADDR,
			memory_mem_ba      => HPS_DDR3_BA,
			memory_mem_ck      => HPS_DDR3_CK_P,
			memory_mem_ck_n    => HPS_DDR3_CK_N,
			memory_mem_cke     => HPS_DDR3_CKE,
			memory_mem_cs_n    => HPS_DDR3_CS_N,
			memory_mem_ras_n   => HPS_DDR3_RAS_N,
			memory_mem_cas_n   => HPS_DDR3_CAS_N,
			memory_mem_we_n    => HPS_DDR3_WE_N,
			memory_mem_reset_n => HPS_DDR3_RESET_N,
			memory_mem_dq      => HPS_DDR3_DQ,
			memory_mem_dqs     => HPS_DDR3_DQS_P,
			memory_mem_dqs_n   => HPS_DDR3_DQS_N,
			memory_mem_odt     => HPS_DDR3_ODT,
			memory_mem_dm      => HPS_DDR3_DM,
			memory_oct_rzqin   => HPS_DDR3_RZQ,
			reset_reset_n      => KEY(1),
			pio_done_export    => motors_done,
			pio_enable_export  => motors_enable,
			signed(pio_cmd_export) => motors_cmd
		);
	u_motors: entity work.motors
		port map(
			clk_50   => FPGA_CLK1_50,
			stp_step => GPIO_0(2 downto 0),
			stp_dir  => GPIO_0(5 downto 3),
			srv_pwm  => GPIO_0(8 downto 6),
			enable   => motors_enable,
			done     => motors_done,
			cmd      => motors_cmd
		);
end rtl;
