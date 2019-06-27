----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.04.2019 11:46:12
-- Design Name: 
-- Module Name: Detector - Behavioral
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
use ieee.std_logic_misc.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Detector is
    generic(
        width : integer := 4
    );
    port (
        clock : in std_logic;
        into_detect:  in std_logic_vector(width-1 downto 0);
        enable : in std_logic;
        mask : in std_logic_vector(width-1 downto 0);
        status:   out std_logic_vector(width-1 downto 0);
        trigger : out std_logic
    );
end Detector;

architecture Behavioral of Detector is
    signal first_stage : std_logic_vector(width-1 downto 0); -- first  sampling stage
    signal current_stage : std_logic_vector(width-1 downto 0); -- second sampling stage 
    signal last_stage : std_logic_vector(width-1 downto 0); -- last value o
    signal detected : std_logic_vector(width-1 downto 0);
    
begin

    sync: process(clock)
    begin
        if rising_edge(clock) then
            first_stage <= into_detect;
            current_stage <= first_stage;
        end if;
    end process;


--    last_stage <= current_stage when rising_edge(clock); 
    detected <= (first_stage xor current_stage);    
    trigger <= enable and (or_reduce(detected and mask));
    status <= detected;

end Behavioral;