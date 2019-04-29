--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
--Date        : Tue Mar 26 22:02:44 2019
--Host        : saverio-UX530UX running 64-bit Ubuntu 16.04.6 LTS
--Command     : generate_target gpio_arr_wrapper.bd
--Design      : gpio_arr_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gpio_arr_wrapper is
  port (
    clk_0 : in STD_LOGIC;
    outputs_0 : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
end gpio_arr_wrapper;

architecture STRUCTURE of gpio_arr_wrapper is
  component gpio_arr is
  port (
    clk_0 : in STD_LOGIC;
    outputs_0 : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  end component gpio_arr;
begin
gpio_arr_i: component gpio_arr
     port map (
      clk_0 => clk_0,
      outputs_0(3 downto 0) => outputs_0(3 downto 0)
    );
end STRUCTURE;
