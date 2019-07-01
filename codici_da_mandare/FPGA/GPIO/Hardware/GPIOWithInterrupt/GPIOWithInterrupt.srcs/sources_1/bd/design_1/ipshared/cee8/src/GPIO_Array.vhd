----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.04.2019 18:49:22
-- Design Name: 
-- Module Name: GPIO_Array - structural
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

entity GPIO_Array is
		generic (
			width : integer := 4);
	  Port (
	  		enable : in std_logic_vector(width-1 downto 0);
	  		write : in std_logic_vector(width-1 downto 0);
	  		read : out std_logic_vector(width-1 downto 0);
	  		pads : inout std_logic_vector(width-1 downto 0) 
	   );
end GPIO_Array;

architecture structural of GPIO_Array is

	component gpio is
		port (
			enable : in std_logic;
        	write : in std_logic;
        	read : out std_logic;
        	pad : inout std_logic
		);
	end component gpio;
begin

	generate_gpio : for i in 0 to width-1 generate
		gpio_map : gpio port map (
			enable => enable(i),
			write => write(i),
			read => read(i),
			pad => pads(i)
		);
	end generate generate_gpio;

end structural;
