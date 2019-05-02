library ieee;
use ieee.std_logic_1164.all;

entity edge_detector is
    port (
        clk : in  std_logic;
        reset : in  std_logic;
        level : in  std_logic;
        pulse : out std_logic);
end edge_detector;

architecture rtl of edge_detector is
    signal r0_input                           : std_logic;
    signal r1_input                           : std_logic;
begin
    p_rising_edge_detector : process(clk,reset)
    begin
        if(reset='1') then
            r0_input           <= '0';
            r1_input           <= '0';
    elsif(rising_edge(clk)) then
            r0_input           <= level;
            r1_input           <= r0_input;
        end if;
        end process p_rising_edge_detector;

pulse<= not r1_input and r0_input;

end rtl;