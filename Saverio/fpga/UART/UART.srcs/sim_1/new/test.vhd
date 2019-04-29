----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.04.2019 13:52:32
-- Design Name: 
-- Module Name: test - Behavioral
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
 
ENTITY Sender_Receiver_testbench IS
END Sender_Receiver_testbench;
 
ARCHITECTURE behavior OF Sender_Receiver_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Sender_receiver
    PORT(
         clk : IN  std_logic;
         start : IN  std_logic;
         reset : IN  std_logic;
         data : IN  std_logic_vector(7 downto 0);
         data_t : OUT  std_logic;
         received : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal start : std_logic := '0';
   signal reset : std_logic := '0';
   signal data : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal data_t : std_logic;
   signal received : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Sender_receiver PORT MAP (
          clk => clk,
          start => start,
          reset => reset,
          data => data,
          data_t => data_t,
          received => received
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		start<='1';
		reset<='1';
		data<="00001101";
		wait for 10 ns;
		start<='0';
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;