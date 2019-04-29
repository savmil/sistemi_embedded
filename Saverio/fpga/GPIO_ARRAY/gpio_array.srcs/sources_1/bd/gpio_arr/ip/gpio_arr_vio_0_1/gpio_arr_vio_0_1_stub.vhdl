-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
-- Date        : Tue Mar 26 20:51:48 2019
-- Host        : saverio-UX530UX running 64-bit Ubuntu 16.04.6 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/saverio/GPIO_ARRAY/gpio_array.srcs/sources_1/bd/gpio_arr/ip/gpio_arr_vio_0_1/gpio_arr_vio_0_1_stub.vhdl
-- Design      : gpio_arr_vio_0_1
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gpio_arr_vio_0_1 is
  Port ( 
    clk : in STD_LOGIC;
    probe_in0 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    probe_out0 : out STD_LOGIC_VECTOR ( 3 downto 0 );
    probe_out1 : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );

end gpio_arr_vio_0_1;

architecture stub of gpio_arr_vio_0_1 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe_in0[3:0],probe_out0[3:0],probe_out1[3:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "vio,Vivado 2018.2";
begin
end;
