----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:06:14 11/16/2017 
-- Design Name: 
-- Module Name:    d_latch_register8 - Behavioral 
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

entity d_ff_register is
    Generic (N : integer := 8);
	Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           d : in  STD_LOGIC_VECTOR (N-1 downto 0);
           q : out  STD_LOGIC_VECTOR (N-1 downto 0));
end d_ff_register;

architecture Behavioral of d_ff_register is

begin

process (clock, reset)
begin
   if reset='1' then   
      q <= (others => '0');
   elsif (clock'event and clock='1') then 
      if enable = '1' then 
         q <= d;
      end if; 
   end if;
end process;



end Behavioral;

