// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Tue Mar 26 20:51:48 2019
// Host        : saverio-UX530UX running 64-bit Ubuntu 16.04.6 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/saverio/GPIO_ARRAY/gpio_array.srcs/sources_1/bd/gpio_arr/ip/gpio_arr_vio_0_1/gpio_arr_vio_0_1_stub.v
// Design      : gpio_arr_vio_0_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2018.2" *)
module gpio_arr_vio_0_1(clk, probe_in0, probe_out0, probe_out1)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_in0[3:0],probe_out0[3:0],probe_out1[3:0]" */;
  input clk;
  input [3:0]probe_in0;
  output [3:0]probe_out0;
  output [3:0]probe_out1;
endmodule
