--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
--Date        : Tue Mar 26 22:02:44 2019
--Host        : saverio-UX530UX running 64-bit Ubuntu 16.04.6 LTS
--Command     : generate_target gpio_arr.bd
--Design      : gpio_arr
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gpio_arr is
  port (
    clk_0 : in STD_LOGIC;
    outputs_0 : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of gpio_arr : entity is "gpio_arr,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=gpio_arr,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=2,numReposBlks=2,numNonXlnxBlks=1,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of gpio_arr : entity is "gpio_arr.hwdef";
end gpio_arr;

architecture STRUCTURE of gpio_arr is
  component gpio_arr_gpio_array_0_0 is
  port (
    inputs : in STD_LOGIC_VECTOR ( 3 downto 0 );
    enable : in STD_LOGIC_VECTOR ( 3 downto 0 );
    outputs : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  end component gpio_arr_gpio_array_0_0;
  component gpio_arr_vio_0_1 is
  port (
    clk : in STD_LOGIC;
    probe_in0 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    probe_out0 : out STD_LOGIC_VECTOR ( 3 downto 0 );
    probe_out1 : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  end component gpio_arr_vio_0_1;
  signal clk_0_1 : STD_LOGIC;
  signal gpio_array_0_outputs : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal vio_0_probe_out0 : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal vio_0_probe_out1 : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk_0 : signal is "xilinx.com:signal:clock:1.0 CLK.CLK_0 CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk_0 : signal is "XIL_INTERFACENAME CLK.CLK_0, CLK_DOMAIN gpio_arr_clk_0, FREQ_HZ 100000000, PHASE 0.000";
begin
  clk_0_1 <= clk_0;
  outputs_0(3 downto 0) <= gpio_array_0_outputs(3 downto 0);
gpio_array_0: component gpio_arr_gpio_array_0_0
     port map (
      enable(3 downto 0) => vio_0_probe_out1(3 downto 0),
      inputs(3 downto 0) => vio_0_probe_out0(3 downto 0),
      outputs(3 downto 0) => gpio_array_0_outputs(3 downto 0)
    );
vio_0: component gpio_arr_vio_0_1
     port map (
      clk => clk_0_1,
      probe_in0(3 downto 0) => gpio_array_0_outputs(3 downto 0),
      probe_out0(3 downto 0) => vio_0_probe_out0(3 downto 0),
      probe_out1(3 downto 0) => vio_0_probe_out1(3 downto 0)
    );
end STRUCTURE;
