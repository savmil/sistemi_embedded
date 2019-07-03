// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
// Date        : Tue Jul  2 13:17:41 2019
// Host        : andrea-X580VD running 64-bit Ubuntu 18.04.2 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_UART_0_0_sim_netlist.v
// Design      : design_1_UART_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_UART
   (SR,
    D,
    \axi_araddr_reg[4] ,
    tx,
    Q,
    s00_axi_aclk,
    rx,
    \tmp_sig_reg[8] ,
    sel0,
    \axi_rdata_reg[7] ,
    \axi_rdata_reg[6] ,
    \axi_rdata_reg[5] ,
    \axi_rdata_reg[4] ,
    \axi_rdata_reg[3] ,
    \axi_rdata_reg[2] ,
    \axi_rdata_reg[2]_0 ,
    \axi_rdata_reg[1] ,
    \axi_rdata_reg[0] ,
    s00_axi_aresetn);
  output [0:0]SR;
  output [1:0]D;
  output [7:0]\axi_araddr_reg[4] ;
  output tx;
  input [6:0]Q;
  input s00_axi_aclk;
  input rx;
  input [7:0]\tmp_sig_reg[8] ;
  input [2:0]sel0;
  input \axi_rdata_reg[7] ;
  input \axi_rdata_reg[6] ;
  input \axi_rdata_reg[5] ;
  input \axi_rdata_reg[4] ;
  input \axi_rdata_reg[3] ;
  input \axi_rdata_reg[2] ;
  input \axi_rdata_reg[2]_0 ;
  input \axi_rdata_reg[1] ;
  input \axi_rdata_reg[0] ;
  input s00_axi_aresetn;

  wire [1:0]D;
  wire [6:0]Q;
  wire [0:0]SR;
  wire TX_UART_n_0;
  wire [7:0]\axi_araddr_reg[4] ;
  wire \axi_rdata_reg[0] ;
  wire \axi_rdata_reg[1] ;
  wire \axi_rdata_reg[2] ;
  wire \axi_rdata_reg[2]_0 ;
  wire \axi_rdata_reg[3] ;
  wire \axi_rdata_reg[4] ;
  wire \axi_rdata_reg[5] ;
  wire \axi_rdata_reg[6] ;
  wire \axi_rdata_reg[7] ;
  wire clock_out;
  wire [2:1]data3;
  wire inst_edge_detector_n_2;
  wire load_data;
  wire r0_input;
  wire r1_input;
  wire [7:0]received_data;
  wire rx;
  wire s00_axi_aclk;
  wire s00_axi_aresetn;
  wire [2:0]sel0;
  wire [7:0]\tmp_sig_reg[8] ;
  wire tx;
  wire tx_clock;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_clock_mod BAUDGENERATOR
       (.CLK(clock_out),
        .s00_axi_aclk(s00_axi_aclk));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_d_ff_register Holding_register
       (.D(D[0]),
        .E(D[1]),
        .Q(data3),
        .SS(SR),
        .\axi_araddr_reg[4] ({\axi_araddr_reg[4] [7:3],\axi_araddr_reg[4] [0]}),
        .\axi_rdata_reg[0] (\axi_rdata_reg[0] ),
        .\axi_rdata_reg[3] (\axi_rdata_reg[3] ),
        .\axi_rdata_reg[4] (\axi_rdata_reg[4] ),
        .\axi_rdata_reg[5] (\axi_rdata_reg[5] ),
        .\axi_rdata_reg[6] (\axi_rdata_reg[6] ),
        .\axi_rdata_reg[7] (\axi_rdata_reg[7] ),
        .\axi_rdata_reg[7]_0 ({Q[6:2],Q[0]}),
        .\axi_rdata_reg[7]_1 ({\tmp_sig_reg[8] [7:3],\tmp_sig_reg[8] [0]}),
        .\q_reg[7]_0 (load_data),
        .\q_reg[7]_1 (received_data),
        .s00_axi_aclk(s00_axi_aclk),
        .sel0(sel0));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_rx_cu RX_UART
       (.CLK(clock_out),
        .D(D[0]),
        .\FSM_onehot_current_state_reg[4]_0 (load_data),
        .Q(data3),
        .SS(SR),
        .\axi_araddr_reg[3] (\axi_araddr_reg[4] [2:1]),
        .\axi_rdata_reg[1] (\axi_rdata_reg[1] ),
        .\axi_rdata_reg[1]_0 (Q[1]),
        .\axi_rdata_reg[1]_1 (\tmp_sig_reg[8] [1]),
        .\axi_rdata_reg[2] (\axi_rdata_reg[2] ),
        .\axi_rdata_reg[2]_0 (\axi_rdata_reg[2]_0 ),
        .rx(rx),
        .s00_axi_aresetn(s00_axi_aresetn),
        .sel0(sel0),
        .\tmp_sig_reg[7] (received_data));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tx_cu TX_UART
       (.E(D[1]),
        .\FSM_onehot_current_state_reg[0]_0 (TX_UART_n_0),
        .\FSM_onehot_current_state_reg[1]_0 (inst_edge_detector_n_2),
        .SS(SR),
        .r0_input(r0_input),
        .r1_input(r1_input),
        .s00_axi_aresetn(s00_axi_aresetn),
        .\tmp_sig_reg[8] (\tmp_sig_reg[8] ),
        .tx(tx),
        .tx_clock(tx_clock));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_edge_detector inst_edge_detector
       (.\FSM_onehot_current_state_reg[1] (TX_UART_n_0),
        .Q(Q[0]),
        .SS(SR),
        .r0_input(r0_input),
        .r0_input_reg_0(inst_edge_detector_n_2),
        .r1_input(r1_input),
        .s00_axi_aresetn(s00_axi_aresetn),
        .tx_clock(tx_clock));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_clock_mod__parameterized1 tx_clock_mod
       (.CLK(clock_out),
        .tx_clock(tx_clock));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_UART_v1_0
   (S_AXI_AWREADY,
    tx,
    S_AXI_WREADY,
    interrupt,
    S_AXI_ARREADY,
    s00_axi_rdata,
    s00_axi_rvalid,
    s00_axi_bvalid,
    s00_axi_aresetn,
    s00_axi_aclk,
    s00_axi_awaddr,
    s00_axi_awvalid,
    s00_axi_wvalid,
    s00_axi_wdata,
    rx,
    s00_axi_araddr,
    s00_axi_arvalid,
    s00_axi_wstrb,
    s00_axi_bready,
    s00_axi_rready);
  output S_AXI_AWREADY;
  output tx;
  output S_AXI_WREADY;
  output interrupt;
  output S_AXI_ARREADY;
  output [31:0]s00_axi_rdata;
  output s00_axi_rvalid;
  output s00_axi_bvalid;
  input s00_axi_aresetn;
  input s00_axi_aclk;
  input [2:0]s00_axi_awaddr;
  input s00_axi_awvalid;
  input s00_axi_wvalid;
  input [31:0]s00_axi_wdata;
  input rx;
  input [2:0]s00_axi_araddr;
  input s00_axi_arvalid;
  input [3:0]s00_axi_wstrb;
  input s00_axi_bready;
  input s00_axi_rready;

  wire S_AXI_ARREADY;
  wire S_AXI_AWREADY;
  wire S_AXI_WREADY;
  wire interrupt;
  wire rx;
  wire s00_axi_aclk;
  wire [2:0]s00_axi_araddr;
  wire s00_axi_aresetn;
  wire s00_axi_arvalid;
  wire [2:0]s00_axi_awaddr;
  wire s00_axi_awvalid;
  wire s00_axi_bready;
  wire s00_axi_bvalid;
  wire [31:0]s00_axi_rdata;
  wire s00_axi_rready;
  wire s00_axi_rvalid;
  wire [31:0]s00_axi_wdata;
  wire [3:0]s00_axi_wstrb;
  wire s00_axi_wvalid;
  wire tx;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_UART_v1_0_S00_AXI UART_v1_0_S00_AXI_inst
       (.S_AXI_ARREADY(S_AXI_ARREADY),
        .S_AXI_AWREADY(S_AXI_AWREADY),
        .S_AXI_WREADY(S_AXI_WREADY),
        .interrupt(interrupt),
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
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_UART_v1_0_S00_AXI
   (S_AXI_AWREADY,
    tx,
    S_AXI_WREADY,
    interrupt,
    S_AXI_ARREADY,
    s00_axi_rdata,
    s00_axi_rvalid,
    s00_axi_bvalid,
    s00_axi_aresetn,
    s00_axi_aclk,
    s00_axi_awaddr,
    s00_axi_awvalid,
    s00_axi_wvalid,
    s00_axi_wdata,
    rx,
    s00_axi_araddr,
    s00_axi_arvalid,
    s00_axi_wstrb,
    s00_axi_bready,
    s00_axi_rready);
  output S_AXI_AWREADY;
  output tx;
  output S_AXI_WREADY;
  output interrupt;
  output S_AXI_ARREADY;
  output [31:0]s00_axi_rdata;
  output s00_axi_rvalid;
  output s00_axi_bvalid;
  input s00_axi_aresetn;
  input s00_axi_aclk;
  input [2:0]s00_axi_awaddr;
  input s00_axi_awvalid;
  input s00_axi_wvalid;
  input [31:0]s00_axi_wdata;
  input rx;
  input [2:0]s00_axi_araddr;
  input s00_axi_arvalid;
  input [3:0]s00_axi_wstrb;
  input s00_axi_bready;
  input s00_axi_rready;

  wire S_AXI_ARREADY;
  wire S_AXI_AWREADY;
  wire S_AXI_WREADY;
  wire aw_en_i_1_n_0;
  wire aw_en_reg_n_0;
  wire \axi_araddr[2]_i_1_n_0 ;
  wire \axi_araddr[3]_i_1_n_0 ;
  wire \axi_araddr[4]_i_1_n_0 ;
  wire axi_arready0;
  wire \axi_awaddr[2]_i_1_n_0 ;
  wire \axi_awaddr[3]_i_1_n_0 ;
  wire \axi_awaddr[4]_i_1_n_0 ;
  wire axi_awready0;
  wire axi_bvalid_i_1_n_0;
  wire \axi_rdata[0]_i_3_n_0 ;
  wire \axi_rdata[10]_i_2_n_0 ;
  wire \axi_rdata[11]_i_2_n_0 ;
  wire \axi_rdata[12]_i_2_n_0 ;
  wire \axi_rdata[13]_i_2_n_0 ;
  wire \axi_rdata[14]_i_2_n_0 ;
  wire \axi_rdata[15]_i_2_n_0 ;
  wire \axi_rdata[16]_i_2_n_0 ;
  wire \axi_rdata[17]_i_2_n_0 ;
  wire \axi_rdata[18]_i_2_n_0 ;
  wire \axi_rdata[19]_i_2_n_0 ;
  wire \axi_rdata[1]_i_3_n_0 ;
  wire \axi_rdata[20]_i_2_n_0 ;
  wire \axi_rdata[21]_i_2_n_0 ;
  wire \axi_rdata[22]_i_2_n_0 ;
  wire \axi_rdata[23]_i_2_n_0 ;
  wire \axi_rdata[24]_i_2_n_0 ;
  wire \axi_rdata[25]_i_2_n_0 ;
  wire \axi_rdata[26]_i_2_n_0 ;
  wire \axi_rdata[27]_i_2_n_0 ;
  wire \axi_rdata[28]_i_2_n_0 ;
  wire \axi_rdata[29]_i_2_n_0 ;
  wire \axi_rdata[2]_i_2_n_0 ;
  wire \axi_rdata[2]_i_4_n_0 ;
  wire \axi_rdata[30]_i_2_n_0 ;
  wire \axi_rdata[31]_i_3_n_0 ;
  wire \axi_rdata[3]_i_3_n_0 ;
  wire \axi_rdata[4]_i_3_n_0 ;
  wire \axi_rdata[5]_i_3_n_0 ;
  wire \axi_rdata[6]_i_3_n_0 ;
  wire \axi_rdata[7]_i_3_n_0 ;
  wire \axi_rdata[8]_i_2_n_0 ;
  wire \axi_rdata[9]_i_2_n_0 ;
  wire axi_rvalid_i_1_n_0;
  wire axi_wready0;
  wire [1:0]current_stage;
  wire inst_uart_n_1;
  wire inst_uart_n_2;
  wire interrupt;
  wire interrupt0;
  wire \last_stage_reg_n_0_[0] ;
  wire \last_stage_reg_n_0_[1] ;
  wire [2:0]p_0_in;
  wire \pending_intr[0]_i_1_n_0 ;
  wire \pending_intr[1]_i_1_n_0 ;
  wire \pending_intr[1]_i_2_n_0 ;
  wire \pending_intr[1]_i_3_n_0 ;
  wire [31:0]reg_data_out;
  wire reset;
  wire rx;
  wire s00_axi_aclk;
  wire [2:0]s00_axi_araddr;
  wire s00_axi_aresetn;
  wire s00_axi_arvalid;
  wire [2:0]s00_axi_awaddr;
  wire s00_axi_awvalid;
  wire s00_axi_bready;
  wire s00_axi_bvalid;
  wire [31:0]s00_axi_rdata;
  wire s00_axi_rready;
  wire s00_axi_rvalid;
  wire [31:0]s00_axi_wdata;
  wire [3:0]s00_axi_wstrb;
  wire s00_axi_wvalid;
  wire [2:0]sel0;
  wire [31:0]slv_reg0;
  wire \slv_reg0[15]_i_1_n_0 ;
  wire \slv_reg0[23]_i_1_n_0 ;
  wire \slv_reg0[31]_i_1_n_0 ;
  wire \slv_reg0[7]_i_1_n_0 ;
  wire [31:0]slv_reg1;
  wire \slv_reg1[15]_i_1_n_0 ;
  wire \slv_reg1[23]_i_1_n_0 ;
  wire \slv_reg1[31]_i_1_n_0 ;
  wire \slv_reg1[7]_i_1_n_0 ;
  wire \slv_reg4[15]_i_1_n_0 ;
  wire \slv_reg4[23]_i_1_n_0 ;
  wire \slv_reg4[31]_i_1_n_0 ;
  wire \slv_reg4[7]_i_1_n_0 ;
  wire \slv_reg4_reg_n_0_[0] ;
  wire \slv_reg4_reg_n_0_[10] ;
  wire \slv_reg4_reg_n_0_[11] ;
  wire \slv_reg4_reg_n_0_[12] ;
  wire \slv_reg4_reg_n_0_[13] ;
  wire \slv_reg4_reg_n_0_[14] ;
  wire \slv_reg4_reg_n_0_[15] ;
  wire \slv_reg4_reg_n_0_[16] ;
  wire \slv_reg4_reg_n_0_[17] ;
  wire \slv_reg4_reg_n_0_[18] ;
  wire \slv_reg4_reg_n_0_[19] ;
  wire \slv_reg4_reg_n_0_[1] ;
  wire \slv_reg4_reg_n_0_[20] ;
  wire \slv_reg4_reg_n_0_[21] ;
  wire \slv_reg4_reg_n_0_[22] ;
  wire \slv_reg4_reg_n_0_[23] ;
  wire \slv_reg4_reg_n_0_[24] ;
  wire \slv_reg4_reg_n_0_[25] ;
  wire \slv_reg4_reg_n_0_[26] ;
  wire \slv_reg4_reg_n_0_[27] ;
  wire \slv_reg4_reg_n_0_[28] ;
  wire \slv_reg4_reg_n_0_[29] ;
  wire \slv_reg4_reg_n_0_[2] ;
  wire \slv_reg4_reg_n_0_[30] ;
  wire \slv_reg4_reg_n_0_[31] ;
  wire \slv_reg4_reg_n_0_[3] ;
  wire \slv_reg4_reg_n_0_[4] ;
  wire \slv_reg4_reg_n_0_[5] ;
  wire \slv_reg4_reg_n_0_[6] ;
  wire \slv_reg4_reg_n_0_[7] ;
  wire \slv_reg4_reg_n_0_[8] ;
  wire \slv_reg4_reg_n_0_[9] ;
  wire \slv_reg5[15]_i_1_n_0 ;
  wire \slv_reg5[23]_i_1_n_0 ;
  wire \slv_reg5[31]_i_1_n_0 ;
  wire \slv_reg5[7]_i_1_n_0 ;
  wire \slv_reg5_reg_n_0_[0] ;
  wire \slv_reg5_reg_n_0_[10] ;
  wire \slv_reg5_reg_n_0_[11] ;
  wire \slv_reg5_reg_n_0_[12] ;
  wire \slv_reg5_reg_n_0_[13] ;
  wire \slv_reg5_reg_n_0_[14] ;
  wire \slv_reg5_reg_n_0_[15] ;
  wire \slv_reg5_reg_n_0_[16] ;
  wire \slv_reg5_reg_n_0_[17] ;
  wire \slv_reg5_reg_n_0_[18] ;
  wire \slv_reg5_reg_n_0_[19] ;
  wire \slv_reg5_reg_n_0_[1] ;
  wire \slv_reg5_reg_n_0_[20] ;
  wire \slv_reg5_reg_n_0_[21] ;
  wire \slv_reg5_reg_n_0_[22] ;
  wire \slv_reg5_reg_n_0_[23] ;
  wire \slv_reg5_reg_n_0_[24] ;
  wire \slv_reg5_reg_n_0_[25] ;
  wire \slv_reg5_reg_n_0_[26] ;
  wire \slv_reg5_reg_n_0_[27] ;
  wire \slv_reg5_reg_n_0_[28] ;
  wire \slv_reg5_reg_n_0_[29] ;
  wire \slv_reg5_reg_n_0_[2] ;
  wire \slv_reg5_reg_n_0_[30] ;
  wire \slv_reg5_reg_n_0_[31] ;
  wire \slv_reg5_reg_n_0_[3] ;
  wire \slv_reg5_reg_n_0_[4] ;
  wire \slv_reg5_reg_n_0_[5] ;
  wire \slv_reg5_reg_n_0_[6] ;
  wire \slv_reg5_reg_n_0_[7] ;
  wire \slv_reg5_reg_n_0_[8] ;
  wire \slv_reg5_reg_n_0_[9] ;
  wire [31:0]slv_reg6;
  wire \slv_reg6[15]_i_1_n_0 ;
  wire \slv_reg6[23]_i_1_n_0 ;
  wire \slv_reg6[31]_i_1_n_0 ;
  wire \slv_reg6[7]_i_1_n_0 ;
  wire [1:0]slv_reg7;
  wire \slv_reg7[0]_i_1_n_0 ;
  wire \slv_reg7[1]_i_1_n_0 ;
  wire \slv_reg7[1]_i_2_n_0 ;
  wire [1:0]slv_reg7_out;
  wire slv_reg_rden;
  wire slv_reg_wren__2;
  wire tx;

  LUT6 #(
    .INIT(64'hBFFF8CCC8CCC8CCC)) 
    aw_en_i_1
       (.I0(S_AXI_AWREADY),
        .I1(aw_en_reg_n_0),
        .I2(s00_axi_wvalid),
        .I3(s00_axi_awvalid),
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
        .I2(S_AXI_ARREADY),
        .I3(sel0[0]),
        .O(\axi_araddr[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \axi_araddr[3]_i_1 
       (.I0(s00_axi_araddr[1]),
        .I1(s00_axi_arvalid),
        .I2(S_AXI_ARREADY),
        .I3(sel0[1]),
        .O(\axi_araddr[3]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \axi_araddr[4]_i_1 
       (.I0(s00_axi_araddr[2]),
        .I1(s00_axi_arvalid),
        .I2(S_AXI_ARREADY),
        .I3(sel0[2]),
        .O(\axi_araddr[4]_i_1_n_0 ));
  FDSE \axi_araddr_reg[2] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\axi_araddr[2]_i_1_n_0 ),
        .Q(sel0[0]),
        .S(reset));
  FDSE \axi_araddr_reg[3] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\axi_araddr[3]_i_1_n_0 ),
        .Q(sel0[1]),
        .S(reset));
  FDSE \axi_araddr_reg[4] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\axi_araddr[4]_i_1_n_0 ),
        .Q(sel0[2]),
        .S(reset));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT2 #(
    .INIT(4'h2)) 
    axi_arready_i_1
       (.I0(s00_axi_arvalid),
        .I1(S_AXI_ARREADY),
        .O(axi_arready0));
  FDRE axi_arready_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_arready0),
        .Q(S_AXI_ARREADY),
        .R(reset));
  LUT6 #(
    .INIT(64'hFFFFBFFF00008000)) 
    \axi_awaddr[2]_i_1 
       (.I0(s00_axi_awaddr[0]),
        .I1(s00_axi_awvalid),
        .I2(s00_axi_wvalid),
        .I3(aw_en_reg_n_0),
        .I4(S_AXI_AWREADY),
        .I5(p_0_in[0]),
        .O(\axi_awaddr[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFBFFF00008000)) 
    \axi_awaddr[3]_i_1 
       (.I0(s00_axi_awaddr[1]),
        .I1(s00_axi_awvalid),
        .I2(s00_axi_wvalid),
        .I3(aw_en_reg_n_0),
        .I4(S_AXI_AWREADY),
        .I5(p_0_in[1]),
        .O(\axi_awaddr[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFBFFF00008000)) 
    \axi_awaddr[4]_i_1 
       (.I0(s00_axi_awaddr[2]),
        .I1(s00_axi_awvalid),
        .I2(s00_axi_wvalid),
        .I3(aw_en_reg_n_0),
        .I4(S_AXI_AWREADY),
        .I5(p_0_in[2]),
        .O(\axi_awaddr[4]_i_1_n_0 ));
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
  FDRE \axi_awaddr_reg[4] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\axi_awaddr[4]_i_1_n_0 ),
        .Q(p_0_in[2]),
        .R(reset));
  LUT4 #(
    .INIT(16'h0080)) 
    axi_awready_i_1
       (.I0(s00_axi_awvalid),
        .I1(s00_axi_wvalid),
        .I2(aw_en_reg_n_0),
        .I3(S_AXI_AWREADY),
        .O(axi_awready0));
  FDRE axi_awready_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_awready0),
        .Q(S_AXI_AWREADY),
        .R(reset));
  LUT6 #(
    .INIT(64'h0000FFFF80008000)) 
    axi_bvalid_i_1
       (.I0(s00_axi_awvalid),
        .I1(S_AXI_AWREADY),
        .I2(S_AXI_WREADY),
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
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[0]_i_3 
       (.I0(slv_reg7_out[0]),
        .I1(slv_reg6[0]),
        .I2(sel0[1]),
        .I3(\slv_reg5_reg_n_0_[0] ),
        .I4(sel0[0]),
        .I5(\slv_reg4_reg_n_0_[0] ),
        .O(\axi_rdata[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[10]_i_1 
       (.I0(\axi_rdata[10]_i_2_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[10]),
        .I3(sel0[0]),
        .I4(slv_reg1[10]),
        .I5(sel0[1]),
        .O(reg_data_out[10]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[10]_i_2 
       (.I0(slv_reg6[10]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[10] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[10] ),
        .O(\axi_rdata[10]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[11]_i_1 
       (.I0(\axi_rdata[11]_i_2_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[11]),
        .I3(sel0[0]),
        .I4(slv_reg1[11]),
        .I5(sel0[1]),
        .O(reg_data_out[11]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[11]_i_2 
       (.I0(slv_reg6[11]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[11] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[11] ),
        .O(\axi_rdata[11]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[12]_i_1 
       (.I0(\axi_rdata[12]_i_2_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[12]),
        .I3(sel0[0]),
        .I4(slv_reg1[12]),
        .I5(sel0[1]),
        .O(reg_data_out[12]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[12]_i_2 
       (.I0(slv_reg6[12]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[12] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[12] ),
        .O(\axi_rdata[12]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[13]_i_1 
       (.I0(\axi_rdata[13]_i_2_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[13]),
        .I3(sel0[0]),
        .I4(slv_reg1[13]),
        .I5(sel0[1]),
        .O(reg_data_out[13]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[13]_i_2 
       (.I0(slv_reg6[13]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[13] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[13] ),
        .O(\axi_rdata[13]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[14]_i_1 
       (.I0(\axi_rdata[14]_i_2_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[14]),
        .I3(sel0[0]),
        .I4(slv_reg1[14]),
        .I5(sel0[1]),
        .O(reg_data_out[14]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[14]_i_2 
       (.I0(slv_reg6[14]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[14] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[14] ),
        .O(\axi_rdata[14]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[15]_i_1 
       (.I0(\axi_rdata[15]_i_2_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[15]),
        .I3(sel0[0]),
        .I4(slv_reg1[15]),
        .I5(sel0[1]),
        .O(reg_data_out[15]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[15]_i_2 
       (.I0(slv_reg6[15]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[15] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[15] ),
        .O(\axi_rdata[15]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[16]_i_1 
       (.I0(\axi_rdata[16]_i_2_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[16]),
        .I3(sel0[0]),
        .I4(slv_reg1[16]),
        .I5(sel0[1]),
        .O(reg_data_out[16]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[16]_i_2 
       (.I0(slv_reg6[16]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[16] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[16] ),
        .O(\axi_rdata[16]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[17]_i_1 
       (.I0(\axi_rdata[17]_i_2_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[17]),
        .I3(sel0[0]),
        .I4(slv_reg1[17]),
        .I5(sel0[1]),
        .O(reg_data_out[17]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[17]_i_2 
       (.I0(slv_reg6[17]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[17] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[17] ),
        .O(\axi_rdata[17]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[18]_i_1 
       (.I0(\axi_rdata[18]_i_2_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[18]),
        .I3(sel0[0]),
        .I4(slv_reg1[18]),
        .I5(sel0[1]),
        .O(reg_data_out[18]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[18]_i_2 
       (.I0(slv_reg6[18]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[18] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[18] ),
        .O(\axi_rdata[18]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[19]_i_1 
       (.I0(\axi_rdata[19]_i_2_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[19]),
        .I3(sel0[0]),
        .I4(slv_reg1[19]),
        .I5(sel0[1]),
        .O(reg_data_out[19]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[19]_i_2 
       (.I0(slv_reg6[19]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[19] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[19] ),
        .O(\axi_rdata[19]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[1]_i_3 
       (.I0(slv_reg7_out[1]),
        .I1(slv_reg6[1]),
        .I2(sel0[1]),
        .I3(\slv_reg5_reg_n_0_[1] ),
        .I4(sel0[0]),
        .I5(\slv_reg4_reg_n_0_[1] ),
        .O(\axi_rdata[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[20]_i_1 
       (.I0(\axi_rdata[20]_i_2_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[20]),
        .I3(sel0[0]),
        .I4(slv_reg1[20]),
        .I5(sel0[1]),
        .O(reg_data_out[20]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[20]_i_2 
       (.I0(slv_reg6[20]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[20] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[20] ),
        .O(\axi_rdata[20]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[21]_i_1 
       (.I0(\axi_rdata[21]_i_2_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[21]),
        .I3(sel0[0]),
        .I4(slv_reg1[21]),
        .I5(sel0[1]),
        .O(reg_data_out[21]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[21]_i_2 
       (.I0(slv_reg6[21]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[21] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[21] ),
        .O(\axi_rdata[21]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[22]_i_1 
       (.I0(\axi_rdata[22]_i_2_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[22]),
        .I3(sel0[0]),
        .I4(slv_reg1[22]),
        .I5(sel0[1]),
        .O(reg_data_out[22]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[22]_i_2 
       (.I0(slv_reg6[22]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[22] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[22] ),
        .O(\axi_rdata[22]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[23]_i_1 
       (.I0(\axi_rdata[23]_i_2_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[23]),
        .I3(sel0[0]),
        .I4(slv_reg1[23]),
        .I5(sel0[1]),
        .O(reg_data_out[23]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[23]_i_2 
       (.I0(slv_reg6[23]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[23] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[23] ),
        .O(\axi_rdata[23]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[24]_i_1 
       (.I0(\axi_rdata[24]_i_2_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[24]),
        .I3(sel0[0]),
        .I4(slv_reg1[24]),
        .I5(sel0[1]),
        .O(reg_data_out[24]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[24]_i_2 
       (.I0(slv_reg6[24]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[24] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[24] ),
        .O(\axi_rdata[24]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[25]_i_1 
       (.I0(\axi_rdata[25]_i_2_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[25]),
        .I3(sel0[0]),
        .I4(slv_reg1[25]),
        .I5(sel0[1]),
        .O(reg_data_out[25]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[25]_i_2 
       (.I0(slv_reg6[25]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[25] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[25] ),
        .O(\axi_rdata[25]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[26]_i_1 
       (.I0(\axi_rdata[26]_i_2_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[26]),
        .I3(sel0[0]),
        .I4(slv_reg1[26]),
        .I5(sel0[1]),
        .O(reg_data_out[26]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[26]_i_2 
       (.I0(slv_reg6[26]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[26] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[26] ),
        .O(\axi_rdata[26]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[27]_i_1 
       (.I0(\axi_rdata[27]_i_2_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[27]),
        .I3(sel0[0]),
        .I4(slv_reg1[27]),
        .I5(sel0[1]),
        .O(reg_data_out[27]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[27]_i_2 
       (.I0(slv_reg6[27]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[27] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[27] ),
        .O(\axi_rdata[27]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[28]_i_1 
       (.I0(\axi_rdata[28]_i_2_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[28]),
        .I3(sel0[0]),
        .I4(slv_reg1[28]),
        .I5(sel0[1]),
        .O(reg_data_out[28]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[28]_i_2 
       (.I0(slv_reg6[28]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[28] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[28] ),
        .O(\axi_rdata[28]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[29]_i_1 
       (.I0(\axi_rdata[29]_i_2_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[29]),
        .I3(sel0[0]),
        .I4(slv_reg1[29]),
        .I5(sel0[1]),
        .O(reg_data_out[29]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[29]_i_2 
       (.I0(slv_reg6[29]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[29] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[29] ),
        .O(\axi_rdata[29]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAAAABABF)) 
    \axi_rdata[2]_i_2 
       (.I0(sel0[2]),
        .I1(slv_reg1[2]),
        .I2(sel0[0]),
        .I3(slv_reg0[2]),
        .I4(sel0[1]),
        .O(\axi_rdata[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h33E200E200000000)) 
    \axi_rdata[2]_i_4 
       (.I0(\slv_reg4_reg_n_0_[2] ),
        .I1(sel0[0]),
        .I2(\slv_reg5_reg_n_0_[2] ),
        .I3(sel0[1]),
        .I4(slv_reg6[2]),
        .I5(sel0[2]),
        .O(\axi_rdata[2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[30]_i_1 
       (.I0(\axi_rdata[30]_i_2_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[30]),
        .I3(sel0[0]),
        .I4(slv_reg1[30]),
        .I5(sel0[1]),
        .O(reg_data_out[30]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[30]_i_2 
       (.I0(slv_reg6[30]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[30] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[30] ),
        .O(\axi_rdata[30]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h08)) 
    \axi_rdata[31]_i_1 
       (.I0(S_AXI_ARREADY),
        .I1(s00_axi_arvalid),
        .I2(s00_axi_rvalid),
        .O(slv_reg_rden));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[31]_i_2 
       (.I0(\axi_rdata[31]_i_3_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[31]),
        .I3(sel0[0]),
        .I4(slv_reg1[31]),
        .I5(sel0[1]),
        .O(reg_data_out[31]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[31]_i_3 
       (.I0(slv_reg6[31]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[31] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[31] ),
        .O(\axi_rdata[31]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[3]_i_3 
       (.I0(slv_reg6[3]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[3] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[3] ),
        .O(\axi_rdata[3]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[4]_i_3 
       (.I0(slv_reg6[4]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[4] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[4] ),
        .O(\axi_rdata[4]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[5]_i_3 
       (.I0(slv_reg6[5]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[5] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[5] ),
        .O(\axi_rdata[5]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[6]_i_3 
       (.I0(slv_reg6[6]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[6] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[6] ),
        .O(\axi_rdata[6]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[7]_i_3 
       (.I0(slv_reg6[7]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[7] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[7] ),
        .O(\axi_rdata[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[8]_i_1 
       (.I0(\axi_rdata[8]_i_2_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[8]),
        .I3(sel0[0]),
        .I4(slv_reg1[8]),
        .I5(sel0[1]),
        .O(reg_data_out[8]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[8]_i_2 
       (.I0(slv_reg6[8]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[8] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[8] ),
        .O(\axi_rdata[8]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888888BBB888B8)) 
    \axi_rdata[9]_i_1 
       (.I0(\axi_rdata[9]_i_2_n_0 ),
        .I1(sel0[2]),
        .I2(slv_reg0[9]),
        .I3(sel0[0]),
        .I4(slv_reg1[9]),
        .I5(sel0[1]),
        .O(reg_data_out[9]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \axi_rdata[9]_i_2 
       (.I0(slv_reg6[9]),
        .I1(sel0[1]),
        .I2(\slv_reg5_reg_n_0_[9] ),
        .I3(sel0[0]),
        .I4(\slv_reg4_reg_n_0_[9] ),
        .O(\axi_rdata[9]_i_2_n_0 ));
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
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT4 #(
    .INIT(16'h08F8)) 
    axi_rvalid_i_1
       (.I0(s00_axi_arvalid),
        .I1(S_AXI_ARREADY),
        .I2(s00_axi_rvalid),
        .I3(s00_axi_rready),
        .O(axi_rvalid_i_1_n_0));
  FDRE axi_rvalid_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_rvalid_i_1_n_0),
        .Q(s00_axi_rvalid),
        .R(reset));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT4 #(
    .INIT(16'h0080)) 
    axi_wready_i_1
       (.I0(s00_axi_awvalid),
        .I1(s00_axi_wvalid),
        .I2(aw_en_reg_n_0),
        .I3(S_AXI_WREADY),
        .O(axi_wready0));
  FDRE axi_wready_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_wready0),
        .Q(S_AXI_WREADY),
        .R(reset));
  FDRE \current_stage_reg[0] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\last_stage_reg_n_0_[0] ),
        .Q(current_stage[0]),
        .R(reset));
  FDRE \current_stage_reg[1] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\last_stage_reg_n_0_[1] ),
        .Q(current_stage[1]),
        .R(reset));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_UART inst_uart
       (.D({inst_uart_n_1,inst_uart_n_2}),
        .Q({slv_reg1[7:3],slv_reg1[1:0]}),
        .SR(reset),
        .\axi_araddr_reg[4] (reg_data_out[7:0]),
        .\axi_rdata_reg[0] (\axi_rdata[0]_i_3_n_0 ),
        .\axi_rdata_reg[1] (\axi_rdata[1]_i_3_n_0 ),
        .\axi_rdata_reg[2] (\axi_rdata[2]_i_2_n_0 ),
        .\axi_rdata_reg[2]_0 (\axi_rdata[2]_i_4_n_0 ),
        .\axi_rdata_reg[3] (\axi_rdata[3]_i_3_n_0 ),
        .\axi_rdata_reg[4] (\axi_rdata[4]_i_3_n_0 ),
        .\axi_rdata_reg[5] (\axi_rdata[5]_i_3_n_0 ),
        .\axi_rdata_reg[6] (\axi_rdata[6]_i_3_n_0 ),
        .\axi_rdata_reg[7] (\axi_rdata[7]_i_3_n_0 ),
        .rx(rx),
        .s00_axi_aclk(s00_axi_aclk),
        .s00_axi_aresetn(s00_axi_aresetn),
        .sel0(sel0),
        .\tmp_sig_reg[8] (slv_reg0[7:0]),
        .tx(tx));
  LUT3 #(
    .INIT(8'hA8)) 
    interrupt_i_1
       (.I0(\slv_reg4_reg_n_0_[0] ),
        .I1(slv_reg7_out[0]),
        .I2(slv_reg7_out[1]),
        .O(interrupt0));
  FDRE interrupt_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(interrupt0),
        .Q(interrupt),
        .R(reset));
  FDRE \last_stage_reg[0] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(inst_uart_n_2),
        .Q(\last_stage_reg_n_0_[0] ),
        .R(reset));
  FDRE \last_stage_reg[1] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(inst_uart_n_1),
        .Q(\last_stage_reg_n_0_[1] ),
        .R(reset));
  LUT5 #(
    .INIT(32'hD0FFC0C0)) 
    \pending_intr[0]_i_1 
       (.I0(\pending_intr[1]_i_2_n_0 ),
        .I1(\pending_intr[1]_i_3_n_0 ),
        .I2(\slv_reg4_reg_n_0_[0] ),
        .I3(slv_reg7[0]),
        .I4(slv_reg7_out[0]),
        .O(\pending_intr[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hD0FF5050)) 
    \pending_intr[1]_i_1 
       (.I0(\pending_intr[1]_i_2_n_0 ),
        .I1(\pending_intr[1]_i_3_n_0 ),
        .I2(\slv_reg4_reg_n_0_[0] ),
        .I3(slv_reg7[1]),
        .I4(slv_reg7_out[1]),
        .O(\pending_intr[1]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hBF)) 
    \pending_intr[1]_i_2 
       (.I0(current_stage[0]),
        .I1(\last_stage_reg_n_0_[0] ),
        .I2(\slv_reg5_reg_n_0_[1] ),
        .O(\pending_intr[1]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h08)) 
    \pending_intr[1]_i_3 
       (.I0(current_stage[1]),
        .I1(\slv_reg5_reg_n_0_[0] ),
        .I2(\last_stage_reg_n_0_[1] ),
        .O(\pending_intr[1]_i_3_n_0 ));
  FDRE \pending_intr_reg[0] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\pending_intr[0]_i_1_n_0 ),
        .Q(slv_reg7_out[0]),
        .R(reset));
  FDRE \pending_intr_reg[1] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\pending_intr[1]_i_1_n_0 ),
        .Q(slv_reg7_out[1]),
        .R(reset));
  LUT5 #(
    .INIT(32'h00020000)) 
    \slv_reg0[15]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(p_0_in[2]),
        .I4(s00_axi_wstrb[1]),
        .O(\slv_reg0[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00020000)) 
    \slv_reg0[23]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(p_0_in[2]),
        .I4(s00_axi_wstrb[2]),
        .O(\slv_reg0[23]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00020000)) 
    \slv_reg0[31]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(p_0_in[2]),
        .I4(s00_axi_wstrb[3]),
        .O(\slv_reg0[31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \slv_reg0[31]_i_2 
       (.I0(s00_axi_awvalid),
        .I1(S_AXI_AWREADY),
        .I2(S_AXI_WREADY),
        .I3(s00_axi_wvalid),
        .O(slv_reg_wren__2));
  LUT5 #(
    .INIT(32'h00020000)) 
    \slv_reg0[7]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(p_0_in[2]),
        .I4(s00_axi_wstrb[0]),
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
  LUT5 #(
    .INIT(32'h02000000)) 
    \slv_reg1[15]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[2]),
        .I2(p_0_in[1]),
        .I3(s00_axi_wstrb[1]),
        .I4(p_0_in[0]),
        .O(\slv_reg1[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h02000000)) 
    \slv_reg1[23]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[2]),
        .I2(p_0_in[1]),
        .I3(s00_axi_wstrb[2]),
        .I4(p_0_in[0]),
        .O(\slv_reg1[23]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h02000000)) 
    \slv_reg1[31]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[2]),
        .I2(p_0_in[1]),
        .I3(s00_axi_wstrb[3]),
        .I4(p_0_in[0]),
        .O(\slv_reg1[31]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h02000000)) 
    \slv_reg1[7]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[2]),
        .I2(p_0_in[1]),
        .I3(s00_axi_wstrb[0]),
        .I4(p_0_in[0]),
        .O(\slv_reg1[7]_i_1_n_0 ));
  FDRE \slv_reg1_reg[0] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[0]),
        .Q(slv_reg1[0]),
        .R(reset));
  FDRE \slv_reg1_reg[10] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[10]),
        .Q(slv_reg1[10]),
        .R(reset));
  FDRE \slv_reg1_reg[11] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[11]),
        .Q(slv_reg1[11]),
        .R(reset));
  FDRE \slv_reg1_reg[12] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[12]),
        .Q(slv_reg1[12]),
        .R(reset));
  FDRE \slv_reg1_reg[13] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[13]),
        .Q(slv_reg1[13]),
        .R(reset));
  FDRE \slv_reg1_reg[14] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[14]),
        .Q(slv_reg1[14]),
        .R(reset));
  FDRE \slv_reg1_reg[15] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[15]),
        .Q(slv_reg1[15]),
        .R(reset));
  FDRE \slv_reg1_reg[16] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[16]),
        .Q(slv_reg1[16]),
        .R(reset));
  FDRE \slv_reg1_reg[17] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[17]),
        .Q(slv_reg1[17]),
        .R(reset));
  FDRE \slv_reg1_reg[18] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[18]),
        .Q(slv_reg1[18]),
        .R(reset));
  FDRE \slv_reg1_reg[19] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[19]),
        .Q(slv_reg1[19]),
        .R(reset));
  FDRE \slv_reg1_reg[1] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[1]),
        .Q(slv_reg1[1]),
        .R(reset));
  FDRE \slv_reg1_reg[20] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[20]),
        .Q(slv_reg1[20]),
        .R(reset));
  FDRE \slv_reg1_reg[21] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[21]),
        .Q(slv_reg1[21]),
        .R(reset));
  FDRE \slv_reg1_reg[22] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[22]),
        .Q(slv_reg1[22]),
        .R(reset));
  FDRE \slv_reg1_reg[23] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[23]_i_1_n_0 ),
        .D(s00_axi_wdata[23]),
        .Q(slv_reg1[23]),
        .R(reset));
  FDRE \slv_reg1_reg[24] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[24]),
        .Q(slv_reg1[24]),
        .R(reset));
  FDRE \slv_reg1_reg[25] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[25]),
        .Q(slv_reg1[25]),
        .R(reset));
  FDRE \slv_reg1_reg[26] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[26]),
        .Q(slv_reg1[26]),
        .R(reset));
  FDRE \slv_reg1_reg[27] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[27]),
        .Q(slv_reg1[27]),
        .R(reset));
  FDRE \slv_reg1_reg[28] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[28]),
        .Q(slv_reg1[28]),
        .R(reset));
  FDRE \slv_reg1_reg[29] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[29]),
        .Q(slv_reg1[29]),
        .R(reset));
  FDRE \slv_reg1_reg[2] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[2]),
        .Q(slv_reg1[2]),
        .R(reset));
  FDRE \slv_reg1_reg[30] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[30]),
        .Q(slv_reg1[30]),
        .R(reset));
  FDRE \slv_reg1_reg[31] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[31]_i_1_n_0 ),
        .D(s00_axi_wdata[31]),
        .Q(slv_reg1[31]),
        .R(reset));
  FDRE \slv_reg1_reg[3] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[3]),
        .Q(slv_reg1[3]),
        .R(reset));
  FDRE \slv_reg1_reg[4] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[4]),
        .Q(slv_reg1[4]),
        .R(reset));
  FDRE \slv_reg1_reg[5] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[5]),
        .Q(slv_reg1[5]),
        .R(reset));
  FDRE \slv_reg1_reg[6] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[6]),
        .Q(slv_reg1[6]),
        .R(reset));
  FDRE \slv_reg1_reg[7] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[7]_i_1_n_0 ),
        .D(s00_axi_wdata[7]),
        .Q(slv_reg1[7]),
        .R(reset));
  FDRE \slv_reg1_reg[8] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[8]),
        .Q(slv_reg1[8]),
        .R(reset));
  FDRE \slv_reg1_reg[9] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg1[15]_i_1_n_0 ),
        .D(s00_axi_wdata[9]),
        .Q(slv_reg1[9]),
        .R(reset));
  LUT5 #(
    .INIT(32'h02000000)) 
    \slv_reg4[15]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(p_0_in[2]),
        .I4(s00_axi_wstrb[1]),
        .O(\slv_reg4[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h02000000)) 
    \slv_reg4[23]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(p_0_in[2]),
        .I4(s00_axi_wstrb[2]),
        .O(\slv_reg4[23]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h02000000)) 
    \slv_reg4[31]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(p_0_in[2]),
        .I4(s00_axi_wstrb[3]),
        .O(\slv_reg4[31]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h02000000)) 
    \slv_reg4[7]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(p_0_in[2]),
        .I4(s00_axi_wstrb[0]),
        .O(\slv_reg4[7]_i_1_n_0 ));
  FDRE \slv_reg4_reg[0] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[7]_i_1_n_0 ),
        .D(s00_axi_wdata[0]),
        .Q(\slv_reg4_reg_n_0_[0] ),
        .R(reset));
  FDRE \slv_reg4_reg[10] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[15]_i_1_n_0 ),
        .D(s00_axi_wdata[10]),
        .Q(\slv_reg4_reg_n_0_[10] ),
        .R(reset));
  FDRE \slv_reg4_reg[11] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[15]_i_1_n_0 ),
        .D(s00_axi_wdata[11]),
        .Q(\slv_reg4_reg_n_0_[11] ),
        .R(reset));
  FDRE \slv_reg4_reg[12] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[15]_i_1_n_0 ),
        .D(s00_axi_wdata[12]),
        .Q(\slv_reg4_reg_n_0_[12] ),
        .R(reset));
  FDRE \slv_reg4_reg[13] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[15]_i_1_n_0 ),
        .D(s00_axi_wdata[13]),
        .Q(\slv_reg4_reg_n_0_[13] ),
        .R(reset));
  FDRE \slv_reg4_reg[14] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[15]_i_1_n_0 ),
        .D(s00_axi_wdata[14]),
        .Q(\slv_reg4_reg_n_0_[14] ),
        .R(reset));
  FDRE \slv_reg4_reg[15] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[15]_i_1_n_0 ),
        .D(s00_axi_wdata[15]),
        .Q(\slv_reg4_reg_n_0_[15] ),
        .R(reset));
  FDRE \slv_reg4_reg[16] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[23]_i_1_n_0 ),
        .D(s00_axi_wdata[16]),
        .Q(\slv_reg4_reg_n_0_[16] ),
        .R(reset));
  FDRE \slv_reg4_reg[17] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[23]_i_1_n_0 ),
        .D(s00_axi_wdata[17]),
        .Q(\slv_reg4_reg_n_0_[17] ),
        .R(reset));
  FDRE \slv_reg4_reg[18] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[23]_i_1_n_0 ),
        .D(s00_axi_wdata[18]),
        .Q(\slv_reg4_reg_n_0_[18] ),
        .R(reset));
  FDRE \slv_reg4_reg[19] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[23]_i_1_n_0 ),
        .D(s00_axi_wdata[19]),
        .Q(\slv_reg4_reg_n_0_[19] ),
        .R(reset));
  FDRE \slv_reg4_reg[1] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[7]_i_1_n_0 ),
        .D(s00_axi_wdata[1]),
        .Q(\slv_reg4_reg_n_0_[1] ),
        .R(reset));
  FDRE \slv_reg4_reg[20] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[23]_i_1_n_0 ),
        .D(s00_axi_wdata[20]),
        .Q(\slv_reg4_reg_n_0_[20] ),
        .R(reset));
  FDRE \slv_reg4_reg[21] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[23]_i_1_n_0 ),
        .D(s00_axi_wdata[21]),
        .Q(\slv_reg4_reg_n_0_[21] ),
        .R(reset));
  FDRE \slv_reg4_reg[22] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[23]_i_1_n_0 ),
        .D(s00_axi_wdata[22]),
        .Q(\slv_reg4_reg_n_0_[22] ),
        .R(reset));
  FDRE \slv_reg4_reg[23] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[23]_i_1_n_0 ),
        .D(s00_axi_wdata[23]),
        .Q(\slv_reg4_reg_n_0_[23] ),
        .R(reset));
  FDRE \slv_reg4_reg[24] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[31]_i_1_n_0 ),
        .D(s00_axi_wdata[24]),
        .Q(\slv_reg4_reg_n_0_[24] ),
        .R(reset));
  FDRE \slv_reg4_reg[25] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[31]_i_1_n_0 ),
        .D(s00_axi_wdata[25]),
        .Q(\slv_reg4_reg_n_0_[25] ),
        .R(reset));
  FDRE \slv_reg4_reg[26] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[31]_i_1_n_0 ),
        .D(s00_axi_wdata[26]),
        .Q(\slv_reg4_reg_n_0_[26] ),
        .R(reset));
  FDRE \slv_reg4_reg[27] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[31]_i_1_n_0 ),
        .D(s00_axi_wdata[27]),
        .Q(\slv_reg4_reg_n_0_[27] ),
        .R(reset));
  FDRE \slv_reg4_reg[28] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[31]_i_1_n_0 ),
        .D(s00_axi_wdata[28]),
        .Q(\slv_reg4_reg_n_0_[28] ),
        .R(reset));
  FDRE \slv_reg4_reg[29] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[31]_i_1_n_0 ),
        .D(s00_axi_wdata[29]),
        .Q(\slv_reg4_reg_n_0_[29] ),
        .R(reset));
  FDRE \slv_reg4_reg[2] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[7]_i_1_n_0 ),
        .D(s00_axi_wdata[2]),
        .Q(\slv_reg4_reg_n_0_[2] ),
        .R(reset));
  FDRE \slv_reg4_reg[30] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[31]_i_1_n_0 ),
        .D(s00_axi_wdata[30]),
        .Q(\slv_reg4_reg_n_0_[30] ),
        .R(reset));
  FDRE \slv_reg4_reg[31] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[31]_i_1_n_0 ),
        .D(s00_axi_wdata[31]),
        .Q(\slv_reg4_reg_n_0_[31] ),
        .R(reset));
  FDRE \slv_reg4_reg[3] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[7]_i_1_n_0 ),
        .D(s00_axi_wdata[3]),
        .Q(\slv_reg4_reg_n_0_[3] ),
        .R(reset));
  FDRE \slv_reg4_reg[4] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[7]_i_1_n_0 ),
        .D(s00_axi_wdata[4]),
        .Q(\slv_reg4_reg_n_0_[4] ),
        .R(reset));
  FDRE \slv_reg4_reg[5] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[7]_i_1_n_0 ),
        .D(s00_axi_wdata[5]),
        .Q(\slv_reg4_reg_n_0_[5] ),
        .R(reset));
  FDRE \slv_reg4_reg[6] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[7]_i_1_n_0 ),
        .D(s00_axi_wdata[6]),
        .Q(\slv_reg4_reg_n_0_[6] ),
        .R(reset));
  FDRE \slv_reg4_reg[7] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[7]_i_1_n_0 ),
        .D(s00_axi_wdata[7]),
        .Q(\slv_reg4_reg_n_0_[7] ),
        .R(reset));
  FDRE \slv_reg4_reg[8] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[15]_i_1_n_0 ),
        .D(s00_axi_wdata[8]),
        .Q(\slv_reg4_reg_n_0_[8] ),
        .R(reset));
  FDRE \slv_reg4_reg[9] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[15]_i_1_n_0 ),
        .D(s00_axi_wdata[9]),
        .Q(\slv_reg4_reg_n_0_[9] ),
        .R(reset));
  LUT5 #(
    .INIT(32'h20000000)) 
    \slv_reg5[15]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[1]),
        .I2(s00_axi_wstrb[1]),
        .I3(p_0_in[0]),
        .I4(p_0_in[2]),
        .O(\slv_reg5[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h20000000)) 
    \slv_reg5[23]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[1]),
        .I2(s00_axi_wstrb[2]),
        .I3(p_0_in[0]),
        .I4(p_0_in[2]),
        .O(\slv_reg5[23]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h20000000)) 
    \slv_reg5[31]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[1]),
        .I2(s00_axi_wstrb[3]),
        .I3(p_0_in[0]),
        .I4(p_0_in[2]),
        .O(\slv_reg5[31]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h20000000)) 
    \slv_reg5[7]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[1]),
        .I2(s00_axi_wstrb[0]),
        .I3(p_0_in[0]),
        .I4(p_0_in[2]),
        .O(\slv_reg5[7]_i_1_n_0 ));
  FDRE \slv_reg5_reg[0] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[7]_i_1_n_0 ),
        .D(s00_axi_wdata[0]),
        .Q(\slv_reg5_reg_n_0_[0] ),
        .R(reset));
  FDRE \slv_reg5_reg[10] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[15]_i_1_n_0 ),
        .D(s00_axi_wdata[10]),
        .Q(\slv_reg5_reg_n_0_[10] ),
        .R(reset));
  FDRE \slv_reg5_reg[11] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[15]_i_1_n_0 ),
        .D(s00_axi_wdata[11]),
        .Q(\slv_reg5_reg_n_0_[11] ),
        .R(reset));
  FDRE \slv_reg5_reg[12] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[15]_i_1_n_0 ),
        .D(s00_axi_wdata[12]),
        .Q(\slv_reg5_reg_n_0_[12] ),
        .R(reset));
  FDRE \slv_reg5_reg[13] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[15]_i_1_n_0 ),
        .D(s00_axi_wdata[13]),
        .Q(\slv_reg5_reg_n_0_[13] ),
        .R(reset));
  FDRE \slv_reg5_reg[14] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[15]_i_1_n_0 ),
        .D(s00_axi_wdata[14]),
        .Q(\slv_reg5_reg_n_0_[14] ),
        .R(reset));
  FDRE \slv_reg5_reg[15] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[15]_i_1_n_0 ),
        .D(s00_axi_wdata[15]),
        .Q(\slv_reg5_reg_n_0_[15] ),
        .R(reset));
  FDRE \slv_reg5_reg[16] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[23]_i_1_n_0 ),
        .D(s00_axi_wdata[16]),
        .Q(\slv_reg5_reg_n_0_[16] ),
        .R(reset));
  FDRE \slv_reg5_reg[17] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[23]_i_1_n_0 ),
        .D(s00_axi_wdata[17]),
        .Q(\slv_reg5_reg_n_0_[17] ),
        .R(reset));
  FDRE \slv_reg5_reg[18] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[23]_i_1_n_0 ),
        .D(s00_axi_wdata[18]),
        .Q(\slv_reg5_reg_n_0_[18] ),
        .R(reset));
  FDRE \slv_reg5_reg[19] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[23]_i_1_n_0 ),
        .D(s00_axi_wdata[19]),
        .Q(\slv_reg5_reg_n_0_[19] ),
        .R(reset));
  FDRE \slv_reg5_reg[1] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[7]_i_1_n_0 ),
        .D(s00_axi_wdata[1]),
        .Q(\slv_reg5_reg_n_0_[1] ),
        .R(reset));
  FDRE \slv_reg5_reg[20] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[23]_i_1_n_0 ),
        .D(s00_axi_wdata[20]),
        .Q(\slv_reg5_reg_n_0_[20] ),
        .R(reset));
  FDRE \slv_reg5_reg[21] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[23]_i_1_n_0 ),
        .D(s00_axi_wdata[21]),
        .Q(\slv_reg5_reg_n_0_[21] ),
        .R(reset));
  FDRE \slv_reg5_reg[22] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[23]_i_1_n_0 ),
        .D(s00_axi_wdata[22]),
        .Q(\slv_reg5_reg_n_0_[22] ),
        .R(reset));
  FDRE \slv_reg5_reg[23] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[23]_i_1_n_0 ),
        .D(s00_axi_wdata[23]),
        .Q(\slv_reg5_reg_n_0_[23] ),
        .R(reset));
  FDRE \slv_reg5_reg[24] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[31]_i_1_n_0 ),
        .D(s00_axi_wdata[24]),
        .Q(\slv_reg5_reg_n_0_[24] ),
        .R(reset));
  FDRE \slv_reg5_reg[25] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[31]_i_1_n_0 ),
        .D(s00_axi_wdata[25]),
        .Q(\slv_reg5_reg_n_0_[25] ),
        .R(reset));
  FDRE \slv_reg5_reg[26] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[31]_i_1_n_0 ),
        .D(s00_axi_wdata[26]),
        .Q(\slv_reg5_reg_n_0_[26] ),
        .R(reset));
  FDRE \slv_reg5_reg[27] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[31]_i_1_n_0 ),
        .D(s00_axi_wdata[27]),
        .Q(\slv_reg5_reg_n_0_[27] ),
        .R(reset));
  FDRE \slv_reg5_reg[28] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[31]_i_1_n_0 ),
        .D(s00_axi_wdata[28]),
        .Q(\slv_reg5_reg_n_0_[28] ),
        .R(reset));
  FDRE \slv_reg5_reg[29] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[31]_i_1_n_0 ),
        .D(s00_axi_wdata[29]),
        .Q(\slv_reg5_reg_n_0_[29] ),
        .R(reset));
  FDRE \slv_reg5_reg[2] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[7]_i_1_n_0 ),
        .D(s00_axi_wdata[2]),
        .Q(\slv_reg5_reg_n_0_[2] ),
        .R(reset));
  FDRE \slv_reg5_reg[30] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[31]_i_1_n_0 ),
        .D(s00_axi_wdata[30]),
        .Q(\slv_reg5_reg_n_0_[30] ),
        .R(reset));
  FDRE \slv_reg5_reg[31] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[31]_i_1_n_0 ),
        .D(s00_axi_wdata[31]),
        .Q(\slv_reg5_reg_n_0_[31] ),
        .R(reset));
  FDRE \slv_reg5_reg[3] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[7]_i_1_n_0 ),
        .D(s00_axi_wdata[3]),
        .Q(\slv_reg5_reg_n_0_[3] ),
        .R(reset));
  FDRE \slv_reg5_reg[4] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[7]_i_1_n_0 ),
        .D(s00_axi_wdata[4]),
        .Q(\slv_reg5_reg_n_0_[4] ),
        .R(reset));
  FDRE \slv_reg5_reg[5] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[7]_i_1_n_0 ),
        .D(s00_axi_wdata[5]),
        .Q(\slv_reg5_reg_n_0_[5] ),
        .R(reset));
  FDRE \slv_reg5_reg[6] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[7]_i_1_n_0 ),
        .D(s00_axi_wdata[6]),
        .Q(\slv_reg5_reg_n_0_[6] ),
        .R(reset));
  FDRE \slv_reg5_reg[7] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[7]_i_1_n_0 ),
        .D(s00_axi_wdata[7]),
        .Q(\slv_reg5_reg_n_0_[7] ),
        .R(reset));
  FDRE \slv_reg5_reg[8] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[15]_i_1_n_0 ),
        .D(s00_axi_wdata[8]),
        .Q(\slv_reg5_reg_n_0_[8] ),
        .R(reset));
  FDRE \slv_reg5_reg[9] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[15]_i_1_n_0 ),
        .D(s00_axi_wdata[9]),
        .Q(\slv_reg5_reg_n_0_[9] ),
        .R(reset));
  LUT5 #(
    .INIT(32'h20000000)) 
    \slv_reg6[15]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(s00_axi_wstrb[1]),
        .I4(p_0_in[2]),
        .O(\slv_reg6[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h20000000)) 
    \slv_reg6[23]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(s00_axi_wstrb[2]),
        .I4(p_0_in[2]),
        .O(\slv_reg6[23]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h20000000)) 
    \slv_reg6[31]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(s00_axi_wstrb[3]),
        .I4(p_0_in[2]),
        .O(\slv_reg6[31]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h20000000)) 
    \slv_reg6[7]_i_1 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(s00_axi_wstrb[0]),
        .I4(p_0_in[2]),
        .O(\slv_reg6[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[0] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[7]_i_1_n_0 ),
        .D(s00_axi_wdata[0]),
        .Q(slv_reg6[0]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[10] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[15]_i_1_n_0 ),
        .D(s00_axi_wdata[10]),
        .Q(slv_reg6[10]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[11] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[15]_i_1_n_0 ),
        .D(s00_axi_wdata[11]),
        .Q(slv_reg6[11]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[12] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[15]_i_1_n_0 ),
        .D(s00_axi_wdata[12]),
        .Q(slv_reg6[12]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[13] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[15]_i_1_n_0 ),
        .D(s00_axi_wdata[13]),
        .Q(slv_reg6[13]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[14] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[15]_i_1_n_0 ),
        .D(s00_axi_wdata[14]),
        .Q(slv_reg6[14]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[15] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[15]_i_1_n_0 ),
        .D(s00_axi_wdata[15]),
        .Q(slv_reg6[15]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[16] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[23]_i_1_n_0 ),
        .D(s00_axi_wdata[16]),
        .Q(slv_reg6[16]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[17] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[23]_i_1_n_0 ),
        .D(s00_axi_wdata[17]),
        .Q(slv_reg6[17]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[18] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[23]_i_1_n_0 ),
        .D(s00_axi_wdata[18]),
        .Q(slv_reg6[18]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[19] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[23]_i_1_n_0 ),
        .D(s00_axi_wdata[19]),
        .Q(slv_reg6[19]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[1] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[7]_i_1_n_0 ),
        .D(s00_axi_wdata[1]),
        .Q(slv_reg6[1]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[20] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[23]_i_1_n_0 ),
        .D(s00_axi_wdata[20]),
        .Q(slv_reg6[20]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[21] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[23]_i_1_n_0 ),
        .D(s00_axi_wdata[21]),
        .Q(slv_reg6[21]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[22] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[23]_i_1_n_0 ),
        .D(s00_axi_wdata[22]),
        .Q(slv_reg6[22]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[23] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[23]_i_1_n_0 ),
        .D(s00_axi_wdata[23]),
        .Q(slv_reg6[23]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[24] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[31]_i_1_n_0 ),
        .D(s00_axi_wdata[24]),
        .Q(slv_reg6[24]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[25] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[31]_i_1_n_0 ),
        .D(s00_axi_wdata[25]),
        .Q(slv_reg6[25]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[26] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[31]_i_1_n_0 ),
        .D(s00_axi_wdata[26]),
        .Q(slv_reg6[26]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[27] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[31]_i_1_n_0 ),
        .D(s00_axi_wdata[27]),
        .Q(slv_reg6[27]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[28] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[31]_i_1_n_0 ),
        .D(s00_axi_wdata[28]),
        .Q(slv_reg6[28]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[29] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[31]_i_1_n_0 ),
        .D(s00_axi_wdata[29]),
        .Q(slv_reg6[29]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[2] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[7]_i_1_n_0 ),
        .D(s00_axi_wdata[2]),
        .Q(slv_reg6[2]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[30] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[31]_i_1_n_0 ),
        .D(s00_axi_wdata[30]),
        .Q(slv_reg6[30]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[31] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[31]_i_1_n_0 ),
        .D(s00_axi_wdata[31]),
        .Q(slv_reg6[31]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[3] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[7]_i_1_n_0 ),
        .D(s00_axi_wdata[3]),
        .Q(slv_reg6[3]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[4] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[7]_i_1_n_0 ),
        .D(s00_axi_wdata[4]),
        .Q(slv_reg6[4]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[5] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[7]_i_1_n_0 ),
        .D(s00_axi_wdata[5]),
        .Q(slv_reg6[5]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[6] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[7]_i_1_n_0 ),
        .D(s00_axi_wdata[6]),
        .Q(slv_reg6[6]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[7] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[7]_i_1_n_0 ),
        .D(s00_axi_wdata[7]),
        .Q(slv_reg6[7]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[8] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[15]_i_1_n_0 ),
        .D(s00_axi_wdata[8]),
        .Q(slv_reg6[8]),
        .R(reset));
  FDRE #(
    .INIT(1'b0)) 
    \slv_reg6_reg[9] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[15]_i_1_n_0 ),
        .D(s00_axi_wdata[9]),
        .Q(slv_reg6[9]),
        .R(reset));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slv_reg7[0]_i_1 
       (.I0(s00_axi_wdata[0]),
        .I1(\slv_reg7[1]_i_2_n_0 ),
        .I2(slv_reg7[0]),
        .O(\slv_reg7[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slv_reg7[1]_i_1 
       (.I0(s00_axi_wdata[1]),
        .I1(\slv_reg7[1]_i_2_n_0 ),
        .I2(slv_reg7[1]),
        .O(\slv_reg7[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h80000000)) 
    \slv_reg7[1]_i_2 
       (.I0(slv_reg_wren__2),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(p_0_in[2]),
        .I4(s00_axi_wstrb[0]),
        .O(\slv_reg7[1]_i_2_n_0 ));
  FDRE \slv_reg7_reg[0] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\slv_reg7[0]_i_1_n_0 ),
        .Q(slv_reg7[0]),
        .R(reset));
  FDRE \slv_reg7_reg[1] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\slv_reg7[1]_i_1_n_0 ),
        .Q(slv_reg7[1]),
        .R(reset));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_clock_mod
   (CLK,
    s00_axi_aclk);
  output CLK;
  input s00_axi_aclk;

  wire CLK;
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
        .I5(CLK),
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
        .Q(CLK),
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
    \count[3]_i_1 
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
   (tx_clock,
    CLK);
  output tx_clock;
  input CLK;

  wire CLK;
  wire clock_tmp_i_1_n_0;
  wire [2:0]count;
  wire \count[0]_i_1__1_n_0 ;
  wire \count[1]_i_1_n_0 ;
  wire \count[2]_i_1_n_0 ;
  wire tx_clock;

  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    clock_tmp_i_1
       (.I0(count[0]),
        .I1(count[2]),
        .I2(count[1]),
        .I3(tx_clock),
        .O(clock_tmp_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    clock_tmp_reg
       (.C(CLK),
        .CE(1'b1),
        .D(clock_tmp_i_1_n_0),
        .Q(tx_clock),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \count[0]_i_1__1 
       (.I0(count[0]),
        .O(\count[0]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \count[1]_i_1 
       (.I0(count[1]),
        .I1(count[0]),
        .O(\count[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'h6C)) 
    \count[2]_i_1 
       (.I0(count[1]),
        .I1(count[2]),
        .I2(count[0]),
        .O(\count[2]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\count[0]_i_1__1_n_0 ),
        .Q(count[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\count[1]_i_1_n_0 ),
        .Q(count[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(\count[2]_i_1_n_0 ),
        .Q(count[2]),
        .R(1'b0));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_counter_modN
   (counter_hit_reg_0,
    \FSM_onehot_current_state_reg[2] ,
    shift_en,
    tx_clock,
    p_load,
    \FSM_onehot_current_state_reg[0] ,
    r0_input,
    r1_input,
    s00_axi_aresetn);
  output counter_hit_reg_0;
  output \FSM_onehot_current_state_reg[2] ;
  input shift_en;
  input tx_clock;
  input p_load;
  input \FSM_onehot_current_state_reg[0] ;
  input r0_input;
  input r1_input;
  input s00_axi_aresetn;

  wire \FSM_onehot_current_state_reg[0] ;
  wire \FSM_onehot_current_state_reg[2] ;
  wire [3:0]count;
  wire \count[0]_i_1__0_n_0 ;
  wire \count[1]_i_1_n_0 ;
  wire \count[2]_i_1_n_0 ;
  wire \count[3]_i_1_n_0 ;
  wire counter_hit__0;
  wire counter_hit_n_0;
  wire counter_hit_reg_0;
  wire p_load;
  wire r0_input;
  wire r1_input;
  wire reset_counter;
  wire s00_axi_aresetn;
  wire shift_en;
  wire tx_clock;

  LUT5 #(
    .INIT(32'hFF8F8888)) 
    \FSM_onehot_current_state[0]_i_1 
       (.I0(counter_hit__0),
        .I1(shift_en),
        .I2(r0_input),
        .I3(r1_input),
        .I4(\FSM_onehot_current_state_reg[0] ),
        .O(counter_hit_reg_0));
  LUT4 #(
    .INIT(16'hF200)) 
    \FSM_onehot_current_state[2]_i_1 
       (.I0(shift_en),
        .I1(counter_hit__0),
        .I2(p_load),
        .I3(s00_axi_aresetn),
        .O(\FSM_onehot_current_state_reg[2] ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'h00BF)) 
    \count[0]_i_1__0 
       (.I0(count[2]),
        .I1(count[3]),
        .I2(count[1]),
        .I3(count[0]),
        .O(\count[0]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
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
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'h68F0)) 
    \count[3]_i_1 
       (.I0(count[2]),
        .I1(count[0]),
        .I2(count[3]),
        .I3(count[1]),
        .O(\count[3]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \count[3]_i_2 
       (.I0(p_load),
        .I1(\FSM_onehot_current_state_reg[0] ),
        .O(reset_counter));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[0] 
       (.C(tx_clock),
        .CE(shift_en),
        .CLR(reset_counter),
        .D(\count[0]_i_1__0_n_0 ),
        .Q(count[0]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[1] 
       (.C(tx_clock),
        .CE(shift_en),
        .CLR(reset_counter),
        .D(\count[1]_i_1_n_0 ),
        .Q(count[1]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[2] 
       (.C(tx_clock),
        .CE(shift_en),
        .CLR(reset_counter),
        .D(\count[2]_i_1_n_0 ),
        .Q(count[2]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[3] 
       (.C(tx_clock),
        .CE(shift_en),
        .CLR(reset_counter),
        .D(\count[3]_i_1_n_0 ),
        .Q(count[3]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'h1000)) 
    counter_hit
       (.I0(count[2]),
        .I1(count[0]),
        .I2(count[3]),
        .I3(count[1]),
        .O(counter_hit_n_0));
  FDCE counter_hit_reg
       (.C(tx_clock),
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
    CLK,
    rx);
  output counter_hit;
  output [0:0]D;
  input [1:0]Q;
  input CLK;
  input rx;

  wire CLK;
  wire [0:0]D;
  wire [1:0]Q;
  wire [2:0]count;
  wire \count[0]_i_1__2_n_0 ;
  wire \count[1]_i_1_n_0 ;
  wire \count[2]_i_1_n_0 ;
  wire counter_hit;
  wire counter_hit__0_n_0;
  wire rx;

  LUT4 #(
    .INIT(16'h4F44)) 
    \FSM_onehot_current_state[1]_i_1__0 
       (.I0(counter_hit),
        .I1(Q[1]),
        .I2(rx),
        .I3(Q[0]),
        .O(D));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \count[0]_i_1__2 
       (.I0(count[0]),
        .O(\count[0]_i_1__2_n_0 ));
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
       (.C(CLK),
        .CE(Q[1]),
        .CLR(Q[0]),
        .D(\count[0]_i_1__2_n_0 ),
        .Q(count[0]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[1] 
       (.C(CLK),
        .CE(Q[1]),
        .CLR(Q[0]),
        .D(\count[1]_i_1_n_0 ),
        .Q(count[1]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[2] 
       (.C(CLK),
        .CE(Q[1]),
        .CLR(Q[0]),
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
       (.C(CLK),
        .CE(Q[1]),
        .CLR(Q[0]),
        .D(counter_hit__0_n_0),
        .Q(counter_hit));
endmodule

(* ORIG_REF_NAME = "counter_modN" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_counter_modN__parameterized3
   (D,
    Q,
    CLK,
    counter_hit,
    done_bit_count);
  output [1:0]D;
  input [3:0]Q;
  input CLK;
  input counter_hit;
  input done_bit_count;

  wire CLK;
  wire [1:0]D;
  wire [3:0]Q;
  wire [3:0]count;
  wire \count[0]_i_1__3_n_0 ;
  wire \count[1]_i_1_n_0 ;
  wire \count[2]_i_1_n_0 ;
  wire \count[3]_i_1_n_0 ;
  wire counter_hit;
  wire counter_hit__0_n_0;
  wire done_16count;
  wire done_bit_count;
  wire reset_16count;

  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \FSM_onehot_current_state[2]_i_1__0 
       (.I0(done_16count),
        .I1(Q[2]),
        .I2(counter_hit),
        .I3(Q[1]),
        .I4(Q[3]),
        .I5(done_bit_count),
        .O(D[0]));
  LUT2 #(
    .INIT(4'h8)) 
    \FSM_onehot_current_state[3]_i_1 
       (.I0(done_16count),
        .I1(Q[2]),
        .O(D[1]));
  LUT1 #(
    .INIT(2'h1)) 
    \count[0]_i_1__3 
       (.I0(count[0]),
        .O(\count[0]_i_1__3_n_0 ));
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
  LUT2 #(
    .INIT(4'hE)) 
    \count[3]_i_2__0 
       (.I0(Q[3]),
        .I1(Q[0]),
        .O(reset_16count));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[0] 
       (.C(CLK),
        .CE(Q[2]),
        .CLR(reset_16count),
        .D(\count[0]_i_1__3_n_0 ),
        .Q(count[0]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[1] 
       (.C(CLK),
        .CE(Q[2]),
        .CLR(reset_16count),
        .D(\count[1]_i_1_n_0 ),
        .Q(count[1]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[2] 
       (.C(CLK),
        .CE(Q[2]),
        .CLR(reset_16count),
        .D(\count[2]_i_1_n_0 ),
        .Q(count[2]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[3] 
       (.C(CLK),
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
       (.C(CLK),
        .CE(Q[2]),
        .CLR(reset_16count),
        .D(counter_hit__0_n_0),
        .Q(done_16count));
endmodule

(* ORIG_REF_NAME = "counter_modN" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_counter_modN__parameterized5
   (done_bit_count,
    E,
    D,
    Q,
    CLK);
  output done_bit_count;
  output [0:0]E;
  output [0:0]D;
  input [1:0]Q;
  input CLK;

  wire CLK;
  wire [0:0]D;
  wire [0:0]E;
  wire [1:0]Q;
  wire [3:0]count;
  wire \count[0]_i_1__4_n_0 ;
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
    \count[0]_i_1__4 
       (.I0(count[0]),
        .O(\count[0]_i_1__4_n_0 ));
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
       (.C(CLK),
        .CE(Q[1]),
        .CLR(Q[0]),
        .D(\count[0]_i_1__4_n_0 ),
        .Q(count[0]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[1] 
       (.C(CLK),
        .CE(Q[1]),
        .CLR(Q[0]),
        .D(\count[1]_i_1_n_0 ),
        .Q(count[1]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[2] 
       (.C(CLK),
        .CE(Q[1]),
        .CLR(Q[0]),
        .D(\count[2]_i_1_n_0 ),
        .Q(count[2]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[3] 
       (.C(CLK),
        .CE(Q[1]),
        .CLR(Q[0]),
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
       (.C(CLK),
        .CE(Q[1]),
        .CLR(Q[0]),
        .D(counter_hit_n_0),
        .Q(done_bit_count));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \tmp_sig[9]_i_1 
       (.I0(Q[1]),
        .I1(done_bit_count),
        .O(E));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_d_ff_register
   (\axi_araddr_reg[4] ,
    Q,
    sel0,
    \axi_rdata_reg[7] ,
    \axi_rdata_reg[7]_0 ,
    \axi_rdata_reg[7]_1 ,
    \axi_rdata_reg[6] ,
    \axi_rdata_reg[5] ,
    \axi_rdata_reg[4] ,
    E,
    \axi_rdata_reg[3] ,
    D,
    \axi_rdata_reg[0] ,
    \q_reg[7]_0 ,
    \q_reg[7]_1 ,
    s00_axi_aclk,
    SS);
  output [5:0]\axi_araddr_reg[4] ;
  output [1:0]Q;
  input [2:0]sel0;
  input \axi_rdata_reg[7] ;
  input [5:0]\axi_rdata_reg[7]_0 ;
  input [5:0]\axi_rdata_reg[7]_1 ;
  input \axi_rdata_reg[6] ;
  input \axi_rdata_reg[5] ;
  input \axi_rdata_reg[4] ;
  input [0:0]E;
  input \axi_rdata_reg[3] ;
  input [0:0]D;
  input \axi_rdata_reg[0] ;
  input [0:0]\q_reg[7]_0 ;
  input [7:0]\q_reg[7]_1 ;
  input s00_axi_aclk;
  input [0:0]SS;

  wire [0:0]D;
  wire [0:0]E;
  wire [1:0]Q;
  wire [0:0]SS;
  wire [5:0]\axi_araddr_reg[4] ;
  wire \axi_rdata[0]_i_2_n_0 ;
  wire \axi_rdata[3]_i_2_n_0 ;
  wire \axi_rdata[4]_i_2_n_0 ;
  wire \axi_rdata[5]_i_2_n_0 ;
  wire \axi_rdata[6]_i_2_n_0 ;
  wire \axi_rdata[7]_i_2_n_0 ;
  wire \axi_rdata_reg[0] ;
  wire \axi_rdata_reg[3] ;
  wire \axi_rdata_reg[4] ;
  wire \axi_rdata_reg[5] ;
  wire \axi_rdata_reg[6] ;
  wire \axi_rdata_reg[7] ;
  wire [5:0]\axi_rdata_reg[7]_0 ;
  wire [5:0]\axi_rdata_reg[7]_1 ;
  wire [7:0]data3;
  wire [0:0]\q_reg[7]_0 ;
  wire [7:0]\q_reg[7]_1 ;
  wire s00_axi_aclk;
  wire [2:0]sel0;

  LUT5 #(
    .INIT(32'hB833B800)) 
    \axi_rdata[0]_i_2 
       (.I0(data3[0]),
        .I1(sel0[1]),
        .I2(\axi_rdata_reg[7]_0 [0]),
        .I3(sel0[0]),
        .I4(\axi_rdata_reg[7]_1 [0]),
        .O(\axi_rdata[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[3]_i_2 
       (.I0(data3[3]),
        .I1(D),
        .I2(sel0[1]),
        .I3(\axi_rdata_reg[7]_0 [1]),
        .I4(sel0[0]),
        .I5(\axi_rdata_reg[7]_1 [1]),
        .O(\axi_rdata[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[4]_i_2 
       (.I0(data3[4]),
        .I1(E),
        .I2(sel0[1]),
        .I3(\axi_rdata_reg[7]_0 [2]),
        .I4(sel0[0]),
        .I5(\axi_rdata_reg[7]_1 [2]),
        .O(\axi_rdata[4]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB833B800)) 
    \axi_rdata[5]_i_2 
       (.I0(data3[5]),
        .I1(sel0[1]),
        .I2(\axi_rdata_reg[7]_0 [3]),
        .I3(sel0[0]),
        .I4(\axi_rdata_reg[7]_1 [3]),
        .O(\axi_rdata[5]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB833B800)) 
    \axi_rdata[6]_i_2 
       (.I0(data3[6]),
        .I1(sel0[1]),
        .I2(\axi_rdata_reg[7]_0 [4]),
        .I3(sel0[0]),
        .I4(\axi_rdata_reg[7]_1 [4]),
        .O(\axi_rdata[6]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB833B800)) 
    \axi_rdata[7]_i_2 
       (.I0(data3[7]),
        .I1(sel0[1]),
        .I2(\axi_rdata_reg[7]_0 [5]),
        .I3(sel0[0]),
        .I4(\axi_rdata_reg[7]_1 [5]),
        .O(\axi_rdata[7]_i_2_n_0 ));
  MUXF7 \axi_rdata_reg[0]_i_1 
       (.I0(\axi_rdata[0]_i_2_n_0 ),
        .I1(\axi_rdata_reg[0] ),
        .O(\axi_araddr_reg[4] [0]),
        .S(sel0[2]));
  MUXF7 \axi_rdata_reg[3]_i_1 
       (.I0(\axi_rdata[3]_i_2_n_0 ),
        .I1(\axi_rdata_reg[3] ),
        .O(\axi_araddr_reg[4] [1]),
        .S(sel0[2]));
  MUXF7 \axi_rdata_reg[4]_i_1 
       (.I0(\axi_rdata[4]_i_2_n_0 ),
        .I1(\axi_rdata_reg[4] ),
        .O(\axi_araddr_reg[4] [2]),
        .S(sel0[2]));
  MUXF7 \axi_rdata_reg[5]_i_1 
       (.I0(\axi_rdata[5]_i_2_n_0 ),
        .I1(\axi_rdata_reg[5] ),
        .O(\axi_araddr_reg[4] [3]),
        .S(sel0[2]));
  MUXF7 \axi_rdata_reg[6]_i_1 
       (.I0(\axi_rdata[6]_i_2_n_0 ),
        .I1(\axi_rdata_reg[6] ),
        .O(\axi_araddr_reg[4] [4]),
        .S(sel0[2]));
  MUXF7 \axi_rdata_reg[7]_i_1 
       (.I0(\axi_rdata[7]_i_2_n_0 ),
        .I1(\axi_rdata_reg[7] ),
        .O(\axi_araddr_reg[4] [5]),
        .S(sel0[2]));
  FDCE \q_reg[0] 
       (.C(s00_axi_aclk),
        .CE(\q_reg[7]_0 ),
        .CLR(SS),
        .D(\q_reg[7]_1 [0]),
        .Q(data3[0]));
  FDCE \q_reg[1] 
       (.C(s00_axi_aclk),
        .CE(\q_reg[7]_0 ),
        .CLR(SS),
        .D(\q_reg[7]_1 [1]),
        .Q(Q[0]));
  FDCE \q_reg[2] 
       (.C(s00_axi_aclk),
        .CE(\q_reg[7]_0 ),
        .CLR(SS),
        .D(\q_reg[7]_1 [2]),
        .Q(Q[1]));
  FDCE \q_reg[3] 
       (.C(s00_axi_aclk),
        .CE(\q_reg[7]_0 ),
        .CLR(SS),
        .D(\q_reg[7]_1 [3]),
        .Q(data3[3]));
  FDCE \q_reg[4] 
       (.C(s00_axi_aclk),
        .CE(\q_reg[7]_0 ),
        .CLR(SS),
        .D(\q_reg[7]_1 [4]),
        .Q(data3[4]));
  FDCE \q_reg[5] 
       (.C(s00_axi_aclk),
        .CE(\q_reg[7]_0 ),
        .CLR(SS),
        .D(\q_reg[7]_1 [5]),
        .Q(data3[5]));
  FDCE \q_reg[6] 
       (.C(s00_axi_aclk),
        .CE(\q_reg[7]_0 ),
        .CLR(SS),
        .D(\q_reg[7]_1 [6]),
        .Q(data3[6]));
  FDCE \q_reg[7] 
       (.C(s00_axi_aclk),
        .CE(\q_reg[7]_0 ),
        .CLR(SS),
        .D(\q_reg[7]_1 [7]),
        .Q(data3[7]));
endmodule

(* CHECK_LICENSE_TYPE = "design_1_UART_0_0,UART_v1_0,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "UART_v1_0,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (tx,
    rx,
    interrupt,
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
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 interrupt INTERRUPT" *) (* x_interface_parameter = "XIL_INTERFACENAME interrupt, SENSITIVITY LEVEL_HIGH, PortWidth 1" *) output interrupt;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI AWADDR" *) (* x_interface_parameter = "XIL_INTERFACENAME S00_AXI, WIZ_DATA_WIDTH 32, WIZ_NUM_REG 8, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 50000000, ID_WIDTH 0, ADDR_WIDTH 5, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [4:0]s00_axi_awaddr;
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
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI ARADDR" *) input [4:0]s00_axi_araddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI ARPROT" *) input [2:0]s00_axi_arprot;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI ARVALID" *) input s00_axi_arvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI ARREADY" *) output s00_axi_arready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI RDATA" *) output [31:0]s00_axi_rdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI RRESP" *) output [1:0]s00_axi_rresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI RVALID" *) output s00_axi_rvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S00_AXI RREADY" *) input s00_axi_rready;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 S00_AXI_CLK CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME S00_AXI_CLK, ASSOCIATED_BUSIF S00_AXI, ASSOCIATED_RESET s00_axi_aresetn, FREQ_HZ 50000000, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input s00_axi_aclk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 S00_AXI_RST RST" *) (* x_interface_parameter = "XIL_INTERFACENAME S00_AXI_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input s00_axi_aresetn;

  wire \<const0> ;
  wire interrupt;
  wire rx;
  wire s00_axi_aclk;
  wire [4:0]s00_axi_araddr;
  wire s00_axi_aresetn;
  wire s00_axi_arready;
  wire s00_axi_arvalid;
  wire [4:0]s00_axi_awaddr;
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
  wire tx;

  assign s00_axi_bresp[1] = \<const0> ;
  assign s00_axi_bresp[0] = \<const0> ;
  assign s00_axi_rresp[1] = \<const0> ;
  assign s00_axi_rresp[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_UART_v1_0 U0
       (.S_AXI_ARREADY(s00_axi_arready),
        .S_AXI_AWREADY(s00_axi_awready),
        .S_AXI_WREADY(s00_axi_wready),
        .interrupt(interrupt),
        .rx(rx),
        .s00_axi_aclk(s00_axi_aclk),
        .s00_axi_araddr(s00_axi_araddr[4:2]),
        .s00_axi_aresetn(s00_axi_aresetn),
        .s00_axi_arvalid(s00_axi_arvalid),
        .s00_axi_awaddr(s00_axi_awaddr[4:2]),
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
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_edge_detector
   (r0_input,
    r1_input,
    r0_input_reg_0,
    Q,
    tx_clock,
    SS,
    \FSM_onehot_current_state_reg[1] ,
    s00_axi_aresetn);
  output r0_input;
  output r1_input;
  output r0_input_reg_0;
  input [0:0]Q;
  input tx_clock;
  input [0:0]SS;
  input \FSM_onehot_current_state_reg[1] ;
  input s00_axi_aresetn;

  wire \FSM_onehot_current_state_reg[1] ;
  wire [0:0]Q;
  wire [0:0]SS;
  wire r0_input;
  wire r0_input_reg_0;
  wire r1_input;
  wire s00_axi_aresetn;
  wire tx_clock;

  LUT4 #(
    .INIT(16'h2000)) 
    \FSM_onehot_current_state[1]_i_1 
       (.I0(r0_input),
        .I1(r1_input),
        .I2(\FSM_onehot_current_state_reg[1] ),
        .I3(s00_axi_aresetn),
        .O(r0_input_reg_0));
  FDCE r0_input_reg
       (.C(tx_clock),
        .CE(1'b1),
        .CLR(SS),
        .D(Q),
        .Q(r0_input));
  FDCE r1_input_reg
       (.C(tx_clock),
        .CE(1'b1),
        .CLR(SS),
        .D(r0_input),
        .Q(r1_input));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_rx_cu
   (D,
    \axi_araddr_reg[3] ,
    \tmp_sig_reg[7] ,
    \FSM_onehot_current_state_reg[4]_0 ,
    SS,
    CLK,
    rx,
    \axi_rdata_reg[2] ,
    sel0,
    Q,
    \axi_rdata_reg[2]_0 ,
    \axi_rdata_reg[1] ,
    \axi_rdata_reg[1]_0 ,
    \axi_rdata_reg[1]_1 ,
    s00_axi_aresetn);
  output [0:0]D;
  output [1:0]\axi_araddr_reg[3] ;
  output [7:0]\tmp_sig_reg[7] ;
  output [0:0]\FSM_onehot_current_state_reg[4]_0 ;
  output [0:0]SS;
  input CLK;
  input rx;
  input \axi_rdata_reg[2] ;
  input [2:0]sel0;
  input [1:0]Q;
  input \axi_rdata_reg[2]_0 ;
  input \axi_rdata_reg[1] ;
  input [0:0]\axi_rdata_reg[1]_0 ;
  input [0:0]\axi_rdata_reg[1]_1 ;
  input s00_axi_aresetn;

  wire CLK;
  wire [0:0]D;
  wire \FSM_onehot_current_state[0]_i_1__0_n_0 ;
  wire [0:0]\FSM_onehot_current_state_reg[4]_0 ;
  wire \FSM_onehot_current_state_reg_n_0_[5] ;
  wire [1:0]Q;
  wire [0:0]SS;
  wire [1:0]\axi_araddr_reg[3] ;
  wire \axi_rdata[2]_i_5_n_0 ;
  wire \axi_rdata_reg[1] ;
  wire [0:0]\axi_rdata_reg[1]_0 ;
  wire [0:0]\axi_rdata_reg[1]_1 ;
  wire \axi_rdata_reg[2] ;
  wire \axi_rdata_reg[2]_0 ;
  wire bit_counter_n_2;
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
  wire [2:0]sel0;
  wire shift_en;
  wire [7:0]\tmp_sig_reg[7] ;

  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hEA)) 
    \FSM_onehot_current_state[0]_i_1__0 
       (.I0(\FSM_onehot_current_state_reg_n_0_[5] ),
        .I1(rx),
        .I2(reset_8count),
        .O(\FSM_onehot_current_state[0]_i_1__0_n_0 ));
  (* FSM_ENCODED_STATES = "rda_state:100000,idle:000001,eight_delay:000010,get_bit:001000,wait_for_centre:000100,check_stop:010000" *) 
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_current_state_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\FSM_onehot_current_state[0]_i_1__0_n_0 ),
        .Q(reset_8count),
        .S(SS));
  (* FSM_ENCODED_STATES = "rda_state:100000,idle:000001,eight_delay:000010,get_bit:001000,wait_for_centre:000100,check_stop:010000" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_current_state_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(counter_mod8_n_1),
        .Q(counter_8incr),
        .R(SS));
  (* FSM_ENCODED_STATES = "rda_state:100000,idle:000001,eight_delay:000010,get_bit:001000,wait_for_centre:000100,check_stop:010000" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_current_state_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(counter_mod16_n_1),
        .Q(counter_16incr),
        .R(SS));
  (* FSM_ENCODED_STATES = "rda_state:100000,idle:000001,eight_delay:000010,get_bit:001000,wait_for_centre:000100,check_stop:010000" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_current_state_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(counter_mod16_n_0),
        .Q(counter_bit_incr),
        .R(SS));
  (* FSM_ENCODED_STATES = "rda_state:100000,idle:000001,eight_delay:000010,get_bit:001000,wait_for_centre:000100,check_stop:010000" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_current_state_reg[4] 
       (.C(CLK),
        .CE(1'b1),
        .D(bit_counter_n_2),
        .Q(\FSM_onehot_current_state_reg[4]_0 ),
        .R(SS));
  (* FSM_ENCODED_STATES = "rda_state:100000,idle:000001,eight_delay:000010,get_bit:001000,wait_for_centre:000100,check_stop:010000" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_current_state_reg[5] 
       (.C(CLK),
        .CE(1'b1),
        .D(\FSM_onehot_current_state_reg[4]_0 ),
        .Q(\FSM_onehot_current_state_reg_n_0_[5] ),
        .R(SS));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_shift_register_SIPO RX_shift_register_SIPO
       (.CLK(CLK),
        .E(shift_en),
        .Q(Q),
        .SR(SS),
        .\axi_araddr_reg[3] (\axi_araddr_reg[3] ),
        .\axi_rdata[1]_i_2_0 ({\FSM_onehot_current_state_reg_n_0_[5] ,\FSM_onehot_current_state_reg[4]_0 }),
        .\axi_rdata_reg[1] (\axi_rdata_reg[1] ),
        .\axi_rdata_reg[1]_0 (\axi_rdata_reg[1]_0 ),
        .\axi_rdata_reg[1]_1 (\axi_rdata_reg[1]_1 ),
        .\axi_rdata_reg[2] (\axi_rdata_reg[2] ),
        .\axi_rdata_reg[2]_0 (\axi_rdata_reg[2]_0 ),
        .\axi_rdata_reg[2]_1 (\axi_rdata[2]_i_5_n_0 ),
        .rx(rx),
        .s00_axi_aresetn(s00_axi_aresetn),
        .sel0(sel0),
        .\tmp_sig_reg[7]_0 (\tmp_sig_reg[7] ));
  LUT2 #(
    .INIT(4'h1)) 
    \axi_rdata[2]_i_5 
       (.I0(\FSM_onehot_current_state_reg_n_0_[5] ),
        .I1(\FSM_onehot_current_state_reg[4]_0 ),
        .O(\axi_rdata[2]_i_5_n_0 ));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_counter_modN__parameterized5 bit_counter
       (.CLK(CLK),
        .D(bit_counter_n_2),
        .E(shift_en),
        .Q({counter_bit_incr,reset_8count}),
        .done_bit_count(done_bit_count));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_counter_modN__parameterized3 counter_mod16
       (.CLK(CLK),
        .D({counter_mod16_n_0,counter_mod16_n_1}),
        .Q({counter_bit_incr,counter_16incr,counter_8incr,reset_8count}),
        .counter_hit(counter_hit),
        .done_bit_count(done_bit_count));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_counter_modN__parameterized1 counter_mod8
       (.CLK(CLK),
        .D(counter_mod8_n_1),
        .Q({counter_8incr,reset_8count}),
        .counter_hit(counter_hit),
        .rx(rx));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \last_stage[0]_i_1 
       (.I0(reset_8count),
        .I1(\FSM_onehot_current_state_reg_n_0_[5] ),
        .O(D));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_shift_register
   (E,
    tx,
    shift_en,
    p_load,
    \tmp_sig_reg[8]_0 ,
    SS,
    tx_clock);
  output [0:0]E;
  output tx;
  input shift_en;
  input p_load;
  input [7:0]\tmp_sig_reg[8]_0 ;
  input [0:0]SS;
  input tx_clock;

  wire [0:0]E;
  wire [0:0]SS;
  wire p_load;
  wire shift_en;
  wire \tmp_sig[0]_i_3_n_0 ;
  wire \tmp_sig[1]_i_1_n_0 ;
  wire \tmp_sig[2]_i_1_n_0 ;
  wire \tmp_sig[3]_i_1_n_0 ;
  wire \tmp_sig[4]_i_1_n_0 ;
  wire \tmp_sig[5]_i_1_n_0 ;
  wire \tmp_sig[6]_i_1_n_0 ;
  wire \tmp_sig[7]_i_1_n_0 ;
  wire \tmp_sig[8]_i_1_n_0 ;
  wire \tmp_sig[9]_i_1__0_n_0 ;
  wire \tmp_sig[9]_i_2_n_0 ;
  wire [7:0]\tmp_sig_reg[8]_0 ;
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
  wire tx_clock;

  LUT2 #(
    .INIT(4'hE)) 
    \tmp_sig[0]_i_2 
       (.I0(shift_en),
        .I1(p_load),
        .O(E));
  LUT2 #(
    .INIT(4'h2)) 
    \tmp_sig[0]_i_3 
       (.I0(\tmp_sig_reg_n_0_[1] ),
        .I1(p_load),
        .O(\tmp_sig[0]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \tmp_sig[1]_i_1 
       (.I0(\tmp_sig_reg[8]_0 [0]),
        .I1(p_load),
        .I2(\tmp_sig_reg_n_0_[2] ),
        .O(\tmp_sig[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \tmp_sig[2]_i_1 
       (.I0(\tmp_sig_reg[8]_0 [1]),
        .I1(p_load),
        .I2(\tmp_sig_reg_n_0_[3] ),
        .O(\tmp_sig[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \tmp_sig[3]_i_1 
       (.I0(\tmp_sig_reg[8]_0 [2]),
        .I1(p_load),
        .I2(\tmp_sig_reg_n_0_[4] ),
        .O(\tmp_sig[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \tmp_sig[4]_i_1 
       (.I0(\tmp_sig_reg[8]_0 [3]),
        .I1(p_load),
        .I2(\tmp_sig_reg_n_0_[5] ),
        .O(\tmp_sig[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \tmp_sig[5]_i_1 
       (.I0(\tmp_sig_reg[8]_0 [4]),
        .I1(p_load),
        .I2(\tmp_sig_reg_n_0_[6] ),
        .O(\tmp_sig[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \tmp_sig[6]_i_1 
       (.I0(\tmp_sig_reg[8]_0 [5]),
        .I1(p_load),
        .I2(\tmp_sig_reg_n_0_[7] ),
        .O(\tmp_sig[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \tmp_sig[7]_i_1 
       (.I0(\tmp_sig_reg[8]_0 [6]),
        .I1(p_load),
        .I2(\tmp_sig_reg_n_0_[8] ),
        .O(\tmp_sig[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \tmp_sig[8]_i_1 
       (.I0(\tmp_sig_reg[8]_0 [7]),
        .I1(p_load),
        .I2(\tmp_sig_reg_n_0_[9] ),
        .O(\tmp_sig[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h7DD7D77DD77D7DD7)) 
    \tmp_sig[9]_i_1__0 
       (.I0(p_load),
        .I1(\tmp_sig[9]_i_2_n_0 ),
        .I2(\tmp_sig_reg[8]_0 [1]),
        .I3(\tmp_sig_reg[8]_0 [2]),
        .I4(\tmp_sig_reg[8]_0 [4]),
        .I5(\tmp_sig_reg[8]_0 [0]),
        .O(\tmp_sig[9]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \tmp_sig[9]_i_2 
       (.I0(\tmp_sig_reg[8]_0 [7]),
        .I1(\tmp_sig_reg[8]_0 [5]),
        .I2(\tmp_sig_reg[8]_0 [6]),
        .I3(\tmp_sig_reg[8]_0 [3]),
        .O(\tmp_sig[9]_i_2_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \tmp_sig_reg[0] 
       (.C(tx_clock),
        .CE(E),
        .D(\tmp_sig[0]_i_3_n_0 ),
        .Q(tx),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \tmp_sig_reg[1] 
       (.C(tx_clock),
        .CE(E),
        .D(\tmp_sig[1]_i_1_n_0 ),
        .Q(\tmp_sig_reg_n_0_[1] ),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \tmp_sig_reg[2] 
       (.C(tx_clock),
        .CE(E),
        .D(\tmp_sig[2]_i_1_n_0 ),
        .Q(\tmp_sig_reg_n_0_[2] ),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \tmp_sig_reg[3] 
       (.C(tx_clock),
        .CE(E),
        .D(\tmp_sig[3]_i_1_n_0 ),
        .Q(\tmp_sig_reg_n_0_[3] ),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \tmp_sig_reg[4] 
       (.C(tx_clock),
        .CE(E),
        .D(\tmp_sig[4]_i_1_n_0 ),
        .Q(\tmp_sig_reg_n_0_[4] ),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \tmp_sig_reg[5] 
       (.C(tx_clock),
        .CE(E),
        .D(\tmp_sig[5]_i_1_n_0 ),
        .Q(\tmp_sig_reg_n_0_[5] ),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \tmp_sig_reg[6] 
       (.C(tx_clock),
        .CE(E),
        .D(\tmp_sig[6]_i_1_n_0 ),
        .Q(\tmp_sig_reg_n_0_[6] ),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \tmp_sig_reg[7] 
       (.C(tx_clock),
        .CE(E),
        .D(\tmp_sig[7]_i_1_n_0 ),
        .Q(\tmp_sig_reg_n_0_[7] ),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \tmp_sig_reg[8] 
       (.C(tx_clock),
        .CE(E),
        .D(\tmp_sig[8]_i_1_n_0 ),
        .Q(\tmp_sig_reg_n_0_[8] ),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \tmp_sig_reg[9] 
       (.C(tx_clock),
        .CE(E),
        .D(\tmp_sig[9]_i_1__0_n_0 ),
        .Q(\tmp_sig_reg_n_0_[9] ),
        .S(SS));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_shift_register_SIPO
   (\axi_araddr_reg[3] ,
    \tmp_sig_reg[7]_0 ,
    SR,
    \axi_rdata_reg[2] ,
    sel0,
    Q,
    \axi_rdata_reg[2]_0 ,
    \axi_rdata_reg[2]_1 ,
    \axi_rdata_reg[1] ,
    \axi_rdata_reg[1]_0 ,
    \axi_rdata_reg[1]_1 ,
    \axi_rdata[1]_i_2_0 ,
    s00_axi_aresetn,
    E,
    rx,
    CLK);
  output [1:0]\axi_araddr_reg[3] ;
  output [7:0]\tmp_sig_reg[7]_0 ;
  output [0:0]SR;
  input \axi_rdata_reg[2] ;
  input [2:0]sel0;
  input [1:0]Q;
  input \axi_rdata_reg[2]_0 ;
  input \axi_rdata_reg[2]_1 ;
  input \axi_rdata_reg[1] ;
  input [0:0]\axi_rdata_reg[1]_0 ;
  input [0:0]\axi_rdata_reg[1]_1 ;
  input [1:0]\axi_rdata[1]_i_2_0 ;
  input s00_axi_aresetn;
  input [0:0]E;
  input rx;
  input CLK;

  wire CLK;
  wire [0:0]E;
  wire [1:0]Q;
  wire [0:0]SR;
  wire [1:0]\axi_araddr_reg[3] ;
  wire [1:0]\axi_rdata[1]_i_2_0 ;
  wire \axi_rdata[1]_i_2_n_0 ;
  wire \axi_rdata[1]_i_4_n_0 ;
  wire \axi_rdata[2]_i_3_n_0 ;
  wire \axi_rdata[2]_i_6_n_0 ;
  wire \axi_rdata_reg[1] ;
  wire [0:0]\axi_rdata_reg[1]_0 ;
  wire [0:0]\axi_rdata_reg[1]_1 ;
  wire \axi_rdata_reg[2] ;
  wire \axi_rdata_reg[2]_0 ;
  wire \axi_rdata_reg[2]_1 ;
  wire rx;
  wire [8:8]rx_frame;
  wire s00_axi_aresetn;
  wire [2:0]sel0;
  wire [7:0]\tmp_sig_reg[7]_0 ;
  wire \tmp_sig_reg_n_0_[9] ;

  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \axi_rdata[1]_i_2 
       (.I0(\axi_rdata[1]_i_4_n_0 ),
        .I1(sel0[1]),
        .I2(\axi_rdata_reg[1]_0 ),
        .I3(sel0[0]),
        .I4(\axi_rdata_reg[1]_1 ),
        .O(\axi_rdata[1]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h8B8B8B88)) 
    \axi_rdata[1]_i_4 
       (.I0(Q[0]),
        .I1(sel0[0]),
        .I2(\tmp_sig_reg_n_0_[9] ),
        .I3(\axi_rdata[1]_i_2_0 [0]),
        .I4(\axi_rdata[1]_i_2_0 [1]),
        .O(\axi_rdata[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF55450545)) 
    \axi_rdata[2]_i_1 
       (.I0(\axi_rdata_reg[2] ),
        .I1(\axi_rdata[2]_i_3_n_0 ),
        .I2(sel0[1]),
        .I3(sel0[0]),
        .I4(Q[1]),
        .I5(\axi_rdata_reg[2]_0 ),
        .O(\axi_araddr_reg[3] [1]));
  LUT6 #(
    .INIT(64'h1441411441141441)) 
    \axi_rdata[2]_i_3 
       (.I0(\axi_rdata_reg[2]_1 ),
        .I1(\axi_rdata[2]_i_6_n_0 ),
        .I2(\tmp_sig_reg[7]_0 [0]),
        .I3(rx_frame),
        .I4(\tmp_sig_reg[7]_0 [3]),
        .I5(\tmp_sig_reg[7]_0 [1]),
        .O(\axi_rdata[2]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h96696996)) 
    \axi_rdata[2]_i_6 
       (.I0(\tmp_sig_reg[7]_0 [5]),
        .I1(\tmp_sig_reg[7]_0 [6]),
        .I2(\tmp_sig_reg[7]_0 [4]),
        .I3(\tmp_sig_reg[7]_0 [2]),
        .I4(\tmp_sig_reg[7]_0 [7]),
        .O(\axi_rdata[2]_i_6_n_0 ));
  MUXF7 \axi_rdata_reg[1]_i_1 
       (.I0(\axi_rdata[1]_i_2_n_0 ),
        .I1(\axi_rdata_reg[1] ),
        .O(\axi_araddr_reg[3] [0]),
        .S(sel0[2]));
  LUT1 #(
    .INIT(2'h1)) 
    \tmp_sig[0]_i_1 
       (.I0(s00_axi_aresetn),
        .O(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tmp_sig_reg[0] 
       (.C(CLK),
        .CE(E),
        .D(\tmp_sig_reg[7]_0 [1]),
        .Q(\tmp_sig_reg[7]_0 [0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tmp_sig_reg[1] 
       (.C(CLK),
        .CE(E),
        .D(\tmp_sig_reg[7]_0 [2]),
        .Q(\tmp_sig_reg[7]_0 [1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tmp_sig_reg[2] 
       (.C(CLK),
        .CE(E),
        .D(\tmp_sig_reg[7]_0 [3]),
        .Q(\tmp_sig_reg[7]_0 [2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tmp_sig_reg[3] 
       (.C(CLK),
        .CE(E),
        .D(\tmp_sig_reg[7]_0 [4]),
        .Q(\tmp_sig_reg[7]_0 [3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tmp_sig_reg[4] 
       (.C(CLK),
        .CE(E),
        .D(\tmp_sig_reg[7]_0 [5]),
        .Q(\tmp_sig_reg[7]_0 [4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tmp_sig_reg[5] 
       (.C(CLK),
        .CE(E),
        .D(\tmp_sig_reg[7]_0 [6]),
        .Q(\tmp_sig_reg[7]_0 [5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tmp_sig_reg[6] 
       (.C(CLK),
        .CE(E),
        .D(\tmp_sig_reg[7]_0 [7]),
        .Q(\tmp_sig_reg[7]_0 [6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tmp_sig_reg[7] 
       (.C(CLK),
        .CE(E),
        .D(rx_frame),
        .Q(\tmp_sig_reg[7]_0 [7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tmp_sig_reg[8] 
       (.C(CLK),
        .CE(E),
        .D(\tmp_sig_reg_n_0_[9] ),
        .Q(rx_frame),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tmp_sig_reg[9] 
       (.C(CLK),
        .CE(E),
        .D(rx),
        .Q(\tmp_sig_reg_n_0_[9] ),
        .R(SR));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tx_cu
   (\FSM_onehot_current_state_reg[0]_0 ,
    E,
    tx,
    tx_clock,
    SS,
    \FSM_onehot_current_state_reg[1]_0 ,
    r0_input,
    r1_input,
    \tmp_sig_reg[8] ,
    s00_axi_aresetn);
  output \FSM_onehot_current_state_reg[0]_0 ;
  output [0:0]E;
  output tx;
  input tx_clock;
  input [0:0]SS;
  input \FSM_onehot_current_state_reg[1]_0 ;
  input r0_input;
  input r1_input;
  input [7:0]\tmp_sig_reg[8] ;
  input s00_axi_aresetn;

  wire [0:0]E;
  wire \FSM_onehot_current_state_reg[0]_0 ;
  wire \FSM_onehot_current_state_reg[1]_0 ;
  wire [0:0]SS;
  wire TX_counter_n_0;
  wire TX_counter_n_1;
  wire p_load;
  wire r0_input;
  wire r1_input;
  wire s00_axi_aresetn;
  wire shift_en;
  wire [7:0]\tmp_sig_reg[8] ;
  wire tx;
  wire tx_clock;

  (* FSM_ENCODED_STATES = "start:010,transmit:100,idle:001" *) 
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_current_state_reg[0] 
       (.C(tx_clock),
        .CE(1'b1),
        .D(TX_counter_n_0),
        .Q(\FSM_onehot_current_state_reg[0]_0 ),
        .S(SS));
  (* FSM_ENCODED_STATES = "start:010,transmit:100,idle:001" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_current_state_reg[1] 
       (.C(tx_clock),
        .CE(1'b1),
        .D(\FSM_onehot_current_state_reg[1]_0 ),
        .Q(p_load),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "start:010,transmit:100,idle:001" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_current_state_reg[2] 
       (.C(tx_clock),
        .CE(1'b1),
        .D(TX_counter_n_1),
        .Q(shift_en),
        .R(1'b0));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_counter_modN TX_counter
       (.\FSM_onehot_current_state_reg[0] (\FSM_onehot_current_state_reg[0]_0 ),
        .\FSM_onehot_current_state_reg[2] (TX_counter_n_1),
        .counter_hit_reg_0(TX_counter_n_0),
        .p_load(p_load),
        .r0_input(r0_input),
        .r1_input(r1_input),
        .s00_axi_aresetn(s00_axi_aresetn),
        .shift_en(shift_en),
        .tx_clock(tx_clock));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_shift_register TX_shift_register
       (.E(E),
        .SS(SS),
        .p_load(p_load),
        .shift_en(shift_en),
        .\tmp_sig_reg[8]_0 (\tmp_sig_reg[8] ),
        .tx(tx),
        .tx_clock(tx_clock));
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
