----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.04.2019 17:34:56
-- Design Name: 
-- Module Name: connessione_test - Behavioral
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

entity connessione_test is
--  Port ( );
end connessione_test;

architecture Behavioral of connessione_test is
	component connessione is
		generic (
	    clk_per_bit : integer := 87     -- Needs to be set correctly
	    );
	    Port (
	    	clk : in STD_LOGIC;
	    	reset: in STD_LOGIC_VECTOR(0 downto 0);
	    	start: in STD_LOGIC_VECTOR(0 downto 0);
	    	data_i : in STD_LOGIC_VECTOR(7 downto 0);
	    	data_v : out STD_LOGIC_VECTOR(0 downto 0);
	    	data_o : out STD_LOGIC_VECTOR (7 downto 0)
	    );
	end component;
	signal clk: STD_LOGIC:='0';
	signal start: STD_LOGIC_VECTOR(0 downto 0):="0";
	signal reset: STD_LOGIC_VECTOR(0 downto 0):="0";
	signal data_in: STD_LOGIC_VECTOR(7 downto 0):="01111110";
	signal data_out: STD_LOGIC_VECTOR(7 downto 0):="00000000";
	constant clk_period : time := 100 ns;  
begin
	uut: connessione 
	generic map (87)
	port map(
		clk=>clk,
		reset=>reset,
		start=>start,
		data_i=>data_in,
		data_o=>data_out
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
   		reset<="1";
   		start<="0";
   		wait for clk_period;
   		start<="1";
   		wait for clk_period;
   		start<="0";
   		wait for clk_period*1000;
   		start<="0";
   		wait for clk_period;
   		start<="1";
   		wait for clk_period;
   		start<="0";
   		wait;
   	end process;
end Behavioral;
