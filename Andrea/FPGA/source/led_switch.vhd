----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.04.2019 10:08:52
-- Design Name: 
-- Module Name: led_switch - Dataflow
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

entity led_switch is
    Generic (value : integer := 4);
    Port ( clk : in STD_LOGIC;
           led_in : in STD_LOGIC_VECTOR(value-1 downto 0);
           switch_out : out STD_LOGIC_VECTOR(value-1 downto 0);
           led_out : out STD_LOGIC_VECTOR (value-1 downto 0);
           switch_in : in STD_LOGIC_VECTOR (value-1 downto 0));
end led_switch;

architecture Dataflow of led_switch is

begin

    LS : process(clk)
    begin
        if rising_edge(clk) then
            led_out <= led_in;
            switch_out <= switch_in;
        end if;
   end process;

end Dataflow;
