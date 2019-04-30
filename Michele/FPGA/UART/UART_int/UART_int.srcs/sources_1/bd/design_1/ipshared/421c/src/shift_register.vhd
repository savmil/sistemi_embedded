----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:52:04 01/03/2018 
-- Design Name: 
-- Module Name:    shift_register - Behavioral 
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

entity shift_register is
	Generic(n_bits : integer := 10);
	Port ( 
		clock : in  STD_LOGIC;
      reset : in  STD_LOGIC;
      load : in  STD_LOGIC;
      shift : in  STD_LOGIC;
      d_in : in  STD_LOGIC;
      data_in : in  STD_LOGIC_VECTOR (n_bits-1 downto 0);
      data_out : out  STD_LOGIC
	);
end shift_register;

architecture Behavioral of shift_register is



signal tmp_sig : STD_LOGIC_VECTOR(n_bits-1 downto 0) := (others => '1');

begin

	process (clock)
		begin
		if clock'event and clock='1' then  
			if reset ='1' then 
				tmp_sig <= (others => '1'); 
			elsif load = '1' then 
				tmp_sig <= data_in; 
			elsif shift = '1' then 
				tmp_sig <= d_in & tmp_sig(n_bits-1 downto 1);
			end if; 
		end if;
	end process;
	
	data_out <= tmp_sig(0);


end Behavioral;

