----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:02:23 01/18/2018 
-- Design Name: 
-- Module Name:    clock_mod - Behavioral 
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

entity clock_mod is
    Generic (N : integer := 16);
	 Port ( clock : in  STD_LOGIC;
           clock_out : out  STD_LOGIC);
end clock_mod;

architecture Behavioral of clock_mod is

	signal count : integer range 0 to N-1 := 0;
	signal clock_tmp : STD_LOGIC := '0';
   

begin
	
	clock_out <= clock_tmp;

	process (clock,count)
	begin
	if (clock = '1' and clock'event) then
			if count = N-1 then
				clock_tmp <= not clock_tmp;
				count <= 0;
			else
				clock_tmp <= clock_tmp;
				count <= count + 1;
			end if;
	end if;
	end process;

end Behavioral;

