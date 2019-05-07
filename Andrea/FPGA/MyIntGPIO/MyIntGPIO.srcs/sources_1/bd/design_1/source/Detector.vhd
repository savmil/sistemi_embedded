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
----------------------------------------------------------------------------------
--! @file
--! @brief	Componente utilizzato per decidere quale segnale debba essere  
--! 		campionato e poi generi un segnale di interrupt
----------------------------------------------------------------------------------
--! Viene utilizzato la libreria IEEE
library IEEE;
--! Sono utilizzati i segnali della standard logic
use IEEE.STD_LOGIC_1164.ALL;
--! Viene utilizzata la libreria misc di utility
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
        clock : in std_logic; --! segnale che gestisce il clock del componente
        into_detect:  in std_logic_vector(width-1 downto 0); --! insieme di segnale da voler campionare
        mask : in std_logic_vector(width-1 downto 0); --! maschera che decide quali segnali di into_detect da campionare
        status:   out std_logic_vector(width-1 downto 0); --! identifica quali segnali hanno generato un interrupt
        trigger : out std_logic --! segnale di interrupt abilitato solo se un segnale genera interrupt e maschera è alta
    );
end Detector;

--! @brief Per la descrizione del componente riferirsi alla documentazione dell' intero design
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

    last_stage <= current_stage when rising_edge(clock);
    
    
    detected <= (last_stage xor current_stage);    
    trigger <= or_reduce(detected and mask);
    status <= detected;

end Behavioral;
