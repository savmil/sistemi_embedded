----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:13:29 01/18/2018 
-- Design Name: 
-- Module Name:    rx_cu - Behavioral 
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

entity rx_cu is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           rx : in  STD_LOGIC;
			  FE : out STD_LOGIC;
			  PE : out STD_LOGIC;
			  OE : out STD_LOGIC;
			  RDA : out STD_LOGIC;
			  load_data : out STD_LOGIC;
           received_data : out  STD_LOGIC_VECTOR (7 downto 0)
		);
end rx_cu;


architecture Behavioral of rx_cu is

	COMPONENT shift_register_SIPO
	Generic(n_bits : integer := 10);
	PORT(
		clock : IN std_logic;
		reset : IN std_logic;
		shift : IN std_logic;
		d_in : IN std_logic;          
		data_out : OUT std_logic_vector(n_bits-1 downto 0)
		);
	END COMPONENT;

	COMPONENT counter_modN
	Generic(N : integer := 8);
	PORT(
		clock : IN std_logic;
		reset : IN std_logic;
		enable : IN std_logic;          
		counter_hit : OUT std_logic
		);
	END COMPONENT;
	
	
	
	type state is (idle, eight_delay, wait_for_centre, get_bit, check_stop,RDA_state);
	
	signal current_state,next_state : state := idle;

	--------Signal -------------
	signal rx_frame : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
	signal shift_en : STD_LOGIC := '0';
	signal reset_8count, reset_16count, reset_bit_count : STD_LOGIC := '0';
	signal counter_8incr, counter_16incr, counter_bit_incr : STD_LOGIC := '0';
	signal done_8count, done_16count, done_bit_count : STD_LOGIC := '0';
	signal frameError, parError : STD_LOGIC := '0';

begin
	
	frameError <= not rx_frame(9);
	parError <= not ( rx_frame(8) xor (((rx_frame(0) xor rx_frame(1)) xor (rx_frame(2) xor rx_frame(3))) xor ((rx_frame(4) xor rx_frame(5)) xor (rx_frame(6) xor rx_frame(7)))) );

	received_data <= rx_frame(7 downto 0);
		
	
	RX_shift_register_SIPO: shift_register_SIPO GENERIC MAP (10) PORT MAP(
		clock => clock,
		reset => reset,
		shift => shift_en,
		d_in => rx,
		data_out => rx_frame
		);

	

	counter_mod8: counter_modN Generic map (8) PORT MAP(
		clock => clock ,
		reset => reset_8count,
		enable => counter_8incr,
		counter_hit => done_8count
	);
		
	
	counter_mod16: counter_modN Generic map (16) PORT MAP(
		clock => clock ,
		reset => reset_16count,
		enable => counter_16incr,
		counter_hit => done_16count
	);
		
		
	bit_counter: counter_modN Generic map (10) PORT MAP(
		clock => clock ,
		reset => reset_bit_count,
		enable => counter_bit_incr,
		counter_hit => done_bit_count
	);
		

	state_assignment : process(clock, reset) is
		begin
			if  (clock = '0' and clock'event) then
				if reset = '1' then
					current_state <= idle;
				else 
					current_state <= next_state;
				end if;
			end if;
		end process;

	
	rx_fsm : process(clock, reset, rx, current_state, done_8count, done_16count, done_bit_count, parError,frameError)
		begin
		
			

			
			case current_state is 			
				
				when idle =>
					
					counter_8incr <= '0';
					counter_16incr <= '0';
					counter_bit_incr <= '0';
					shift_en <= '0';
					load_data <= '0';
					PE <= '0';
					FE <= '0';
					OE <= '0';
					
					
					RDA <= '1';
					reset_8count <= '1';
					reset_16count <= '1';
					reset_bit_count <= '1';

					if (rx = '1') then
						next_state <= idle;
					else
						next_state <= eight_delay;
					end if;
				
				when eight_delay =>
					
					counter_16incr <= '0';
					counter_bit_incr <= '0';
					reset_8count <= '0';
					reset_16count <= '0';
					reset_bit_count <= '0';
					shift_en <= '0';
					load_data <= '0';
					PE <= '0';
					FE <= '0';
					OE <= '0';
					
					counter_8incr <= '1';
					RDA <= '0';
					
					if (done_8count = '1') then
						next_state <= wait_for_centre;
					else 
						next_state <= eight_delay;
					end if;
				
				when wait_for_centre =>
					
					counter_8incr <= '0';
					counter_bit_incr <= '0';
					reset_8count <= '0';
					reset_16count <= '0';
					reset_bit_count <= '0';
					shift_en <= '0';
					load_data <= '0';
					PE <= '0';
					FE <= '0';
					OE <= '0';
							
					RDA <= '0';					
					counter_16incr <= '1';
					
					if (done_16count = '1') then
						next_state <= get_bit;
					else 
						next_state <= wait_for_centre;
					end if;
				
				when get_bit =>
					
					counter_8incr <= '0';
					counter_16incr <= '0';
					reset_8count <= '0';
					reset_16count <= '1';
					reset_bit_count <= '0';
					load_data <= '0';
					PE <= '0';
					FE <= '0';
					OE <= '0';
					
					
					
					RDA <= '0';				
					shift_en <= '0';
					counter_bit_incr <= '1';

					
					if (done_bit_count = '1') then
						next_state <= check_stop;
					else 
						shift_en <= '1';
						next_state <= wait_for_centre;
					end if;
				
				when check_stop =>
					
					counter_8incr <= '0';
					counter_16incr <= '0';
					counter_bit_incr <= '0';
					reset_8count <= '0';
					reset_16count <= '0';
					reset_bit_count <= '0';
					shift_en <= '0';
								
					PE <= parError;
					FE <= frameError;
					OE <= '0';
					RDA <= '0';
					
					load_data <= '1';
					
					next_state <= RDA_state;
					
				when RDA_state =>
				
				    counter_8incr <= '0';
					counter_16incr <= '0';
					counter_bit_incr <= '0';
					reset_8count <= '0';
					reset_16count <= '0';
					reset_bit_count <= '0';
					shift_en <= '0';
								
					PE <= parError;
					FE <= frameError;
					OE <= '0';
					RDA <= '1';
					
					load_data <= '0';
					
					next_state <= idle;
					
			end case;
		end process;

end Behavioral;

