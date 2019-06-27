----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:02:41 01/18/2018 
-- Design Name: 
-- Module Name:    shift_register_SIPO - Behavioral 
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

entity shift_register_SIPO is
	Generic(n_bits : integer := 10);
	Port ( 
		clock : in  STD_LOGIC;
      reset : in  STD_LOGIC;
      shift : in  STD_LOGIC;
      d_in : in  STD_LOGIC;
      data_out : out  STD_LOGIC_VECTOR(n_bits-1 downto 0)
	);
end shift_register_SIPO;

architecture Behavioral of shift_register_SIPO is



signal tmp_sig : STD_LOGIC_VECTOR(n_bits-1 downto 0) := (others => '0');



begin

	
	process (clock)
		begin
		if clock'event and clock='1' then  
			if reset ='1' then 
				tmp_sig <= (others => '0'); 
			elsif shift = '1' then 
				tmp_sig <= d_in & tmp_sig(n_bits-1 downto 1);
			end if; 
		end if;
	end process;
	
	data_out <= tmp_sig;


end Behavioral;


