----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:24:21 12/12/2017 
-- Design Name: 
-- Module Name:    debounce - Behavioral 
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

library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity debounce is 
    Port ( clock : in  STD_LOGIC; 
           input : in  STD_LOGIC; 
           result : out  STD_LOGIC); 
end debounce; 

architecture Behavioral of debounce is 
 
signal Q0, Q1, Q2 : STD_LOGIC := '0'; 

begin 

process (clock) is 
begin 
 if (clock'event and clock = '1') then  
  Q0 <= input; 

  Q1 <= Q0; 

  Q2 <= Q1; 

 end if; 

end process; 

result <= Q0 and Q1 and (not Q2);

end Behavioral; 