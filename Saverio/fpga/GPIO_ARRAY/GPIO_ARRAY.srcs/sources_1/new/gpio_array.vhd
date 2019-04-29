----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:19:46 12/28/2017 
-- Design Name: 
-- Module Name:    gpio - Behavioral 
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

entity gpio_array is
	 generic(width : natural := 2);
    Port ( pads : inout  STD_LOGIC_VECTOR (width-1 downto 0);
           inputs : in  STD_LOGIC_VECTOR (width-1 downto 0);
           enable : in  STD_LOGIC_VECTOR (width-1 downto 0);
           outputs : out  STD_LOGIC_VECTOR (width-1 downto 0));
end gpio_array;

architecture Structural of gpio_array is
component gpio is
    Port ( in_out : inout  STD_LOGIC;
           s_in : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           s_out : out  STD_LOGIC);
end component;

begin

	gpio_gen: for i in 0 to width-1 generate
		inst_gpio: gpio
			Port map( in_out => pads(i),
						 s_in => inputs(i),
						 enable => enable(i),
						 s_out => outputs(i)
			);
	
	end generate;

end Structural;