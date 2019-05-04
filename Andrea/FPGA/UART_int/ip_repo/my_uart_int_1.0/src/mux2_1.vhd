library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2_1 is
	Port (
		SEL : in STD_LOGIC;
		A : in STD_LOGIC;
		B : in STD_LOGIC;
		X : out STD_LOGIC
	);
end mux2_1;

architecture Behavioral of mux2_1 is

begin

	--X <= A when (SEL = '1'),
	--	 B when (SEL = '0') else 'X'; --X=unknow
	
	X<= (A and SEL) or (B and (not SEL)); --ottimo cdice poichè SEL ha un raporto diretto
	
end Behavioral;