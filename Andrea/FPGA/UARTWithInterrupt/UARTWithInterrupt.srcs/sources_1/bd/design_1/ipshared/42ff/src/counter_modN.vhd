----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:34:01 31/12/2017 
-- Design Name: 
-- Module Name:    counter_modN - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_modN is
	Generic(N : integer := 8);
    Port (
		clock : in  STD_LOGIC;
      reset : in  STD_LOGIC;
      enable : in  STD_LOGIC;
      counter_hit : out  STD_LOGIC
		);
end counter_modN;

architecture Behavioral of counter_modN is

signal count : integer range 0 to N-1 := 0;

begin

	process (clock, reset)
	begin
	
	if reset = '1' then
		count <= 0;
		counter_hit <= '0';
	elsif clock = '1' and clock'event then
		if enable = '1' then
			if count = N-1 then
				counter_hit <= '1';
				count <= 0;
			else
			count <= count + 1;
			counter_hit <= '0';
			end if;
		end if;
	end if;
	
end process;

end Behavioral;

