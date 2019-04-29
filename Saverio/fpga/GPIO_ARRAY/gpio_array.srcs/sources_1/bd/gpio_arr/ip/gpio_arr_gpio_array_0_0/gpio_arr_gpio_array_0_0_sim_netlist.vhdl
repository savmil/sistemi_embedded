-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
-- Date        : Tue Mar 26 20:51:53 2019
-- Host        : saverio-UX530UX running 64-bit Ubuntu 16.04.6 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /home/saverio/GPIO_ARRAY/gpio_array.srcs/sources_1/bd/gpio_arr/ip/gpio_arr_gpio_array_0_0/gpio_arr_gpio_array_0_0_sim_netlist.vhdl
-- Design      : gpio_arr_gpio_array_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gpio_arr_gpio_array_0_0 is
  port (
    inputs : in STD_LOGIC_VECTOR ( 3 downto 0 );
    enable : in STD_LOGIC_VECTOR ( 3 downto 0 );
    outputs : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of gpio_arr_gpio_array_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of gpio_arr_gpio_array_0_0 : entity is "gpio_arr_gpio_array_0_0,gpio_array,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of gpio_arr_gpio_array_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of gpio_arr_gpio_array_0_0 : entity is "package_project";
  attribute x_core_info : string;
  attribute x_core_info of gpio_arr_gpio_array_0_0 : entity is "gpio_array,Vivado 2018.2";
end gpio_arr_gpio_array_0_0;

architecture STRUCTURE of gpio_arr_gpio_array_0_0 is
begin
\outputs[0]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => inputs(0),
      I1 => enable(0),
      O => outputs(0)
    );
\outputs[1]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => inputs(1),
      I1 => enable(1),
      O => outputs(1)
    );
\outputs[2]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => inputs(2),
      I1 => enable(2),
      O => outputs(2)
    );
\outputs[3]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => inputs(3),
      I1 => enable(3),
      O => outputs(3)
    );
end STRUCTURE;
