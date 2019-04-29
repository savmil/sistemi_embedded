// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Tue Mar 26 20:51:52 2019
// Host        : saverio-UX530UX running 64-bit Ubuntu 16.04.6 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/saverio/GPIO_ARRAY/gpio_array.srcs/sources_1/bd/gpio_arr/ip/gpio_arr_gpio_array_0_0/gpio_arr_gpio_array_0_0_stub.v
// Design      : gpio_arr_gpio_array_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "gpio_array,Vivado 2018.2" *)
module gpio_arr_gpio_array_0_0(inputs, enable, outputs)
/* synthesis syn_black_box black_box_pad_pin="inputs[3:0],enable[3:0],outputs[3:0]" */;
  input [3:0]inputs;
  input [3:0]enable;
  output [3:0]outputs;
endmodule
