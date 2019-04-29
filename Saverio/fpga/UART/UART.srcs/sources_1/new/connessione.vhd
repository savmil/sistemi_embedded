----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.04.2019 17:29:01
-- Design Name: 
-- Module Name: connessione - Behavioral
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

entity connessione is
	generic (
    clk_per_bit : integer := 87     -- Needs to be set correctly
    );
    Port (
    	clk : in STD_LOGIC;
    	start: in STD_LOGIC_VECTOR(0 downto 0);
    	data_i : in STD_LOGIC_VECTOR(7 downto 0);
    	data_o : out STD_LOGIC_VECTOR (7 downto 0)
    );
end connessione;

architecture Behavioral of connessione is
component transmitter is
	generic (
    clk_per_bit : integer := 87     -- Needs to be set correctly
    );
    Port (
    	clk : in STD_LOGIC;
    	start: in STD_LOGIC_VECTOR(0 downto 0);
    	data_in : in STD_LOGIC_VECTOR(7 downto 0);
    	data_out : out STD_LOGIC_VECTOR (0 downto 0)
    );
end component;
component Receiver is
generic (
    clk_per_bit : integer := 87     -- Needs to be set correctly
    );
Port ( clk : in  STD_LOGIC_VECTOR(0 downto 0);
	data_in : in  STD_LOGIC_VECTOR(0 downto 0);
	data_out : out  STD_LOGIC_VECTOR(7 downto 0));
end component;
	signal data_in : STD_LOGIC_VECTOR (0 downto 0):="0";
	signal temp_data_i:STD_LOGIC_VECTOR(7 downto 0):=(others=>'0');
	signal temp_data_o:STD_LOGIC_VECTOR(7 downto 0):=(others=>'0');
begin
	
	inst_trasmitter: transmitter
	generic map (clk_per_bit)
	port map(
		clk=>clk,
		start=>start,
		data_in=>data_i,
		data_out=>data_in
		);
	inst_receive : Receiver
	generic map (clk_per_bit)
	port map(
		clk=>clk,
		data_in=>data_in,
		data_out=>data_o
		);

end Behavioral;
