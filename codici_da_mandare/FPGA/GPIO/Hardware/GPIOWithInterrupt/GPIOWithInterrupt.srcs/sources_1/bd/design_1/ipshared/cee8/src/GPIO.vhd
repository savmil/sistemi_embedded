----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.04.2019 18:49:22
-- Design Name: 
-- Module Name: GPIO - dataflow
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

entity GPIO is
     Port (
        enable : in std_logic;
        write : in std_logic;
        read : out std_logic;
        pad : inout std_logic
      );
end GPIO;

architecture dataflow of GPIO is

begin
    
    with enable select 
        pad <= write when '1',
        'Z' when others; 
        
     read <= pad;
        
end dataflow;
