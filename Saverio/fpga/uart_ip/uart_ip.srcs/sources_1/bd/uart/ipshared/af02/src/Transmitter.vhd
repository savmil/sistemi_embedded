----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:29:58 12/25/2017 
-- Design Name: 
-- Module Name:    Transmitter - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Receiver is
generic (
    clk_per_bit : integer := 87     -- Needs to be set correctly
    );
Port ( clk : in  STD_LOGIC;
	reset: in STD_LOGIC_VECTOR(0 downto 0);
	data_in : in  STD_LOGIC_VECTOR(0 downto 0);
	data_valid : out STD_LOGIC_VECTOR(0 downto 0);
	data_out : out  STD_LOGIC_VECTOR(7 downto 0));
end Receiver;

architecture Behavioral of Receiver is
	type state is (idle,sfasamento,receive,wait_for_next);
	signal current_state: state;
	signal tempo_di_attesa : integer range 0 to clk_per_bit-1:=0;
	signal numero_di_bit : integer range 0 to 8:=0;
begin

	ricezione : process (clk)
	begin
	if rising_edge(clk) then
		if reset="0" then
		data_valid<="0";
		else
			case current_state is
			when idle =>

				if data_in="0"  then --start-bit
					current_state<=sfasamento;
					data_valid<="0";
				else
					current_state<=idle;
				end if;
			when sfasamento =>
				if tempo_di_attesa=(clk_per_bit-1)/2 then
					tempo_di_attesa<=0;

					current_state<=wait_for_next;
				else
					tempo_di_attesa<=tempo_di_attesa+1;
				end if;
			when receive =>
				data_out(numero_di_bit)<=data_in(0);
				numero_di_bit<=numero_di_bit+1;
				current_state<=wait_for_next;
			when wait_for_next =>
				if numero_di_bit<=7 then

					if tempo_di_attesa=clk_per_bit-1 then
						tempo_di_attesa<=0;
						
						current_state<=receive;
					else
						tempo_di_attesa<=tempo_di_attesa+1;
					end if;
				elsif numero_di_bit=8  then
					if tempo_di_attesa=clk_per_bit-1 then
						if data_in="1" then --stop bit
							tempo_di_attesa<=0;
							numero_di_bit<=0;
							data_valid<="1";
							current_state<=idle;
						end if;
					else
						tempo_di_attesa<=tempo_di_attesa+1;
					end if;
					

				end if;
				

			end case;
		end if;
	end if;
	end process ricezione;
	
end Behavioral;
