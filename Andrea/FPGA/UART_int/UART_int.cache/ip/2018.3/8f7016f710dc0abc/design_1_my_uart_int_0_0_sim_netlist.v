// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
// Date        : Tue Apr 30 18:59:02 2019
// Host        : andrea-X580VD running 64-bit Ubuntu 18.04.2 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_my_uart_int_0_0_sim_netlist.v
// Design      : design_1_my_uart_int_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_UART
   (SR,
    D,
    E,
    tx,
    s00_axi_aclk,
    s00_axi_aresetn,
    Q,
    axi_araddr,
    \axi_rdata_reg[8] ,
    rx,
    \axi_rdata_reg[2] );
  output [0:0]SR;
  output [8:0]D;
  output [0:0]E;
  output tx;
  input s00_axi_aclk;
  input s00_axi_aresetn;
  input [8:0]Q;
  input [1:0]axi_araddr;
  input [7:0]\axi_rdata_reg[8] ;
  input rx;
  input \axi_rdata_reg[2] ;

  wire [8:0]D;
  wire [0:0]E;
  wire Holding_register_n_7;
  wire [8:0]Q;
  wire [0:0]SR;
  wire [1:0]axi_araddr;
  wire \axi_rdata_reg[2] ;
  wire [7:0]\axi_rdata_reg[8] ;
  wire clock_out;
  wire load_data;
  wire [7:0]received_data;
  wire rx;
  wire s00_axi_aclk;
  wire s00_axi_aresetn;
  wire [4:1]slv_reg3_out;
  wire tx;
  wire tx_clock;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_clock_mod BAUDGENERATOR
       (.clock_out(clock_out),
        .s00_axi_aclk(s00_axi_aclk));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_d_ff_register Holding_register
       (.D({D[7:5],D[3],D[0]}),
        .Q({Q[7:5],Q[3],Q[0]}),
        .SS(SR),
        .axi_araddr(axi_araddr),
        .\axi_araddr_reg[3] (Holding_register_n_7),
        .\axi_rdata_reg[7] ({\axi_rdata_reg[8] [6:4],\axi_rdata_reg[8] [2],\axi_rdata_reg[8] [0]}),
        .\q_reg[4]_0 ({slv_reg3_out[4],slv_reg3_out[1]}),
        .\q_reg[7]_0 (load_data),
        .\q_reg[7]_1 (received_data),
        .s00_axi_aclk(s00_axi_aclk));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_rx_cu RX_UART
       (.D({D[8],D[2:1]}),
        .\FSM_onehot_current_state_reg[4]_0 (load_data),
        .Q({Q[8],Q[1]}),
        .SS(SR),
        .axi_araddr(axi_araddr),
        .\axi_rdata_reg[1] (slv_reg3_out[1]),
        .\axi_rdata_reg[2] (Holding_register_n_7),
        .\axi_rdata_reg[2]_0 (\axi_rdata_reg[2] ),
        .\axi_rdata_reg[8] ({\axi_rdata_reg[8] [7],\axi_rdata_reg[8] [1]}),
        .clock_out(clock_out),
        .rx(rx),
        .s00_axi_aresetn(s00_axi_aresetn),
        .\tmp_sig_reg[7] (received_data));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tx_cu TX_UART
       (.CLK(tx_clock),
        .D(D[4]),
        .E(E),
        .Q(Q[7:0]),
        .SS(SR),
        .axi_araddr(axi_araddr),
        .\axi_rdata_reg[4] (slv_reg3_out[4]),
        .\axi_rdata_reg[4]_0 ({\axi_rdata_reg[8] [3],\axi_rdata_reg[8] [0]}),
        .s00_axi_aresetn(s00_axi_aresetn),
        .tx(tx));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_clock_mod__parameterized1 tx_clock_mod
       (.CLK(tx_clock),
        .clock_out(clock_out));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_clock_mod
   (clock_out,
    s00_axi_aclk);
  output clock_out;
  input s00_axi_aclk;

  wire clock_out;
  wire clock_tmp_i_1__0_n_0;
  wire clock_tmp_i_2_n_0;
  wire \count[0]_i_1_n_0 ;
  wire \count[7]_i_1_n_0 ;
  wire \count[7]_i_3_n_0 ;
  wire \count[7]_i_4_n_0 ;
  wire \count_reg_n_0_[0] ;
  wire \count_reg_n_0_[1] ;
  wire \count_reg_n_0_[2] ;
  wire \count_reg_n_0_[3] ;
  wire \count_reg_n_0_[4] ;
  wire \count_reg_n_0_[5] ;
  wire \count_reg_n_0_[6] ;
  wire \count_reg_n_0_[7] ;
  wire [7:1]data0;
  wire s00_axi_aclk;

  LUT6 #(
    .INIT(64'hFFFFFFFE00000001)) 
    clock_tmp_i_1__0
       (.I0(clock_tmp_i_2_n_0),
        .I1(\count_reg_n_0_[2] ),
        .I2(\count_reg_n_0_[6] ),
        .I3(\count_reg_n_0_[4] ),
        .I4(\count_reg_n_0_[1] ),
        .I5(clock_out),
        .O(clock_tmp_i_1__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'hDFFF)) 
    clock_tmp_i_2
       (.I0(\count_reg_n_0_[7] ),
        .I1(\count_reg_n_0_[3] ),
        .I2(\count_reg_n_0_[0] ),
        .I3(\count_reg_n_0_[5] ),
        .O(clock_tmp_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    clock_tmp_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(clock_tmp_i_1__0_n_0),
        .Q(clock_out),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \count[0]_i_1 
       (.I0(\count_reg_n_0_[0] ),
        .O(\count[0]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \count[1]_i_1 
       (.I0(\count_reg_n_0_[0] ),
        .I1(\count_reg_n_0_[1] ),
        .O(data0[1]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \count[2]_i_1 
       (.I0(\count_reg_n_0_[0] ),
        .I1(\count_reg_n_0_[1] ),
        .I2(\count_reg_n_0_[2] ),
        .O(data0[2]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \count[3]_i_1__0 
       (.I0(\count_reg_n_0_[1] ),
        .I1(\count_reg_n_0_[0] ),
        .I2(\count_reg_n_0_[2] ),
        .I3(\count_reg_n_0_[3] ),
        .O(data0[3]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \count[4]_i_1 
       (.I0(\count_reg_n_0_[2] ),
        .I1(\count_reg_n_0_[0] ),
        .I2(\count_reg_n_0_[1] ),
        .I3(\count_reg_n_0_[3] ),
        .I4(\count_reg_n_0_[4] ),
        .O(data0[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \count[5]_i_1 
       (.I0(\count_reg_n_0_[3] ),
        .I1(\count_reg_n_0_[1] ),
        .I2(\count_reg_n_0_[0] ),
        .I3(\count_reg_n_0_[2] ),
        .I4(\count_reg_n_0_[4] ),
        .I5(\count_reg_n_0_[5] ),
        .O(data0[5]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \count[6]_i_1 
       (.I0(\count[7]_i_4_n_0 ),
        .I1(\count_reg_n_0_[6] ),
        .O(data0[6]));
  LUT5 #(
    .INIT(32'h00004000)) 
    \count[7]_i_1 
       (.I0(\count_reg_n_0_[6] ),
        .I1(\count_reg_n_0_[5] ),
        .I2(\count_reg_n_0_[0] ),
        .I3(\count_reg_n_0_[7] ),
        .I4(\count[7]_i_3_n_0 ),
        .O(\count[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \count[7]_i_2 
       (.I0(\count[7]_i_4_n_0 ),
        .I1(\count_reg_n_0_[6] ),
        .I2(\count_reg_n_0_[7] ),
        .O(data0[7]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \count[7]_i_3 
       (.I0(\count_reg_n_0_[2] ),
        .I1(\count_reg_n_0_[3] ),
        .I2(\count_reg_n_0_[4] ),
        .I3(\count_reg_n_0_[1] ),
        .O(\count[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \count[7]_i_4 
       (.I0(\count_reg_n_0_[5] ),
        .I1(\count_reg_n_0_[3] ),
        .I2(\count_reg_n_0_[1] ),
        .I3(\count_reg_n_0_[0] ),
        .I4(\count_reg_n_0_[2] ),
        .I5(\count_reg_n_0_[4] ),
        .O(\count[7]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[0] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\count[0]_i_1_n_0 ),
        .Q(\count_reg_n_0_[0] ),
        .R(\count[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[1] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(data0[1]),
        .Q(\count_reg_n_0_[1] ),
        .R(\count[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[2] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(data0[2]),
        .Q(\count_reg_n_0_[2] ),
        .R(\count[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[3] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(data0[3]),
        .Q(\count_reg_n_0_[3] ),
        .R(\count[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[4] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(data0[4]),
        .Q(\count_reg_n_0_[4] ),
        .R(\count[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[5] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(data0[5]),
        .Q(\count_reg_n_0_[5] ),
        .R(\count[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[6] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(data0[6]),
        .Q(\count_reg_n_0_[6] ),
        .R(\count[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[7] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(data0[7]),
        .Q(\count_reg_n_0_[7] ),
        .R(\count[7]_i_1_n_0 ));
endmodule

(* ORIG_REF_NAME = "clock_mod" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_clock_mod__parameterized1
   (CLK,
    clock_out);
  output CLK;
  input clock_out;

  wire CLK;
  wire clock_out;
  wire clock_tmp_i_1_n_0;
  wire [3:0]count;
  wire \count[0]_i_1_n_0 ;
  wire \count[1]_i_1_n_0 ;
  wire \count[2]_i_1_n_0 ;
  wire \count[3]_i_1__1_n_0 ;
  wire \count[3]_i_2_n_0 ;

  LUT5 #(
    .INIT(32'hFFFB0004)) 
    clock_tmp_i_1
       (.I0(count[0]),
        .I1(count[3]),
        .I2(count[1]),
        .I3(count[2]),
        .I4(CLK),
        .O(clock_tmp_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    clock_tmp_reg
       (.C(clock_out),
        .CE(1'b1),
        .D(clock_tmp_i_1_n_0),
        .Q(CLK),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \count[0]_i_1 
       (.I0(count[0]),
        .O(\count[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \count[1]_i_1 
       (.I0(count[0]),
        .I1(count[1]),
        .O(\count[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \count[2]_i_1 
       (.I0(count[0]),
        .I1(count[1]),
        .I2(count[2]),
        .O(\count[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0002)) 
    \count[3]_i_1__1 
       (.I0(count[3]),
        .I1(count[2]),
        .I2(count[0]),
        .I3(count[1]),
        .O(\count[3]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \count[3]_i_2 
       (.I0(count[1]),
        .I1(count[0]),
        .I2(count[2]),
        .I3(count[3]),
        .O(\count[3]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[0] 
       (.C(clock_out),
        .CE(1'b1),
        .D(\count[0]_i_1_n_0 ),
        .Q(count[0]),
        .R(\count[3]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[1] 
       (.C(clock_out),
        .CE(1'b1),
        .D(\count[1]_i_1_n_0 ),
        .Q(count[1]),
        .R(\count[3]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[2] 
       (.C(clock_out),
        .CE(1'b1),
        .D(\count[2]_i_1_n_0 ),
        .Q(count[2]),
        .R(\count[3]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[3] 
       (.C(clock_out),
        .CE(1'b1),
        .D(\count[3]_i_2_n_0 ),
        .Q(count[3]),
        .R(\count[3]_i_1__1_n_0 ));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_counter_modN
   (\slv_reg1_reg[0] ,
    CLK,
    current_state,
    \FSM_sequential_current_state_reg[0] ,
    s00_axi_aresetn);
  output \slv_reg1_reg[0] ;
  input CLK;
  input [1:0]current_state;
  input [0:0]\FSM_sequential_current_state_reg[0] ;
  input s00_axi_aresetn;

  wire CLK;
  wire [0:0]\FSM_sequential_current_state_reg[0] ;
  wire [3:0]count;
  wire \count[0]_i_1__0_n_0 ;
  wire \count[1]_i_1_n_0 ;
  wire \count[2]_i_1_n_0 ;
  wire \count[3]_i_2_n_0 ;
  wire counter_hit__0;
  wire counter_hit_n_0;
  wire [1:0]current_state;
  wire reset_counter;
  wire s00_axi_aresetn;
  wire shift_en;
  wire \slv_reg1_reg[0] ;

  LUT5 #(
    .INIT(32'h32020000)) 
    \FSM_sequential_current_state[0]_i_1 
       (.I0(\FSM_sequential_current_state_reg[0] ),
        .I1(current_state[0]),
        .I2(current_state[1]),
        .I3(counter_hit__0),
        .I4(s00_axi_aresetn),
        .O(\slv_reg1_reg[0] ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'h00BF)) 
    \count[0]_i_1__0 
       (.I0(count[2]),
        .I1(count[3]),
        .I2(count[1]),
        .I3(count[0]),
        .O(\count[0]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'h23CC)) 
    \count[1]_i_1 
       (.I0(count[2]),
        .I1(count[0]),
        .I2(count[3]),
        .I3(count[1]),
        .O(\count[1]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h6A)) 
    \count[2]_i_1 
       (.I0(count[2]),
        .I1(count[0]),
        .I2(count[1]),
        .O(\count[2]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \count[3]_i_1 
       (.I0(current_state[1]),
        .I1(current_state[0]),
        .O(shift_en));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'h68F0)) 
    \count[3]_i_2 
       (.I0(count[2]),
        .I1(count[0]),
        .I2(count[3]),
        .I3(count[1]),
        .O(\count[3]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \count[3]_i_3 
       (.I0(current_state[0]),
        .I1(current_state[1]),
        .O(reset_counter));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[0] 
       (.C(CLK),
        .CE(shift_en),
        .CLR(reset_counter),
        .D(\count[0]_i_1__0_n_0 ),
        .Q(count[0]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[1] 
       (.C(CLK),
        .CE(shift_en),
        .CLR(reset_counter),
        .D(\count[1]_i_1_n_0 ),
        .Q(count[1]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[2] 
       (.C(CLK),
        .CE(shift_en),
        .CLR(reset_counter),
        .D(\count[2]_i_1_n_0 ),
        .Q(count[2]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[3] 
       (.C(CLK),
        .CE(shift_en),
        .CLR(reset_counter),
        .D(\count[3]_i_2_n_0 ),
        .Q(count[3]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'h1000)) 
    counter_hit
       (.I0(count[2]),
        .I1(count[0]),
        .I2(count[3]),
        .I3(count[1]),
        .O(counter_hit_n_0));
  FDCE counter_hit_reg
       (.C(CLK),
        .CE(shift_en),
        .CLR(reset_counter),
        .D(counter_hit_n_0),
        .Q(counter_hit__0));
endmodule

(* ORIG_REF_NAME = "counter_modN" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_counter_modN__parameterized1
   (counter_hit,
    D,
    Q,
    clock_out,
    AR,
    rx);
  output counter_hit;
  output [0:0]D;
  input [2:0]Q;
  input clock_out;
  input [0:0]AR;
  input rx;

  wire [0:0]AR;
  wire [0:0]D;
  wire [2:0]Q;
  wire clock_out;
  wire [2:0]count;
  wire \count[0]_i_1__1_n_0 ;
  wire \count[1]_i_1_n_0 ;
  wire \count[2]_i_1_n_0 ;
  wire counter_hit;
  wire counter_hit__0_n_0;
  wire rx;

  LUT5 #(
    .INIT(32'h54FF5454)) 
    \FSM_onehot_current_state[1]_i_1 
       (.I0(rx),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(counter_hit),
        .I4(Q[1]),
        .O(D));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \count[0]_i_1__1 
       (.I0(count[0]),
        .O(\count[0]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \count[1]_i_1 
       (.I0(count[1]),
        .I1(count[0]),
        .O(\count[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h6C)) 
    \count[2]_i_1 
       (.I0(count[1]),
        .I1(count[2]),
        .I2(count[0]),
        .O(\count[2]_i_1_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[0] 
       (.C(clock_out),
        .CE(Q[1]),
        .CLR(AR),
        .D(\count[0]_i_1__1_n_0 ),
        .Q(count[0]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[1] 
       (.C(clock_out),
        .CE(Q[1]),
        .CLR(AR),
        .D(\count[1]_i_1_n_0 ),
        .Q(count[1]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[2] 
       (.C(clock_out),
        .CE(Q[1]),
        .CLR(AR),
        .D(\count[2]_i_1_n_0 ),
        .Q(count[2]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h80)) 
    counter_hit__0
       (.I0(count[1]),
        .I1(count[2]),
        .I2(count[0]),
        .O(counter_hit__0_n_0));
  FDCE counter_hit_reg
       (.C(clock_out),
        .CE(Q[1]),
        .CLR(AR),
        .D(counter_hit__0_n_0),
        .Q(counter_hit));
endmodule

(* ORIG_REF_NAME = "counter_modN" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_counter_modN__parameterized3
   (D,
    Q,
    clock_out,
    done_bit_count,
    counter_hit);
  output [1:0]D;
  input [4:0]Q;
  input clock_out;
  input done_bit_count;
  input counter_hit;

  wire [1:0]D;
  wire [4:0]Q;
  wire clock_out;
  wire [3:0]count;
  wire \count[0]_i_1__2_n_0 ;
  wire \count[1]_i_1_n_0 ;
  wire \count[2]_i_1_n_0 ;
  wire \count[3]_i_1_n_0 ;
  wire counter_hit;
  wire counter_hit__0_n_0;
  wire done_16count;
  wire done_bit_count;
  wire reset_16count;

  LUT6 #(
    .INIT(64'hFFFF22F222F222F2)) 
    \FSM_onehot_current_state[2]_i_1 
       (.I0(Q[2]),
        .I1(done_16count),
        .I2(Q[3]),
        .I3(done_bit_count),
        .I4(counter_hit),
        .I5(Q[1]),
        .O(D[0]));
  LUT2 #(
    .INIT(4'h8)) 
    \FSM_onehot_current_state[3]_i_1 
       (.I0(Q[2]),
        .I1(done_16count),
        .O(D[1]));
  LUT1 #(
    .INIT(2'h1)) 
    \count[0]_i_1__2 
       (.I0(count[0]),
        .O(\count[0]_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \count[1]_i_1 
       (.I0(count[1]),
        .I1(count[0]),
        .O(\count[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \count[2]_i_1 
       (.I0(count[1]),
        .I1(count[0]),
        .I2(count[2]),
        .O(\count[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \count[3]_i_1 
       (.I0(count[1]),
        .I1(count[0]),
        .I2(count[2]),
        .I3(count[3]),
        .O(\count[3]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hFE)) 
    \count[3]_i_2 
       (.I0(Q[4]),
        .I1(Q[0]),
        .I2(Q[3]),
        .O(reset_16count));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[0] 
       (.C(clock_out),
        .CE(Q[2]),
        .CLR(reset_16count),
        .D(\count[0]_i_1__2_n_0 ),
        .Q(count[0]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[1] 
       (.C(clock_out),
        .CE(Q[2]),
        .CLR(reset_16count),
        .D(\count[1]_i_1_n_0 ),
        .Q(count[1]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[2] 
       (.C(clock_out),
        .CE(Q[2]),
        .CLR(reset_16count),
        .D(\count[2]_i_1_n_0 ),
        .Q(count[2]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[3] 
       (.C(clock_out),
        .CE(Q[2]),
        .CLR(reset_16count),
        .D(\count[3]_i_1_n_0 ),
        .Q(count[3]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    counter_hit__0
       (.I0(count[1]),
        .I1(count[0]),
        .I2(count[2]),
        .I3(count[3]),
        .O(counter_hit__0_n_0));
  FDCE counter_hit_reg
       (.C(clock_out),
        .CE(Q[2]),
        .CLR(reset_16count),
        .D(counter_hit__0_n_0),
        .Q(done_16count));
endmodule

(* ORIG_REF_NAME = "counter_modN" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_counter_modN__parameterized5
   (done_bit_count,
    AR,
    E,
    D,
    Q,
    clock_out);
  output done_bit_count;
  output [0:0]AR;
  output [0:0]E;
  output [0:0]D;
  input [2:0]Q;
  input clock_out;

  wire [0:0]AR;
  wire [0:0]D;
  wire [0:0]E;
  wire [2:0]Q;
  wire clock_out;
  wire [3:0]count;
  wire \count[0]_i_1__3_n_0 ;
  wire \count[1]_i_1_n_0 ;
  wire \count[2]_i_1_n_0 ;
  wire \count[3]_i_1_n_0 ;
  wire counter_hit_n_0;
  wire done_bit_count;

  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \FSM_onehot_current_state[4]_i_1 
       (.I0(Q[1]),
        .I1(done_bit_count),
        .O(D));
  LUT1 #(
    .INIT(2'h1)) 
    \count[0]_i_1__3 
       (.I0(count[0]),
        .O(\count[0]_i_1__3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h23CC)) 
    \count[1]_i_1 
       (.I0(count[2]),
        .I1(count[1]),
        .I2(count[3]),
        .I3(count[0]),
        .O(\count[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \count[2]_i_1 
       (.I0(count[2]),
        .I1(count[1]),
        .I2(count[0]),
        .O(\count[2]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \count[2]_i_2 
       (.I0(Q[0]),
        .I1(Q[2]),
        .O(AR));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h68F0)) 
    \count[3]_i_1 
       (.I0(count[2]),
        .I1(count[1]),
        .I2(count[3]),
        .I3(count[0]),
        .O(\count[3]_i_1_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[0] 
       (.C(clock_out),
        .CE(Q[1]),
        .CLR(AR),
        .D(\count[0]_i_1__3_n_0 ),
        .Q(count[0]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[1] 
       (.C(clock_out),
        .CE(Q[1]),
        .CLR(AR),
        .D(\count[1]_i_1_n_0 ),
        .Q(count[1]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[2] 
       (.C(clock_out),
        .CE(Q[1]),
        .CLR(AR),
        .D(\count[2]_i_1_n_0 ),
        .Q(count[2]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[3] 
       (.C(clock_out),
        .CE(Q[1]),
        .CLR(AR),
        .D(\count[3]_i_1_n_0 ),
        .Q(count[3]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h1000)) 
    counter_hit
       (.I0(count[2]),
        .I1(count[1]),
        .I2(count[3]),
        .I3(count[0]),
        .O(counter_hit_n_0));
  FDCE counter_hit_reg
       (.C(clock_out),
        .CE(Q[1]),
        .CLR(AR),
        .D(counter_hit_n_0),
        .Q(done_bit_count));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \tmp_sig[9]_i_1__0 
       (.I0(Q[1]),
        .I1(done_bit_count),
        .O(E));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_d_ff_register
   (D,
    \q_reg[4]_0 ,
    \axi_araddr_reg[3] ,
    Q,
    \axi_rdata_reg[7] ,
    axi_araddr,
    \q_reg[7]_0 ,
    \q_reg[7]_1 ,
    s00_axi_aclk,
    SS);
  output [4:0]D;
  output [1:0]\q_reg[4]_0 ;
  output \axi_araddr_reg[3] ;
  input [4:0]Q;
  input [4:0]\axi_rdata_reg[7] ;
  input [1:0]axi_araddr;
  input [0:0]\q_reg[7]_0 ;
  input [7:0]\q_reg[7]_1 ;
  input s00_axi_aclk;
  input [0:0]SS;

  wire [4:0]D;
  wire [4:0]Q;
  wire [0:0]SS;
  wire [1:0]axi_araddr;
  wire \axi_araddr_reg[3] ;
  wire [4:0]\axi_rdata_reg[7] ;
  wire [1:0]\q_reg[4]_0 ;
  wire [0:0]\q_reg[7]_0 ;
  wire [7:0]\q_reg[7]_1 ;
  wire s00_axi_aclk;
  wire [7:0]slv_reg3_out;

  LUT5 #(
    .INIT(32'hF000CCAA)) 
    \axi_rdata[0]_i_1 
       (.I0(Q[0]),
        .I1(\axi_rdata_reg[7] [0]),
        .I2(slv_reg3_out[0]),
        .I3(axi_araddr[0]),
        .I4(axi_araddr[1]),
        .O(D[0]));
  LUT3 #(
    .INIT(8'h80)) 
    \axi_rdata[2]_i_5 
       (.I0(axi_araddr[1]),
        .I1(axi_araddr[0]),
        .I2(slv_reg3_out[2]),
        .O(\axi_araddr_reg[3] ));
  LUT5 #(
    .INIT(32'hF000CCAA)) 
    \axi_rdata[3]_i_1 
       (.I0(Q[1]),
        .I1(\axi_rdata_reg[7] [1]),
        .I2(slv_reg3_out[3]),
        .I3(axi_araddr[0]),
        .I4(axi_araddr[1]),
        .O(D[1]));
  LUT5 #(
    .INIT(32'hF000CCAA)) 
    \axi_rdata[5]_i_1 
       (.I0(Q[2]),
        .I1(\axi_rdata_reg[7] [2]),
        .I2(slv_reg3_out[5]),
        .I3(axi_araddr[0]),
        .I4(axi_araddr[1]),
        .O(D[2]));
  LUT5 #(
    .INIT(32'hF000CCAA)) 
    \axi_rdata[6]_i_1 
       (.I0(Q[3]),
        .I1(\axi_rdata_reg[7] [3]),
        .I2(slv_reg3_out[6]),
        .I3(axi_araddr[0]),
        .I4(axi_araddr[1]),
        .O(D[3]));
  LUT5 #(
    .INIT(32'hF000CCAA)) 
    \axi_rdata[7]_i_1 
       (.I0(Q[4]),
        .I1(\axi_rdata_reg[7] [4]),
        .I2(slv_reg3_out[7]),
        .I3(axi_araddr[0]),
        .I4(axi_araddr[1]),
        .O(D[4]));
  FDCE \q_reg[0] 
       (.C(s00_axi_aclk),
        .CE(\q_reg[7]_0 ),
        .CLR(SS),
        .D(\q_reg[7]_1 [0]),
        .Q(slv_reg3_out[0]));
  FDCE \q_reg[1] 
       (.C(s00_axi_aclk),
        .CE(\q_reg[7]_0 ),
        .CLR(SS),
        .D(\q_reg[7]_1 [1]),
        .Q(\q_reg[4]_0 [0]));
  FDCE \q_reg[2] 
       (.C(s00_axi_aclk),
        .CE(\q_reg[7]_0 ),
        .CLR(SS),
        .D(\q_reg[7]_1 [2]),
        .Q(slv_reg3_out[2]));
  FDCE \q_reg[3] 
       (.C(s00_axi_aclk),
        .CE(\q_reg[7]_0 ),
        .CLR(SS),
        .D(\q_reg[7]_1 [3]),
        .Q(slv_reg3_out[3]));
  FDCE \q_reg[4] 
       (.C(s00_axi_aclk),
        .CE(\q_reg[7]_0 ),
        .CLR(SS),
        .D(\q_reg[7]_1 [4]),
        .Q(\q_reg[4]_0 [1]));
  FDCE \q_reg[5] 
       (.C(s00_axi_aclk),
        .CE(\q_reg[7]_0 ),
        .CLR(SS),
        .D(\q_reg[7]_1 [5]),
        .Q(slv_reg3_out[5]));
  FDCE \q_reg[6] 
       (.C(s00_axi_aclk),
        .CE(\q_reg[7]_0 ),
        .CLR(SS),
        .D(\q_reg[7]_1 [6]),
        .Q(slv_reg3_out[6]));
  FDCE \q_reg[7] 
       (.C(s00_axi_aclk),
        .CE(\q_reg[7]_0 ),
        .CLR(SS),
        .D(\q_reg[7]_1 [7]),
        .Q(slv_reg3_out[7]));
endmodule

(* CHECK_LICENSE_TYPE = "design_1_my_uart_int_0_0,my_uart_int_v1_0,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "my_uart_int_v1_0,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (tx,
    rx,
    s_axi_intr_awaddr,
    s_axi_intr_awprot,
    s_axi_intr_awvalid,
    s_axi_intr_awready,
    s_axi_intr_wdata,
    s_axi_intr_wstrb,
    s_axi_intr_wvalid,
    s_axi_intr_wready,
    s_axi_intr_bresp,
    s_axi_intr_bvalid,
    s_axi_intr_bready,
    s_axi_intr_araddr,
    s_axi_intr_arprot,
    s_axi_intr_arvalid,
    s_axi_intr_arready,
    s_axi_intr_rdata,
    s_axi_intr_rresp,
    s_axi_intr_rvalid,
    s_axi_intr_rready,
    s_axi_intr_aclk,
    s_axi_intr_aresetn,
    irq,
    s00_axi_awaddr,
    s00_axi_awprot,
    s00_axi_awvalid,
    s00_axi_awready,
    s00_axi_wdata,
    s00_axi_wstrb,
    s00_axi_wvalid,
    s00_axi_wready,
    s00_axi_bresp,
    s00_axi_bvalid,
    s00_axi_bready,
    s00_axi_araddr,
    s00_axi_arprot,
    s00_axi_arvalid,
    s00_axi_arready,
    s00_axi_rdata,
    s00_axi_rresp,
    s00_axi_rvalid,
    s00_axi_rready,
    s00_axi_aclk,
    s00_axi_aresetn);
  output tx;
  input rx;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI_INTR AWADDR" *) (* x_interface_parameter = "XIL_INTERFACENAME S_AXI_INTR, WIZ_DATA_WIDTH 32, WIZ_NUM_REG 5, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 5e+07, ID_WIDTH 0, ADDR_WIDTH 5, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [4:0]s_axi_intr_awaddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI_INTR AWPROT" *) input [2:0]s_axi_intr_awprot;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI_INTR AWVALID" *) input s_axi_intr_awvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI_INTR AWREADY" *) output s_axi_intr_awready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI_INTR WDATA" *) input [31:0]s_axi_intr_wdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI_INTR WSTRB" *) input [3:0]s_axi_intr_wstrb;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI_INTR WVALID" *) input s_axi_intr_wvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI_INTR WREADY" *) output s_axi_intr_wready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI_INTR BRESP" *) output [1:0]s_axi_intr_bresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI_INTR BVALID" *) output s_axi_intr_bvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI_INTR BREADY" *) input s_axi_intr_bready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI_INTR ARADDR" *) input [4:0]s_axi_intr_araddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI_INTR ARPROT" *) input [2:0]s_axi_intr_arprot;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI_INTR ARVALID" *) input s_axi_intr_arvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI_INTR ARREADY" *) output s_axi_intr_arready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI_INTR RDATA" *) output [31:0]s_axi_intr_rdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI_INTR RRESP" *) output [1:0]s_axi_intr_rresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI_INTR RVALID" *) output s_axi_intr_rvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI_INTR RREADY" *) input s_axi_intr_rready;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 S_AXI_INTR_CLK CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME S_AXI_INTR_CLK, ASSOCIATED_BUSIF S_AXI_INTR, ASSOCIATED_RESET s_axi_intr_aresetn, FREQ_HZ 5e+07, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input s_axi_intr_aclk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 S_AXI_INTR_RST RST" *) (* x_interface_parameter = "XIL_INTERFACENAME S_AXI_INTR_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input s_axi_intr_aresetn;
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 IRQ INTERRUPT" *) (* x_interface_parameter = "XIL_INTERFACENAME IRQ, SENSITIVITY LEVEL_HIGH, PortWidth 1" *) output irq;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI AWADDR" *) (* x_interface_parameter = "XIL_INTERFACENAME S00_AXI, WIZ_DATA_WIDTH 32, WIZ_NUM_REG 4, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 5e+07, ID_WIDTH 0, ADDR_WIDTH 4, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [3:0]s00_axi_awaddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI AWPROT" *) input [2:0]s00_axi_awprot;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI AWVALID" *) input s00_axi_awvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI AWREADY" *) output s00_axi_awready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI WDATA" *) input [31:0]s00_axi_wdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI WSTRB" *) input [3:0]s00_axi_wstrb;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI WVALID" *) input s00_axi_wvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI WREADY" *) output s00_axi_wready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI BRESP" *) output [1:0]s00_axi_bresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI BVALID" *) output s00_axi_bvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI BREADY" *) input s00_axi_bready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI ARADDR" *) input [3:0]s00_axi_araddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI ARPROT" *) input [2:0]s00_axi_arprot;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI ARVALID" *) input s00_axi_arvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI ARREADY" *) output s00_axi_arready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI RDATA" *) output [31:0]s00_axi_rdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI RRESP" *) output [1:0]s00_axi_rresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI RVALID" *) output s00_axi_rvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI RREADY" *) input s00_axi_rready;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 S00_AXI_CLK CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME S00_AXI_CLK, ASSOCIATED_BUSIF S00_AXI, ASSOCIATED_RESET s00_axi_aresetn, FREQ_HZ 5e+07, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input s00_axi_aclk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 S00_AXI_RST RST" *) (* x_interface_parameter = "XIL_INTERFACENAME S00_AXI_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input s00_axi_aresetn;

  wire \<const0> ;
  wire irq;
  wire rx;
  wire s00_axi_aclk;
  wire [3:0]s00_axi_araddr;
  wire s00_axi_aresetn;
  wire s00_axi_arready;
  wire s00_axi_arvalid;
  wire [3:0]s00_axi_awaddr;
  wire s00_axi_awready;
  wire s00_axi_awvalid;
  wire s00_axi_bready;
  wire s00_axi_bvalid;
  wire [31:0]s00_axi_rdata;
  wire s00_axi_rready;
  wire s00_axi_rvalid;
  wire [31:0]s00_axi_wdata;
  wire s00_axi_wready;
  wire [3:0]s00_axi_wstrb;
  wire s00_axi_wvalid;
  wire s_axi_intr_aclk;
  wire [4:0]s_axi_intr_araddr;
  wire s_axi_intr_aresetn;
  wire s_axi_intr_arready;
  wire s_axi_intr_arvalid;
  wire [4:0]s_axi_intr_awaddr;
  wire s_axi_intr_awready;
  wire s_axi_intr_awvalid;
  wire s_axi_intr_bready;
  wire s_axi_intr_bvalid;
  wire [0:0]\^s_axi_intr_rdata ;
  wire s_axi_intr_rready;
  wire s_axi_intr_rvalid;
  wire [31:0]s_axi_intr_wdata;
  wire s_axi_intr_wready;
  wire s_axi_intr_wvalid;
  wire tx;

  assign s00_axi_bresp[1] = \<const0> ;
  assign s00_axi_bresp[0] = \<const0> ;
  assign s00_axi_rresp[1] = \<const0> ;
  assign s00_axi_rresp[0] = \<const0> ;
  assign s_axi_intr_bresp[1] = \<const0> ;
  assign s_axi_intr_bresp[0] = \<const0> ;
  assign s_axi_intr_rdata[31] = \<const0> ;
  assign s_axi_intr_rdata[30] = \<const0> ;
  assign s_axi_intr_rdata[29] = \<const0> ;
  assign s_axi_intr_rdata[28] = \<const0> ;
  assign s_axi_intr_rdata[27] = \<const0> ;
  assign s_axi_intr_rdata[26] = \<const0> ;
  assign s_axi_intr_rdata[25] = \<const0> ;
  assign s_axi_intr_rdata[24] = \<const0> ;
  assign s_axi_intr_rdata[23] = \<const0> ;
  assign s_axi_intr_rdata[22] = \<const0> ;
  assign s_axi_intr_rdata[21] = \<const0> ;
  assign s_axi_intr_rdata[20] = \<const0> ;
  assign s_axi_intr_rdata[19] = \<const0> ;
  assign s_axi_intr_rdata[18] = \<const0> ;
  assign s_axi_intr_rdata[17] = \<const0> ;
  assign s_axi_intr_rdata[16] = \<const0> ;
  assign s_axi_intr_rdata[15] = \<const0> ;
  assign s_axi_intr_rdata[14] = \<const0> ;
  assign s_axi_intr_rdata[13] = \<const0> ;
  assign s_axi_intr_rdata[12] = \<const0> ;
  assign s_axi_intr_rdata[11] = \<const0> ;
  assign s_axi_intr_rdata[10] = \<const0> ;
  assign s_axi_intr_rdata[9] = \<const0> ;
  assign s_axi_intr_rdata[8] = \<const0> ;
  assign s_axi_intr_rdata[7] = \<const0> ;
  assign s_axi_intr_rdata[6] = \<const0> ;
  assign s_axi_intr_rdata[5] = \<const0> ;
  assign s_axi_intr_rdata[4] = \<const0> ;
  assign s_axi_intr_rdata[3] = \<const0> ;
  assign s_axi_intr_rdata[2] = \<const0> ;
  assign s_axi_intr_rdata[1] = \<const0> ;
  assign s_axi_intr_rdata[0] = \^s_axi_intr_rdata [0];
  assign s_axi_intr_rresp[1] = \<const0> ;
  assign s_axi_intr_rresp[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_my_uart_int_v1_0 U0
       (.irq(irq),
        .rx(rx),
        .s00_axi_aclk(s00_axi_aclk),
        .s00_axi_araddr(s00_axi_araddr[3:2]),
        .s00_axi_aresetn(s00_axi_aresetn),
        .s00_axi_arready(s00_axi_arready),
        .s00_axi_arvalid(s00_axi_arvalid),
        .s00_axi_awaddr(s00_axi_awaddr[3:2]),
        .s00_axi_awready(s00_axi_awready),
        .s00_axi_awvalid(s00_axi_awvalid),
        .s00_axi_bready(s00_axi_bready),
        .s00_axi_bvalid(s00_axi_bvalid),
        .s00_axi_rdata(s00_axi_rdata),
        .s00_axi_rready(s00_axi_rready),
        .s00_axi_rvalid(s00_axi_rvalid),
        .s00_axi_wdata(s00_axi_wdata),
        .s00_axi_wready(s00_axi_wready),
        .s00_axi_wstrb(s00_axi_wstrb),
        .s00_axi_wvalid(s00_axi_wvalid),
        .s_axi_intr_aclk(s_axi_intr_aclk),
        .s_axi_intr_araddr(s_axi_intr_araddr[4:2]),
        .s_axi_intr_aresetn(s_axi_intr_aresetn),
        .s_axi_intr_arready(s_axi_intr_arready),
        .s_axi_intr_arvalid(s_axi_intr_arvalid),
        .s_axi_intr_awaddr(s_axi_intr_awaddr[4:2]),
        .s_axi_intr_awready(s_axi_intr_awready),
        .s_axi_intr_awvalid(s_axi_intr_awvalid),
        .s_axi_intr_bready(s_axi_intr_bready),
        .s_axi_intr_bvalid(s_axi_intr_bvalid),
        .s_axi_intr_rdata(\^s_axi_intr_rdata ),
        .s_axi_intr_rready(s_axi_intr_rready),
        .s_axi_intr_rvalid(s_axi_intr_rvalid),
        .s_axi_intr_wdata(s_axi_intr_wdata[0]),
        .s_axi_intr_wready(s_axi_intr_wready),
        .s_axi_intr_wvalid(s_axi_intr_wvalid),
        .tx(tx));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_my_uart_int_v1_0
   (s00_axi_awready,
    tx,
    s00_axi_wready,
    s00_axi_arready,
    s00_axi_rdata,
    s_axi_intr_wready,
    s_axi_intr_awready,
    s_axi_intr_arready,
    s00_axi_rvalid,
    s_axi_intr_rvalid,
    irq,
    s00_axi_bvalid,
    s_axi_intr_bvalid,
    s_axi_intr_rdata,
    s_axi_intr_aresetn,
    s00_axi_aresetn,
    s00_axi_aclk,
    s00_axi_awaddr,
    s00_axi_wvalid,
    s00_axi_awvalid,
    s00_axi_wdata,
    rx,
    s00_axi_araddr,
    s00_axi_arvalid,
    s_axi_intr_aclk,
    s_axi_intr_awaddr,
    s_axi_intr_awvalid,
    s_axi_intr_wvalid,
    s_axi_intr_araddr,
    s_axi_intr_arvalid,
    s00_axi_wstrb,
    s00_axi_bready,
    s00_axi_rready,
    s_axi_intr_bready,
    s_axi_intr_rready,
    s_axi_intr_wdata);
  output s00_axi_awready;
  output tx;
  output s00_axi_wready;
  output s00_axi_arready;
  output [31:0]s00_axi_rdata;
  output s_axi_intr_wready;
  output s_axi_intr_awready;
  output s_axi_intr_arready;
  output s00_axi_rvalid;
  output s_axi_intr_rvalid;
  output irq;
  output s00_axi_bvalid;
  output s_axi_intr_bvalid;
  output [0:0]s_axi_intr_rdata;
  input s_axi_intr_aresetn;
  input s00_axi_aresetn;
  input s00_axi_aclk;
  input [1:0]s00_axi_awaddr;
  input s00_axi_wvalid;
  input s00_axi_awvalid;
  input [31:0]s00_axi_wdata;
  input rx;
  input [1:0]s00_axi_araddr;
  input s00_axi_arvalid;
  input s_axi_intr_aclk;
  input [2:0]s_axi_intr_awaddr;
  input s_axi_intr_awvalid;
  input s_axi_intr_wvalid;
  input [2:0]s_axi_intr_araddr;
  input s_axi_intr_arvalid;
  input [3:0]s00_axi_wstrb;
  input s00_axi_bready;
  input s00_axi_rready;
  input s_axi_intr_bready;
  input s_axi_intr_rready;
  input [0:0]s_axi_intr_wdata;

  wire [1:1]\inst_uart/TX_UART/next_state ;
  wire irq;
  wire rx;
  wire s00_axi_aclk;
  wire [1:0]s00_axi_araddr;
  wire s00_axi_aresetn;
  wire s00_axi_arready;
  wire s00_axi_arvalid;
  wire [1:0]s00_axi_awaddr;
  wire s00_axi_awready;
  wire s00_axi_awvalid;
  wire s00_axi_bready;
  wire s00_axi_bvalid;
  wire [31:0]s00_axi_rdata;
  wire s00_axi_rready;
  wire s00_axi_rvalid;
  wire [31:0]s00_axi_wdata;
  wire s00_axi_wready;
  wire [3:0]s00_axi_wstrb;
  wire s00_axi_wvalid;
  wire s_axi_intr_aclk;
  wire [2:0]s_axi_intr_araddr;
  wire s_axi_intr_aresetn;
  wire s_axi_intr_arready;
  wire s_axi_intr_arvalid;
  wire [2:0]s_axi_intr_awaddr;
  wire s_axi_intr_awready;
  wire s_axi_intr_awvalid;
  wire s_axi_intr_bready;
  wire s_axi_intr_bvalid;
  wire [0:0]s_axi_intr_rdata;
  wire s_axi_intr_rready;
  wire s_axi_intr_rvalid;
  wire [0:0]s_axi_intr_wdata;
  wire s_axi_intr_wready;
  wire s_axi_intr_wvalid;
  wire tx;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_my_uart_int_v1_0_S00_AXI my_uart_int_v1_0_S00_AXI_inst
       (.E(\inst_uart/TX_UART/next_state ),
        .axi_arready_reg_0(s00_axi_arready),
        .axi_awready_reg_0(s00_axi_awready),
        .axi_wready_reg_0(s00_axi_wready),
        .rx(rx),
        .s00_axi_aclk(s00_axi_aclk),
        .s00_axi_araddr(s00_axi_araddr),
        .s00_axi_aresetn(s00_axi_aresetn),
        .s00_axi_arvalid(s00_axi_arvalid),
        .s00_axi_awaddr(s00_axi_awaddr),
        .s00_axi_awvalid(s00_axi_awvalid),
        .s00_axi_bready(s00_axi_bready),
        .s00_axi_bvalid(s00_axi_bvalid),
        .s00_axi_rdata(s00_axi_rdata),
        .s00_axi_rready(s00_axi_rready),
        .s00_axi_rvalid(s00_axi_rvalid),
        .s00_axi_wdata(s00_axi_wdata),
        .s00_axi_wstrb(s00_axi_wstrb),
        .s00_axi_wvalid(s00_axi_wvalid),
        .tx(tx));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_my_uart_int_v1_0_S_AXI_INTR my_uart_int_v1_0_S_AXI_INTR_inst
       (.E(\inst_uart/TX_UART/next_state ),
        .axi_arready_reg_0(s_axi_intr_arready),
        .axi_awready_reg_0(s_axi_intr_awready),
        .axi_wready_reg_0(s_axi_intr_wready),
        .irq(irq),
        .s_axi_intr_aclk(s_axi_intr_aclk),
        .s_axi_intr_araddr(s_axi_intr_araddr),
        .s_axi_intr_aresetn(s_axi_intr_aresetn),
        .s_axi_intr_arvalid(s_axi_intr_arvalid),
        .s_axi_intr_awaddr(s_axi_intr_awaddr),
        .s_axi_intr_awvalid(s_axi_intr_awvalid),
        .s_axi_intr_bready(s_axi_intr_bready),
        .s_axi_intr_bvalid(s_axi_intr_bvalid),
        .s_axi_intr_rdata(s_axi_intr_rdata),
        .s_axi_intr_rready(s_axi_intr_rready),
        .s_axi_intr_rvalid(s_axi_intr_rvalid),
        .s_axi_intr_wdata(s_axi_intr_wdata),
        .s_axi_intr_wvalid(s_axi_intr_wvalid));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_my_uart_int_v1_0_S00_AXI
   (axi_wready_reg_0,
    axi_awready_reg_0,
    axi_arready_reg_0,
    s00_axi_bvalid,
    s00_axi_rvalid,
    E,
    tx,
    s00_axi_rdata,
    s00_axi_aclk,
    s00_axi_aresetn,
    s00_axi_awvalid,
    s00_axi_wvalid,
    s00_axi_bready,
    s00_axi_arvalid,
    s00_axi_rready,
    s00_axi_awaddr,
    s00_axi_wdata,
    rx,
    s00_axi_araddr,
    s00_axi_wstrb);
  output axi_wready_reg_0;
  output axi_awready_reg_0;
  output axi_arready_reg_0;
  output s00_axi_bvalid;
  output s00_axi_rvalid;
  output [0:0]E;
  output tx;
  output [31:0]s00_axi_rdata;
  input s00_axi_aclk;
  input s00_axi_aresetn;
  input s00_axi_awvalid;
  input s00_axi_wvalid;
  input s00_axi_bready;
  input s00_axi_arvalid;
  input s00_axi_rready;
  input [1:0]s00_axi_awaddr;
  input [31:0]s00_axi_wdata;
  input rx;
  input [1:0]s00_axi_araddr;
  input [3:0]s00_axi_wstrb;

  wire [0:0]E;
  wire aw_en_i_1_n_0;
  wire aw_en_reg_n_0;
  wire [3:2]axi_araddr;
  wire \axi_araddr[2]_i_1_n_0 ;
  wire \axi_araddr[3]_i_1_n_0 ;
  wire axi_arready0;
  wire axi_arready_reg_0;
  wire \axi_awaddr[2]_i_1_n_0 ;
  wire \axi_awaddr[3]_i_1_n_0 ;
  wire axi_awready0;
  wire axi_awready_reg_0;
  wire axi_bvalid_i_1_n_0;
  wire \axi_rdata[2]_i_6_n_0 ;
  wire axi_rvalid_i_1_n_0;
  wire axi_wready0;
  wire axi_wready_reg_0;
  wire [1:0]p_0_in;
  wire [31:0]reg_data_out;
  wire reset;
  wire rx;
  wire s00_axi_aclk;
  wire [1:0]s00_axi_araddr;
  wire s00_axi_aresetn;
  wire s00_axi_arvalid;
  wire [1:0]s00_axi_awaddr;
  wire s00_axi_awvalid;
  wire s00_axi_bready;
  wire s00_axi_bvalid;
  wire [31:0]s00_axi_rdata;
  wire s00_axi_rready;
  wire s00_axi_rvalid;
  wire [31:0]s00_axi_wdata;
  wire [3:0]s00_axi_wstrb;
  wire s00_axi_wvalid;
  wire [31:0]slv_reg0;
  wire \slv_reg0[15]_i_1_n_0 ;
  wire \slv_reg0[23]_i_1_n_0 ;
  wire \slv_reg0[31]_i_1_n_0 ;
  wire \slv_reg0[7]_i_1_n_0 ;
  wire [0:0]slv_reg1;
  wire \slv_reg1[15]_i_1_n_0 ;
  wire \slv_reg1[23]_i_1_n_0 ;
  wire \slv_reg1[31]_i_1_n_0 ;
  wire \slv_reg1[7]_i_1_n_0 ;
  wire \slv_reg1_reg_n_0_[10] ;
  wire \slv_reg1_reg_n_0_[11] ;
  wire \slv_reg1_reg_n_0_[12] ;
  wire \slv_reg1_reg_n_0_[13] ;
  wire \slv_reg1_reg_n_0_[14] ;
  wire \slv_reg1_reg_n_0_[15] ;
  wire \slv_reg1_reg_n_0_[16] ;
  wire \slv_reg1_reg_n_0_[17] ;
  wire \slv_reg1_reg_n_0_[18] ;
  wire \slv_reg1_reg_n_0_[19] ;
  wire \slv_reg1_reg_n_0_[1] ;
  wire \slv_reg1_reg_n_0_[20] ;
  wire \slv_reg1_reg_n_0_[21] ;
  wire \slv_reg1_reg_n_0_[22] ;
  wire \slv_reg1_reg_n_0_[23] ;
  wire \slv_reg1_reg_n_0_[24] ;
  wire \slv_reg1_reg_n_0_[25] ;
  wire \slv_reg1_reg_n_0_[26] ;
  wire \slv_reg1_reg_n_0_[27] ;
  wire \slv_reg1_reg_n_0_[28] ;
  wire \slv_reg1_reg_n_0_[29] ;
  wire \slv_reg1_reg_n_0_[2] ;
  wire \slv_reg1_reg_n_0_[30] ;
  wire \slv_reg1_reg_n_0_[31] ;
  wire \slv_reg1_reg_n_0_[3] ;
  wire \slv_reg1_reg_n_0_[4] ;
  wire \slv_reg1_reg_n_0_[5] ;
  wire \slv_reg1_reg_n_0_[6] ;
  wire \slv_reg1_reg_n_0_[7] ;
  wire \slv_reg1_reg_n_0_[8] ;
  wire \slv_reg1_reg_n_0_[9] ;
  wire slv_reg_rden;
  wire slv_reg_wren__2;
  wire tx;

  LUT6 #(
    .INIT(64'hBFFFBF00BF00BF00)) 
    aw_en_i_1
       (.I0(axi_awready_reg_0),
        .I1(s00_axi_awvalid),
        .I2(s00_axi_wvalid),
        .I3(aw_en_reg_n_0),
        .I4(s00_axi_bready),
        .I5(s00_axi_bvalid),
        .O(aw_en_i_1_n_0));
  FDSE aw_en_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(aw_en_i_1_n_0),
        .Q(aw_en_reg_n_0),
        .S(reset));
  LUT4 #(
    .INIT(16'hFB08)) 
    \axi_araddr[2]_i_1 
       (.I0(s00_axi_araddr[0]),
        .I1(s00_axi_arvalid),
        .I2(axi_arready_reg_0),
        .I3(axi_araddr[2]),
        .O(\axi_araddr[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \axi_araddr[3]_i_1 
       (.I0(s00_axi_araddr[1]),
        .I1(s00_axi_arvalid),
        .I2(axi_arready_reg_0),
        .I3(axi_araddr[3]),
        .O(\axi_araddr[3]_i_1_n_0 ));
  FDSE \axi_araddr_reg[2] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\axi_araddr[2]_i_1_n_0 ),
        .Q(axi_araddr[2]),
        .S(reset));
  FDSE \axi_araddr_reg[3] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\axi_araddr[3]_i_1_n_0 ),
        .Q(axi_araddr[3]),
        .S(reset));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h2)) 
    axi_arready_i_1
       (.I0(s00_axi_arvalid),
        .I1(axi_arready_reg_0),
        .O(axi_arready0));
  FDRE axi_arready_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_arready0),
        .Q(axi_arready_reg_0),
        .R(reset));
  LUT6 #(
    .INIT(64'hFFFFBFFF00008000)) 
    \axi_awaddr[2]_i_1 
       (.I0(s00_axi_awaddr[0]),
        .I1(aw_en_reg_n_0),
        .I2(s00_axi_wvalid),
        .I3(s00_axi_awvalid),
        .I4(axi_awready_reg_0),
        .I5(p_0_in[0]),
        .O(\axi_awaddr[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFBFFF00008000)) 
    \axi_awaddr[3]_i_1 
       (.I0(s00_axi_awaddr[1]),
        .I1(aw_en_reg_n_0),
        .I2(s00_axi_wvalid),
        .I3(s00_axi_awvalid),
        .I4(axi_awready_reg_0),
        .I5(p_0_in[1]),
        .O(\axi_awaddr[3]_i_1_n_0 ));
  FDRE \axi_awaddr_reg[2] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\axi_awaddr[2]_i_1_n_0 ),
        .Q(p_0_in[0]),
        .R(reset));
  FDRE \axi_awaddr_reg[3] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\axi_awaddr[3]_i_1_n_0 ),
        .Q(p_0_in[1]),
        .R(reset));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT4 #(
    .INIT(16'h0080)) 
    axi_awready_i_1
       (.I0(aw_en_reg_n_0),
        .I1(s00_axi_wvalid),
        .I2(s00_axi_awvalid),
        .I3(axi_awready_reg_0),
        .O(axi_awready0));
  FDRE axi_awready_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_awready0),
        .Q(axi_awready_reg_0),
        .R(reset));
  LUT6 #(
    .INIT(64'h0000FFFF80008000)) 
    axi_bvalid_i_1
       (.I0(s00_axi_awvalid),
        .I1(axi_awready_reg_0),
        .I2(axi_wready_reg_0),
        .I3(s00_axi_wvalid),
        .I4(s00_axi_bready),
        .I5(s00_axi_bvalid),
        .O(axi_bvalid_i_1_n_0));
  FDRE axi_bvalid_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_bvalid_i_1_n_0),
        .Q(s00_axi_bvalid),
        .R(reset));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[10]_i_1 
       (.I0(\slv_reg1_reg_n_0_[10] ),
        .I1(slv_reg0[10]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(reg_data_out[10]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[11]_i_1 
       (.I0(\slv_reg1_reg_n_0_[11] ),
        .I1(slv_reg0[11]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(reg_data_out[11]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[12]_i_1 
       (.I0(\slv_reg1_reg_n_0_[12] ),
        .I1(slv_reg0[12]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(reg_data_out[12]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[13]_i_1 
       (.I0(\slv_reg1_reg_n_0_[13] ),
        .I1(slv_reg0[13]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(reg_data_out[13]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[14]_i_1 
       (.I0(\slv_reg1_reg_n_0_[14] ),
        .I1(slv_reg0[14]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(reg_data_out[14]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[15]_i_1 
       (.I0(\slv_reg1_reg_n_0_[15] ),
        .I1(slv_reg0[15]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(reg_data_out[15]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[16]_i_1 
       (.I0(\slv_reg1_reg_n_0_[16] ),
        .I1(slv_reg0[16]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(reg_data_out[16]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[17]_i_1 
       (.I0(\slv_reg1_reg_n_0_[17] ),
        .I1(slv_reg0[17]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(reg_data_out[17]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[18]_i_1 
       (.I0(\slv_reg1_reg_n_0_[18] ),
        .I1(slv_reg0[18]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(reg_data_out[18]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[19]_i_1 
       (.I0(\slv_reg1_reg_n_0_[19] ),
        .I1(slv_reg0[19]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(reg_data_out[19]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[20]_i_1 
       (.I0(\slv_reg1_reg_n_0_[20] ),
        .I1(slv_reg0[20]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(reg_data_out[20]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[21]_i_1 
       (.I0(\slv_reg1_reg_n_0_[21] ),
        .I1(slv_reg0[21]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(reg_data_out[21]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[22]_i_1 
       (.I0(\slv_reg1_reg_n_0_[22] ),
        .I1(slv_reg0[22]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(reg_data_out[22]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[23]_i_1 
       (.I0(\slv_reg1_reg_n_0_[23] ),
        .I1(slv_reg0[23]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(reg_data_out[23]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[24]_i_1 
       (.I0(\slv_reg1_reg_n_0_[24] ),
        .I1(slv_reg0[24]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(reg_data_out[24]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[25]_i_1 
       (.I0(\slv_reg1_reg_n_0_[25] ),
        .I1(slv_reg0[25]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(reg_data_out[25]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[26]_i_1 
       (.I0(\slv_reg1_reg_n_0_[26] ),
        .I1(slv_reg0[26]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(reg_data_out[26]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[27]_i_1 
       (.I0(\slv_reg1_reg_n_0_[27] ),
        .I1(slv_reg0[27]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(reg_data_out[27]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[28]_i_1 
       (.I0(\slv_reg1_reg_n_0_[28] ),
        .I1(slv_reg0[28]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(reg_data_out[28]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[29]_i_1 
       (.I0(\slv_reg1_reg_n_0_[29] ),
        .I1(slv_reg0[29]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(reg_data_out[29]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[2]_i_6 
       (.I0(\slv_reg1_reg_n_0_[2] ),
        .I1(slv_reg0[2]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(\axi_rdata[2]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[30]_i_1 
       (.I0(\slv_reg1_reg_n_0_[30] ),
        .I1(slv_reg0[30]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(reg_data_out[30]));
  LUT3 #(
    .INIT(8'h08)) 
    \axi_rdata[31]_i_1 
       (.I0(axi_arready_reg_0),
        .I1(s00_axi_arvalid),
        .I2(s00_axi_rvalid),
        .O(slv_reg_rden));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[31]_i_2 
       (.I0(\slv_reg1_reg_n_0_[31] ),
        .I1(slv_reg0[31]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(reg_data_out[31]));
  LUT4 #(
    .INIT(16'h00AC)) 
    \axi_rdata[9]_i_1 
       (.I0(\slv_reg1_reg_n_0_[9] ),
        .I1(slv_reg0[9]),
        .I2(axi_araddr[2]),
        .I3(axi_araddr[3]),
        .O(reg_data_out[9]));
  FDRE \axi_rdata_reg[0] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[0]),
        .Q(s00_axi_rdata[0]),
        .R(reset));
  FDRE \axi_rdata_reg[10] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[10]),
        .Q(s00_axi_rdata[10]),
        .R(reset));
  FDRE \axi_rdata_reg[11] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[11]),
        .Q(s00_axi_rdata[11]),
        .R(reset));
  FDRE \axi_rdata_reg[12] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[12]),
        .Q(s00_axi_rdata[12]),
        .R(reset));
  FDRE \axi_rdata_reg[13] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[13]),
        .Q(s00_axi_rdata[13]),
        .R(reset));
  FDRE \axi_rdata_reg[14] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[14]),
        .Q(s00_axi_rdata[14]),
        .R(reset));
  FDRE \axi_rdata_reg[15] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[15]),
        .Q(s00_axi_rdata[15]),
        .R(reset));
  FDRE \axi_rdata_reg[16] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[16]),
        .Q(s00_axi_rdata[16]),
        .R(reset));
  FDRE \axi_rdata_reg[17] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[17]),
        .Q(s00_axi_rdata[17]),
        .R(reset));
  FDRE \axi_rdata_reg[18] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[18]),
        .Q(s00_axi_rdata[18]),
        .R(reset));
  FDRE \axi_rdata_reg[19] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[19]),
        .Q(s00_axi_rdata[19]),
        .R(reset));
  FDRE \axi_rdata_reg[1] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[1]),
        .Q(s00_axi_rdata[1]),
        .R(reset));
  FDRE \axi_rdata_reg[20] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[20]),
        .Q(s00_axi_rdata[20]),
        .R(reset));
  FDRE \axi_rdata_reg[21] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[21]),
        .Q(s00_axi_rdata[21]),
        .R(reset));
  FDRE \axi_rdata_reg[22] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[22]),
        .Q(s00_axi_rdata[22]),
        .R(reset));
  FDRE \axi_rdata_reg[23] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[23]),
        .Q(s00_axi_rdata[23]),
        .R(reset));
  FDRE \axi_rdata_reg[24] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[24]),
        .Q(s00_axi_rdata[24]),
        .R(reset));
  FDRE \axi_rdata_reg[25] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[25]),
        .Q(s00_axi_rdata[25]),
        .R(reset));
  FDRE \axi_rdata_reg[26] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[26]),
        .Q(s00_axi_rdata[26]),
        .R(reset));
  FDRE \axi_rdata_reg[27] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[27]),
        .Q(s00_axi_rdata[27]),
        .R(reset));
  FDRE \axi_rdata_reg[28] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[28]),
        .Q(s00_axi_rdata[28]),
        .R(reset));
  FDRE \axi_rdata_reg[29] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[29]),
        .Q(s00_axi_rdata[29]),
        .R(reset));
  FDRE \axi_rdata_reg[2] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[2]),
        .Q(s00_axi_rdata[2]),
        .R(reset));
  FDRE \axi_rdata_reg[30] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[30]),
        .Q(s00_axi_rdata[30]),
        .R(reset));
  FDRE \axi_rdata_reg[31] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[31]),
        .Q(s00_axi_rdata[31]),
        .R(reset));
  FDRE \axi_rdata_reg[3] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[3]),
        .Q(s00_axi_rdata[3]),
        .R(reset));
  FDRE \axi_rdata_reg[4] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[4]),
        .Q(s00_axi_rdata[4]),
        .R(reset));
  FDRE \axi_rdata_reg[5] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[5]),
        .Q(s00_axi_rdata[5]),
        .R(reset));
  FDRE \axi_rdata_reg[6] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[6]),
        .Q(s00_axi_rdata[6]),
        .R(reset));
  FDRE \axi_rdata_reg[7] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[7]),
        .Q(s00_axi_rdata[7]),
        .R(reset));
  FDRE \axi_rdata_reg[8] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[8]),
        .Q(s00_axi_rdata[8]),
        .R(reset));
  FDRE \axi_rdata_reg[9] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden),
        .D(reg_data_out[9]),
        .Q(s00_axi_rdata[9]),
        .R(reset));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT4 #(
    .INIT(16'h08F8)) 
    axi_rvalid_i_1
       (.I0(s00_axi_arvalid),
        .I1(axi_arready_reg_0),
        .I2(s00_axi_rvalid),
        .I3(s00_axi_rready),
        .O(axi_rvalid_i_1_n_0));
  FDRE axi_rvalid_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_rvalid_i_1_n_0),
        .Q(s00_axi_rvalid),
        .R(reset));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT4 #(
    .INIT(16'h0080)) 
    axi_wready_i_1
       (.I0(aw_en_reg_n_0),
        .I1(s00_axi_wvalid),
        .I2(s00_axi_awvalid),
        .I3(axi_wready_reg_0),
        .O(axi_wready0));
  FDRE axi_wready_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_wready0),
        .Q(axi_wready_reg_0),
        .R(reset));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_UART inst_uart
       (.D(reg_data_out[8:0]),
        .E(E),
        .Q(slv_reg0[8:0]),
        .SR(reset),
        .axi_araddr(axi_araddr),
        .\axi_rdata_reg[2] (\axi_rdata[2]_i_6_n_0 ),
        .\axi_rdata_reg[8] ({\slv_reg1_reg_n_0_[8] ,\slv_reg1_reg_n_0_[7] ,\slv_reg1_reg_n_0_[6] ,\slv_reg1_reg_n_0_[5] ,\slv_reg1_reg_n_0_[4] ,\slv_reg1_reg_n_0_[3] ,\slv_reg1_reg_n_0_[1] ,slv_reg1}),
        .rx(rx),
        .s00_axi_aclk(s00_axi_aclk),
        .s00_axi_aresetn(s00_axi_aresetn),
        .tx(tx));
  LUT4 #(
    .INIT(16'h0200)) 
    \slv_reg0[15]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(s00_axi_wstrb[1]),
        .O(\slv_reg0[15]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0200)) 
    \slv_reg0[23]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(s00_axi_wstrb[2]),
        .O(\slv_reg0[23]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0200)) 
    \slv_reg0[31]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(s00_axi_wstrb[3]),
        .O(\slv_reg0[31]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h8000)) 
    \slv_reg0[31]_i_2 
       (.I0(s00_axi_awvalid),
        .I1(axi_awready_reg_0),
        .I2(axi_wready_reg_0),
        .I3(s00_axi_wvalid),
        .O(slv_reg_wren__2));
  LUT4 #(
    .INIT(16'h0200)) 
    \slv_reg0[7]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(s00_axi_wstrb[0]),
        .O(\slv_reg0[7]_i_1_n_0 ));
  FDRE \slv_reg0_reg[0] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[7]_i_1_n_0 ),
        .D(s00_axi_wdata[0]),
        .Q(slv_reg0[0]),
        .R(reset));
  FDRE \slv_reg0_reg[10] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[15]_i_1_n_0 ),
        .D(s00_axi_wdata[10]),
        .Q(slv_reg0[10]),
        .R(reset));
  FDRE \slv_reg0_reg[11] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[15]_i_1_n_0 ),
        .D(s00_axi_wdata[11]),
        .Q(slv_reg0[11]),
        .R(reset));
  FDRE \slv_reg0_reg[12] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[15]_i_1_n_0 ),
        .D(s00_axi_wdata[12]),
        .Q(slv_reg0[12]),
        .R(reset));
  FDRE \slv_reg0_reg[13] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[15]_i_1_n_0 ),
        .D(s00_axi_wdata[13]),
        .Q(slv_reg0[13]),
        .R(reset));
  FDRE \slv_reg0_reg[14] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[15]_i_1_n_0 ),
        .D(s00_axi_wdata[14]),
        .Q(slv_reg0[14]),
        .R(reset));
  FDRE \slv_reg0_reg[15] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[15]_i_1_n_0 ),
        .D(s00_axi_wdata[15]),
        .Q(slv_reg0[15]),
        .R(reset));
  FDRE \slv_reg0_reg[16] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[23]_i_1_n_0 ),
        .D(s00_axi_wdata[16]),
        .Q(slv_reg0[16]),
        .R(reset));
  FDRE \slv_reg0_reg[17] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[23]_i_1_n_0 ),
        .D(s00_axi_wdata[17]),
        .Q(slv_reg0[17]),
        .R(reset));
  FDRE \slv_reg0_reg[18] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[23]_i_1_n_0 ),
        .D(s00_axi_wdata[18]),
        .Q(slv_reg0[18]),
        .R(reset));
  FDRE \slv_reg0_reg[19] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[23]_i_1_n_0 ),
        .D(s00_axi_wdata[19]),
        .Q(slv_reg0[19]),
        .R(reset));
  FDRE \slv_reg0_reg[1] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[7]_i_1_n_0 ),
        .D(s00_axi_wdata[1]),
        .Q(slv_reg0[1]),
        .R(reset));
  FDRE \slv_reg0_reg[20] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[23]_i_1_n_0 ),
        .D(s00_axi_wdata[20]),
        .Q(slv_reg0[20]),
        .R(reset));
  FDRE \slv_reg0_reg[21] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[23]_i_1_n_0 ),
        .D(s00_axi_wdata[21]),
        .Q(slv_reg0[21]),
        .R(reset));
  FDRE \slv_reg0_reg[22] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[23]_i_1_n_0 ),
        .D(s00_axi_wdata[22]),
        .Q(slv_reg0[22]),
        .R(reset));
  FDRE \slv_reg0_reg[23] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[23]_i_1_n_0 ),
        .D(s00_axi_wdata[23]),
        .Q(slv_reg0[23]),
        .R(reset));
  FDRE \slv_reg0_reg[24] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[31]_i_1_n_0 ),
        .D(s00_axi_wdata[24]),
        .Q(slv_reg0[24]),
        .R(reset));
  FDRE \slv_reg0_reg[25] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[31]_i_1_n_0 ),
        .D(s00_axi_wdata[25]),
        .Q(slv_reg0[25]),
        .R(reset));
  FDRE \slv_reg0_reg[26] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[31]_i_1_n_0 ),
        .D(s00_axi_wdata[26]),
        .Q(slv_reg0[26]),
        .R(reset));
  FDRE \slv_reg0_reg[27] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[31]_i_1_n_0 ),
        .D(s00_axi_wdata[27]),
        .Q(slv_reg0[27]),
        .R(reset));
  FDRE \slv_reg0_reg[28] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[31]_i_1_n_0 ),
        .D(s00_axi_wdata[28]),
        .Q(slv_reg0[28]),
        .R(reset));
  FDRE \slv_reg0_reg[29] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[31]_i_1_n_0 ),
        .D(s00_axi_wdata[29]),
        .Q(slv_reg0[29]),
        .R(reset));
  FDRE \slv_reg0_reg[2] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[7]_i_1_n_0 ),
        .D(s00_axi_wdata[2]),
        .Q(slv_reg0[2]),
        .R(reset));
  FDRE \slv_reg0_reg[30] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[31]_i_1_n_0 ),
        .D(s00_axi_wdata[30]),
        .Q(slv_reg0[30]),
        .R(reset));
  FDRE \slv_reg0_reg[31] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[31]_i_1_n_0 ),
        .D(s00_axi_wdata[31]),
        .Q(slv_reg0[31]),
        .R(reset));
  FDRE \slv_reg0_reg[3] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[7]_i_1_n_0 ),
        .D(s00_axi_wdata[3]),
        .Q(slv_reg0[3]),
        .R(reset));
  FDRE \slv_reg0_reg[4] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[7]_i_1_n_0 ),
        .D(s00_axi_wdata[4]),
        .Q(slv_reg0[4]),
        .R(reset));
  FDRE \slv_reg0_reg[5] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[7]_i_1_n_0 ),
        .D(s00_axi_wdata[5]),
        .Q(slv_reg0[5]),
        .R(reset));
  FDRE \slv_reg0_reg[6] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[7]_i_1_n_0 ),
        .D(s00_axi_wdata[6]),
        .Q(slv_reg0[6]),
        .R(reset));
  FDRE \slv_reg0_reg[7] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[7]_i_1_n_0 ),
        .D(s00_axi_wdata[7]),
        .Q(slv_reg0[7]),
        .R(reset));
  FDRE \slv_reg0_reg[8] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[15]_i_1_n_0 ),
        .D(s00_axi_wdata[8]),
        .Q(slv_reg0[8]),
        .R(reset));
  FDRE \slv_reg0_reg[9] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg0[15]_i_1_n_0 ),
        .D(s00_axi_wdata[9]),
        .Q(slv_reg0[9]),
        .R(reset));
  LUT4 #(
    .INIT(16'h0080)) 
    \slv_reg1[15]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(s00_axi_wstrb[1]),
        .I2(p_0_in[0]),
        .I3(p_0_in[1]),
        .O(\slv_reg1[15]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0080)) 
    \slv_reg1[23]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(s00_axi_wstrb[2]),
        .I2(p_0_in[0]),
        .I3(p_0_in[1]),
        .O(\slv_reg1[23]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0080)) 
    \slv_reg1[31]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(s00_axi_wstrb[3]),
        .I2(p_0_in[0]),
        .I3(p_0_in[1]),
        .O(\slv_reg1[31]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0080)) 
    \slv_reg1[7]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(s00_axi_wstrb[0]),
        .I2(p_0_in[0]),
        .I3(p_0_in[1]),
        .O(\slv_reg1[7]_i_1_n_0 ));
  FDRE \slv_reg1_reg[0] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[0]),
        .Q(slv_reg1),
        .R(reset));
  FDRE \slv_reg1_reg[10] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[10]),
        .Q(\slv_reg1_reg_n_0_[10] ),
        .R(reset));
  FDRE \slv_reg1_reg[11] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[11]),
        .Q(\slv_reg1_reg_n_0_[11] ),
        .R(reset));
  FDRE \slv_reg1_reg[12] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[12]),
        .Q(\slv_reg1_reg_n_0_[12] ),
        .R(reset));
  FDRE \slv_reg1_reg[13] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[13]),
        .Q(\slv_reg1_reg_n_0_[13] ),
        .R(reset));
  FDRE \slv_reg1_reg[14] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[14]),
        .Q(\slv_reg1_reg_n_0_[14] ),
        .R(reset));
  FDRE \slv_reg1_reg[15] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[15]),
        .Q(\slv_reg1_reg_n_0_[15] ),
        .R(reset));
  FDRE \slv_reg1_reg[16] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[16]),
        .Q(\slv_reg1_reg_n_0_[16] ),
        .R(reset));
  FDRE \slv_reg1_reg[17] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[17]),
        .Q(\slv_reg1_reg_n_0_[17] ),
        .R(reset));
  FDRE \slv_reg1_reg[18] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[18]),
        .Q(\slv_reg1_reg_n_0_[18] ),
        .R(reset));
  FDRE \slv_reg1_reg[19] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[19]),
        .Q(\slv_reg1_reg_n_0_[19] ),
        .R(reset));
  FDRE \slv_reg1_reg[1] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[1]),
        .Q(\slv_reg1_reg_n_0_[1] ),
        .R(reset));
  FDRE \slv_reg1_reg[20] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[20]),
        .Q(\slv_reg1_reg_n_0_[20] ),
        .R(reset));
  FDRE \slv_reg1_reg[21] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[21]),
        .Q(\slv_reg1_reg_n_0_[21] ),
        .R(reset));
  FDRE \slv_reg1_reg[22] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[22]),
        .Q(\slv_reg1_reg_n_0_[22] ),
        .R(reset));
  FDRE \slv_reg1_reg[23] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[23]),
        .Q(\slv_reg1_reg_n_0_[23] ),
        .R(reset));
  FDRE \slv_reg1_reg[24] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[24]),
        .Q(\slv_reg1_reg_n_0_[24] ),
        .R(reset));
  FDRE \slv_reg1_reg[25] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[25]),
        .Q(\slv_reg1_reg_n_0_[25] ),
        .R(reset));
  FDRE \slv_reg1_reg[26] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[26]),
        .Q(\slv_reg1_reg_n_0_[26] ),
        .R(reset));
  FDRE \slv_reg1_reg[27] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[27]),
        .Q(\slv_reg1_reg_n_0_[27] ),
        .R(reset));
  FDRE \slv_reg1_reg[28] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[28]),
        .Q(\slv_reg1_reg_n_0_[28] ),
        .R(reset));
  FDRE \slv_reg1_reg[29] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[29]),
        .Q(\slv_reg1_reg_n_0_[29] ),
        .R(reset));
  FDRE \slv_reg1_reg[2] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[2]),
        .Q(\slv_reg1_reg_n_0_[2] ),
        .R(reset));
  FDRE \slv_reg1_reg[30] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[30]),
        .Q(\slv_reg1_reg_n_0_[30] ),
        .R(reset));
  FDRE \slv_reg1_reg[31] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[31]),
        .Q(\slv_reg1_reg_n_0_[31] ),
        .R(reset));
  FDRE \slv_reg1_reg[3] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[3]),
        .Q(\slv_reg1_reg_n_0_[3] ),
        .R(reset));
  FDRE \slv_reg1_reg[4] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[4]),
        .Q(\slv_reg1_reg_n_0_[4] ),
        .R(reset));
  FDRE \slv_reg1_reg[5] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[5]),
        .Q(\slv_reg1_reg_n_0_[5] ),
        .R(reset));
  FDRE \slv_reg1_reg[6] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[6]),
        .Q(\slv_reg1_reg_n_0_[6] ),
        .R(reset));
  FDRE \slv_reg1_reg[7] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[7]),
        .Q(\slv_reg1_reg_n_0_[7] ),
        .R(reset));
  FDRE \slv_reg1_reg[8] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[8]),
        .Q(\slv_reg1_reg_n_0_[8] ),
        .R(reset));
  FDRE \slv_reg1_reg[9] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[9]),
        .Q(\slv_reg1_reg_n_0_[9] ),
        .R(reset));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_my_uart_int_v1_0_S_AXI_INTR
   (axi_wready_reg_0,
    axi_awready_reg_0,
    axi_arready_reg_0,
    s_axi_intr_bvalid,
    s_axi_intr_rvalid,
    s_axi_intr_rdata,
    irq,
    s_axi_intr_aclk,
    E,
    s_axi_intr_aresetn,
    s_axi_intr_wvalid,
    s_axi_intr_awvalid,
    s_axi_intr_bready,
    s_axi_intr_arvalid,
    s_axi_intr_rready,
    s_axi_intr_wdata,
    s_axi_intr_awaddr,
    s_axi_intr_araddr);
  output axi_wready_reg_0;
  output axi_awready_reg_0;
  output axi_arready_reg_0;
  output s_axi_intr_bvalid;
  output s_axi_intr_rvalid;
  output [0:0]s_axi_intr_rdata;
  output irq;
  input s_axi_intr_aclk;
  input [0:0]E;
  input s_axi_intr_aresetn;
  input s_axi_intr_wvalid;
  input s_axi_intr_awvalid;
  input s_axi_intr_bready;
  input s_axi_intr_arvalid;
  input s_axi_intr_rready;
  input [0:0]s_axi_intr_wdata;
  input [2:0]s_axi_intr_awaddr;
  input [2:0]s_axi_intr_araddr;

  wire [0:0]E;
  wire aw_en_i_1__0_n_0;
  wire aw_en_reg_n_0;
  wire \axi_araddr[2]_i_1_n_0 ;
  wire \axi_araddr[3]_i_1_n_0 ;
  wire \axi_araddr[4]_i_1_n_0 ;
  wire axi_arready0;
  wire axi_arready_reg_0;
  wire \axi_awaddr[2]_i_1_n_0 ;
  wire \axi_awaddr[3]_i_1_n_0 ;
  wire \axi_awaddr[4]_i_1_n_0 ;
  wire axi_awready0;
  wire axi_awready_i_1__0_n_0;
  wire axi_awready_reg_0;
  wire axi_bvalid_i_1__0_n_0;
  wire \axi_rdata[0]_i_1__0_n_0 ;
  wire \axi_rdata[0]_i_2_n_0 ;
  wire \axi_rdata[0]_i_3_n_0 ;
  wire \axi_rdata[0]_i_4_n_0 ;
  wire axi_rvalid_i_1__0_n_0;
  wire axi_wready0;
  wire axi_wready_reg_0;
  wire det_intr;
  wire \gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.det_intr[0]_i_1_n_0 ;
  wire \gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff[0]_i_1_n_0 ;
  wire \gen_intr_detection[0].gen_irq_level.irq_level_high.s_irq_lvl_i_1_n_0 ;
  wire \gen_intr_reg[0].reg_global_intr_en[0]_i_1_n_0 ;
  wire \gen_intr_reg[0].reg_intr_ack[0]_i_1_n_0 ;
  wire \gen_intr_reg[0].reg_intr_en[0]_i_1_n_0 ;
  wire intr_ack_all;
  wire intr_ack_all_ff;
  wire intr_ack_all_i_1_n_0;
  wire intr_all;
  wire intr_all_i_1_n_0;
  wire intr_ff;
  wire intr_ff2;
  wire intr_reg_rden;
  wire intr_reg_wren__2;
  wire irq;
  wire [2:0]p_0_in;
  wire p_4_out;
  wire reg_global_intr_en;
  wire reg_intr_ack;
  wire reg_intr_en;
  wire reg_intr_pending;
  wire reg_intr_sts;
  wire s_axi_intr_aclk;
  wire [2:0]s_axi_intr_araddr;
  wire s_axi_intr_aresetn;
  wire s_axi_intr_arvalid;
  wire [2:0]s_axi_intr_awaddr;
  wire s_axi_intr_awvalid;
  wire s_axi_intr_bready;
  wire s_axi_intr_bvalid;
  wire [0:0]s_axi_intr_rdata;
  wire s_axi_intr_rready;
  wire s_axi_intr_rvalid;
  wire [0:0]s_axi_intr_wdata;
  wire s_axi_intr_wvalid;
  wire [2:0]sel0;

  LUT6 #(
    .INIT(64'hBFFFBF00BF00BF00)) 
    aw_en_i_1__0
       (.I0(axi_awready_reg_0),
        .I1(s_axi_intr_wvalid),
        .I2(s_axi_intr_awvalid),
        .I3(aw_en_reg_n_0),
        .I4(s_axi_intr_bready),
        .I5(s_axi_intr_bvalid),
        .O(aw_en_i_1__0_n_0));
  FDSE aw_en_reg
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(aw_en_i_1__0_n_0),
        .Q(aw_en_reg_n_0),
        .S(axi_awready_i_1__0_n_0));
  LUT4 #(
    .INIT(16'hFB08)) 
    \axi_araddr[2]_i_1 
       (.I0(s_axi_intr_araddr[0]),
        .I1(s_axi_intr_arvalid),
        .I2(axi_arready_reg_0),
        .I3(sel0[0]),
        .O(\axi_araddr[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \axi_araddr[3]_i_1 
       (.I0(s_axi_intr_araddr[1]),
        .I1(s_axi_intr_arvalid),
        .I2(axi_arready_reg_0),
        .I3(sel0[1]),
        .O(\axi_araddr[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \axi_araddr[4]_i_1 
       (.I0(s_axi_intr_araddr[2]),
        .I1(s_axi_intr_arvalid),
        .I2(axi_arready_reg_0),
        .I3(sel0[2]),
        .O(\axi_araddr[4]_i_1_n_0 ));
  FDSE \axi_araddr_reg[2] 
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(\axi_araddr[2]_i_1_n_0 ),
        .Q(sel0[0]),
        .S(axi_awready_i_1__0_n_0));
  FDSE \axi_araddr_reg[3] 
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(\axi_araddr[3]_i_1_n_0 ),
        .Q(sel0[1]),
        .S(axi_awready_i_1__0_n_0));
  FDSE \axi_araddr_reg[4] 
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(\axi_araddr[4]_i_1_n_0 ),
        .Q(sel0[2]),
        .S(axi_awready_i_1__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'h2)) 
    axi_arready_i_1__0
       (.I0(s_axi_intr_arvalid),
        .I1(axi_arready_reg_0),
        .O(axi_arready0));
  FDRE axi_arready_reg
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(axi_arready0),
        .Q(axi_arready_reg_0),
        .R(axi_awready_i_1__0_n_0));
  LUT6 #(
    .INIT(64'hFFFFBFFF00008000)) 
    \axi_awaddr[2]_i_1 
       (.I0(s_axi_intr_awaddr[0]),
        .I1(aw_en_reg_n_0),
        .I2(s_axi_intr_awvalid),
        .I3(s_axi_intr_wvalid),
        .I4(axi_awready_reg_0),
        .I5(p_0_in[0]),
        .O(\axi_awaddr[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFBFFF00008000)) 
    \axi_awaddr[3]_i_1 
       (.I0(s_axi_intr_awaddr[1]),
        .I1(aw_en_reg_n_0),
        .I2(s_axi_intr_awvalid),
        .I3(s_axi_intr_wvalid),
        .I4(axi_awready_reg_0),
        .I5(p_0_in[1]),
        .O(\axi_awaddr[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFBFFF00008000)) 
    \axi_awaddr[4]_i_1 
       (.I0(s_axi_intr_awaddr[2]),
        .I1(aw_en_reg_n_0),
        .I2(s_axi_intr_awvalid),
        .I3(s_axi_intr_wvalid),
        .I4(axi_awready_reg_0),
        .I5(p_0_in[2]),
        .O(\axi_awaddr[4]_i_1_n_0 ));
  FDRE \axi_awaddr_reg[2] 
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(\axi_awaddr[2]_i_1_n_0 ),
        .Q(p_0_in[0]),
        .R(axi_awready_i_1__0_n_0));
  FDRE \axi_awaddr_reg[3] 
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(\axi_awaddr[3]_i_1_n_0 ),
        .Q(p_0_in[1]),
        .R(axi_awready_i_1__0_n_0));
  FDRE \axi_awaddr_reg[4] 
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(\axi_awaddr[4]_i_1_n_0 ),
        .Q(p_0_in[2]),
        .R(axi_awready_i_1__0_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    axi_awready_i_1__0
       (.I0(s_axi_intr_aresetn),
        .O(axi_awready_i_1__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT4 #(
    .INIT(16'h0080)) 
    axi_awready_i_2
       (.I0(aw_en_reg_n_0),
        .I1(s_axi_intr_awvalid),
        .I2(s_axi_intr_wvalid),
        .I3(axi_awready_reg_0),
        .O(axi_awready0));
  FDRE axi_awready_reg
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(axi_awready0),
        .Q(axi_awready_reg_0),
        .R(axi_awready_i_1__0_n_0));
  LUT6 #(
    .INIT(64'h0000FFFF80008000)) 
    axi_bvalid_i_1__0
       (.I0(s_axi_intr_wvalid),
        .I1(axi_awready_reg_0),
        .I2(axi_wready_reg_0),
        .I3(s_axi_intr_awvalid),
        .I4(s_axi_intr_bready),
        .I5(s_axi_intr_bvalid),
        .O(axi_bvalid_i_1__0_n_0));
  FDRE axi_bvalid_reg
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(axi_bvalid_i_1__0_n_0),
        .Q(s_axi_intr_bvalid),
        .R(axi_awready_i_1__0_n_0));
  LUT6 #(
    .INIT(64'h8830FFFF88300000)) 
    \axi_rdata[0]_i_1__0 
       (.I0(\axi_rdata[0]_i_2_n_0 ),
        .I1(\axi_rdata[0]_i_3_n_0 ),
        .I2(reg_intr_pending),
        .I3(\axi_rdata[0]_i_4_n_0 ),
        .I4(intr_reg_rden),
        .I5(s_axi_intr_rdata),
        .O(\axi_rdata[0]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[0]_i_2 
       (.I0(reg_intr_ack),
        .I1(reg_intr_sts),
        .I2(sel0[1]),
        .I3(reg_intr_en),
        .I4(sel0[0]),
        .I5(reg_global_intr_en),
        .O(\axi_rdata[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \axi_rdata[0]_i_3 
       (.I0(sel0[1]),
        .I1(sel0[2]),
        .O(\axi_rdata[0]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h5D)) 
    \axi_rdata[0]_i_4 
       (.I0(sel0[2]),
        .I1(sel0[0]),
        .I2(sel0[1]),
        .O(\axi_rdata[0]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \axi_rdata[0]_i_5 
       (.I0(axi_arready_reg_0),
        .I1(s_axi_intr_arvalid),
        .I2(s_axi_intr_rvalid),
        .O(intr_reg_rden));
  FDRE \axi_rdata_reg[0] 
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(\axi_rdata[0]_i_1__0_n_0 ),
        .Q(s_axi_intr_rdata),
        .R(axi_awready_i_1__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT4 #(
    .INIT(16'h08F8)) 
    axi_rvalid_i_1__0
       (.I0(s_axi_intr_arvalid),
        .I1(axi_arready_reg_0),
        .I2(s_axi_intr_rvalid),
        .I3(s_axi_intr_rready),
        .O(axi_rvalid_i_1__0_n_0));
  FDRE axi_rvalid_reg
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(axi_rvalid_i_1__0_n_0),
        .Q(s_axi_intr_rvalid),
        .R(axi_awready_i_1__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT4 #(
    .INIT(16'h0080)) 
    axi_wready_i_1__0
       (.I0(aw_en_reg_n_0),
        .I1(s_axi_intr_awvalid),
        .I2(s_axi_intr_wvalid),
        .I3(axi_wready_reg_0),
        .O(axi_wready0));
  FDRE axi_wready_reg
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(axi_wready0),
        .Q(axi_wready_reg_0),
        .R(axi_awready_i_1__0_n_0));
  LUT3 #(
    .INIT(8'hF4)) 
    \gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.det_intr[0]_i_1 
       (.I0(intr_ff),
        .I1(intr_ff2),
        .I2(det_intr),
        .O(\gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.det_intr[0]_i_1_n_0 ));
  FDRE \gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.det_intr_reg[0] 
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(\gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.det_intr[0]_i_1_n_0 ),
        .Q(det_intr),
        .R(\gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff[0]_i_1_n_0 ));
  FDRE \gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff2_reg[0] 
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(intr_ff),
        .Q(intr_ff2),
        .R(\gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff[0]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff[0]_i_1 
       (.I0(reg_intr_ack),
        .I1(s_axi_intr_aresetn),
        .O(\gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff[0]_i_1_n_0 ));
  FDRE \gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff_reg[0] 
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(E),
        .Q(intr_ff),
        .R(\gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h0000EA00)) 
    \gen_intr_detection[0].gen_irq_level.irq_level_high.s_irq_lvl_i_1 
       (.I0(irq),
        .I1(reg_global_intr_en),
        .I2(intr_all),
        .I3(s_axi_intr_aresetn),
        .I4(intr_ack_all),
        .O(\gen_intr_detection[0].gen_irq_level.irq_level_high.s_irq_lvl_i_1_n_0 ));
  FDRE \gen_intr_detection[0].gen_irq_level.irq_level_high.s_irq_lvl_reg 
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(\gen_intr_detection[0].gen_irq_level.irq_level_high.s_irq_lvl_i_1_n_0 ),
        .Q(irq),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFEFFFF00020000)) 
    \gen_intr_reg[0].reg_global_intr_en[0]_i_1 
       (.I0(s_axi_intr_wdata),
        .I1(p_0_in[2]),
        .I2(p_0_in[0]),
        .I3(p_0_in[1]),
        .I4(intr_reg_wren__2),
        .I5(reg_global_intr_en),
        .O(\gen_intr_reg[0].reg_global_intr_en[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h8000)) 
    \gen_intr_reg[0].reg_global_intr_en[0]_i_2 
       (.I0(s_axi_intr_wvalid),
        .I1(axi_awready_reg_0),
        .I2(axi_wready_reg_0),
        .I3(s_axi_intr_awvalid),
        .O(intr_reg_wren__2));
  FDRE \gen_intr_reg[0].reg_global_intr_en_reg[0] 
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(\gen_intr_reg[0].reg_global_intr_en[0]_i_1_n_0 ),
        .Q(reg_global_intr_en),
        .R(axi_awready_i_1__0_n_0));
  LUT5 #(
    .INIT(32'h00800000)) 
    \gen_intr_reg[0].reg_intr_ack[0]_i_1 
       (.I0(s_axi_intr_wdata),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(p_0_in[2]),
        .I4(intr_reg_wren__2),
        .O(\gen_intr_reg[0].reg_intr_ack[0]_i_1_n_0 ));
  FDRE \gen_intr_reg[0].reg_intr_ack_reg[0] 
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(\gen_intr_reg[0].reg_intr_ack[0]_i_1_n_0 ),
        .Q(reg_intr_ack),
        .R(\gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFEFFFFFF02000000)) 
    \gen_intr_reg[0].reg_intr_en[0]_i_1 
       (.I0(s_axi_intr_wdata),
        .I1(p_0_in[1]),
        .I2(p_0_in[2]),
        .I3(p_0_in[0]),
        .I4(intr_reg_wren__2),
        .I5(reg_intr_en),
        .O(\gen_intr_reg[0].reg_intr_en[0]_i_1_n_0 ));
  FDRE \gen_intr_reg[0].reg_intr_en_reg[0] 
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(\gen_intr_reg[0].reg_intr_en[0]_i_1_n_0 ),
        .Q(reg_intr_en),
        .R(axi_awready_i_1__0_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    \gen_intr_reg[0].reg_intr_pending[0]_i_1 
       (.I0(reg_intr_en),
        .I1(reg_intr_sts),
        .O(p_4_out));
  FDRE \gen_intr_reg[0].reg_intr_pending_reg[0] 
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(p_4_out),
        .Q(reg_intr_pending),
        .R(\gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff[0]_i_1_n_0 ));
  FDRE \gen_intr_reg[0].reg_intr_sts_reg[0] 
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(det_intr),
        .Q(reg_intr_sts),
        .R(\gen_intr_detection[0].gen_intr_edge_detect.gen_intr_falling_edge_detect.intr_ff[0]_i_1_n_0 ));
  FDRE intr_ack_all_ff_reg
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(intr_ack_all),
        .Q(intr_ack_all_ff),
        .R(axi_awready_i_1__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'h08)) 
    intr_ack_all_i_1
       (.I0(reg_intr_ack),
        .I1(s_axi_intr_aresetn),
        .I2(intr_ack_all_ff),
        .O(intr_ack_all_i_1_n_0));
  FDRE intr_ack_all_reg
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(intr_ack_all_i_1_n_0),
        .Q(intr_ack_all),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'h08)) 
    intr_all_i_1
       (.I0(reg_intr_pending),
        .I1(s_axi_intr_aresetn),
        .I2(intr_ack_all_ff),
        .O(intr_all_i_1_n_0));
  FDRE intr_all_reg
       (.C(s_axi_intr_aclk),
        .CE(1'b1),
        .D(intr_all_i_1_n_0),
        .Q(intr_all),
        .R(1'b0));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_rx_cu
   (SS,
    D,
    \tmp_sig_reg[7] ,
    \FSM_onehot_current_state_reg[4]_0 ,
    clock_out,
    s00_axi_aresetn,
    rx,
    axi_araddr,
    Q,
    \axi_rdata_reg[8] ,
    \axi_rdata_reg[2] ,
    \axi_rdata_reg[2]_0 ,
    \axi_rdata_reg[1] );
  output [0:0]SS;
  output [2:0]D;
  output [7:0]\tmp_sig_reg[7] ;
  output [0:0]\FSM_onehot_current_state_reg[4]_0 ;
  input clock_out;
  input s00_axi_aresetn;
  input rx;
  input [1:0]axi_araddr;
  input [1:0]Q;
  input [1:0]\axi_rdata_reg[8] ;
  input \axi_rdata_reg[2] ;
  input \axi_rdata_reg[2]_0 ;
  input [0:0]\axi_rdata_reg[1] ;

  wire [2:0]D;
  wire \FSM_onehot_current_state[0]_i_1_n_0 ;
  wire \FSM_onehot_current_state[6]_i_1_n_0 ;
  wire [0:0]\FSM_onehot_current_state_reg[4]_0 ;
  wire \FSM_onehot_current_state_reg_n_0_[0] ;
  wire \FSM_onehot_current_state_reg_n_0_[5] ;
  wire \FSM_onehot_current_state_reg_n_0_[6] ;
  wire [1:0]Q;
  wire [0:0]SS;
  wire [1:0]axi_araddr;
  wire \axi_rdata[2]_i_2_n_0 ;
  wire [0:0]\axi_rdata_reg[1] ;
  wire \axi_rdata_reg[2] ;
  wire \axi_rdata_reg[2]_0 ;
  wire [1:0]\axi_rdata_reg[8] ;
  wire bit_counter_n_3;
  wire clock_out;
  wire counter_16incr;
  wire counter_8incr;
  wire counter_bit_incr;
  wire counter_hit;
  wire counter_mod16_n_0;
  wire counter_mod16_n_1;
  wire counter_mod8_n_1;
  wire done_bit_count;
  wire reset_8count;
  wire rx;
  wire s00_axi_aresetn;
  wire shift_en;
  wire [7:0]\tmp_sig_reg[7] ;

  LUT2 #(
    .INIT(4'h8)) 
    \FSM_onehot_current_state[0]_i_1 
       (.I0(\FSM_onehot_current_state_reg_n_0_[0] ),
        .I1(rx),
        .O(\FSM_onehot_current_state[0]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hF8)) 
    \FSM_onehot_current_state[6]_i_1 
       (.I0(rx),
        .I1(\FSM_onehot_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_current_state_reg_n_0_[5] ),
        .O(\FSM_onehot_current_state[6]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "rda_state:0100000,first_idle:0000001,idle:1000000,eight_delay:0000010,get_bit:0001000,wait_for_centre:0000100,check_stop:0010000" *) 
  FDSE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[0] 
       (.C(clock_out),
        .CE(1'b1),
        .D(\FSM_onehot_current_state[0]_i_1_n_0 ),
        .Q(\FSM_onehot_current_state_reg_n_0_[0] ),
        .S(SS));
  (* FSM_ENCODED_STATES = "rda_state:0100000,first_idle:0000001,idle:1000000,eight_delay:0000010,get_bit:0001000,wait_for_centre:0000100,check_stop:0010000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[1] 
       (.C(clock_out),
        .CE(1'b1),
        .D(counter_mod8_n_1),
        .Q(counter_8incr),
        .R(SS));
  (* FSM_ENCODED_STATES = "rda_state:0100000,first_idle:0000001,idle:1000000,eight_delay:0000010,get_bit:0001000,wait_for_centre:0000100,check_stop:0010000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[2] 
       (.C(clock_out),
        .CE(1'b1),
        .D(counter_mod16_n_1),
        .Q(counter_16incr),
        .R(SS));
  (* FSM_ENCODED_STATES = "rda_state:0100000,first_idle:0000001,idle:1000000,eight_delay:0000010,get_bit:0001000,wait_for_centre:0000100,check_stop:0010000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[3] 
       (.C(clock_out),
        .CE(1'b1),
        .D(counter_mod16_n_0),
        .Q(counter_bit_incr),
        .R(SS));
  (* FSM_ENCODED_STATES = "rda_state:0100000,first_idle:0000001,idle:1000000,eight_delay:0000010,get_bit:0001000,wait_for_centre:0000100,check_stop:0010000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[4] 
       (.C(clock_out),
        .CE(1'b1),
        .D(bit_counter_n_3),
        .Q(\FSM_onehot_current_state_reg[4]_0 ),
        .R(SS));
  (* FSM_ENCODED_STATES = "rda_state:0100000,first_idle:0000001,idle:1000000,eight_delay:0000010,get_bit:0001000,wait_for_centre:0000100,check_stop:0010000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[5] 
       (.C(clock_out),
        .CE(1'b1),
        .D(\FSM_onehot_current_state_reg[4]_0 ),
        .Q(\FSM_onehot_current_state_reg_n_0_[5] ),
        .R(SS));
  (* FSM_ENCODED_STATES = "rda_state:0100000,first_idle:0000001,idle:1000000,eight_delay:0000010,get_bit:0001000,wait_for_centre:0000100,check_stop:0010000" *) 
  FDRE #(
    .INIT(1'b1)) 
    \FSM_onehot_current_state_reg[6] 
       (.C(clock_out),
        .CE(1'b1),
        .D(\FSM_onehot_current_state[6]_i_1_n_0 ),
        .Q(\FSM_onehot_current_state_reg_n_0_[6] ),
        .R(SS));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_shift_register_SIPO RX_shift_register_SIPO
       (.D(D[1:0]),
        .E(shift_en),
        .Q(Q[0]),
        .SR(SS),
        .axi_araddr(axi_araddr),
        .\axi_rdata_reg[1] (\axi_rdata_reg[8] [0]),
        .\axi_rdata_reg[1]_0 (\axi_rdata_reg[1] ),
        .\axi_rdata_reg[1]_1 ({\FSM_onehot_current_state_reg_n_0_[5] ,\FSM_onehot_current_state_reg[4]_0 }),
        .\axi_rdata_reg[2] (\axi_rdata[2]_i_2_n_0 ),
        .\axi_rdata_reg[2]_0 (\axi_rdata_reg[2] ),
        .\axi_rdata_reg[2]_1 (\axi_rdata_reg[2]_0 ),
        .clock_out(clock_out),
        .rx(rx),
        .s00_axi_aresetn(s00_axi_aresetn),
        .\tmp_sig_reg[7]_0 (\tmp_sig_reg[7] ));
  LUT4 #(
    .INIT(16'h4440)) 
    \axi_rdata[2]_i_2 
       (.I0(axi_araddr[0]),
        .I1(axi_araddr[1]),
        .I2(\FSM_onehot_current_state_reg_n_0_[5] ),
        .I3(\FSM_onehot_current_state_reg[4]_0 ),
        .O(\axi_rdata[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEF0FEF00E00FE000)) 
    \axi_rdata[8]_i_1 
       (.I0(\FSM_onehot_current_state_reg_n_0_[6] ),
        .I1(\FSM_onehot_current_state_reg_n_0_[5] ),
        .I2(axi_araddr[1]),
        .I3(axi_araddr[0]),
        .I4(Q[1]),
        .I5(\axi_rdata_reg[8] [1]),
        .O(D[2]));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_counter_modN__parameterized5 bit_counter
       (.AR(reset_8count),
        .D(bit_counter_n_3),
        .E(shift_en),
        .Q({\FSM_onehot_current_state_reg_n_0_[6] ,counter_bit_incr,\FSM_onehot_current_state_reg_n_0_[0] }),
        .clock_out(clock_out),
        .done_bit_count(done_bit_count));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_counter_modN__parameterized3 counter_mod16
       (.D({counter_mod16_n_0,counter_mod16_n_1}),
        .Q({\FSM_onehot_current_state_reg_n_0_[6] ,counter_bit_incr,counter_16incr,counter_8incr,\FSM_onehot_current_state_reg_n_0_[0] }),
        .clock_out(clock_out),
        .counter_hit(counter_hit),
        .done_bit_count(done_bit_count));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_counter_modN__parameterized1 counter_mod8
       (.AR(reset_8count),
        .D(counter_mod8_n_1),
        .Q({\FSM_onehot_current_state_reg_n_0_[6] ,counter_8incr,\FSM_onehot_current_state_reg_n_0_[0] }),
        .clock_out(clock_out),
        .counter_hit(counter_hit),
        .rx(rx));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_shift_register
   (E,
    tx,
    current_state,
    Q,
    SS,
    CLK);
  output [0:0]E;
  output tx;
  input [1:0]current_state;
  input [7:0]Q;
  input [0:0]SS;
  input CLK;

  wire CLK;
  wire [0:0]E;
  wire [7:0]Q;
  wire [0:0]SS;
  wire [1:0]current_state;
  wire p_load__0;
  wire \tmp_sig[0]_i_3_n_0 ;
  wire \tmp_sig[1]_i_1_n_0 ;
  wire \tmp_sig[2]_i_1_n_0 ;
  wire \tmp_sig[3]_i_1_n_0 ;
  wire \tmp_sig[4]_i_1_n_0 ;
  wire \tmp_sig[5]_i_1_n_0 ;
  wire \tmp_sig[6]_i_1_n_0 ;
  wire \tmp_sig[7]_i_1_n_0 ;
  wire \tmp_sig[8]_i_1_n_0 ;
  wire \tmp_sig[9]_i_1_n_0 ;
  wire \tmp_sig[9]_i_2_n_0 ;
  wire \tmp_sig_reg_n_0_[1] ;
  wire \tmp_sig_reg_n_0_[2] ;
  wire \tmp_sig_reg_n_0_[3] ;
  wire \tmp_sig_reg_n_0_[4] ;
  wire \tmp_sig_reg_n_0_[5] ;
  wire \tmp_sig_reg_n_0_[6] ;
  wire \tmp_sig_reg_n_0_[7] ;
  wire \tmp_sig_reg_n_0_[8] ;
  wire \tmp_sig_reg_n_0_[9] ;
  wire tx;

  LUT2 #(
    .INIT(4'h6)) 
    \tmp_sig[0]_i_2 
       (.I0(current_state[1]),
        .I1(current_state[0]),
        .O(E));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \tmp_sig[0]_i_3 
       (.I0(\tmp_sig_reg_n_0_[1] ),
        .I1(current_state[1]),
        .I2(current_state[0]),
        .O(\tmp_sig[0]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \tmp_sig[1]_i_1 
       (.I0(Q[0]),
        .I1(current_state[0]),
        .I2(current_state[1]),
        .I3(\tmp_sig_reg_n_0_[2] ),
        .O(\tmp_sig[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \tmp_sig[2]_i_1 
       (.I0(Q[1]),
        .I1(current_state[0]),
        .I2(current_state[1]),
        .I3(\tmp_sig_reg_n_0_[3] ),
        .O(\tmp_sig[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \tmp_sig[3]_i_1 
       (.I0(Q[2]),
        .I1(current_state[0]),
        .I2(current_state[1]),
        .I3(\tmp_sig_reg_n_0_[4] ),
        .O(\tmp_sig[3]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \tmp_sig[4]_i_1 
       (.I0(Q[3]),
        .I1(current_state[0]),
        .I2(current_state[1]),
        .I3(\tmp_sig_reg_n_0_[5] ),
        .O(\tmp_sig[4]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \tmp_sig[5]_i_1 
       (.I0(Q[4]),
        .I1(current_state[0]),
        .I2(current_state[1]),
        .I3(\tmp_sig_reg_n_0_[6] ),
        .O(\tmp_sig[5]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \tmp_sig[6]_i_1 
       (.I0(Q[5]),
        .I1(current_state[0]),
        .I2(current_state[1]),
        .I3(\tmp_sig_reg_n_0_[7] ),
        .O(\tmp_sig[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \tmp_sig[7]_i_1 
       (.I0(Q[6]),
        .I1(current_state[0]),
        .I2(current_state[1]),
        .I3(\tmp_sig_reg_n_0_[8] ),
        .O(\tmp_sig[7]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \tmp_sig[8]_i_1 
       (.I0(Q[7]),
        .I1(current_state[0]),
        .I2(current_state[1]),
        .I3(\tmp_sig_reg_n_0_[9] ),
        .O(\tmp_sig[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h69969669FFFFFFFF)) 
    \tmp_sig[9]_i_1 
       (.I0(\tmp_sig[9]_i_2_n_0 ),
        .I1(Q[6]),
        .I2(Q[3]),
        .I3(Q[5]),
        .I4(Q[7]),
        .I5(p_load__0),
        .O(\tmp_sig[9]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \tmp_sig[9]_i_2 
       (.I0(Q[4]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[1]),
        .O(\tmp_sig[9]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \tmp_sig[9]_i_3 
       (.I0(current_state[0]),
        .I1(current_state[1]),
        .O(p_load__0));
  FDSE #(
    .INIT(1'b1)) 
    \tmp_sig_reg[0] 
       (.C(CLK),
        .CE(E),
        .D(\tmp_sig[0]_i_3_n_0 ),
        .Q(tx),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \tmp_sig_reg[1] 
       (.C(CLK),
        .CE(E),
        .D(\tmp_sig[1]_i_1_n_0 ),
        .Q(\tmp_sig_reg_n_0_[1] ),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \tmp_sig_reg[2] 
       (.C(CLK),
        .CE(E),
        .D(\tmp_sig[2]_i_1_n_0 ),
        .Q(\tmp_sig_reg_n_0_[2] ),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \tmp_sig_reg[3] 
       (.C(CLK),
        .CE(E),
        .D(\tmp_sig[3]_i_1_n_0 ),
        .Q(\tmp_sig_reg_n_0_[3] ),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \tmp_sig_reg[4] 
       (.C(CLK),
        .CE(E),
        .D(\tmp_sig[4]_i_1_n_0 ),
        .Q(\tmp_sig_reg_n_0_[4] ),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \tmp_sig_reg[5] 
       (.C(CLK),
        .CE(E),
        .D(\tmp_sig[5]_i_1_n_0 ),
        .Q(\tmp_sig_reg_n_0_[5] ),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \tmp_sig_reg[6] 
       (.C(CLK),
        .CE(E),
        .D(\tmp_sig[6]_i_1_n_0 ),
        .Q(\tmp_sig_reg_n_0_[6] ),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \tmp_sig_reg[7] 
       (.C(CLK),
        .CE(E),
        .D(\tmp_sig[7]_i_1_n_0 ),
        .Q(\tmp_sig_reg_n_0_[7] ),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \tmp_sig_reg[8] 
       (.C(CLK),
        .CE(E),
        .D(\tmp_sig[8]_i_1_n_0 ),
        .Q(\tmp_sig_reg_n_0_[8] ),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \tmp_sig_reg[9] 
       (.C(CLK),
        .CE(E),
        .D(\tmp_sig[9]_i_1_n_0 ),
        .Q(\tmp_sig_reg_n_0_[9] ),
        .S(SS));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_shift_register_SIPO
   (SR,
    D,
    \tmp_sig_reg[7]_0 ,
    s00_axi_aresetn,
    axi_araddr,
    Q,
    \axi_rdata_reg[1] ,
    \axi_rdata_reg[2] ,
    \axi_rdata_reg[2]_0 ,
    \axi_rdata_reg[2]_1 ,
    \axi_rdata_reg[1]_0 ,
    \axi_rdata_reg[1]_1 ,
    E,
    rx,
    clock_out);
  output [0:0]SR;
  output [1:0]D;
  output [7:0]\tmp_sig_reg[7]_0 ;
  input s00_axi_aresetn;
  input [1:0]axi_araddr;
  input [0:0]Q;
  input [0:0]\axi_rdata_reg[1] ;
  input \axi_rdata_reg[2] ;
  input \axi_rdata_reg[2]_0 ;
  input \axi_rdata_reg[2]_1 ;
  input [0:0]\axi_rdata_reg[1]_0 ;
  input [1:0]\axi_rdata_reg[1]_1 ;
  input [0:0]E;
  input rx;
  input clock_out;

  wire [1:0]D;
  wire [0:0]E;
  wire [0:0]Q;
  wire [0:0]SR;
  wire [1:0]axi_araddr;
  wire \axi_rdata[1]_i_2_n_0 ;
  wire \axi_rdata[2]_i_3_n_0 ;
  wire \axi_rdata[2]_i_4_n_0 ;
  wire [0:0]\axi_rdata_reg[1] ;
  wire [0:0]\axi_rdata_reg[1]_0 ;
  wire [1:0]\axi_rdata_reg[1]_1 ;
  wire \axi_rdata_reg[2] ;
  wire \axi_rdata_reg[2]_0 ;
  wire \axi_rdata_reg[2]_1 ;
  wire clock_out;
  wire rx;
  wire [8:8]rx_frame;
  wire s00_axi_aresetn;
  wire [7:0]\tmp_sig_reg[7]_0 ;
  wire \tmp_sig_reg_n_0_[9] ;

  LUT5 #(
    .INIT(32'hBBBAABAA)) 
    \axi_rdata[1]_i_1 
       (.I0(\axi_rdata[1]_i_2_n_0 ),
        .I1(axi_araddr[1]),
        .I2(axi_araddr[0]),
        .I3(Q),
        .I4(\axi_rdata_reg[1] ),
        .O(D[0]));
  LUT6 #(
    .INIT(64'hAAAA000000FC0000)) 
    \axi_rdata[1]_i_2 
       (.I0(\axi_rdata_reg[1]_0 ),
        .I1(\axi_rdata_reg[1]_1 [0]),
        .I2(\axi_rdata_reg[1]_1 [1]),
        .I3(\tmp_sig_reg_n_0_[9] ),
        .I4(axi_araddr[1]),
        .I5(axi_araddr[0]),
        .O(\axi_rdata[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF2882)) 
    \axi_rdata[2]_i_1 
       (.I0(\axi_rdata_reg[2] ),
        .I1(\axi_rdata[2]_i_3_n_0 ),
        .I2(\axi_rdata[2]_i_4_n_0 ),
        .I3(\tmp_sig_reg[7]_0 [7]),
        .I4(\axi_rdata_reg[2]_0 ),
        .I5(\axi_rdata_reg[2]_1 ),
        .O(D[1]));
  LUT4 #(
    .INIT(16'h6996)) 
    \axi_rdata[2]_i_3 
       (.I0(\tmp_sig_reg[7]_0 [3]),
        .I1(\tmp_sig_reg[7]_0 [1]),
        .I2(\tmp_sig_reg[7]_0 [6]),
        .I3(\tmp_sig_reg[7]_0 [5]),
        .O(\axi_rdata[2]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \axi_rdata[2]_i_4 
       (.I0(rx_frame),
        .I1(\tmp_sig_reg[7]_0 [0]),
        .I2(\tmp_sig_reg[7]_0 [4]),
        .I3(\tmp_sig_reg[7]_0 [2]),
        .O(\axi_rdata[2]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \tmp_sig[0]_i_1 
       (.I0(s00_axi_aresetn),
        .O(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tmp_sig_reg[0] 
       (.C(clock_out),
        .CE(E),
        .D(\tmp_sig_reg[7]_0 [1]),
        .Q(\tmp_sig_reg[7]_0 [0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tmp_sig_reg[1] 
       (.C(clock_out),
        .CE(E),
        .D(\tmp_sig_reg[7]_0 [2]),
        .Q(\tmp_sig_reg[7]_0 [1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tmp_sig_reg[2] 
       (.C(clock_out),
        .CE(E),
        .D(\tmp_sig_reg[7]_0 [3]),
        .Q(\tmp_sig_reg[7]_0 [2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tmp_sig_reg[3] 
       (.C(clock_out),
        .CE(E),
        .D(\tmp_sig_reg[7]_0 [4]),
        .Q(\tmp_sig_reg[7]_0 [3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tmp_sig_reg[4] 
       (.C(clock_out),
        .CE(E),
        .D(\tmp_sig_reg[7]_0 [5]),
        .Q(\tmp_sig_reg[7]_0 [4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tmp_sig_reg[5] 
       (.C(clock_out),
        .CE(E),
        .D(\tmp_sig_reg[7]_0 [6]),
        .Q(\tmp_sig_reg[7]_0 [5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tmp_sig_reg[6] 
       (.C(clock_out),
        .CE(E),
        .D(\tmp_sig_reg[7]_0 [7]),
        .Q(\tmp_sig_reg[7]_0 [6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tmp_sig_reg[7] 
       (.C(clock_out),
        .CE(E),
        .D(rx_frame),
        .Q(\tmp_sig_reg[7]_0 [7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tmp_sig_reg[8] 
       (.C(clock_out),
        .CE(E),
        .D(\tmp_sig_reg_n_0_[9] ),
        .Q(rx_frame),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tmp_sig_reg[9] 
       (.C(clock_out),
        .CE(E),
        .D(rx),
        .Q(\tmp_sig_reg_n_0_[9] ),
        .R(SR));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tx_cu
   (D,
    E,
    tx,
    CLK,
    Q,
    \axi_rdata_reg[4] ,
    axi_araddr,
    \axi_rdata_reg[4]_0 ,
    s00_axi_aresetn,
    SS);
  output [0:0]D;
  output [0:0]E;
  output tx;
  input CLK;
  input [7:0]Q;
  input [0:0]\axi_rdata_reg[4] ;
  input [1:0]axi_araddr;
  input [1:0]\axi_rdata_reg[4]_0 ;
  input s00_axi_aresetn;
  input [0:0]SS;

  wire CLK;
  wire [0:0]D;
  wire [0:0]E;
  wire \FSM_sequential_current_state[1]_i_1_n_0 ;
  wire [7:0]Q;
  wire [0:0]SS;
  wire TX_counter_n_0;
  wire [1:0]axi_araddr;
  wire [0:0]\axi_rdata_reg[4] ;
  wire [1:0]\axi_rdata_reg[4]_0 ;
  wire [1:0]current_state;
  wire s00_axi_aresetn;
  wire tx;

  LUT3 #(
    .INIT(8'h60)) 
    \FSM_sequential_current_state[1]_i_1 
       (.I0(current_state[0]),
        .I1(current_state[1]),
        .I2(s00_axi_aresetn),
        .O(\FSM_sequential_current_state[1]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "idle:00,start:01,transmit:10,reset_state:11" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_current_state_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(TX_counter_n_0),
        .Q(current_state[0]),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "idle:00,start:01,transmit:10,reset_state:11" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_current_state_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\FSM_sequential_current_state[1]_i_1_n_0 ),
        .Q(current_state[1]),
        .R(1'b0));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_counter_modN TX_counter
       (.CLK(CLK),
        .\FSM_sequential_current_state_reg[0] (\axi_rdata_reg[4]_0 [0]),
        .current_state(current_state),
        .s00_axi_aresetn(s00_axi_aresetn),
        .\slv_reg1_reg[0] (TX_counter_n_0));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_shift_register TX_shift_register
       (.CLK(CLK),
        .E(E),
        .Q(Q),
        .SS(SS),
        .current_state(current_state),
        .tx(tx));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \axi_rdata[4]_i_1 
       (.I0(E),
        .I1(\axi_rdata_reg[4] ),
        .I2(axi_araddr[1]),
        .I3(axi_araddr[0]),
        .I4(Q[4]),
        .I5(\axi_rdata_reg[4]_0 [1]),
        .O(D));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
