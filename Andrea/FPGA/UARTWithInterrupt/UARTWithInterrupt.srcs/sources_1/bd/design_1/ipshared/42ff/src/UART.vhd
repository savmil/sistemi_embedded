----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:06:15 01/18/2018 
-- Design Name: 
-- Module Name:    UART - Structural 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UART is
    Generic(baudrate : integer := 9600;
				clock_freq : integer := 50_000_000);
	 Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           rx : in  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           tx_en : in  STD_LOGIC;
           OE : out  STD_LOGIC;
           tx_busy : out  STD_LOGIC;
           FE : out  STD_LOGIC;
           PE : out  STD_LOGIC;
           tx : out  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (7 downto 0);
           RDA : out  STD_LOGIC);
end UART;

architecture Structural of UART is

	COMPONENT rx_cu
	PORT(
		clock : IN std_logic;
		reset : IN std_logic;
		rx : IN std_logic;          
		FE : OUT std_logic;
		PE : OUT std_logic;
		OE : OUT std_logic;
		RDA : OUT std_logic;
		load_data : OUT std_logic;
		received_data : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	
	COMPONENT tx_cu
	PORT(
		clock : IN std_logic;
		reset : IN std_logic;
		tx_en : IN std_logic;
		data_to_tx : IN std_logic_vector(7 downto 0);          
		tx_busy : OUT std_logic;
		tx : OUT std_logic
		);
	END COMPONENT;

	COMPONENT d_ff_register
	Generic(N : integer := 8);
	PORT(
		clock : IN std_logic;
		reset : IN std_logic;
		enable : IN std_logic;
		d : IN std_logic_vector(N-1 downto 0);          
		q : OUT std_logic_vector(N-1 downto 0)
		);
	END COMPONENT;

	COMPONENT clock_mod
	Generic (N : integer := 16);
	PORT(
		clock : IN std_logic;          
		clock_out : OUT std_logic
		);
	END COMPONENT;
	

component edge_detector is
    port (
        clk : in  std_logic;
        reset : in  std_logic;
        level : in  std_logic;
        pulse : out std_logic
        );
end component;

    signal tx_en_pulse : std_logic;	
	signal load_d : STD_LOGIC := '0';
	signal data_to_reg : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal rx_clock, tx_clock : STD_LOGIC := '0';

	----------
	constant boudDivide : integer := (clock_freq/baudrate)/16;

begin

	BAUDGENERATOR: clock_mod Generic map(boudDivide/2) PORT MAP(
		clock => clock,
		clock_out => rx_clock
	);

	tx_clock_mod: clock_mod Generic map(8)PORT MAP(
		clock => rx_clock,
		clock_out => tx_clock
	);


	TX_UART: tx_cu PORT MAP(
		clock => tx_clock,
		reset => reset,
		tx_en => tx_en_pulse,
		tx_busy => tx_busy,
		data_to_tx => data_in,
		tx => tx
	);

	RX_UART: rx_cu PORT MAP(
		clock => rx_clock,
		reset => reset,
		rx => rx,
		FE => FE,
		PE => PE,
		OE => OE,
		RDA => RDA,
		load_data => load_d,
		received_data => data_to_reg
	);
	
	Holding_register: d_ff_register PORT MAP(
		clock => clock,
		reset => reset,
		enable => load_d,
		d => data_to_reg,
		q => data_out
	);

    inst_edge_detector : edge_detector PORT MAP(
          clk => tx_clock,
        reset => reset,
        level => tx_en,
        pulse => tx_en_pulse
    );

    
end Structural;

