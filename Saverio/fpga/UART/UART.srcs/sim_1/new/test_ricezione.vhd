----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.04.2019 16:45:02
-- Design Name: 
-- Module Name: test_ricezione - Behavioral
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

entity test_ricezione is
--  Port ( );
end test_ricezione;

architecture Behavioral of test_ricezione is
	component Receiver is
	generic (
	    clk_per_bit : integer := 87     -- Needs to be set correctly
	    );
	Port ( clk : in  STD_LOGIC;
		data_in : in  STD_LOGIC_VECTOR(0 downto 0);
		data_out : out  STD_LOGIC_VECTOR(7 downto 0));
	end component;
	signal clk: STD_LOGIC:='0';
	signal data_in: STD_LOGIC_VECTOR(0 downto 0):="0";
	signal data_out: STD_LOGIC_VECTOR(7 downto 0):="00000000";
	constant clk_period : time := 100 ns;  
begin
	uut: Receiver 
	generic map (87)
	port map(
		clk=>clk,
		data_in=>data_in,
		data_out=>data_out
		);
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
   stim_proc: process
   begin
   		data_in<="1";
   		wait for clk_period*87;
   		data_in<="0";
   		wait for clk_period*10;
   		data_in<="1";
   		wait for clk_period*87;
   		data_in<="0";
   		wait for clk_period*87;
   		data_in<="1";
   		wait for clk_period*87;
   		data_in<="1";
   		wait for clk_period*87;
   		data_in<="0";
   		wait for clk_period*87;
   		data_in<="0";
   		wait for clk_period*87;
   		data_in<="1";
   		wait for clk_period*87;
   		data_in<="1";
   		wait for clk_period*87;
          wait;
   end process;

end Behavioral;
