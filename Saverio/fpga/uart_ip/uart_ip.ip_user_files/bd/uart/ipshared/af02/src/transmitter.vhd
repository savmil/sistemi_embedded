----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.04.2019 17:17:45
-- Design Name: 
-- Module Name: transmitter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity transmitter is
	generic (
    clk_per_bit : integer := 87     -- Needs to be set correctly
    );
    Port (
    	clk : in STD_LOGIC;
    	reset: in STD_LOGIC_VECTOR(0 downto 0);
    	start: in STD_LOGIC_VECTOR(0 downto 0);
    	data_in : in STD_LOGIC_VECTOR(7 downto 0);
    	data_out : out STD_LOGIC_VECTOR (0 downto 0)
    );
end transmitter;

architecture Behavioral of transmitter is
	type state is (idle,send_start,send,wait_for_next);
	signal current_state: state:=idle;
	signal tempo_di_attesa : integer range 0 to clk_per_bit-1:=0;
	signal numero_di_bit : integer range 0 to 8:=0;
	signal ended: STD_LOGIC :='1';
begin
	ricezione : process (clk)
	begin
	if rising_edge(clk) then
		if reset="0" then
			data_out<="1";	
		else
			case current_state is
				when idle=>
					data_out<="1";
					if (start="0") then
						ended<='1';
					elsif (start="1" and ended='1') then
						numero_di_bit<=0;
						ended<='0';
						current_state<=send_start;
					end if;
				when send_start =>
					data_out<="0";
					current_state<=wait_for_next;
				when send =>

					data_out<=data_in(numero_di_bit downto numero_di_bit);
					numero_di_bit<=numero_di_bit+1; --aggiorno qua il bit da inviare sennò mi perdo il primo bit
					current_state<=wait_for_next;
				when wait_for_next =>
				if numero_di_bit<=7 then

					if tempo_di_attesa=clk_per_bit-1 then
						tempo_di_attesa<=0;
						current_state<=send;
					else
						tempo_di_attesa<=tempo_di_attesa+1;
					end if;
				elsif numero_di_bit=8  then
					if tempo_di_attesa=clk_per_bit-1 then
						tempo_di_attesa<=0;
						current_state<=idle;
						data_out<="1";	
					else
						tempo_di_attesa<=tempo_di_attesa+1;
					end if;
				
					
				end if;	
			end case;
		end if;
	end if;
	end process;

end Behavioral;
