----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:15:09 12/28/2017 
-- Design Name: 
-- Module Name:    pad - Behavioral 
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

entity gpio is
    Port ( in_out : inout  STD_LOGIC;
           s_in : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           s_out : out  STD_LOGIC);
end gpio;

architecture Behavioral of gpio is

begin

with enable select 
	in_out <= s_in when '1', 'Z' when others;
	
s_out <= in_out;

end Behavioral;