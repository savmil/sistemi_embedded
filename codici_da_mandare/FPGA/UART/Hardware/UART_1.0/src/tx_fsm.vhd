----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:21:43 01/18/2018 
-- Design Name: 
-- Module Name:    tx_cu - Behavioral 
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

entity tx_cu is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           tx_en : in  STD_LOGIC;
		   tx_busy : out STD_LOGIC;
           data_to_tx : in  STD_LOGIC_VECTOR (7 downto 0);
           tx : out  STD_LOGIC);
end tx_cu;

architecture Behavioral of tx_cu is

	COMPONENT shift_register
	Generic(n_bits : integer := 11);
	PORT(
		clock : IN std_logic;
		reset : IN std_logic;
		load : IN std_logic;
		shift : IN std_logic;
		d_in : IN std_logic;
		data_in : IN std_logic_vector(n_bits-1 downto 0);          
		data_out : OUT std_logic
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


	type state is (idle,start,transmit,reset_state);

	------ Signals ------
	signal current_state,next_state : state :=idle;

	
	signal parity : STD_LOGIC := '0';
	signal frame : STD_LOGIC_VECTOR(10 downto 0) := (others => '0');
	signal shift_en, p_load, reset_counter, counter_incr,tx_done : STD_LOGIC := '0';
	


begin

		parity <=  not ( ((data_to_tx(0) xor data_to_tx(1)) xor (data_to_tx(2) xor data_to_tx(3))) xor ((data_to_tx(4) xor data_to_tx(5)) xor (data_to_tx(6) xor data_to_tx(7))) );
		
		frame <= '1' & parity & data_to_tx & '0'; --costruzione frame con start, data, parity e bit di stop


		TX_shift_register: shift_register GENERIC MAP (11) PORT MAP(
			clock => clock ,
			reset => reset,
			load => p_load,
			shift => shift_en,
			d_in => '1',
			data_in => frame,
			data_out => tx
		);

		TX_counter: counter_modN GENERIC MAP(11) PORT MAP(
			clock => clock,
			reset => reset_counter,
			enable => counter_incr,
			counter_hit => tx_done
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


	tx_fsm : process(current_state, clock, reset, tx_en, tx_done)
		begin
				
				
				
				case current_state is
				
					when idle =>
						
						tx_busy <= '0';
						reset_counter <= '1';
						shift_en <= '0';
						p_load <= '0';
						counter_incr <= '0';		
						if (tx_en = '0') then
							next_state <= idle;
						else 
							next_state <= start;
						end if;
						
					when start => 
						
						tx_busy <= '1';
						reset_counter <= '1';
						shift_en <= '0';
						p_load <= '1';
						counter_incr <= '0';		
						next_state <= transmit;
					
					when transmit =>
						
						tx_busy <= '1';
						shift_en <= '1';
						counter_incr <= '1';		
						p_load <= '0';
						reset_counter <= '0';

						
						if (tx_done = '1') then
								next_state <= reset_state;
						else 
								next_state <= transmit;
						end if;
						
					when reset_state => 	
					   
					    tx_busy <= '1';
						shift_en <= '0';
						counter_incr <= '0';		
						p_load <= '0';
						reset_counter <= '1';
					 
					 next_state <= idle;  
					   
			end case;
		end process;
		
end Behavioral;

