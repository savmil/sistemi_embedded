library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity muxn_1 is
	generic(width : natural := 3 --sto dicendo che sel ha dimensione 3
	);
	
	port(
		a : in std_logic_vector(2**width-1 downto 0); --quindi indirizza 4 indirizzi da 3 a 0
		sel : in std_logic_vector(width-1 downto 0);
		x : out std_logic
	);
end muxn_1;

architecture dataflow of muxn_1 is

begin

x <= A(conv_integer(sel)); --sel'lengh ci da indicazioni su quanto è grande il bus

end dataflow;
