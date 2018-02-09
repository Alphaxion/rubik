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
            clk_clk            : in    std_logic                       := 'X';
            memory_mem_a       : out   std_logic_vector(14 downto 0);
            memory_mem_ba      : out   std_logic_vector(2 downto 0);
            memory_mem_ck      : out   std_logic;
            memory_mem_ck_n    : out   std_logic;
            memory_mem_cke     : out   std_logic;
            memory_mem_cs_n    : out   std_logic;
            memory_mem_ras_n   : out   std_logic;
            memory_mem_cas_n   : out   std_logic;
            memory_mem_we_n    : out   std_logic;
            memory_mem_reset_n : out   std_logic;
            memory_mem_dq      : inout std_logic_vector(31 downto 0)   := (others => 'X');
            memory_mem_dqs     : inout std_logic_vector(3 downto 0)    := (others => 'X');
            memory_mem_dqs_n   : inout std_logic_vector(3 downto 0)    := (others => 'X');
            memory_mem_odt     : out   std_logic;
            memory_mem_dm      : out   std_logic_vector(3 downto 0);
            memory_oct_rzqin   : in    std_logic                       := 'X';
            reset_reset_n      : in    std_logic                       := 'X';
            pio_in_export      : in    std_logic                       := 'X';
            pio_out_export     : out   std_logic_vector(4 downto 0)
        );
    end component hps_system;
    signal steppers_cmd: signed(3 downto 0) := (others=>'0');
    signal steppers_reset: std_logic := '0';
    signal steppers_done: std_logic := '1';
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
            pio_in_export      => steppers_done,
            pio_out_export(4)  => steppers_reset,
            signed(pio_out_export(3 downto 0)) => steppers_cmd
        );
    u_steppers: entity work.steppers
        port map(
            clk   => FPGA_CLK1_50,
            step  => GPIO_0(5 downto 0),
            dir   => GPIO_0(11 downto 6),
            reset => steppers_reset,
            done  => steppers_done,
            cmd   => steppers_cmd
        );
end rtl; 
