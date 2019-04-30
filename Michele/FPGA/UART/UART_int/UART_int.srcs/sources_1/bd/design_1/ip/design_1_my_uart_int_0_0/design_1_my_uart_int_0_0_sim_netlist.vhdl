-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
-- Date        : Wed May  1 00:23:23 2019
-- Host        : andrea-X580VD running 64-bit Ubuntu 18.04.2 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /home/andrea/SE_workspace/UART_int/UART_int.srcs/sources_1/bd/design_1/ip/design_1_my_uart_int_0_0/design_1_my_uart_int_0_0_sim_netlist.vhdl
-- Design      : design_1_my_uart_int_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_my_uart_int_0_0_clock_mod is
  port (
    clock_out : out STD_LOGIC;
    s00_axi_aclk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_my_uart_int_0_0_clock_mod : entity is "clock_mod";
end design_1_my_uart_int_0_0_clock_mod;

architecture STRUCTURE of design_1_my_uart_int_0_0_clock_mod is
  signal \^clock_out\ : STD_LOGIC;
  signal \clock_tmp_i_1__0_n_0\ : STD_LOGIC;
  signal clock_tmp_i_2_n_0 : STD_LOGIC;
  signal \count[0]_i_1_n_0\ : STD_LOGIC;
  signal \count[7]_i_1_n_0\ : STD_LOGIC;
  signal \count[7]_i_3_n_0\ : STD_LOGIC;
  signal \count[7]_i_4_n_0\ : STD_LOGIC;
  signal \count_reg_n_0_[0]\ : STD_LOGIC;
  signal \count_reg_n_0_[1]\ : STD_LOGIC;
  signal \count_reg_n_0_[2]\ : STD_LOGIC;
  signal \count_reg_n_0_[3]\ : STD_LOGIC;
  signal \count_reg_n_0_[4]\ : STD_LOGIC;
  signal \count_reg_n_0_[5]\ : STD_LOGIC;
  signal \count_reg_n_0_[6]\ : STD_LOGIC;
  signal \count_reg_n_0_[7]\ : STD_LOGIC;
  signal data0 : STD_LOGIC_VECTOR ( 7 downto 1 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of clock_tmp_i_2 : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \count[0]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \count[2]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \count[3]_i_1__0\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \count[4]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \count[6]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \count[7]_i_2\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \count[7]_i_3\ : label is "soft_lutpair1";
begin
  clock_out <= \^clock_out\;
\clock_tmp_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000001"
    )
        port map (
      I0 => clock_tmp_i_2_n_0,
      I1 => \count_reg_n_0_[2]\,
      I2 => \count_reg_n_0_[6]\,
      I3 => \count_reg_n_0_[4]\,
      I4 => \count_reg_n_0_[1]\,
      I5 => \^clock_out\,
      O => \clock_tmp_i_1__0_n_0\
    );
clock_tmp_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DFFF"
    )
        port map (
      I0 => \count_reg_n_0_[7]\,
      I1 => \count_reg_n_0_[3]\,
      I2 => \count_reg_n_0_[0]\,
      I3 => \count_reg_n_0_[5]\,
      O => clock_tmp_i_2_n_0
    );
clock_tmp_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \clock_tmp_i_1__0_n_0\,
      Q => \^clock_out\,
      R => '0'
    );
\count[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \count_reg_n_0_[0]\,
      O => \count[0]_i_1_n_0\
    );
\count[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \count_reg_n_0_[0]\,
      I1 => \count_reg_n_0_[1]\,
      O => data0(1)
    );
\count[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \count_reg_n_0_[0]\,
      I1 => \count_reg_n_0_[1]\,
      I2 => \count_reg_n_0_[2]\,
      O => data0(2)
    );
\count[3]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \count_reg_n_0_[1]\,
      I1 => \count_reg_n_0_[0]\,
      I2 => \count_reg_n_0_[2]\,
      I3 => \count_reg_n_0_[3]\,
      O => data0(3)
    );
\count[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => \count_reg_n_0_[2]\,
      I1 => \count_reg_n_0_[0]\,
      I2 => \count_reg_n_0_[1]\,
      I3 => \count_reg_n_0_[3]\,
      I4 => \count_reg_n_0_[4]\,
      O => data0(4)
    );
\count[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
        port map (
      I0 => \count_reg_n_0_[3]\,
      I1 => \count_reg_n_0_[1]\,
      I2 => \count_reg_n_0_[0]\,
      I3 => \count_reg_n_0_[2]\,
      I4 => \count_reg_n_0_[4]\,
      I5 => \count_reg_n_0_[5]\,
      O => data0(5)
    );
\count[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \count[7]_i_4_n_0\,
      I1 => \count_reg_n_0_[6]\,
      O => data0(6)
    );
\count[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00004000"
    )
        port map (
      I0 => \count_reg_n_0_[6]\,
      I1 => \count_reg_n_0_[5]\,
      I2 => \count_reg_n_0_[0]\,
      I3 => \count_reg_n_0_[7]\,
      I4 => \count[7]_i_3_n_0\,
      O => \count[7]_i_1_n_0\
    );
\count[7]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \count[7]_i_4_n_0\,
      I1 => \count_reg_n_0_[6]\,
      I2 => \count_reg_n_0_[7]\,
      O => data0(7)
    );
\count[7]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \count_reg_n_0_[2]\,
      I1 => \count_reg_n_0_[3]\,
      I2 => \count_reg_n_0_[4]\,
      I3 => \count_reg_n_0_[1]\,
      O => \count[7]_i_3_n_0\
    );
\count[7]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => \count_reg_n_0_[5]\,
      I1 => \count_reg_n_0_[3]\,
      I2 => \count_reg_n_0_[1]\,
      I3 => \count_reg_n_0_[0]\,
      I4 => \count_reg_n_0_[2]\,
      I5 => \count_reg_n_0_[4]\,
      O => \count[7]_i_4_n_0\
    );
\count_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \count[0]_i_1_n_0\,
      Q => \count_reg_n_0_[0]\,
      R => \count[7]_i_1_n_0\
    );
\count_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => '1',
      D => data0(1),
      Q => \count_reg_n_0_[1]\,
      R => \count[7]_i_1_n_0\
    );
\count_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => '1',
      D => data0(2),
      Q => \count_reg_n_0_[2]\,
      R => \count[7]_i_1_n_0\
    );
\count_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => '1',
      D => data0(3),
      Q => \count_reg_n_0_[3]\,
      R => \count[7]_i_1_n_0\
    );
\count_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => '1',
      D => data0(4),
      Q => \count_reg_n_0_[4]\,
      R => \count[7]_i_1_n_0\
    );
\count_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => '1',
      D => data0(5),
      Q => \count_reg_n_0_[5]\,
      R => \count[7]_i_1_n_0\
    );
\count_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => '1',
      D => data0(6),
      Q => \count_reg_n_0_[6]\,
      R => \count[7]_i_1_n_0\
    );
\count_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => '1',
      D => data0(7),
      Q => \count_reg_n_0_[7]\,
      R => \count[7]_i_1_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \design_1_my_uart_int_0_0_clock_mod__parameterized1\ is
  port (
    tx_clock : out STD_LOGIC;
    clock_out : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \design_1_my_uart_int_0_0_clock_mod__parameterized1\ : entity is "clock_mod";
end \design_1_my_uart_int_0_0_clock_mod__parameterized1\;

architecture STRUCTURE of \design_1_my_uart_int_0_0_clock_mod__parameterized1\ is
  signal clock_tmp_i_1_n_0 : STD_LOGIC;
  signal count : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \count[0]_i_1_n_0\ : STD_LOGIC;
  signal \count[1]_i_1_n_0\ : STD_LOGIC;
  signal \count[2]_i_1_n_0\ : STD_LOGIC;
  signal \count[3]_i_1__1_n_0\ : STD_LOGIC;
  signal \count[3]_i_2_n_0\ : STD_LOGIC;
  signal \^tx_clock\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \count[0]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \count[1]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \count[2]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \count[3]_i_2\ : label is "soft_lutpair17";
begin
  tx_clock <= \^tx_clock\;
clock_tmp_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0004"
    )
        port map (
      I0 => count(0),
      I1 => count(3),
      I2 => count(1),
      I3 => count(2),
      I4 => \^tx_clock\,
      O => clock_tmp_i_1_n_0
    );
clock_tmp_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => '1',
      D => clock_tmp_i_1_n_0,
      Q => \^tx_clock\,
      R => '0'
    );
\count[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => count(0),
      O => \count[0]_i_1_n_0\
    );
\count[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(0),
      I1 => count(1),
      O => \count[1]_i_1_n_0\
    );
\count[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => count(0),
      I1 => count(1),
      I2 => count(2),
      O => \count[2]_i_1_n_0\
    );
\count[3]_i_1__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0002"
    )
        port map (
      I0 => count(3),
      I1 => count(2),
      I2 => count(0),
      I3 => count(1),
      O => \count[3]_i_1__1_n_0\
    );
\count[3]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => count(1),
      I1 => count(0),
      I2 => count(2),
      I3 => count(3),
      O => \count[3]_i_2_n_0\
    );
\count_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => '1',
      D => \count[0]_i_1_n_0\,
      Q => count(0),
      R => \count[3]_i_1__1_n_0\
    );
\count_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => '1',
      D => \count[1]_i_1_n_0\,
      Q => count(1),
      R => \count[3]_i_1__1_n_0\
    );
\count_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => '1',
      D => \count[2]_i_1_n_0\,
      Q => count(2),
      R => \count[3]_i_1__1_n_0\
    );
\count_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => '1',
      D => \count[3]_i_2_n_0\,
      Q => count(3),
      R => \count[3]_i_1__1_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_my_uart_int_0_0_counter_modN is
  port (
    r1_input_reg : out STD_LOGIC;
    tx_clock : in STD_LOGIC;
    current_state : in STD_LOGIC_VECTOR ( 1 downto 0 );
    r1_input : in STD_LOGIC;
    r0_input : in STD_LOGIC;
    s00_axi_aresetn : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_my_uart_int_0_0_counter_modN : entity is "counter_modN";
end design_1_my_uart_int_0_0_counter_modN;

architecture STRUCTURE of design_1_my_uart_int_0_0_counter_modN is
  signal count : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \count[0]_i_1__0_n_0\ : STD_LOGIC;
  signal \count[1]_i_1_n_0\ : STD_LOGIC;
  signal \count[2]_i_1_n_0\ : STD_LOGIC;
  signal \count[3]_i_2_n_0\ : STD_LOGIC;
  signal \counter_hit__0\ : STD_LOGIC;
  signal counter_hit_n_0 : STD_LOGIC;
  signal reset_counter : STD_LOGIC;
  signal shift_en : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \count[0]_i_1__0\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \count[1]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \count[3]_i_2\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of counter_hit : label is "soft_lutpair13";
begin
\FSM_sequential_current_state[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00F4000400000000"
    )
        port map (
      I0 => r1_input,
      I1 => r0_input,
      I2 => current_state(1),
      I3 => current_state(0),
      I4 => \counter_hit__0\,
      I5 => s00_axi_aresetn,
      O => r1_input_reg
    );
\count[0]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00BF"
    )
        port map (
      I0 => count(2),
      I1 => count(3),
      I2 => count(1),
      I3 => count(0),
      O => \count[0]_i_1__0_n_0\
    );
\count[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"23CC"
    )
        port map (
      I0 => count(2),
      I1 => count(0),
      I2 => count(3),
      I3 => count(1),
      O => \count[1]_i_1_n_0\
    );
\count[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => count(2),
      I1 => count(0),
      I2 => count(1),
      O => \count[2]_i_1_n_0\
    );
\count[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => current_state(1),
      I1 => current_state(0),
      O => shift_en
    );
\count[3]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"68F0"
    )
        port map (
      I0 => count(2),
      I1 => count(0),
      I2 => count(3),
      I3 => count(1),
      O => \count[3]_i_2_n_0\
    );
\count[3]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      O => reset_counter
    );
\count_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => tx_clock,
      CE => shift_en,
      CLR => reset_counter,
      D => \count[0]_i_1__0_n_0\,
      Q => count(0)
    );
\count_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => tx_clock,
      CE => shift_en,
      CLR => reset_counter,
      D => \count[1]_i_1_n_0\,
      Q => count(1)
    );
\count_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => tx_clock,
      CE => shift_en,
      CLR => reset_counter,
      D => \count[2]_i_1_n_0\,
      Q => count(2)
    );
\count_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => tx_clock,
      CE => shift_en,
      CLR => reset_counter,
      D => \count[3]_i_2_n_0\,
      Q => count(3)
    );
counter_hit: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1000"
    )
        port map (
      I0 => count(2),
      I1 => count(0),
      I2 => count(3),
      I3 => count(1),
      O => counter_hit_n_0
    );
counter_hit_reg: unisim.vcomponents.FDCE
     port map (
      C => tx_clock,
      CE => shift_en,
      CLR => reset_counter,
      D => counter_hit_n_0,
      Q => \counter_hit__0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \design_1_my_uart_int_0_0_counter_modN__parameterized1\ is
  port (
    counter_hit : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 0 to 0 );
    Q : in STD_LOGIC_VECTOR ( 2 downto 0 );
    clock_out : in STD_LOGIC;
    AR : in STD_LOGIC_VECTOR ( 0 to 0 );
    rx : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \design_1_my_uart_int_0_0_counter_modN__parameterized1\ : entity is "counter_modN";
end \design_1_my_uart_int_0_0_counter_modN__parameterized1\;

architecture STRUCTURE of \design_1_my_uart_int_0_0_counter_modN__parameterized1\ is
  signal count : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \count[0]_i_1__1_n_0\ : STD_LOGIC;
  signal \count[1]_i_1_n_0\ : STD_LOGIC;
  signal \count[2]_i_1_n_0\ : STD_LOGIC;
  signal \^counter_hit\ : STD_LOGIC;
  signal \counter_hit__0_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \count[0]_i_1__1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \count[1]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \count[2]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \counter_hit__0\ : label is "soft_lutpair9";
begin
  counter_hit <= \^counter_hit\;
\FSM_onehot_current_state[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"54FF5454"
    )
        port map (
      I0 => rx,
      I1 => Q(0),
      I2 => Q(2),
      I3 => \^counter_hit\,
      I4 => Q(1),
      O => D(0)
    );
\count[0]_i_1__1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => count(0),
      O => \count[0]_i_1__1_n_0\
    );
\count[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(1),
      I1 => count(0),
      O => \count[1]_i_1_n_0\
    );
\count[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6C"
    )
        port map (
      I0 => count(1),
      I1 => count(2),
      I2 => count(0),
      O => \count[2]_i_1_n_0\
    );
\count_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => Q(1),
      CLR => AR(0),
      D => \count[0]_i_1__1_n_0\,
      Q => count(0)
    );
\count_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => Q(1),
      CLR => AR(0),
      D => \count[1]_i_1_n_0\,
      Q => count(1)
    );
\count_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => Q(1),
      CLR => AR(0),
      D => \count[2]_i_1_n_0\,
      Q => count(2)
    );
\counter_hit__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => count(1),
      I1 => count(2),
      I2 => count(0),
      O => \counter_hit__0_n_0\
    );
counter_hit_reg: unisim.vcomponents.FDCE
     port map (
      C => clock_out,
      CE => Q(1),
      CLR => AR(0),
      D => \counter_hit__0_n_0\,
      Q => \^counter_hit\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \design_1_my_uart_int_0_0_counter_modN__parameterized3\ is
  port (
    D : out STD_LOGIC_VECTOR ( 1 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 4 downto 0 );
    clock_out : in STD_LOGIC;
    done_bit_count : in STD_LOGIC;
    counter_hit : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \design_1_my_uart_int_0_0_counter_modN__parameterized3\ : entity is "counter_modN";
end \design_1_my_uart_int_0_0_counter_modN__parameterized3\;

architecture STRUCTURE of \design_1_my_uart_int_0_0_counter_modN__parameterized3\ is
  signal count : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \count[0]_i_1__2_n_0\ : STD_LOGIC;
  signal \count[1]_i_1_n_0\ : STD_LOGIC;
  signal \count[2]_i_1_n_0\ : STD_LOGIC;
  signal \count[3]_i_1_n_0\ : STD_LOGIC;
  signal \counter_hit__0_n_0\ : STD_LOGIC;
  signal done_16count : STD_LOGIC;
  signal reset_16count : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \count[1]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \count[2]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \count[3]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \counter_hit__0\ : label is "soft_lutpair7";
begin
\FSM_onehot_current_state[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF22F222F222F2"
    )
        port map (
      I0 => Q(2),
      I1 => done_16count,
      I2 => Q(3),
      I3 => done_bit_count,
      I4 => counter_hit,
      I5 => Q(1),
      O => D(0)
    );
\FSM_onehot_current_state[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => Q(2),
      I1 => done_16count,
      O => D(1)
    );
\count[0]_i_1__2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => count(0),
      O => \count[0]_i_1__2_n_0\
    );
\count[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(1),
      I1 => count(0),
      O => \count[1]_i_1_n_0\
    );
\count[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => count(1),
      I1 => count(0),
      I2 => count(2),
      O => \count[2]_i_1_n_0\
    );
\count[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => count(1),
      I1 => count(0),
      I2 => count(2),
      I3 => count(3),
      O => \count[3]_i_1_n_0\
    );
\count[3]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => Q(4),
      I1 => Q(0),
      I2 => Q(3),
      O => reset_16count
    );
\count_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => Q(2),
      CLR => reset_16count,
      D => \count[0]_i_1__2_n_0\,
      Q => count(0)
    );
\count_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => Q(2),
      CLR => reset_16count,
      D => \count[1]_i_1_n_0\,
      Q => count(1)
    );
\count_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => Q(2),
      CLR => reset_16count,
      D => \count[2]_i_1_n_0\,
      Q => count(2)
    );
\count_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => Q(2),
      CLR => reset_16count,
      D => \count[3]_i_1_n_0\,
      Q => count(3)
    );
\counter_hit__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => count(1),
      I1 => count(0),
      I2 => count(2),
      I3 => count(3),
      O => \counter_hit__0_n_0\
    );
counter_hit_reg: unisim.vcomponents.FDCE
     port map (
      C => clock_out,
      CE => Q(2),
      CLR => reset_16count,
      D => \counter_hit__0_n_0\,
      Q => done_16count
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \design_1_my_uart_int_0_0_counter_modN__parameterized5\ is
  port (
    done_bit_count : out STD_LOGIC;
    AR : out STD_LOGIC_VECTOR ( 0 to 0 );
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    D : out STD_LOGIC_VECTOR ( 0 to 0 );
    Q : in STD_LOGIC_VECTOR ( 2 downto 0 );
    clock_out : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \design_1_my_uart_int_0_0_counter_modN__parameterized5\ : entity is "counter_modN";
end \design_1_my_uart_int_0_0_counter_modN__parameterized5\;

architecture STRUCTURE of \design_1_my_uart_int_0_0_counter_modN__parameterized5\ is
  signal \^ar\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal count : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \count[0]_i_1__3_n_0\ : STD_LOGIC;
  signal \count[1]_i_1_n_0\ : STD_LOGIC;
  signal \count[2]_i_1_n_0\ : STD_LOGIC;
  signal \count[3]_i_1_n_0\ : STD_LOGIC;
  signal counter_hit_n_0 : STD_LOGIC;
  signal \^done_bit_count\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_onehot_current_state[4]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \count[1]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \count[2]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \count[3]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of counter_hit : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \tmp_sig[9]_i_1__0\ : label is "soft_lutpair6";
begin
  AR(0) <= \^ar\(0);
  done_bit_count <= \^done_bit_count\;
\FSM_onehot_current_state[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => Q(1),
      I1 => \^done_bit_count\,
      O => D(0)
    );
\count[0]_i_1__3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => count(0),
      O => \count[0]_i_1__3_n_0\
    );
\count[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"23CC"
    )
        port map (
      I0 => count(2),
      I1 => count(1),
      I2 => count(3),
      I3 => count(0),
      O => \count[1]_i_1_n_0\
    );
\count[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => count(2),
      I1 => count(1),
      I2 => count(0),
      O => \count[2]_i_1_n_0\
    );
\count[2]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => Q(0),
      I1 => Q(2),
      O => \^ar\(0)
    );
\count[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"68F0"
    )
        port map (
      I0 => count(2),
      I1 => count(1),
      I2 => count(3),
      I3 => count(0),
      O => \count[3]_i_1_n_0\
    );
\count_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => Q(1),
      CLR => \^ar\(0),
      D => \count[0]_i_1__3_n_0\,
      Q => count(0)
    );
\count_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => Q(1),
      CLR => \^ar\(0),
      D => \count[1]_i_1_n_0\,
      Q => count(1)
    );
\count_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => Q(1),
      CLR => \^ar\(0),
      D => \count[2]_i_1_n_0\,
      Q => count(2)
    );
\count_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => Q(1),
      CLR => \^ar\(0),
      D => \count[3]_i_1_n_0\,
      Q => count(3)
    );
counter_hit: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1000"
    )
        port map (
      I0 => count(2),
      I1 => count(1),
      I2 => count(3),
      I3 => count(0),
      O => counter_hit_n_0
    );
counter_hit_reg: unisim.vcomponents.FDCE
     port map (
      C => clock_out,
      CE => Q(1),
      CLR => \^ar\(0),
      D => counter_hit_n_0,
      Q => \^done_bit_count\
    );
\tmp_sig[9]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Q(1),
      I1 => \^done_bit_count\,
      O => E(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_my_uart_int_0_0_d_ff_register is
  port (
    D : out STD_LOGIC_VECTOR ( 4 downto 0 );
    \q_reg[4]_0\ : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \axi_araddr_reg[3]\ : out STD_LOGIC;
    \axi_rdata_reg[7]\ : in STD_LOGIC_VECTOR ( 4 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 4 downto 0 );
    axi_araddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \q_reg[7]_0\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    \q_reg[7]_1\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s00_axi_aclk : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_my_uart_int_0_0_d_ff_register : entity is "d_ff_register";
end design_1_my_uart_int_0_0_d_ff_register;

architecture STRUCTURE of design_1_my_uart_int_0_0_d_ff_register is
  signal slv_reg3_out : STD_LOGIC_VECTOR ( 7 downto 0 );
begin
\axi_rdata[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F000CCAA"
    )
        port map (
      I0 => \axi_rdata_reg[7]\(0),
      I1 => Q(0),
      I2 => slv_reg3_out(0),
      I3 => axi_araddr(0),
      I4 => axi_araddr(1),
      O => D(0)
    );
\axi_rdata[2]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => axi_araddr(1),
      I1 => axi_araddr(0),
      I2 => slv_reg3_out(2),
      O => \axi_araddr_reg[3]\
    );
\axi_rdata[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F000CCAA"
    )
        port map (
      I0 => \axi_rdata_reg[7]\(1),
      I1 => Q(1),
      I2 => slv_reg3_out(3),
      I3 => axi_araddr(0),
      I4 => axi_araddr(1),
      O => D(1)
    );
\axi_rdata[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F000CCAA"
    )
        port map (
      I0 => \axi_rdata_reg[7]\(2),
      I1 => Q(2),
      I2 => slv_reg3_out(5),
      I3 => axi_araddr(0),
      I4 => axi_araddr(1),
      O => D(2)
    );
\axi_rdata[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F000CCAA"
    )
        port map (
      I0 => \axi_rdata_reg[7]\(3),
      I1 => Q(3),
      I2 => slv_reg3_out(6),
      I3 => axi_araddr(0),
      I4 => axi_araddr(1),
      O => D(3)
    );
\axi_rdata[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F000CCAA"
    )
        port map (
      I0 => \axi_rdata_reg[7]\(4),
      I1 => Q(4),
      I2 => slv_reg3_out(7),
      I3 => axi_araddr(0),
      I4 => axi_araddr(1),
      O => D(4)
    );
\q_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => s00_axi_aclk,
      CE => \q_reg[7]_0\(0),
      CLR => SR(0),
      D => \q_reg[7]_1\(0),
      Q => slv_reg3_out(0)
    );
\q_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => s00_axi_aclk,
      CE => \q_reg[7]_0\(0),
      CLR => SR(0),
      D => \q_reg[7]_1\(1),
      Q => \q_reg[4]_0\(0)
    );
\q_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => s00_axi_aclk,
      CE => \q_reg[7]_0\(0),
      CLR => SR(0),
      D => \q_reg[7]_1\(2),
      Q => slv_reg3_out(2)
    );
\q_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => s00_axi_aclk,
      CE => \q_reg[7]_0\(0),
      CLR => SR(0),
      D => \q_reg[7]_1\(3),
      Q => slv_reg3_out(3)
    );
\q_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => s00_axi_aclk,
      CE => \q_reg[7]_0\(0),
      CLR => SR(0),
      D => \q_reg[7]_1\(4),
      Q => \q_reg[4]_0\(1)
    );
\q_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => s00_axi_aclk,
      CE => \q_reg[7]_0\(0),
      CLR => SR(0),
      D => \q_reg[7]_1\(5),
      Q => slv_reg3_out(5)
    );
\q_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => s00_axi_aclk,
      CE => \q_reg[7]_0\(0),
      CLR => SR(0),
      D => \q_reg[7]_1\(6),
      Q => slv_reg3_out(6)
    );
\q_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => s00_axi_aclk,
      CE => \q_reg[7]_0\(0),
      CLR => SR(0),
      D => \q_reg[7]_1\(7),
      Q => slv_reg3_out(7)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_my_uart_int_0_0_edge_detector is
  port (
    reset : out STD_LOGIC;
    rda_to_intr_0 : out STD_LOGIC;
    rda_to_intr : in STD_LOGIC;
    s_axi_intr_aclk : in STD_LOGIC;
    s_axi_intr_aresetn : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_my_uart_int_0_0_edge_detector : entity is "edge_detector";
end design_1_my_uart_int_0_0_edge_detector;

architecture STRUCTURE of design_1_my_uart_int_0_0_edge_detector is
  signal r0_input : STD_LOGIC;
  signal r1_input : STD_LOGIC;
  signal \^reset\ : STD_LOGIC;
begin
  reset <= \^reset\;
\axi_awready_i_1__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => s_axi_intr_aresetn,
      O => \^reset\
    );
\gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.intr_ff[1]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => r0_input,
      I1 => r1_input,
      O => rda_to_intr_0
    );
r0_input_reg: unisim.vcomponents.FDCE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      CLR => \^reset\,
      D => rda_to_intr,
      Q => r0_input
    );
r1_input_reg: unisim.vcomponents.FDCE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      CLR => \^reset\,
      D => r0_input,
      Q => r1_input
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_my_uart_int_0_0_edge_detector_0 is
  port (
    r0_input : out STD_LOGIC;
    r1_input : out STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    tx_clock : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_my_uart_int_0_0_edge_detector_0 : entity is "edge_detector";
end design_1_my_uart_int_0_0_edge_detector_0;

architecture STRUCTURE of design_1_my_uart_int_0_0_edge_detector_0 is
  signal \^r0_input\ : STD_LOGIC;
begin
  r0_input <= \^r0_input\;
r0_input_reg: unisim.vcomponents.FDCE
     port map (
      C => tx_clock,
      CE => '1',
      CLR => SR(0),
      D => Q(0),
      Q => \^r0_input\
    );
r1_input_reg: unisim.vcomponents.FDCE
     port map (
      C => tx_clock,
      CE => '1',
      CLR => SR(0),
      D => \^r0_input\,
      Q => r1_input
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_my_uart_int_0_0_shift_register is
  port (
    tx : out STD_LOGIC;
    current_state : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \tmp_sig_reg[8]_0\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    SS : in STD_LOGIC_VECTOR ( 0 to 0 );
    tx_clock : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_my_uart_int_0_0_shift_register : entity is "shift_register";
end design_1_my_uart_int_0_0_shift_register;

architecture STRUCTURE of design_1_my_uart_int_0_0_shift_register is
  signal \tmp_sig[0]_i_2_n_0\ : STD_LOGIC;
  signal \tmp_sig[0]_i_3_n_0\ : STD_LOGIC;
  signal \tmp_sig[1]_i_1_n_0\ : STD_LOGIC;
  signal \tmp_sig[2]_i_1_n_0\ : STD_LOGIC;
  signal \tmp_sig[3]_i_1_n_0\ : STD_LOGIC;
  signal \tmp_sig[4]_i_1_n_0\ : STD_LOGIC;
  signal \tmp_sig[5]_i_1_n_0\ : STD_LOGIC;
  signal \tmp_sig[6]_i_1_n_0\ : STD_LOGIC;
  signal \tmp_sig[7]_i_1_n_0\ : STD_LOGIC;
  signal \tmp_sig[8]_i_1_n_0\ : STD_LOGIC;
  signal \tmp_sig[9]_i_1_n_0\ : STD_LOGIC;
  signal \tmp_sig[9]_i_2_n_0\ : STD_LOGIC;
  signal \tmp_sig[9]_i_3_n_0\ : STD_LOGIC;
  signal \tmp_sig_reg_n_0_[1]\ : STD_LOGIC;
  signal \tmp_sig_reg_n_0_[2]\ : STD_LOGIC;
  signal \tmp_sig_reg_n_0_[3]\ : STD_LOGIC;
  signal \tmp_sig_reg_n_0_[4]\ : STD_LOGIC;
  signal \tmp_sig_reg_n_0_[5]\ : STD_LOGIC;
  signal \tmp_sig_reg_n_0_[6]\ : STD_LOGIC;
  signal \tmp_sig_reg_n_0_[7]\ : STD_LOGIC;
  signal \tmp_sig_reg_n_0_[8]\ : STD_LOGIC;
  signal \tmp_sig_reg_n_0_[9]\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \tmp_sig[0]_i_3\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \tmp_sig[1]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \tmp_sig[2]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \tmp_sig[9]_i_3\ : label is "soft_lutpair15";
begin
\tmp_sig[0]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => current_state(1),
      I1 => current_state(0),
      O => \tmp_sig[0]_i_2_n_0\
    );
\tmp_sig[0]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => \tmp_sig_reg_n_0_[1]\,
      I1 => current_state(1),
      I2 => current_state(0),
      O => \tmp_sig[0]_i_3_n_0\
    );
\tmp_sig[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \tmp_sig_reg[8]_0\(0),
      I1 => current_state(0),
      I2 => current_state(1),
      I3 => \tmp_sig_reg_n_0_[2]\,
      O => \tmp_sig[1]_i_1_n_0\
    );
\tmp_sig[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \tmp_sig_reg[8]_0\(1),
      I1 => current_state(0),
      I2 => current_state(1),
      I3 => \tmp_sig_reg_n_0_[3]\,
      O => \tmp_sig[2]_i_1_n_0\
    );
\tmp_sig[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \tmp_sig_reg[8]_0\(2),
      I1 => current_state(0),
      I2 => current_state(1),
      I3 => \tmp_sig_reg_n_0_[4]\,
      O => \tmp_sig[3]_i_1_n_0\
    );
\tmp_sig[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \tmp_sig_reg[8]_0\(3),
      I1 => current_state(0),
      I2 => current_state(1),
      I3 => \tmp_sig_reg_n_0_[5]\,
      O => \tmp_sig[4]_i_1_n_0\
    );
\tmp_sig[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \tmp_sig_reg[8]_0\(4),
      I1 => current_state(0),
      I2 => current_state(1),
      I3 => \tmp_sig_reg_n_0_[6]\,
      O => \tmp_sig[5]_i_1_n_0\
    );
\tmp_sig[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \tmp_sig_reg[8]_0\(5),
      I1 => current_state(0),
      I2 => current_state(1),
      I3 => \tmp_sig_reg_n_0_[7]\,
      O => \tmp_sig[6]_i_1_n_0\
    );
\tmp_sig[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \tmp_sig_reg[8]_0\(6),
      I1 => current_state(0),
      I2 => current_state(1),
      I3 => \tmp_sig_reg_n_0_[8]\,
      O => \tmp_sig[7]_i_1_n_0\
    );
\tmp_sig[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \tmp_sig_reg[8]_0\(7),
      I1 => current_state(0),
      I2 => current_state(1),
      I3 => \tmp_sig_reg_n_0_[9]\,
      O => \tmp_sig[8]_i_1_n_0\
    );
\tmp_sig[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"69969669FFFFFFFF"
    )
        port map (
      I0 => \tmp_sig[9]_i_2_n_0\,
      I1 => \tmp_sig_reg[8]_0\(6),
      I2 => \tmp_sig_reg[8]_0\(3),
      I3 => \tmp_sig_reg[8]_0\(5),
      I4 => \tmp_sig_reg[8]_0\(7),
      I5 => \tmp_sig[9]_i_3_n_0\,
      O => \tmp_sig[9]_i_1_n_0\
    );
\tmp_sig[9]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => \tmp_sig_reg[8]_0\(4),
      I1 => \tmp_sig_reg[8]_0\(0),
      I2 => \tmp_sig_reg[8]_0\(2),
      I3 => \tmp_sig_reg[8]_0\(1),
      O => \tmp_sig[9]_i_2_n_0\
    );
\tmp_sig[9]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      O => \tmp_sig[9]_i_3_n_0\
    );
\tmp_sig_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => tx_clock,
      CE => \tmp_sig[0]_i_2_n_0\,
      D => \tmp_sig[0]_i_3_n_0\,
      Q => tx,
      S => SS(0)
    );
\tmp_sig_reg[1]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => tx_clock,
      CE => \tmp_sig[0]_i_2_n_0\,
      D => \tmp_sig[1]_i_1_n_0\,
      Q => \tmp_sig_reg_n_0_[1]\,
      S => SS(0)
    );
\tmp_sig_reg[2]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => tx_clock,
      CE => \tmp_sig[0]_i_2_n_0\,
      D => \tmp_sig[2]_i_1_n_0\,
      Q => \tmp_sig_reg_n_0_[2]\,
      S => SS(0)
    );
\tmp_sig_reg[3]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => tx_clock,
      CE => \tmp_sig[0]_i_2_n_0\,
      D => \tmp_sig[3]_i_1_n_0\,
      Q => \tmp_sig_reg_n_0_[3]\,
      S => SS(0)
    );
\tmp_sig_reg[4]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => tx_clock,
      CE => \tmp_sig[0]_i_2_n_0\,
      D => \tmp_sig[4]_i_1_n_0\,
      Q => \tmp_sig_reg_n_0_[4]\,
      S => SS(0)
    );
\tmp_sig_reg[5]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => tx_clock,
      CE => \tmp_sig[0]_i_2_n_0\,
      D => \tmp_sig[5]_i_1_n_0\,
      Q => \tmp_sig_reg_n_0_[5]\,
      S => SS(0)
    );
\tmp_sig_reg[6]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => tx_clock,
      CE => \tmp_sig[0]_i_2_n_0\,
      D => \tmp_sig[6]_i_1_n_0\,
      Q => \tmp_sig_reg_n_0_[6]\,
      S => SS(0)
    );
\tmp_sig_reg[7]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => tx_clock,
      CE => \tmp_sig[0]_i_2_n_0\,
      D => \tmp_sig[7]_i_1_n_0\,
      Q => \tmp_sig_reg_n_0_[7]\,
      S => SS(0)
    );
\tmp_sig_reg[8]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => tx_clock,
      CE => \tmp_sig[0]_i_2_n_0\,
      D => \tmp_sig[8]_i_1_n_0\,
      Q => \tmp_sig_reg_n_0_[8]\,
      S => SS(0)
    );
\tmp_sig_reg[9]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => tx_clock,
      CE => \tmp_sig[0]_i_2_n_0\,
      D => \tmp_sig[9]_i_1_n_0\,
      Q => \tmp_sig_reg_n_0_[9]\,
      S => SS(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_my_uart_int_0_0_shift_register_SIPO is
  port (
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    D : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \tmp_sig_reg[7]_0\ : out STD_LOGIC_VECTOR ( 7 downto 0 );
    s00_axi_aresetn : in STD_LOGIC;
    axi_araddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \axi_rdata_reg[1]\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    \axi_rdata_reg[2]\ : in STD_LOGIC;
    \axi_rdata_reg[2]_0\ : in STD_LOGIC;
    \axi_rdata_reg[2]_1\ : in STD_LOGIC;
    \axi_rdata_reg[1]_0\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    \axi_rdata_reg[1]_1\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    rx : in STD_LOGIC;
    clock_out : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_my_uart_int_0_0_shift_register_SIPO : entity is "shift_register_SIPO";
end design_1_my_uart_int_0_0_shift_register_SIPO;

architecture STRUCTURE of design_1_my_uart_int_0_0_shift_register_SIPO is
  signal \^sr\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \axi_rdata[1]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[2]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[2]_i_4_n_0\ : STD_LOGIC;
  signal rx_frame : STD_LOGIC_VECTOR ( 8 to 8 );
  signal \^tmp_sig_reg[7]_0\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \tmp_sig_reg_n_0_[9]\ : STD_LOGIC;
begin
  SR(0) <= \^sr\(0);
  \tmp_sig_reg[7]_0\(7 downto 0) <= \^tmp_sig_reg[7]_0\(7 downto 0);
\axi_rdata[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBBAABAA"
    )
        port map (
      I0 => \axi_rdata[1]_i_2_n_0\,
      I1 => axi_araddr(1),
      I2 => axi_araddr(0),
      I3 => \axi_rdata_reg[1]\(0),
      I4 => Q(0),
      O => D(0)
    );
\axi_rdata[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAA000000FC0000"
    )
        port map (
      I0 => \axi_rdata_reg[1]_0\(0),
      I1 => \axi_rdata_reg[1]_1\(0),
      I2 => \axi_rdata_reg[1]_1\(1),
      I3 => \tmp_sig_reg_n_0_[9]\,
      I4 => axi_araddr(1),
      I5 => axi_araddr(0),
      O => \axi_rdata[1]_i_2_n_0\
    );
\axi_rdata[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF2882"
    )
        port map (
      I0 => \axi_rdata_reg[2]\,
      I1 => \axi_rdata[2]_i_3_n_0\,
      I2 => \axi_rdata[2]_i_4_n_0\,
      I3 => \^tmp_sig_reg[7]_0\(7),
      I4 => \axi_rdata_reg[2]_0\,
      I5 => \axi_rdata_reg[2]_1\,
      O => D(1)
    );
\axi_rdata[2]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => \^tmp_sig_reg[7]_0\(3),
      I1 => \^tmp_sig_reg[7]_0\(1),
      I2 => \^tmp_sig_reg[7]_0\(6),
      I3 => \^tmp_sig_reg[7]_0\(5),
      O => \axi_rdata[2]_i_3_n_0\
    );
\axi_rdata[2]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => rx_frame(8),
      I1 => \^tmp_sig_reg[7]_0\(0),
      I2 => \^tmp_sig_reg[7]_0\(4),
      I3 => \^tmp_sig_reg[7]_0\(2),
      O => \axi_rdata[2]_i_4_n_0\
    );
\tmp_sig[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => s00_axi_aresetn,
      O => \^sr\(0)
    );
\tmp_sig_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => E(0),
      D => \^tmp_sig_reg[7]_0\(1),
      Q => \^tmp_sig_reg[7]_0\(0),
      R => \^sr\(0)
    );
\tmp_sig_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => E(0),
      D => \^tmp_sig_reg[7]_0\(2),
      Q => \^tmp_sig_reg[7]_0\(1),
      R => \^sr\(0)
    );
\tmp_sig_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => E(0),
      D => \^tmp_sig_reg[7]_0\(3),
      Q => \^tmp_sig_reg[7]_0\(2),
      R => \^sr\(0)
    );
\tmp_sig_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => E(0),
      D => \^tmp_sig_reg[7]_0\(4),
      Q => \^tmp_sig_reg[7]_0\(3),
      R => \^sr\(0)
    );
\tmp_sig_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => E(0),
      D => \^tmp_sig_reg[7]_0\(5),
      Q => \^tmp_sig_reg[7]_0\(4),
      R => \^sr\(0)
    );
\tmp_sig_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => E(0),
      D => \^tmp_sig_reg[7]_0\(6),
      Q => \^tmp_sig_reg[7]_0\(5),
      R => \^sr\(0)
    );
\tmp_sig_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => E(0),
      D => \^tmp_sig_reg[7]_0\(7),
      Q => \^tmp_sig_reg[7]_0\(6),
      R => \^sr\(0)
    );
\tmp_sig_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => E(0),
      D => rx_frame(8),
      Q => \^tmp_sig_reg[7]_0\(7),
      R => \^sr\(0)
    );
\tmp_sig_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => E(0),
      D => \tmp_sig_reg_n_0_[9]\,
      Q => rx_frame(8),
      R => \^sr\(0)
    );
\tmp_sig_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => E(0),
      D => rx,
      Q => \tmp_sig_reg_n_0_[9]\,
      R => \^sr\(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_my_uart_int_0_0_my_uart_int_v1_0_S_AXI_INTR is
  port (
    axi_wready_reg_0 : out STD_LOGIC;
    axi_awready_reg_0 : out STD_LOGIC;
    axi_arready_reg_0 : out STD_LOGIC;
    irq : out STD_LOGIC;
    s_axi_intr_bvalid : out STD_LOGIC;
    s_axi_intr_rvalid : out STD_LOGIC;
    s_axi_intr_rdata : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_intr_aclk : in STD_LOGIC;
    rda_to_intr : in STD_LOGIC;
    tx_busy_to_intr : in STD_LOGIC;
    s_axi_intr_aresetn : in STD_LOGIC;
    s_axi_intr_wvalid : in STD_LOGIC;
    s_axi_intr_awvalid : in STD_LOGIC;
    s_axi_intr_bready : in STD_LOGIC;
    s_axi_intr_arvalid : in STD_LOGIC;
    s_axi_intr_rready : in STD_LOGIC;
    s_axi_intr_wdata : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_intr_awaddr : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_intr_araddr : in STD_LOGIC_VECTOR ( 2 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_my_uart_int_0_0_my_uart_int_v1_0_S_AXI_INTR : entity is "my_uart_int_v1_0_S_AXI_INTR";
end design_1_my_uart_int_0_0_my_uart_int_v1_0_S_AXI_INTR;

architecture STRUCTURE of design_1_my_uart_int_0_0_my_uart_int_v1_0_S_AXI_INTR is
  signal \aw_en_i_1__0_n_0\ : STD_LOGIC;
  signal aw_en_reg_n_0 : STD_LOGIC;
  signal \axi_araddr[2]_i_1_n_0\ : STD_LOGIC;
  signal \axi_araddr[3]_i_1_n_0\ : STD_LOGIC;
  signal \axi_araddr[4]_i_1_n_0\ : STD_LOGIC;
  signal axi_arready0 : STD_LOGIC;
  signal \^axi_arready_reg_0\ : STD_LOGIC;
  signal \axi_awaddr[2]_i_1_n_0\ : STD_LOGIC;
  signal \axi_awaddr[3]_i_1_n_0\ : STD_LOGIC;
  signal \axi_awaddr[4]_i_1_n_0\ : STD_LOGIC;
  signal axi_awready0 : STD_LOGIC;
  signal \^axi_awready_reg_0\ : STD_LOGIC;
  signal \axi_bvalid_i_1__0_n_0\ : STD_LOGIC;
  signal \axi_rdata[0]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[0]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[1]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[1]_i_2__0_n_0\ : STD_LOGIC;
  signal \axi_rdata[1]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[1]_i_4_n_0\ : STD_LOGIC;
  signal \axi_rvalid_i_1__0_n_0\ : STD_LOGIC;
  signal axi_wready0 : STD_LOGIC;
  signal \^axi_wready_reg_0\ : STD_LOGIC;
  signal data4 : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal det_intr : STD_LOGIC;
  signal \gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.det_intr[0]_i_1_n_0\ : STD_LOGIC;
  signal \gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff2_reg_n_0_[0]\ : STD_LOGIC;
  signal \gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff[0]_i_1_n_0\ : STD_LOGIC;
  signal \gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.det_intr[1]_i_1_n_0\ : STD_LOGIC;
  signal \gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.det_intr_reg\ : STD_LOGIC;
  signal \gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.intr_ff2_reg_n_0_[1]\ : STD_LOGIC;
  signal \gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.intr_ff[1]_i_1_n_0\ : STD_LOGIC;
  signal \gen_intr_detection[1].gen_irq_level.irq_level_high.s_irq_lvl_i_1_n_0\ : STD_LOGIC;
  signal \gen_intr_reg[0].reg_intr_ack[0]_i_1_n_0\ : STD_LOGIC;
  signal \gen_intr_reg[0].reg_intr_ack_reg_n_0_[0]\ : STD_LOGIC;
  signal \gen_intr_reg[0].reg_intr_en[0]_i_1_n_0\ : STD_LOGIC;
  signal \gen_intr_reg[0].reg_intr_en_reg_n_0_[0]\ : STD_LOGIC;
  signal \gen_intr_reg[0].reg_intr_sts_reg_n_0_[0]\ : STD_LOGIC;
  signal \gen_intr_reg[1].reg_intr_ack[1]_i_1_n_0\ : STD_LOGIC;
  signal \gen_intr_reg[1].reg_intr_ack_reg_n_0_[1]\ : STD_LOGIC;
  signal \gen_intr_reg[1].reg_intr_en[1]_i_1_n_0\ : STD_LOGIC;
  signal \gen_intr_reg[1].reg_intr_en_reg_n_0_[1]\ : STD_LOGIC;
  signal intr_ack_all : STD_LOGIC;
  signal intr_ack_all_ff : STD_LOGIC;
  signal intr_ack_all_i_1_n_0 : STD_LOGIC;
  signal intr_all : STD_LOGIC;
  signal intr_all_i_1_n_0 : STD_LOGIC;
  signal intr_ff2 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal intr_reg_rden : STD_LOGIC;
  signal \intr_reg_wren__2\ : STD_LOGIC;
  signal \^irq\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal p_10_out : STD_LOGIC;
  signal p_11_out : STD_LOGIC;
  signal p_18_in : STD_LOGIC;
  signal p_1_in4_in : STD_LOGIC;
  signal p_1_in9_in : STD_LOGIC;
  signal rda_to_intr_0 : STD_LOGIC;
  signal reg_global_intr_en : STD_LOGIC;
  signal reg_global_intr_en0_out : STD_LOGIC;
  signal reset : STD_LOGIC;
  signal \^s_axi_intr_bvalid\ : STD_LOGIC;
  signal \^s_axi_intr_rdata\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^s_axi_intr_rvalid\ : STD_LOGIC;
  signal sel0 : STD_LOGIC_VECTOR ( 2 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \axi_araddr[3]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \axi_araddr[4]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \axi_arready_i_1__0\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of axi_awready_i_2 : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \axi_rdata[1]_i_3\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \axi_rdata[1]_i_5\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \axi_rvalid_i_1__0\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \axi_wready_i_1__0\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \gen_intr_reg[0].reg_intr_ack[0]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \gen_intr_reg[1].reg_global_intr_en[0]_i_3\ : label is "soft_lutpair21";
begin
  axi_arready_reg_0 <= \^axi_arready_reg_0\;
  axi_awready_reg_0 <= \^axi_awready_reg_0\;
  axi_wready_reg_0 <= \^axi_wready_reg_0\;
  irq <= \^irq\;
  s_axi_intr_bvalid <= \^s_axi_intr_bvalid\;
  s_axi_intr_rdata(1 downto 0) <= \^s_axi_intr_rdata\(1 downto 0);
  s_axi_intr_rvalid <= \^s_axi_intr_rvalid\;
\aw_en_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BFFFBF00BF00BF00"
    )
        port map (
      I0 => \^axi_awready_reg_0\,
      I1 => s_axi_intr_wvalid,
      I2 => s_axi_intr_awvalid,
      I3 => aw_en_reg_n_0,
      I4 => s_axi_intr_bready,
      I5 => \^s_axi_intr_bvalid\,
      O => \aw_en_i_1__0_n_0\
    );
aw_en_reg: unisim.vcomponents.FDSE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => \aw_en_i_1__0_n_0\,
      Q => aw_en_reg_n_0,
      S => reset
    );
\axi_araddr[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_intr_araddr(0),
      I1 => s_axi_intr_arvalid,
      I2 => \^axi_arready_reg_0\,
      I3 => sel0(0),
      O => \axi_araddr[2]_i_1_n_0\
    );
\axi_araddr[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_intr_araddr(1),
      I1 => s_axi_intr_arvalid,
      I2 => \^axi_arready_reg_0\,
      I3 => sel0(1),
      O => \axi_araddr[3]_i_1_n_0\
    );
\axi_araddr[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_intr_araddr(2),
      I1 => s_axi_intr_arvalid,
      I2 => \^axi_arready_reg_0\,
      I3 => sel0(2),
      O => \axi_araddr[4]_i_1_n_0\
    );
\axi_araddr_reg[2]\: unisim.vcomponents.FDSE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => \axi_araddr[2]_i_1_n_0\,
      Q => sel0(0),
      S => reset
    );
\axi_araddr_reg[3]\: unisim.vcomponents.FDSE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => \axi_araddr[3]_i_1_n_0\,
      Q => sel0(1),
      S => reset
    );
\axi_araddr_reg[4]\: unisim.vcomponents.FDSE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => \axi_araddr[4]_i_1_n_0\,
      Q => sel0(2),
      S => reset
    );
\axi_arready_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => s_axi_intr_arvalid,
      I1 => \^axi_arready_reg_0\,
      O => axi_arready0
    );
axi_arready_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => axi_arready0,
      Q => \^axi_arready_reg_0\,
      R => reset
    );
\axi_awaddr[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFBFFF00008000"
    )
        port map (
      I0 => s_axi_intr_awaddr(0),
      I1 => aw_en_reg_n_0,
      I2 => s_axi_intr_awvalid,
      I3 => s_axi_intr_wvalid,
      I4 => \^axi_awready_reg_0\,
      I5 => p_0_in(0),
      O => \axi_awaddr[2]_i_1_n_0\
    );
\axi_awaddr[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFBFFF00008000"
    )
        port map (
      I0 => s_axi_intr_awaddr(1),
      I1 => aw_en_reg_n_0,
      I2 => s_axi_intr_awvalid,
      I3 => s_axi_intr_wvalid,
      I4 => \^axi_awready_reg_0\,
      I5 => p_0_in(1),
      O => \axi_awaddr[3]_i_1_n_0\
    );
\axi_awaddr[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFBFFF00008000"
    )
        port map (
      I0 => s_axi_intr_awaddr(2),
      I1 => aw_en_reg_n_0,
      I2 => s_axi_intr_awvalid,
      I3 => s_axi_intr_wvalid,
      I4 => \^axi_awready_reg_0\,
      I5 => p_0_in(2),
      O => \axi_awaddr[4]_i_1_n_0\
    );
\axi_awaddr_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => \axi_awaddr[2]_i_1_n_0\,
      Q => p_0_in(0),
      R => reset
    );
\axi_awaddr_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => \axi_awaddr[3]_i_1_n_0\,
      Q => p_0_in(1),
      R => reset
    );
\axi_awaddr_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => \axi_awaddr[4]_i_1_n_0\,
      Q => p_0_in(2),
      R => reset
    );
axi_awready_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => aw_en_reg_n_0,
      I1 => s_axi_intr_awvalid,
      I2 => s_axi_intr_wvalid,
      I3 => \^axi_awready_reg_0\,
      O => axi_awready0
    );
axi_awready_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => axi_awready0,
      Q => \^axi_awready_reg_0\,
      R => reset
    );
\axi_bvalid_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FFFF80008000"
    )
        port map (
      I0 => s_axi_intr_wvalid,
      I1 => \^axi_awready_reg_0\,
      I2 => \^axi_wready_reg_0\,
      I3 => s_axi_intr_awvalid,
      I4 => s_axi_intr_bready,
      I5 => \^s_axi_intr_bvalid\,
      O => \axi_bvalid_i_1__0_n_0\
    );
axi_bvalid_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => \axi_bvalid_i_1__0_n_0\,
      Q => \^s_axi_intr_bvalid\,
      R => reset
    );
\axi_rdata[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8830FFFF88300000"
    )
        port map (
      I0 => \axi_rdata[0]_i_2_n_0\,
      I1 => \axi_rdata[1]_i_3_n_0\,
      I2 => data4(0),
      I3 => \axi_rdata[1]_i_4_n_0\,
      I4 => intr_reg_rden,
      I5 => \^s_axi_intr_rdata\(0),
      O => \axi_rdata[0]_i_1_n_0\
    );
\axi_rdata[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_intr_reg[0].reg_intr_ack_reg_n_0_[0]\,
      I1 => \gen_intr_reg[0].reg_intr_sts_reg_n_0_[0]\,
      I2 => sel0(1),
      I3 => \gen_intr_reg[0].reg_intr_en_reg_n_0_[0]\,
      I4 => sel0(0),
      I5 => reg_global_intr_en,
      O => \axi_rdata[0]_i_2_n_0\
    );
\axi_rdata[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88B8FFFF88B80000"
    )
        port map (
      I0 => \axi_rdata[1]_i_2__0_n_0\,
      I1 => \axi_rdata[1]_i_3_n_0\,
      I2 => data4(1),
      I3 => \axi_rdata[1]_i_4_n_0\,
      I4 => intr_reg_rden,
      I5 => \^s_axi_intr_rdata\(1),
      O => \axi_rdata[1]_i_1_n_0\
    );
\axi_rdata[1]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"55C050C005C000C0"
    )
        port map (
      I0 => sel0(2),
      I1 => \gen_intr_reg[1].reg_intr_en_reg_n_0_[1]\,
      I2 => sel0(0),
      I3 => sel0(1),
      I4 => p_1_in9_in,
      I5 => \gen_intr_reg[1].reg_intr_ack_reg_n_0_[1]\,
      O => \axi_rdata[1]_i_2__0_n_0\
    );
\axi_rdata[1]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => sel0(1),
      I1 => sel0(2),
      O => \axi_rdata[1]_i_3_n_0\
    );
\axi_rdata[1]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"5D"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(0),
      I2 => sel0(1),
      O => \axi_rdata[1]_i_4_n_0\
    );
\axi_rdata[1]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => \^axi_arready_reg_0\,
      I1 => s_axi_intr_arvalid,
      I2 => \^s_axi_intr_rvalid\,
      O => intr_reg_rden
    );
\axi_rdata_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => \axi_rdata[0]_i_1_n_0\,
      Q => \^s_axi_intr_rdata\(0),
      R => reset
    );
\axi_rdata_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => \axi_rdata[1]_i_1_n_0\,
      Q => \^s_axi_intr_rdata\(1),
      R => reset
    );
\axi_rvalid_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"08F8"
    )
        port map (
      I0 => s_axi_intr_arvalid,
      I1 => \^axi_arready_reg_0\,
      I2 => \^s_axi_intr_rvalid\,
      I3 => s_axi_intr_rready,
      O => \axi_rvalid_i_1__0_n_0\
    );
axi_rvalid_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => \axi_rvalid_i_1__0_n_0\,
      Q => \^s_axi_intr_rvalid\,
      R => reset
    );
\axi_wready_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => aw_en_reg_n_0,
      I1 => s_axi_intr_awvalid,
      I2 => s_axi_intr_wvalid,
      I3 => \^axi_wready_reg_0\,
      O => axi_wready0
    );
axi_wready_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => axi_wready0,
      Q => \^axi_wready_reg_0\,
      R => reset
    );
\gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.det_intr[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F4"
    )
        port map (
      I0 => intr_ff2(0),
      I1 => \gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff2_reg_n_0_[0]\,
      I2 => det_intr,
      O => \gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.det_intr[0]_i_1_n_0\
    );
\gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.det_intr_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => \gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.det_intr[0]_i_1_n_0\,
      Q => det_intr,
      R => \gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff[0]_i_1_n_0\
    );
\gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff2_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => intr_ff2(0),
      Q => \gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff2_reg_n_0_[0]\,
      R => \gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff[0]_i_1_n_0\
    );
\gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => \gen_intr_reg[0].reg_intr_ack_reg_n_0_[0]\,
      I1 => s_axi_intr_aresetn,
      O => \gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff[0]_i_1_n_0\
    );
\gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => tx_busy_to_intr,
      Q => intr_ff2(0),
      R => \gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff[0]_i_1_n_0\
    );
\gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.det_intr[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F4"
    )
        port map (
      I0 => \gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.intr_ff2_reg_n_0_[1]\,
      I1 => p_1_in4_in,
      I2 => \gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.det_intr_reg\,
      O => \gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.det_intr[1]_i_1_n_0\
    );
\gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.det_intr_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => \gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.det_intr[1]_i_1_n_0\,
      Q => \gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.det_intr_reg\,
      R => \gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.intr_ff[1]_i_1_n_0\
    );
\gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.intr_ff2_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => p_1_in4_in,
      Q => \gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.intr_ff2_reg_n_0_[1]\,
      R => \gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.intr_ff[1]_i_1_n_0\
    );
\gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.intr_ff[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => \gen_intr_reg[1].reg_intr_ack_reg_n_0_[1]\,
      I1 => s_axi_intr_aresetn,
      O => \gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.intr_ff[1]_i_1_n_0\
    );
\gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.intr_ff_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => rda_to_intr_0,
      Q => p_1_in4_in,
      R => \gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.intr_ff[1]_i_1_n_0\
    );
\gen_intr_detection[1].gen_irq_level.irq_level_high.s_irq_lvl_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000EA00"
    )
        port map (
      I0 => \^irq\,
      I1 => reg_global_intr_en,
      I2 => intr_all,
      I3 => s_axi_intr_aresetn,
      I4 => intr_ack_all,
      O => \gen_intr_detection[1].gen_irq_level.irq_level_high.s_irq_lvl_i_1_n_0\
    );
\gen_intr_detection[1].gen_irq_level.irq_level_high.s_irq_lvl_reg\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => \gen_intr_detection[1].gen_irq_level.irq_level_high.s_irq_lvl_i_1_n_0\,
      Q => \^irq\,
      R => '0'
    );
\gen_intr_reg[0].reg_intr_ack[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00800000"
    )
        port map (
      I0 => s_axi_intr_wdata(0),
      I1 => p_0_in(1),
      I2 => p_0_in(0),
      I3 => p_0_in(2),
      I4 => \intr_reg_wren__2\,
      O => \gen_intr_reg[0].reg_intr_ack[0]_i_1_n_0\
    );
\gen_intr_reg[0].reg_intr_ack_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => \gen_intr_reg[0].reg_intr_ack[0]_i_1_n_0\,
      Q => \gen_intr_reg[0].reg_intr_ack_reg_n_0_[0]\,
      R => \gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff[0]_i_1_n_0\
    );
\gen_intr_reg[0].reg_intr_en[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFFFFFF02000000"
    )
        port map (
      I0 => s_axi_intr_wdata(0),
      I1 => p_0_in(1),
      I2 => p_0_in(2),
      I3 => p_0_in(0),
      I4 => \intr_reg_wren__2\,
      I5 => \gen_intr_reg[0].reg_intr_en_reg_n_0_[0]\,
      O => \gen_intr_reg[0].reg_intr_en[0]_i_1_n_0\
    );
\gen_intr_reg[0].reg_intr_en_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => \gen_intr_reg[0].reg_intr_en[0]_i_1_n_0\,
      Q => \gen_intr_reg[0].reg_intr_en_reg_n_0_[0]\,
      R => reset
    );
\gen_intr_reg[0].reg_intr_pending[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \gen_intr_reg[0].reg_intr_en_reg_n_0_[0]\,
      I1 => \gen_intr_reg[0].reg_intr_sts_reg_n_0_[0]\,
      O => p_11_out
    );
\gen_intr_reg[0].reg_intr_pending_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => p_11_out,
      Q => data4(0),
      R => \gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff[0]_i_1_n_0\
    );
\gen_intr_reg[0].reg_intr_sts_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => det_intr,
      Q => \gen_intr_reg[0].reg_intr_sts_reg_n_0_[0]\,
      R => \gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff[0]_i_1_n_0\
    );
\gen_intr_reg[1].reg_global_intr_en[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EA2A0000"
    )
        port map (
      I0 => reg_global_intr_en,
      I1 => \intr_reg_wren__2\,
      I2 => p_18_in,
      I3 => s_axi_intr_wdata(0),
      I4 => s_axi_intr_aresetn,
      O => reg_global_intr_en0_out
    );
\gen_intr_reg[1].reg_global_intr_en[0]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => s_axi_intr_wvalid,
      I1 => \^axi_awready_reg_0\,
      I2 => \^axi_wready_reg_0\,
      I3 => s_axi_intr_awvalid,
      O => \intr_reg_wren__2\
    );
\gen_intr_reg[1].reg_global_intr_en[0]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => p_0_in(1),
      I1 => p_0_in(0),
      I2 => p_0_in(2),
      O => p_18_in
    );
\gen_intr_reg[1].reg_global_intr_en_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => reg_global_intr_en0_out,
      Q => reg_global_intr_en,
      R => '0'
    );
\gen_intr_reg[1].reg_intr_ack[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00800000"
    )
        port map (
      I0 => s_axi_intr_wdata(1),
      I1 => p_0_in(1),
      I2 => p_0_in(0),
      I3 => p_0_in(2),
      I4 => \intr_reg_wren__2\,
      O => \gen_intr_reg[1].reg_intr_ack[1]_i_1_n_0\
    );
\gen_intr_reg[1].reg_intr_ack_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => \gen_intr_reg[1].reg_intr_ack[1]_i_1_n_0\,
      Q => \gen_intr_reg[1].reg_intr_ack_reg_n_0_[1]\,
      R => \gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.intr_ff[1]_i_1_n_0\
    );
\gen_intr_reg[1].reg_intr_en[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFFFFFF02000000"
    )
        port map (
      I0 => s_axi_intr_wdata(1),
      I1 => p_0_in(1),
      I2 => p_0_in(2),
      I3 => p_0_in(0),
      I4 => \intr_reg_wren__2\,
      I5 => \gen_intr_reg[1].reg_intr_en_reg_n_0_[1]\,
      O => \gen_intr_reg[1].reg_intr_en[1]_i_1_n_0\
    );
\gen_intr_reg[1].reg_intr_en_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => \gen_intr_reg[1].reg_intr_en[1]_i_1_n_0\,
      Q => \gen_intr_reg[1].reg_intr_en_reg_n_0_[1]\,
      R => reset
    );
\gen_intr_reg[1].reg_intr_pending[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \gen_intr_reg[1].reg_intr_en_reg_n_0_[1]\,
      I1 => p_1_in9_in,
      O => p_10_out
    );
\gen_intr_reg[1].reg_intr_pending_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => p_10_out,
      Q => data4(1),
      R => \gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.intr_ff[1]_i_1_n_0\
    );
\gen_intr_reg[1].reg_intr_sts_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => \gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.det_intr_reg\,
      Q => p_1_in9_in,
      R => \gen_intr_detection[1].gen_intr_edge_detect.gen_intr_rising_edge_detect.intr_ff[1]_i_1_n_0\
    );
inst_edge_det: entity work.design_1_my_uart_int_0_0_edge_detector
     port map (
      rda_to_intr => rda_to_intr,
      rda_to_intr_0 => rda_to_intr_0,
      reset => reset,
      s_axi_intr_aclk => s_axi_intr_aclk,
      s_axi_intr_aresetn => s_axi_intr_aresetn
    );
intr_ack_all_ff_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => intr_ack_all,
      Q => intr_ack_all_ff,
      R => reset
    );
intr_ack_all_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E0"
    )
        port map (
      I0 => \gen_intr_reg[0].reg_intr_ack_reg_n_0_[0]\,
      I1 => \gen_intr_reg[1].reg_intr_ack_reg_n_0_[1]\,
      I2 => s_axi_intr_aresetn,
      I3 => intr_ack_all_ff,
      O => intr_ack_all_i_1_n_0
    );
intr_ack_all_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => intr_ack_all_i_1_n_0,
      Q => intr_ack_all,
      R => '0'
    );
intr_all_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E0"
    )
        port map (
      I0 => data4(0),
      I1 => data4(1),
      I2 => s_axi_intr_aresetn,
      I3 => intr_ack_all_ff,
      O => intr_all_i_1_n_0
    );
intr_all_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_intr_aclk,
      CE => '1',
      D => intr_all_i_1_n_0,
      Q => intr_all,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_my_uart_int_0_0_rx_cu is
  port (
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    D : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rda_to_intr : out STD_LOGIC;
    \tmp_sig_reg[7]\ : out STD_LOGIC_VECTOR ( 7 downto 0 );
    \FSM_onehot_current_state_reg[4]_0\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    clock_out : in STD_LOGIC;
    s00_axi_aresetn : in STD_LOGIC;
    \axi_rdata_reg[8]\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_araddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    rx : in STD_LOGIC;
    \axi_rdata_reg[2]\ : in STD_LOGIC;
    \axi_rdata_reg[2]_0\ : in STD_LOGIC;
    \axi_rdata_reg[1]\ : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_my_uart_int_0_0_rx_cu : entity is "rx_cu";
end design_1_my_uart_int_0_0_rx_cu;

architecture STRUCTURE of design_1_my_uart_int_0_0_rx_cu is
  signal \FSM_onehot_current_state[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_current_state[6]_i_1_n_0\ : STD_LOGIC;
  signal \^fsm_onehot_current_state_reg[4]_0\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \FSM_onehot_current_state_reg_n_0_[0]\ : STD_LOGIC;
  signal \FSM_onehot_current_state_reg_n_0_[5]\ : STD_LOGIC;
  signal \FSM_onehot_current_state_reg_n_0_[6]\ : STD_LOGIC;
  signal \^sr\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \axi_rdata[2]_i_2_n_0\ : STD_LOGIC;
  signal bit_counter_n_3 : STD_LOGIC;
  signal counter_16incr : STD_LOGIC;
  signal counter_8incr : STD_LOGIC;
  signal counter_bit_incr : STD_LOGIC;
  signal counter_hit : STD_LOGIC;
  signal counter_mod16_n_0 : STD_LOGIC;
  signal counter_mod16_n_1 : STD_LOGIC;
  signal counter_mod8_n_1 : STD_LOGIC;
  signal done_bit_count : STD_LOGIC;
  signal reset_8count : STD_LOGIC;
  signal shift_en : STD_LOGIC;
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_onehot_current_state_reg[0]\ : label is "rda_state:0100000,first_idle:0000001,idle:1000000,eight_delay:0000010,get_bit:0001000,wait_for_centre:0000100,check_stop:0010000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_current_state_reg[1]\ : label is "rda_state:0100000,first_idle:0000001,idle:1000000,eight_delay:0000010,get_bit:0001000,wait_for_centre:0000100,check_stop:0010000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_current_state_reg[2]\ : label is "rda_state:0100000,first_idle:0000001,idle:1000000,eight_delay:0000010,get_bit:0001000,wait_for_centre:0000100,check_stop:0010000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_current_state_reg[3]\ : label is "rda_state:0100000,first_idle:0000001,idle:1000000,eight_delay:0000010,get_bit:0001000,wait_for_centre:0000100,check_stop:0010000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_current_state_reg[4]\ : label is "rda_state:0100000,first_idle:0000001,idle:1000000,eight_delay:0000010,get_bit:0001000,wait_for_centre:0000100,check_stop:0010000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_current_state_reg[5]\ : label is "rda_state:0100000,first_idle:0000001,idle:1000000,eight_delay:0000010,get_bit:0001000,wait_for_centre:0000100,check_stop:0010000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_current_state_reg[6]\ : label is "rda_state:0100000,first_idle:0000001,idle:1000000,eight_delay:0000010,get_bit:0001000,wait_for_centre:0000100,check_stop:0010000";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \axi_rdata[2]_i_2\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of r0_input_i_1 : label is "soft_lutpair11";
begin
  \FSM_onehot_current_state_reg[4]_0\(0) <= \^fsm_onehot_current_state_reg[4]_0\(0);
  SR(0) <= \^sr\(0);
\FSM_onehot_current_state[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \FSM_onehot_current_state_reg_n_0_[0]\,
      I1 => rx,
      O => \FSM_onehot_current_state[0]_i_1_n_0\
    );
\FSM_onehot_current_state[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F8"
    )
        port map (
      I0 => rx,
      I1 => \FSM_onehot_current_state_reg_n_0_[6]\,
      I2 => \FSM_onehot_current_state_reg_n_0_[5]\,
      O => \FSM_onehot_current_state[6]_i_1_n_0\
    );
\FSM_onehot_current_state_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => '1',
      D => \FSM_onehot_current_state[0]_i_1_n_0\,
      Q => \FSM_onehot_current_state_reg_n_0_[0]\,
      S => \^sr\(0)
    );
\FSM_onehot_current_state_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => '1',
      D => counter_mod8_n_1,
      Q => counter_8incr,
      R => \^sr\(0)
    );
\FSM_onehot_current_state_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => '1',
      D => counter_mod16_n_1,
      Q => counter_16incr,
      R => \^sr\(0)
    );
\FSM_onehot_current_state_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => '1',
      D => counter_mod16_n_0,
      Q => counter_bit_incr,
      R => \^sr\(0)
    );
\FSM_onehot_current_state_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => '1',
      D => bit_counter_n_3,
      Q => \^fsm_onehot_current_state_reg[4]_0\(0),
      R => \^sr\(0)
    );
\FSM_onehot_current_state_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clock_out,
      CE => '1',
      D => \^fsm_onehot_current_state_reg[4]_0\(0),
      Q => \FSM_onehot_current_state_reg_n_0_[5]\,
      R => \^sr\(0)
    );
\FSM_onehot_current_state_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => clock_out,
      CE => '1',
      D => \FSM_onehot_current_state[6]_i_1_n_0\,
      Q => \FSM_onehot_current_state_reg_n_0_[6]\,
      R => \^sr\(0)
    );
RX_shift_register_SIPO: entity work.design_1_my_uart_int_0_0_shift_register_SIPO
     port map (
      D(1 downto 0) => D(1 downto 0),
      E(0) => shift_en,
      Q(0) => Q(0),
      SR(0) => \^sr\(0),
      axi_araddr(1 downto 0) => axi_araddr(1 downto 0),
      \axi_rdata_reg[1]\(0) => \axi_rdata_reg[8]\(0),
      \axi_rdata_reg[1]_0\(0) => \axi_rdata_reg[1]\(0),
      \axi_rdata_reg[1]_1\(1) => \FSM_onehot_current_state_reg_n_0_[5]\,
      \axi_rdata_reg[1]_1\(0) => \^fsm_onehot_current_state_reg[4]_0\(0),
      \axi_rdata_reg[2]\ => \axi_rdata[2]_i_2_n_0\,
      \axi_rdata_reg[2]_0\ => \axi_rdata_reg[2]\,
      \axi_rdata_reg[2]_1\ => \axi_rdata_reg[2]_0\,
      clock_out => clock_out,
      rx => rx,
      s00_axi_aresetn => s00_axi_aresetn,
      \tmp_sig_reg[7]_0\(7 downto 0) => \tmp_sig_reg[7]\(7 downto 0)
    );
\axi_rdata[2]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4440"
    )
        port map (
      I0 => axi_araddr(0),
      I1 => axi_araddr(1),
      I2 => \FSM_onehot_current_state_reg_n_0_[5]\,
      I3 => \^fsm_onehot_current_state_reg[4]_0\(0),
      O => \axi_rdata[2]_i_2_n_0\
    );
\axi_rdata[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0CAF0CAF0CA00CA"
    )
        port map (
      I0 => \axi_rdata_reg[8]\(1),
      I1 => Q(1),
      I2 => axi_araddr(0),
      I3 => axi_araddr(1),
      I4 => \FSM_onehot_current_state_reg_n_0_[5]\,
      I5 => \FSM_onehot_current_state_reg_n_0_[6]\,
      O => D(2)
    );
bit_counter: entity work.\design_1_my_uart_int_0_0_counter_modN__parameterized5\
     port map (
      AR(0) => reset_8count,
      D(0) => bit_counter_n_3,
      E(0) => shift_en,
      Q(2) => \FSM_onehot_current_state_reg_n_0_[6]\,
      Q(1) => counter_bit_incr,
      Q(0) => \FSM_onehot_current_state_reg_n_0_[0]\,
      clock_out => clock_out,
      done_bit_count => done_bit_count
    );
counter_mod16: entity work.\design_1_my_uart_int_0_0_counter_modN__parameterized3\
     port map (
      D(1) => counter_mod16_n_0,
      D(0) => counter_mod16_n_1,
      Q(4) => \FSM_onehot_current_state_reg_n_0_[6]\,
      Q(3) => counter_bit_incr,
      Q(2) => counter_16incr,
      Q(1) => counter_8incr,
      Q(0) => \FSM_onehot_current_state_reg_n_0_[0]\,
      clock_out => clock_out,
      counter_hit => counter_hit,
      done_bit_count => done_bit_count
    );
counter_mod8: entity work.\design_1_my_uart_int_0_0_counter_modN__parameterized1\
     port map (
      AR(0) => reset_8count,
      D(0) => counter_mod8_n_1,
      Q(2) => \FSM_onehot_current_state_reg_n_0_[6]\,
      Q(1) => counter_8incr,
      Q(0) => \FSM_onehot_current_state_reg_n_0_[0]\,
      clock_out => clock_out,
      counter_hit => counter_hit,
      rx => rx
    );
r0_input_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \FSM_onehot_current_state_reg_n_0_[5]\,
      I1 => \FSM_onehot_current_state_reg_n_0_[6]\,
      O => rda_to_intr
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_my_uart_int_0_0_tx_cu is
  port (
    D : out STD_LOGIC_VECTOR ( 0 to 0 );
    tx_busy_to_intr : out STD_LOGIC;
    tx : out STD_LOGIC;
    tx_clock : in STD_LOGIC;
    \tmp_sig_reg[8]\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \axi_rdata_reg[4]\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    axi_araddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    s00_axi_aresetn : in STD_LOGIC;
    r1_input : in STD_LOGIC;
    r0_input : in STD_LOGIC;
    SS : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_my_uart_int_0_0_tx_cu : entity is "tx_cu";
end design_1_my_uart_int_0_0_tx_cu;

architecture STRUCTURE of design_1_my_uart_int_0_0_tx_cu is
  signal \FSM_sequential_current_state[1]_i_1_n_0\ : STD_LOGIC;
  signal TX_counter_n_0 : STD_LOGIC;
  signal current_state : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^tx_busy_to_intr\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_current_state[1]_i_1\ : label is "soft_lutpair16";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_current_state_reg[0]\ : label is "idle:00,start:01,transmit:10,reset_state:11";
  attribute FSM_ENCODED_STATES of \FSM_sequential_current_state_reg[1]\ : label is "idle:00,start:01,transmit:10,reset_state:11";
  attribute SOFT_HLUTNM of \gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff[0]_i_2\ : label is "soft_lutpair16";
begin
  tx_busy_to_intr <= \^tx_busy_to_intr\;
\FSM_sequential_current_state[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"60"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      I2 => s00_axi_aresetn,
      O => \FSM_sequential_current_state[1]_i_1_n_0\
    );
\FSM_sequential_current_state_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => tx_clock,
      CE => '1',
      D => TX_counter_n_0,
      Q => current_state(0),
      R => '0'
    );
\FSM_sequential_current_state_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => tx_clock,
      CE => '1',
      D => \FSM_sequential_current_state[1]_i_1_n_0\,
      Q => current_state(1),
      R => '0'
    );
TX_counter: entity work.design_1_my_uart_int_0_0_counter_modN
     port map (
      current_state(1 downto 0) => current_state(1 downto 0),
      r0_input => r0_input,
      r1_input => r1_input,
      r1_input_reg => TX_counter_n_0,
      s00_axi_aresetn => s00_axi_aresetn,
      tx_clock => tx_clock
    );
TX_shift_register: entity work.design_1_my_uart_int_0_0_shift_register
     port map (
      SS(0) => SS(0),
      current_state(1 downto 0) => current_state(1 downto 0),
      \tmp_sig_reg[8]_0\(7 downto 0) => \tmp_sig_reg[8]\(7 downto 0),
      tx => tx,
      tx_clock => tx_clock
    );
\axi_rdata[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => \^tx_busy_to_intr\,
      I1 => \axi_rdata_reg[4]\(0),
      I2 => axi_araddr(1),
      I3 => axi_araddr(0),
      I4 => \tmp_sig_reg[8]\(4),
      I5 => Q(0),
      O => D(0)
    );
\gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff[0]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      O => \^tx_busy_to_intr\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_my_uart_int_0_0_UART is
  port (
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    D : out STD_LOGIC_VECTOR ( 8 downto 0 );
    tx_busy_to_intr : out STD_LOGIC;
    rda_to_intr : out STD_LOGIC;
    tx : out STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s00_axi_aclk : in STD_LOGIC;
    s00_axi_aresetn : in STD_LOGIC;
    \axi_rdata_reg[8]\ : in STD_LOGIC_VECTOR ( 8 downto 0 );
    axi_araddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    rx : in STD_LOGIC;
    \axi_rdata_reg[2]\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_my_uart_int_0_0_UART : entity is "UART";
end design_1_my_uart_int_0_0_UART;

architecture STRUCTURE of design_1_my_uart_int_0_0_UART is
  signal Holding_register_n_7 : STD_LOGIC;
  signal \^sr\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal clock_out : STD_LOGIC;
  signal load_data : STD_LOGIC;
  signal r0_input : STD_LOGIC;
  signal r1_input : STD_LOGIC;
  signal received_data : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal slv_reg3_out : STD_LOGIC_VECTOR ( 4 downto 1 );
  signal tx_clock : STD_LOGIC;
begin
  SR(0) <= \^sr\(0);
BAUDGENERATOR: entity work.design_1_my_uart_int_0_0_clock_mod
     port map (
      clock_out => clock_out,
      s00_axi_aclk => s00_axi_aclk
    );
Holding_register: entity work.design_1_my_uart_int_0_0_d_ff_register
     port map (
      D(4 downto 2) => D(7 downto 5),
      D(1) => D(3),
      D(0) => D(0),
      Q(4 downto 2) => Q(6 downto 4),
      Q(1) => Q(2),
      Q(0) => Q(0),
      SR(0) => \^sr\(0),
      axi_araddr(1 downto 0) => axi_araddr(1 downto 0),
      \axi_araddr_reg[3]\ => Holding_register_n_7,
      \axi_rdata_reg[7]\(4 downto 2) => \axi_rdata_reg[8]\(7 downto 5),
      \axi_rdata_reg[7]\(1) => \axi_rdata_reg[8]\(3),
      \axi_rdata_reg[7]\(0) => \axi_rdata_reg[8]\(0),
      \q_reg[4]_0\(1) => slv_reg3_out(4),
      \q_reg[4]_0\(0) => slv_reg3_out(1),
      \q_reg[7]_0\(0) => load_data,
      \q_reg[7]_1\(7 downto 0) => received_data(7 downto 0),
      s00_axi_aclk => s00_axi_aclk
    );
RX_UART: entity work.design_1_my_uart_int_0_0_rx_cu
     port map (
      D(2) => D(8),
      D(1 downto 0) => D(2 downto 1),
      \FSM_onehot_current_state_reg[4]_0\(0) => load_data,
      Q(1) => Q(7),
      Q(0) => Q(1),
      SR(0) => \^sr\(0),
      axi_araddr(1 downto 0) => axi_araddr(1 downto 0),
      \axi_rdata_reg[1]\(0) => slv_reg3_out(1),
      \axi_rdata_reg[2]\ => Holding_register_n_7,
      \axi_rdata_reg[2]_0\ => \axi_rdata_reg[2]\,
      \axi_rdata_reg[8]\(1) => \axi_rdata_reg[8]\(8),
      \axi_rdata_reg[8]\(0) => \axi_rdata_reg[8]\(1),
      clock_out => clock_out,
      rda_to_intr => rda_to_intr,
      rx => rx,
      s00_axi_aresetn => s00_axi_aresetn,
      \tmp_sig_reg[7]\(7 downto 0) => received_data(7 downto 0)
    );
TX_UART: entity work.design_1_my_uart_int_0_0_tx_cu
     port map (
      D(0) => D(4),
      Q(0) => Q(3),
      SS(0) => \^sr\(0),
      axi_araddr(1 downto 0) => axi_araddr(1 downto 0),
      \axi_rdata_reg[4]\(0) => slv_reg3_out(4),
      r0_input => r0_input,
      r1_input => r1_input,
      s00_axi_aresetn => s00_axi_aresetn,
      \tmp_sig_reg[8]\(7 downto 0) => \axi_rdata_reg[8]\(7 downto 0),
      tx => tx,
      tx_busy_to_intr => tx_busy_to_intr,
      tx_clock => tx_clock
    );
inst_edge_detector: entity work.design_1_my_uart_int_0_0_edge_detector_0
     port map (
      Q(0) => Q(0),
      SR(0) => \^sr\(0),
      r0_input => r0_input,
      r1_input => r1_input,
      tx_clock => tx_clock
    );
tx_clock_mod: entity work.\design_1_my_uart_int_0_0_clock_mod__parameterized1\
     port map (
      clock_out => clock_out,
      tx_clock => tx_clock
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_my_uart_int_0_0_my_uart_int_v1_0_S00_AXI is
  port (
    axi_wready_reg_0 : out STD_LOGIC;
    axi_awready_reg_0 : out STD_LOGIC;
    axi_arready_reg_0 : out STD_LOGIC;
    s00_axi_bvalid : out STD_LOGIC;
    s00_axi_rvalid : out STD_LOGIC;
    tx : out STD_LOGIC;
    s00_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    tx_busy_to_intr : out STD_LOGIC;
    rda_to_intr : out STD_LOGIC;
    s00_axi_aclk : in STD_LOGIC;
    s00_axi_aresetn : in STD_LOGIC;
    s00_axi_awvalid : in STD_LOGIC;
    s00_axi_wvalid : in STD_LOGIC;
    s00_axi_bready : in STD_LOGIC;
    s00_axi_arvalid : in STD_LOGIC;
    s00_axi_rready : in STD_LOGIC;
    s00_axi_awaddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    rx : in STD_LOGIC;
    s00_axi_araddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_my_uart_int_0_0_my_uart_int_v1_0_S00_AXI : entity is "my_uart_int_v1_0_S00_AXI";
end design_1_my_uart_int_0_0_my_uart_int_v1_0_S00_AXI;

architecture STRUCTURE of design_1_my_uart_int_0_0_my_uart_int_v1_0_S00_AXI is
  signal aw_en_i_1_n_0 : STD_LOGIC;
  signal aw_en_reg_n_0 : STD_LOGIC;
  signal axi_araddr : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \axi_araddr[2]_i_1_n_0\ : STD_LOGIC;
  signal \axi_araddr[3]_i_1_n_0\ : STD_LOGIC;
  signal axi_arready0 : STD_LOGIC;
  signal \^axi_arready_reg_0\ : STD_LOGIC;
  signal \axi_awaddr[2]_i_1_n_0\ : STD_LOGIC;
  signal \axi_awaddr[3]_i_1_n_0\ : STD_LOGIC;
  signal axi_awready0 : STD_LOGIC;
  signal \^axi_awready_reg_0\ : STD_LOGIC;
  signal axi_bvalid_i_1_n_0 : STD_LOGIC;
  signal \axi_rdata[2]_i_6_n_0\ : STD_LOGIC;
  signal axi_rvalid_i_1_n_0 : STD_LOGIC;
  signal axi_wready0 : STD_LOGIC;
  signal \^axi_wready_reg_0\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal reg_data_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal reset : STD_LOGIC;
  signal \^s00_axi_bvalid\ : STD_LOGIC;
  signal \^s00_axi_rvalid\ : STD_LOGIC;
  signal slv_reg0 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \slv_reg0[15]_i_1_n_0\ : STD_LOGIC;
  signal \slv_reg0[23]_i_1_n_0\ : STD_LOGIC;
  signal \slv_reg0[31]_i_1_n_0\ : STD_LOGIC;
  signal \slv_reg0[7]_i_1_n_0\ : STD_LOGIC;
  signal slv_reg1 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \slv_reg1[15]_i_1_n_0\ : STD_LOGIC;
  signal \slv_reg1[23]_i_1_n_0\ : STD_LOGIC;
  signal \slv_reg1[31]_i_1_n_0\ : STD_LOGIC;
  signal \slv_reg1[7]_i_1_n_0\ : STD_LOGIC;
  signal slv_reg_rden : STD_LOGIC;
  signal \slv_reg_wren__2\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of axi_arready_i_1 : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of axi_awready_i_1 : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of axi_rvalid_i_1 : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of axi_wready_i_1 : label is "soft_lutpair20";
begin
  axi_arready_reg_0 <= \^axi_arready_reg_0\;
  axi_awready_reg_0 <= \^axi_awready_reg_0\;
  axi_wready_reg_0 <= \^axi_wready_reg_0\;
  s00_axi_bvalid <= \^s00_axi_bvalid\;
  s00_axi_rvalid <= \^s00_axi_rvalid\;
aw_en_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BFFFBF00BF00BF00"
    )
        port map (
      I0 => \^axi_awready_reg_0\,
      I1 => s00_axi_awvalid,
      I2 => s00_axi_wvalid,
      I3 => aw_en_reg_n_0,
      I4 => s00_axi_bready,
      I5 => \^s00_axi_bvalid\,
      O => aw_en_i_1_n_0
    );
aw_en_reg: unisim.vcomponents.FDSE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => aw_en_i_1_n_0,
      Q => aw_en_reg_n_0,
      S => reset
    );
\axi_araddr[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s00_axi_araddr(0),
      I1 => s00_axi_arvalid,
      I2 => \^axi_arready_reg_0\,
      I3 => axi_araddr(2),
      O => \axi_araddr[2]_i_1_n_0\
    );
\axi_araddr[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s00_axi_araddr(1),
      I1 => s00_axi_arvalid,
      I2 => \^axi_arready_reg_0\,
      I3 => axi_araddr(3),
      O => \axi_araddr[3]_i_1_n_0\
    );
\axi_araddr_reg[2]\: unisim.vcomponents.FDSE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \axi_araddr[2]_i_1_n_0\,
      Q => axi_araddr(2),
      S => reset
    );
\axi_araddr_reg[3]\: unisim.vcomponents.FDSE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \axi_araddr[3]_i_1_n_0\,
      Q => axi_araddr(3),
      S => reset
    );
axi_arready_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => s00_axi_arvalid,
      I1 => \^axi_arready_reg_0\,
      O => axi_arready0
    );
axi_arready_reg: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => axi_arready0,
      Q => \^axi_arready_reg_0\,
      R => reset
    );
\axi_awaddr[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFBFFF00008000"
    )
        port map (
      I0 => s00_axi_awaddr(0),
      I1 => aw_en_reg_n_0,
      I2 => s00_axi_wvalid,
      I3 => s00_axi_awvalid,
      I4 => \^axi_awready_reg_0\,
      I5 => p_0_in(0),
      O => \axi_awaddr[2]_i_1_n_0\
    );
\axi_awaddr[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFBFFF00008000"
    )
        port map (
      I0 => s00_axi_awaddr(1),
      I1 => aw_en_reg_n_0,
      I2 => s00_axi_wvalid,
      I3 => s00_axi_awvalid,
      I4 => \^axi_awready_reg_0\,
      I5 => p_0_in(1),
      O => \axi_awaddr[3]_i_1_n_0\
    );
\axi_awaddr_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \axi_awaddr[2]_i_1_n_0\,
      Q => p_0_in(0),
      R => reset
    );
\axi_awaddr_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \axi_awaddr[3]_i_1_n_0\,
      Q => p_0_in(1),
      R => reset
    );
axi_awready_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => aw_en_reg_n_0,
      I1 => s00_axi_wvalid,
      I2 => s00_axi_awvalid,
      I3 => \^axi_awready_reg_0\,
      O => axi_awready0
    );
axi_awready_reg: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => axi_awready0,
      Q => \^axi_awready_reg_0\,
      R => reset
    );
axi_bvalid_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FFFF80008000"
    )
        port map (
      I0 => s00_axi_awvalid,
      I1 => \^axi_awready_reg_0\,
      I2 => \^axi_wready_reg_0\,
      I3 => s00_axi_wvalid,
      I4 => s00_axi_bready,
      I5 => \^s00_axi_bvalid\,
      O => axi_bvalid_i_1_n_0
    );
axi_bvalid_reg: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => axi_bvalid_i_1_n_0,
      Q => \^s00_axi_bvalid\,
      R => reset
    );
\axi_rdata[10]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(10),
      I1 => slv_reg0(10),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => reg_data_out(10)
    );
\axi_rdata[11]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(11),
      I1 => slv_reg0(11),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => reg_data_out(11)
    );
\axi_rdata[12]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(12),
      I1 => slv_reg0(12),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => reg_data_out(12)
    );
\axi_rdata[13]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(13),
      I1 => slv_reg0(13),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => reg_data_out(13)
    );
\axi_rdata[14]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(14),
      I1 => slv_reg0(14),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => reg_data_out(14)
    );
\axi_rdata[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(15),
      I1 => slv_reg0(15),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => reg_data_out(15)
    );
\axi_rdata[16]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(16),
      I1 => slv_reg0(16),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => reg_data_out(16)
    );
\axi_rdata[17]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(17),
      I1 => slv_reg0(17),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => reg_data_out(17)
    );
\axi_rdata[18]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(18),
      I1 => slv_reg0(18),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => reg_data_out(18)
    );
\axi_rdata[19]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(19),
      I1 => slv_reg0(19),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => reg_data_out(19)
    );
\axi_rdata[20]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(20),
      I1 => slv_reg0(20),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => reg_data_out(20)
    );
\axi_rdata[21]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(21),
      I1 => slv_reg0(21),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => reg_data_out(21)
    );
\axi_rdata[22]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(22),
      I1 => slv_reg0(22),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => reg_data_out(22)
    );
\axi_rdata[23]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(23),
      I1 => slv_reg0(23),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => reg_data_out(23)
    );
\axi_rdata[24]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(24),
      I1 => slv_reg0(24),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => reg_data_out(24)
    );
\axi_rdata[25]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(25),
      I1 => slv_reg0(25),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => reg_data_out(25)
    );
\axi_rdata[26]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(26),
      I1 => slv_reg0(26),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => reg_data_out(26)
    );
\axi_rdata[27]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(27),
      I1 => slv_reg0(27),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => reg_data_out(27)
    );
\axi_rdata[28]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(28),
      I1 => slv_reg0(28),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => reg_data_out(28)
    );
\axi_rdata[29]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(29),
      I1 => slv_reg0(29),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => reg_data_out(29)
    );
\axi_rdata[2]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(2),
      I1 => slv_reg0(2),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => \axi_rdata[2]_i_6_n_0\
    );
\axi_rdata[30]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(30),
      I1 => slv_reg0(30),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => reg_data_out(30)
    );
\axi_rdata[31]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => \^axi_arready_reg_0\,
      I1 => s00_axi_arvalid,
      I2 => \^s00_axi_rvalid\,
      O => slv_reg_rden
    );
\axi_rdata[31]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(31),
      I1 => slv_reg0(31),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => reg_data_out(31)
    );
\axi_rdata[9]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AC"
    )
        port map (
      I0 => slv_reg1(9),
      I1 => slv_reg0(9),
      I2 => axi_araddr(2),
      I3 => axi_araddr(3),
      O => reg_data_out(9)
    );
\axi_rdata_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(0),
      Q => s00_axi_rdata(0),
      R => reset
    );
\axi_rdata_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(10),
      Q => s00_axi_rdata(10),
      R => reset
    );
\axi_rdata_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(11),
      Q => s00_axi_rdata(11),
      R => reset
    );
\axi_rdata_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(12),
      Q => s00_axi_rdata(12),
      R => reset
    );
\axi_rdata_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(13),
      Q => s00_axi_rdata(13),
      R => reset
    );
\axi_rdata_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(14),
      Q => s00_axi_rdata(14),
      R => reset
    );
\axi_rdata_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(15),
      Q => s00_axi_rdata(15),
      R => reset
    );
\axi_rdata_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(16),
      Q => s00_axi_rdata(16),
      R => reset
    );
\axi_rdata_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(17),
      Q => s00_axi_rdata(17),
      R => reset
    );
\axi_rdata_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(18),
      Q => s00_axi_rdata(18),
      R => reset
    );
\axi_rdata_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(19),
      Q => s00_axi_rdata(19),
      R => reset
    );
\axi_rdata_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(1),
      Q => s00_axi_rdata(1),
      R => reset
    );
\axi_rdata_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(20),
      Q => s00_axi_rdata(20),
      R => reset
    );
\axi_rdata_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(21),
      Q => s00_axi_rdata(21),
      R => reset
    );
\axi_rdata_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(22),
      Q => s00_axi_rdata(22),
      R => reset
    );
\axi_rdata_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(23),
      Q => s00_axi_rdata(23),
      R => reset
    );
\axi_rdata_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(24),
      Q => s00_axi_rdata(24),
      R => reset
    );
\axi_rdata_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(25),
      Q => s00_axi_rdata(25),
      R => reset
    );
\axi_rdata_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(26),
      Q => s00_axi_rdata(26),
      R => reset
    );
\axi_rdata_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(27),
      Q => s00_axi_rdata(27),
      R => reset
    );
\axi_rdata_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(28),
      Q => s00_axi_rdata(28),
      R => reset
    );
\axi_rdata_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(29),
      Q => s00_axi_rdata(29),
      R => reset
    );
\axi_rdata_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(2),
      Q => s00_axi_rdata(2),
      R => reset
    );
\axi_rdata_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(30),
      Q => s00_axi_rdata(30),
      R => reset
    );
\axi_rdata_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(31),
      Q => s00_axi_rdata(31),
      R => reset
    );
\axi_rdata_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(3),
      Q => s00_axi_rdata(3),
      R => reset
    );
\axi_rdata_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(4),
      Q => s00_axi_rdata(4),
      R => reset
    );
\axi_rdata_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(5),
      Q => s00_axi_rdata(5),
      R => reset
    );
\axi_rdata_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(6),
      Q => s00_axi_rdata(6),
      R => reset
    );
\axi_rdata_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(7),
      Q => s00_axi_rdata(7),
      R => reset
    );
\axi_rdata_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(8),
      Q => s00_axi_rdata(8),
      R => reset
    );
\axi_rdata_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_rden,
      D => reg_data_out(9),
      Q => s00_axi_rdata(9),
      R => reset
    );
axi_rvalid_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"08F8"
    )
        port map (
      I0 => s00_axi_arvalid,
      I1 => \^axi_arready_reg_0\,
      I2 => \^s00_axi_rvalid\,
      I3 => s00_axi_rready,
      O => axi_rvalid_i_1_n_0
    );
axi_rvalid_reg: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => axi_rvalid_i_1_n_0,
      Q => \^s00_axi_rvalid\,
      R => reset
    );
axi_wready_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => aw_en_reg_n_0,
      I1 => s00_axi_wvalid,
      I2 => s00_axi_awvalid,
      I3 => \^axi_wready_reg_0\,
      O => axi_wready0
    );
axi_wready_reg: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => axi_wready0,
      Q => \^axi_wready_reg_0\,
      R => reset
    );
inst_uart: entity work.design_1_my_uart_int_0_0_UART
     port map (
      D(8 downto 0) => reg_data_out(8 downto 0),
      Q(7 downto 2) => slv_reg1(8 downto 3),
      Q(1 downto 0) => slv_reg1(1 downto 0),
      SR(0) => reset,
      axi_araddr(1 downto 0) => axi_araddr(3 downto 2),
      \axi_rdata_reg[2]\ => \axi_rdata[2]_i_6_n_0\,
      \axi_rdata_reg[8]\(8 downto 0) => slv_reg0(8 downto 0),
      rda_to_intr => rda_to_intr,
      rx => rx,
      s00_axi_aclk => s00_axi_aclk,
      s00_axi_aresetn => s00_axi_aresetn,
      tx => tx,
      tx_busy_to_intr => tx_busy_to_intr
    );
\slv_reg0[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0200"
    )
        port map (
      I0 => \slv_reg_wren__2\,
      I1 => p_0_in(1),
      I2 => p_0_in(0),
      I3 => s00_axi_wstrb(1),
      O => \slv_reg0[15]_i_1_n_0\
    );
\slv_reg0[23]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0200"
    )
        port map (
      I0 => \slv_reg_wren__2\,
      I1 => p_0_in(1),
      I2 => p_0_in(0),
      I3 => s00_axi_wstrb(2),
      O => \slv_reg0[23]_i_1_n_0\
    );
\slv_reg0[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0200"
    )
        port map (
      I0 => \slv_reg_wren__2\,
      I1 => p_0_in(1),
      I2 => p_0_in(0),
      I3 => s00_axi_wstrb(3),
      O => \slv_reg0[31]_i_1_n_0\
    );
\slv_reg0[31]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => s00_axi_awvalid,
      I1 => \^axi_awready_reg_0\,
      I2 => \^axi_wready_reg_0\,
      I3 => s00_axi_wvalid,
      O => \slv_reg_wren__2\
    );
\slv_reg0[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0200"
    )
        port map (
      I0 => \slv_reg_wren__2\,
      I1 => p_0_in(1),
      I2 => p_0_in(0),
      I3 => s00_axi_wstrb(0),
      O => \slv_reg0[7]_i_1_n_0\
    );
\slv_reg0_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[7]_i_1_n_0\,
      D => s00_axi_wdata(0),
      Q => slv_reg0(0),
      R => reset
    );
\slv_reg0_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[15]_i_1_n_0\,
      D => s00_axi_wdata(10),
      Q => slv_reg0(10),
      R => reset
    );
\slv_reg0_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[15]_i_1_n_0\,
      D => s00_axi_wdata(11),
      Q => slv_reg0(11),
      R => reset
    );
\slv_reg0_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[15]_i_1_n_0\,
      D => s00_axi_wdata(12),
      Q => slv_reg0(12),
      R => reset
    );
\slv_reg0_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[15]_i_1_n_0\,
      D => s00_axi_wdata(13),
      Q => slv_reg0(13),
      R => reset
    );
\slv_reg0_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[15]_i_1_n_0\,
      D => s00_axi_wdata(14),
      Q => slv_reg0(14),
      R => reset
    );
\slv_reg0_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[15]_i_1_n_0\,
      D => s00_axi_wdata(15),
      Q => slv_reg0(15),
      R => reset
    );
\slv_reg0_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[23]_i_1_n_0\,
      D => s00_axi_wdata(16),
      Q => slv_reg0(16),
      R => reset
    );
\slv_reg0_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[23]_i_1_n_0\,
      D => s00_axi_wdata(17),
      Q => slv_reg0(17),
      R => reset
    );
\slv_reg0_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[23]_i_1_n_0\,
      D => s00_axi_wdata(18),
      Q => slv_reg0(18),
      R => reset
    );
\slv_reg0_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[23]_i_1_n_0\,
      D => s00_axi_wdata(19),
      Q => slv_reg0(19),
      R => reset
    );
\slv_reg0_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[7]_i_1_n_0\,
      D => s00_axi_wdata(1),
      Q => slv_reg0(1),
      R => reset
    );
\slv_reg0_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[23]_i_1_n_0\,
      D => s00_axi_wdata(20),
      Q => slv_reg0(20),
      R => reset
    );
\slv_reg0_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[23]_i_1_n_0\,
      D => s00_axi_wdata(21),
      Q => slv_reg0(21),
      R => reset
    );
\slv_reg0_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[23]_i_1_n_0\,
      D => s00_axi_wdata(22),
      Q => slv_reg0(22),
      R => reset
    );
\slv_reg0_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[23]_i_1_n_0\,
      D => s00_axi_wdata(23),
      Q => slv_reg0(23),
      R => reset
    );
\slv_reg0_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[31]_i_1_n_0\,
      D => s00_axi_wdata(24),
      Q => slv_reg0(24),
      R => reset
    );
\slv_reg0_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[31]_i_1_n_0\,
      D => s00_axi_wdata(25),
      Q => slv_reg0(25),
      R => reset
    );
\slv_reg0_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[31]_i_1_n_0\,
      D => s00_axi_wdata(26),
      Q => slv_reg0(26),
      R => reset
    );
\slv_reg0_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[31]_i_1_n_0\,
      D => s00_axi_wdata(27),
      Q => slv_reg0(27),
      R => reset
    );
\slv_reg0_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[31]_i_1_n_0\,
      D => s00_axi_wdata(28),
      Q => slv_reg0(28),
      R => reset
    );
\slv_reg0_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[31]_i_1_n_0\,
      D => s00_axi_wdata(29),
      Q => slv_reg0(29),
      R => reset
    );
\slv_reg0_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[7]_i_1_n_0\,
      D => s00_axi_wdata(2),
      Q => slv_reg0(2),
      R => reset
    );
\slv_reg0_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[31]_i_1_n_0\,
      D => s00_axi_wdata(30),
      Q => slv_reg0(30),
      R => reset
    );
\slv_reg0_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[31]_i_1_n_0\,
      D => s00_axi_wdata(31),
      Q => slv_reg0(31),
      R => reset
    );
\slv_reg0_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[7]_i_1_n_0\,
      D => s00_axi_wdata(3),
      Q => slv_reg0(3),
      R => reset
    );
\slv_reg0_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[7]_i_1_n_0\,
      D => s00_axi_wdata(4),
      Q => slv_reg0(4),
      R => reset
    );
\slv_reg0_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[7]_i_1_n_0\,
      D => s00_axi_wdata(5),
      Q => slv_reg0(5),
      R => reset
    );
\slv_reg0_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[7]_i_1_n_0\,
      D => s00_axi_wdata(6),
      Q => slv_reg0(6),
      R => reset
    );
\slv_reg0_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[7]_i_1_n_0\,
      D => s00_axi_wdata(7),
      Q => slv_reg0(7),
      R => reset
    );
\slv_reg0_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[15]_i_1_n_0\,
      D => s00_axi_wdata(8),
      Q => slv_reg0(8),
      R => reset
    );
\slv_reg0_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[15]_i_1_n_0\,
      D => s00_axi_wdata(9),
      Q => slv_reg0(9),
      R => reset
    );
\slv_reg1[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => \slv_reg_wren__2\,
      I1 => s00_axi_wstrb(1),
      I2 => p_0_in(0),
      I3 => p_0_in(1),
      O => \slv_reg1[15]_i_1_n_0\
    );
\slv_reg1[23]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => \slv_reg_wren__2\,
      I1 => s00_axi_wstrb(2),
      I2 => p_0_in(0),
      I3 => p_0_in(1),
      O => \slv_reg1[23]_i_1_n_0\
    );
\slv_reg1[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => \slv_reg_wren__2\,
      I1 => s00_axi_wstrb(3),
      I2 => p_0_in(0),
      I3 => p_0_in(1),
      O => \slv_reg1[31]_i_1_n_0\
    );
\slv_reg1[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => \slv_reg_wren__2\,
      I1 => s00_axi_wstrb(0),
      I2 => p_0_in(0),
      I3 => p_0_in(1),
      O => \slv_reg1[7]_i_1_n_0\
    );
\slv_reg1_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[7]_i_1_n_0\,
      D => s00_axi_wdata(0),
      Q => slv_reg1(0),
      R => reset
    );
\slv_reg1_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[15]_i_1_n_0\,
      D => s00_axi_wdata(10),
      Q => slv_reg1(10),
      R => reset
    );
\slv_reg1_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[15]_i_1_n_0\,
      D => s00_axi_wdata(11),
      Q => slv_reg1(11),
      R => reset
    );
\slv_reg1_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[15]_i_1_n_0\,
      D => s00_axi_wdata(12),
      Q => slv_reg1(12),
      R => reset
    );
\slv_reg1_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[15]_i_1_n_0\,
      D => s00_axi_wdata(13),
      Q => slv_reg1(13),
      R => reset
    );
\slv_reg1_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[15]_i_1_n_0\,
      D => s00_axi_wdata(14),
      Q => slv_reg1(14),
      R => reset
    );
\slv_reg1_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[15]_i_1_n_0\,
      D => s00_axi_wdata(15),
      Q => slv_reg1(15),
      R => reset
    );
\slv_reg1_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[23]_i_1_n_0\,
      D => s00_axi_wdata(16),
      Q => slv_reg1(16),
      R => reset
    );
\slv_reg1_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[23]_i_1_n_0\,
      D => s00_axi_wdata(17),
      Q => slv_reg1(17),
      R => reset
    );
\slv_reg1_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[23]_i_1_n_0\,
      D => s00_axi_wdata(18),
      Q => slv_reg1(18),
      R => reset
    );
\slv_reg1_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[23]_i_1_n_0\,
      D => s00_axi_wdata(19),
      Q => slv_reg1(19),
      R => reset
    );
\slv_reg1_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[7]_i_1_n_0\,
      D => s00_axi_wdata(1),
      Q => slv_reg1(1),
      R => reset
    );
\slv_reg1_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[23]_i_1_n_0\,
      D => s00_axi_wdata(20),
      Q => slv_reg1(20),
      R => reset
    );
\slv_reg1_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[23]_i_1_n_0\,
      D => s00_axi_wdata(21),
      Q => slv_reg1(21),
      R => reset
    );
\slv_reg1_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[23]_i_1_n_0\,
      D => s00_axi_wdata(22),
      Q => slv_reg1(22),
      R => reset
    );
\slv_reg1_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[23]_i_1_n_0\,
      D => s00_axi_wdata(23),
      Q => slv_reg1(23),
      R => reset
    );
\slv_reg1_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[31]_i_1_n_0\,
      D => s00_axi_wdata(24),
      Q => slv_reg1(24),
      R => reset
    );
\slv_reg1_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[31]_i_1_n_0\,
      D => s00_axi_wdata(25),
      Q => slv_reg1(25),
      R => reset
    );
\slv_reg1_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[31]_i_1_n_0\,
      D => s00_axi_wdata(26),
      Q => slv_reg1(26),
      R => reset
    );
\slv_reg1_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[31]_i_1_n_0\,
      D => s00_axi_wdata(27),
      Q => slv_reg1(27),
      R => reset
    );
\slv_reg1_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[31]_i_1_n_0\,
      D => s00_axi_wdata(28),
      Q => slv_reg1(28),
      R => reset
    );
\slv_reg1_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[31]_i_1_n_0\,
      D => s00_axi_wdata(29),
      Q => slv_reg1(29),
      R => reset
    );
\slv_reg1_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[7]_i_1_n_0\,
      D => s00_axi_wdata(2),
      Q => slv_reg1(2),
      R => reset
    );
\slv_reg1_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[31]_i_1_n_0\,
      D => s00_axi_wdata(30),
      Q => slv_reg1(30),
      R => reset
    );
\slv_reg1_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[31]_i_1_n_0\,
      D => s00_axi_wdata(31),
      Q => slv_reg1(31),
      R => reset
    );
\slv_reg1_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[7]_i_1_n_0\,
      D => s00_axi_wdata(3),
      Q => slv_reg1(3),
      R => reset
    );
\slv_reg1_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[7]_i_1_n_0\,
      D => s00_axi_wdata(4),
      Q => slv_reg1(4),
      R => reset
    );
\slv_reg1_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[7]_i_1_n_0\,
      D => s00_axi_wdata(5),
      Q => slv_reg1(5),
      R => reset
    );
\slv_reg1_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[7]_i_1_n_0\,
      D => s00_axi_wdata(6),
      Q => slv_reg1(6),
      R => reset
    );
\slv_reg1_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[7]_i_1_n_0\,
      D => s00_axi_wdata(7),
      Q => slv_reg1(7),
      R => reset
    );
\slv_reg1_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[15]_i_1_n_0\,
      D => s00_axi_wdata(8),
      Q => slv_reg1(8),
      R => reset
    );
\slv_reg1_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[15]_i_1_n_0\,
      D => s00_axi_wdata(9),
      Q => slv_reg1(9),
      R => reset
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_my_uart_int_0_0_my_uart_int_v1_0 is
  port (
    s00_axi_awready : out STD_LOGIC;
    tx : out STD_LOGIC;
    s00_axi_wready : out STD_LOGIC;
    s00_axi_arready : out STD_LOGIC;
    s00_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_intr_wready : out STD_LOGIC;
    s_axi_intr_awready : out STD_LOGIC;
    s_axi_intr_arready : out STD_LOGIC;
    s_axi_intr_rdata : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_rvalid : out STD_LOGIC;
    s_axi_intr_rvalid : out STD_LOGIC;
    s00_axi_bvalid : out STD_LOGIC;
    s_axi_intr_bvalid : out STD_LOGIC;
    irq : out STD_LOGIC;
    s_axi_intr_aresetn : in STD_LOGIC;
    s00_axi_aresetn : in STD_LOGIC;
    s_axi_intr_aclk : in STD_LOGIC;
    s00_axi_aclk : in STD_LOGIC;
    s00_axi_awaddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_wvalid : in STD_LOGIC;
    s00_axi_awvalid : in STD_LOGIC;
    s00_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    rx : in STD_LOGIC;
    s00_axi_araddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_arvalid : in STD_LOGIC;
    s_axi_intr_awaddr : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_intr_awvalid : in STD_LOGIC;
    s_axi_intr_wvalid : in STD_LOGIC;
    s_axi_intr_araddr : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_intr_arvalid : in STD_LOGIC;
    s00_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_intr_wdata : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_bready : in STD_LOGIC;
    s00_axi_rready : in STD_LOGIC;
    s_axi_intr_bready : in STD_LOGIC;
    s_axi_intr_rready : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_my_uart_int_0_0_my_uart_int_v1_0 : entity is "my_uart_int_v1_0";
end design_1_my_uart_int_0_0_my_uart_int_v1_0;

architecture STRUCTURE of design_1_my_uart_int_0_0_my_uart_int_v1_0 is
  signal rda_to_intr : STD_LOGIC;
  signal tx_busy_to_intr : STD_LOGIC;
begin
my_uart_int_v1_0_S00_AXI_inst: entity work.design_1_my_uart_int_0_0_my_uart_int_v1_0_S00_AXI
     port map (
      axi_arready_reg_0 => s00_axi_arready,
      axi_awready_reg_0 => s00_axi_awready,
      axi_wready_reg_0 => s00_axi_wready,
      rda_to_intr => rda_to_intr,
      rx => rx,
      s00_axi_aclk => s00_axi_aclk,
      s00_axi_araddr(1 downto 0) => s00_axi_araddr(1 downto 0),
      s00_axi_aresetn => s00_axi_aresetn,
      s00_axi_arvalid => s00_axi_arvalid,
      s00_axi_awaddr(1 downto 0) => s00_axi_awaddr(1 downto 0),
      s00_axi_awvalid => s00_axi_awvalid,
      s00_axi_bready => s00_axi_bready,
      s00_axi_bvalid => s00_axi_bvalid,
      s00_axi_rdata(31 downto 0) => s00_axi_rdata(31 downto 0),
      s00_axi_rready => s00_axi_rready,
      s00_axi_rvalid => s00_axi_rvalid,
      s00_axi_wdata(31 downto 0) => s00_axi_wdata(31 downto 0),
      s00_axi_wstrb(3 downto 0) => s00_axi_wstrb(3 downto 0),
      s00_axi_wvalid => s00_axi_wvalid,
      tx => tx,
      tx_busy_to_intr => tx_busy_to_intr
    );
my_uart_int_v1_0_S_AXI_INTR_inst: entity work.design_1_my_uart_int_0_0_my_uart_int_v1_0_S_AXI_INTR
     port map (
      axi_arready_reg_0 => s_axi_intr_arready,
      axi_awready_reg_0 => s_axi_intr_awready,
      axi_wready_reg_0 => s_axi_intr_wready,
      irq => irq,
      rda_to_intr => rda_to_intr,
      s_axi_intr_aclk => s_axi_intr_aclk,
      s_axi_intr_araddr(2 downto 0) => s_axi_intr_araddr(2 downto 0),
      s_axi_intr_aresetn => s_axi_intr_aresetn,
      s_axi_intr_arvalid => s_axi_intr_arvalid,
      s_axi_intr_awaddr(2 downto 0) => s_axi_intr_awaddr(2 downto 0),
      s_axi_intr_awvalid => s_axi_intr_awvalid,
      s_axi_intr_bready => s_axi_intr_bready,
      s_axi_intr_bvalid => s_axi_intr_bvalid,
      s_axi_intr_rdata(1 downto 0) => s_axi_intr_rdata(1 downto 0),
      s_axi_intr_rready => s_axi_intr_rready,
      s_axi_intr_rvalid => s_axi_intr_rvalid,
      s_axi_intr_wdata(1 downto 0) => s_axi_intr_wdata(1 downto 0),
      s_axi_intr_wvalid => s_axi_intr_wvalid,
      tx_busy_to_intr => tx_busy_to_intr
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_my_uart_int_0_0 is
  port (
    tx : out STD_LOGIC;
    rx : in STD_LOGIC;
    s_axi_intr_awaddr : in STD_LOGIC_VECTOR ( 4 downto 0 );
    s_axi_intr_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_intr_awvalid : in STD_LOGIC;
    s_axi_intr_awready : out STD_LOGIC;
    s_axi_intr_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_intr_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_intr_wvalid : in STD_LOGIC;
    s_axi_intr_wready : out STD_LOGIC;
    s_axi_intr_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_intr_bvalid : out STD_LOGIC;
    s_axi_intr_bready : in STD_LOGIC;
    s_axi_intr_araddr : in STD_LOGIC_VECTOR ( 4 downto 0 );
    s_axi_intr_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_intr_arvalid : in STD_LOGIC;
    s_axi_intr_arready : out STD_LOGIC;
    s_axi_intr_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_intr_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_intr_rvalid : out STD_LOGIC;
    s_axi_intr_rready : in STD_LOGIC;
    s_axi_intr_aclk : in STD_LOGIC;
    s_axi_intr_aresetn : in STD_LOGIC;
    irq : out STD_LOGIC;
    s00_axi_awaddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s00_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s00_axi_awvalid : in STD_LOGIC;
    s00_axi_awready : out STD_LOGIC;
    s00_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s00_axi_wvalid : in STD_LOGIC;
    s00_axi_wready : out STD_LOGIC;
    s00_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_bvalid : out STD_LOGIC;
    s00_axi_bready : in STD_LOGIC;
    s00_axi_araddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s00_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s00_axi_arvalid : in STD_LOGIC;
    s00_axi_arready : out STD_LOGIC;
    s00_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_rvalid : out STD_LOGIC;
    s00_axi_rready : in STD_LOGIC;
    s00_axi_aclk : in STD_LOGIC;
    s00_axi_aresetn : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_my_uart_int_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_my_uart_int_0_0 : entity is "design_1_my_uart_int_0_0,my_uart_int_v1_0,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of design_1_my_uart_int_0_0 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of design_1_my_uart_int_0_0 : entity is "my_uart_int_v1_0,Vivado 2018.3";
end design_1_my_uart_int_0_0;

architecture STRUCTURE of design_1_my_uart_int_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \^s_axi_intr_rdata\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute x_interface_info : string;
  attribute x_interface_info of irq : signal is "xilinx.com:signal:interrupt:1.0 IRQ INTERRUPT";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of irq : signal is "XIL_INTERFACENAME IRQ, SENSITIVITY LEVEL_HIGH, PortWidth 1";
  attribute x_interface_info of s00_axi_aclk : signal is "xilinx.com:signal:clock:1.0 S00_AXI_CLK CLK";
  attribute x_interface_parameter of s00_axi_aclk : signal is "XIL_INTERFACENAME S00_AXI_CLK, ASSOCIATED_BUSIF S00_AXI, ASSOCIATED_RESET s00_axi_aresetn, FREQ_HZ 5e+07, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
  attribute x_interface_info of s00_axi_aresetn : signal is "xilinx.com:signal:reset:1.0 S00_AXI_RST RST";
  attribute x_interface_parameter of s00_axi_aresetn : signal is "XIL_INTERFACENAME S00_AXI_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute x_interface_info of s00_axi_arready : signal is "xilinx.com:interface:aximm:1.0 S00_AXI ARREADY";
  attribute x_interface_info of s00_axi_arvalid : signal is "xilinx.com:interface:aximm:1.0 S00_AXI ARVALID";
  attribute x_interface_info of s00_axi_awready : signal is "xilinx.com:interface:aximm:1.0 S00_AXI AWREADY";
  attribute x_interface_info of s00_axi_awvalid : signal is "xilinx.com:interface:aximm:1.0 S00_AXI AWVALID";
  attribute x_interface_info of s00_axi_bready : signal is "xilinx.com:interface:aximm:1.0 S00_AXI BREADY";
  attribute x_interface_info of s00_axi_bvalid : signal is "xilinx.com:interface:aximm:1.0 S00_AXI BVALID";
  attribute x_interface_info of s00_axi_rready : signal is "xilinx.com:interface:aximm:1.0 S00_AXI RREADY";
  attribute x_interface_info of s00_axi_rvalid : signal is "xilinx.com:interface:aximm:1.0 S00_AXI RVALID";
  attribute x_interface_info of s00_axi_wready : signal is "xilinx.com:interface:aximm:1.0 S00_AXI WREADY";
  attribute x_interface_info of s00_axi_wvalid : signal is "xilinx.com:interface:aximm:1.0 S00_AXI WVALID";
  attribute x_interface_info of s_axi_intr_aclk : signal is "xilinx.com:signal:clock:1.0 S_AXI_INTR_CLK CLK";
  attribute x_interface_parameter of s_axi_intr_aclk : signal is "XIL_INTERFACENAME S_AXI_INTR_CLK, ASSOCIATED_BUSIF S_AXI_INTR, ASSOCIATED_RESET s_axi_intr_aresetn, FREQ_HZ 5e+07, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
  attribute x_interface_info of s_axi_intr_aresetn : signal is "xilinx.com:signal:reset:1.0 S_AXI_INTR_RST RST";
  attribute x_interface_parameter of s_axi_intr_aresetn : signal is "XIL_INTERFACENAME S_AXI_INTR_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute x_interface_info of s_axi_intr_arready : signal is "xilinx.com:interface:aximm:1.0 S_AXI_INTR ARREADY";
  attribute x_interface_info of s_axi_intr_arvalid : signal is "xilinx.com:interface:aximm:1.0 S_AXI_INTR ARVALID";
  attribute x_interface_info of s_axi_intr_awready : signal is "xilinx.com:interface:aximm:1.0 S_AXI_INTR AWREADY";
  attribute x_interface_info of s_axi_intr_awvalid : signal is "xilinx.com:interface:aximm:1.0 S_AXI_INTR AWVALID";
  attribute x_interface_info of s_axi_intr_bready : signal is "xilinx.com:interface:aximm:1.0 S_AXI_INTR BREADY";
  attribute x_interface_info of s_axi_intr_bvalid : signal is "xilinx.com:interface:aximm:1.0 S_AXI_INTR BVALID";
  attribute x_interface_info of s_axi_intr_rready : signal is "xilinx.com:interface:aximm:1.0 S_AXI_INTR RREADY";
  attribute x_interface_info of s_axi_intr_rvalid : signal is "xilinx.com:interface:aximm:1.0 S_AXI_INTR RVALID";
  attribute x_interface_info of s_axi_intr_wready : signal is "xilinx.com:interface:aximm:1.0 S_AXI_INTR WREADY";
  attribute x_interface_info of s_axi_intr_wvalid : signal is "xilinx.com:interface:aximm:1.0 S_AXI_INTR WVALID";
  attribute x_interface_info of s00_axi_araddr : signal is "xilinx.com:interface:aximm:1.0 S00_AXI ARADDR";
  attribute x_interface_info of s00_axi_arprot : signal is "xilinx.com:interface:aximm:1.0 S00_AXI ARPROT";
  attribute x_interface_info of s00_axi_awaddr : signal is "xilinx.com:interface:aximm:1.0 S00_AXI AWADDR";
  attribute x_interface_parameter of s00_axi_awaddr : signal is "XIL_INTERFACENAME S00_AXI, WIZ_DATA_WIDTH 32, WIZ_NUM_REG 4, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 5e+07, ID_WIDTH 0, ADDR_WIDTH 4, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute x_interface_info of s00_axi_awprot : signal is "xilinx.com:interface:aximm:1.0 S00_AXI AWPROT";
  attribute x_interface_info of s00_axi_bresp : signal is "xilinx.com:interface:aximm:1.0 S00_AXI BRESP";
  attribute x_interface_info of s00_axi_rdata : signal is "xilinx.com:interface:aximm:1.0 S00_AXI RDATA";
  attribute x_interface_info of s00_axi_rresp : signal is "xilinx.com:interface:aximm:1.0 S00_AXI RRESP";
  attribute x_interface_info of s00_axi_wdata : signal is "xilinx.com:interface:aximm:1.0 S00_AXI WDATA";
  attribute x_interface_info of s00_axi_wstrb : signal is "xilinx.com:interface:aximm:1.0 S00_AXI WSTRB";
  attribute x_interface_info of s_axi_intr_araddr : signal is "xilinx.com:interface:aximm:1.0 S_AXI_INTR ARADDR";
  attribute x_interface_info of s_axi_intr_arprot : signal is "xilinx.com:interface:aximm:1.0 S_AXI_INTR ARPROT";
  attribute x_interface_info of s_axi_intr_awaddr : signal is "xilinx.com:interface:aximm:1.0 S_AXI_INTR AWADDR";
  attribute x_interface_parameter of s_axi_intr_awaddr : signal is "XIL_INTERFACENAME S_AXI_INTR, WIZ_DATA_WIDTH 32, WIZ_NUM_REG 5, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 5e+07, ID_WIDTH 0, ADDR_WIDTH 5, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute x_interface_info of s_axi_intr_awprot : signal is "xilinx.com:interface:aximm:1.0 S_AXI_INTR AWPROT";
  attribute x_interface_info of s_axi_intr_bresp : signal is "xilinx.com:interface:aximm:1.0 S_AXI_INTR BRESP";
  attribute x_interface_info of s_axi_intr_rdata : signal is "xilinx.com:interface:aximm:1.0 S_AXI_INTR RDATA";
  attribute x_interface_info of s_axi_intr_rresp : signal is "xilinx.com:interface:aximm:1.0 S_AXI_INTR RRESP";
  attribute x_interface_info of s_axi_intr_wdata : signal is "xilinx.com:interface:aximm:1.0 S_AXI_INTR WDATA";
  attribute x_interface_info of s_axi_intr_wstrb : signal is "xilinx.com:interface:aximm:1.0 S_AXI_INTR WSTRB";
begin
  s00_axi_bresp(1) <= \<const0>\;
  s00_axi_bresp(0) <= \<const0>\;
  s00_axi_rresp(1) <= \<const0>\;
  s00_axi_rresp(0) <= \<const0>\;
  s_axi_intr_bresp(1) <= \<const0>\;
  s_axi_intr_bresp(0) <= \<const0>\;
  s_axi_intr_rdata(31) <= \<const0>\;
  s_axi_intr_rdata(30) <= \<const0>\;
  s_axi_intr_rdata(29) <= \<const0>\;
  s_axi_intr_rdata(28) <= \<const0>\;
  s_axi_intr_rdata(27) <= \<const0>\;
  s_axi_intr_rdata(26) <= \<const0>\;
  s_axi_intr_rdata(25) <= \<const0>\;
  s_axi_intr_rdata(24) <= \<const0>\;
  s_axi_intr_rdata(23) <= \<const0>\;
  s_axi_intr_rdata(22) <= \<const0>\;
  s_axi_intr_rdata(21) <= \<const0>\;
  s_axi_intr_rdata(20) <= \<const0>\;
  s_axi_intr_rdata(19) <= \<const0>\;
  s_axi_intr_rdata(18) <= \<const0>\;
  s_axi_intr_rdata(17) <= \<const0>\;
  s_axi_intr_rdata(16) <= \<const0>\;
  s_axi_intr_rdata(15) <= \<const0>\;
  s_axi_intr_rdata(14) <= \<const0>\;
  s_axi_intr_rdata(13) <= \<const0>\;
  s_axi_intr_rdata(12) <= \<const0>\;
  s_axi_intr_rdata(11) <= \<const0>\;
  s_axi_intr_rdata(10) <= \<const0>\;
  s_axi_intr_rdata(9) <= \<const0>\;
  s_axi_intr_rdata(8) <= \<const0>\;
  s_axi_intr_rdata(7) <= \<const0>\;
  s_axi_intr_rdata(6) <= \<const0>\;
  s_axi_intr_rdata(5) <= \<const0>\;
  s_axi_intr_rdata(4) <= \<const0>\;
  s_axi_intr_rdata(3) <= \<const0>\;
  s_axi_intr_rdata(2) <= \<const0>\;
  s_axi_intr_rdata(1 downto 0) <= \^s_axi_intr_rdata\(1 downto 0);
  s_axi_intr_rresp(1) <= \<const0>\;
  s_axi_intr_rresp(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
U0: entity work.design_1_my_uart_int_0_0_my_uart_int_v1_0
     port map (
      irq => irq,
      rx => rx,
      s00_axi_aclk => s00_axi_aclk,
      s00_axi_araddr(1 downto 0) => s00_axi_araddr(3 downto 2),
      s00_axi_aresetn => s00_axi_aresetn,
      s00_axi_arready => s00_axi_arready,
      s00_axi_arvalid => s00_axi_arvalid,
      s00_axi_awaddr(1 downto 0) => s00_axi_awaddr(3 downto 2),
      s00_axi_awready => s00_axi_awready,
      s00_axi_awvalid => s00_axi_awvalid,
      s00_axi_bready => s00_axi_bready,
      s00_axi_bvalid => s00_axi_bvalid,
      s00_axi_rdata(31 downto 0) => s00_axi_rdata(31 downto 0),
      s00_axi_rready => s00_axi_rready,
      s00_axi_rvalid => s00_axi_rvalid,
      s00_axi_wdata(31 downto 0) => s00_axi_wdata(31 downto 0),
      s00_axi_wready => s00_axi_wready,
      s00_axi_wstrb(3 downto 0) => s00_axi_wstrb(3 downto 0),
      s00_axi_wvalid => s00_axi_wvalid,
      s_axi_intr_aclk => s_axi_intr_aclk,
      s_axi_intr_araddr(2 downto 0) => s_axi_intr_araddr(4 downto 2),
      s_axi_intr_aresetn => s_axi_intr_aresetn,
      s_axi_intr_arready => s_axi_intr_arready,
      s_axi_intr_arvalid => s_axi_intr_arvalid,
      s_axi_intr_awaddr(2 downto 0) => s_axi_intr_awaddr(4 downto 2),
      s_axi_intr_awready => s_axi_intr_awready,
      s_axi_intr_awvalid => s_axi_intr_awvalid,
      s_axi_intr_bready => s_axi_intr_bready,
      s_axi_intr_bvalid => s_axi_intr_bvalid,
      s_axi_intr_rdata(1 downto 0) => \^s_axi_intr_rdata\(1 downto 0),
      s_axi_intr_rready => s_axi_intr_rready,
      s_axi_intr_rvalid => s_axi_intr_rvalid,
      s_axi_intr_wdata(1 downto 0) => s_axi_intr_wdata(1 downto 0),
      s_axi_intr_wready => s_axi_intr_wready,
      s_axi_intr_wvalid => s_axi_intr_wvalid,
      tx => tx
    );
end STRUCTURE;
