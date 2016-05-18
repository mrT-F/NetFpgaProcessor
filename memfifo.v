////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 10.1.03
//  \   \         Application : sch2verilog
//  /   /         Filename : memfifo.vf
// /___/   /\     Timestamp : 03/06/2016 14:24:11
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: C:\Xilinx\10.1\ISE\bin\nt\unwrapped\sch2verilog.exe -intstyle ise -family virtex2p -w E:/Lab9/alu64/memfifo.sch memfifo.vf
//Design Name: memfifo
//Device: virtex2p
//Purpose:
//    This verilog netlist is translated from an ECS schematic.It can be 
//    synthesized and simulated, but it should not be modified. 
//
`timescale 1ns / 1ps

module M2_1_MXILINX_memfifo(D0, 
                            D1, 
                            S0, 
                            O);

    input D0;
    input D1;
    input S0;
   output O;
   
   wire M0;
   wire M1;
   
   AND2B1 I_36_7 (.I0(S0), 
                  .I1(D0), 
                  .O(M0));
   OR2 I_36_8 (.I0(M1), 
               .I1(M0), 
               .O(O));
   AND2 I_36_9 (.I0(D1), 
                .I1(S0), 
                .O(M1));
endmodule
`timescale 1ns / 1ps

module FTCLEX_MXILINX_memfifo(C, 
                              CE, 
                              CLR, 
                              D, 
                              L, 
                              T, 
                              Q);

    input C;
    input CE;
    input CLR;
    input D;
    input L;
    input T;
   output Q;
   
   wire MD;
   wire TQ;
   wire Q_DUMMY;
   
   assign Q = Q_DUMMY;
   M2_1_MXILINX_memfifo I_36_30 (.D0(TQ), 
                                 .D1(D), 
                                 .S0(L), 
                                 .O(MD));
   // synthesis attribute HU_SET of I_36_30 is "I_36_30_0"
   XOR2 I_36_32 (.I0(T), 
                 .I1(Q_DUMMY), 
                 .O(TQ));
   FDCE I_36_35 (.C(C), 
                 .CE(CE), 
                 .CLR(CLR), 
                 .D(MD), 
                 .Q(Q_DUMMY));
   // synthesis attribute RLOC of I_36_35 is "X0Y0"
   defparam I_36_35.INIT = 1'b0;
endmodule
`timescale 1ns / 1ps

module CB8CLE_MXILINX_memfifo(C, 
                              CE, 
                              CLR, 
                              D, 
                              L, 
                              CEO, 
                              Q, 
                              TC);

    input C;
    input CE;
    input CLR;
    input [7:0] D;
    input L;
   output CEO;
   output [7:0] Q;
   output TC;
   
   wire OR_CE_L;
   wire T2;
   wire T3;
   wire T4;
   wire T5;
   wire T6;
   wire T7;
   wire XLXN_1;
   wire [7:0] Q_DUMMY;
   wire TC_DUMMY;
   
   assign Q[7:0] = Q_DUMMY[7:0];
   assign TC = TC_DUMMY;
   FTCLEX_MXILINX_memfifo I_Q0 (.C(C), 
                                .CE(OR_CE_L), 
                                .CLR(CLR), 
                                .D(D[0]), 
                                .L(L), 
                                .T(XLXN_1), 
                                .Q(Q_DUMMY[0]));
   // synthesis attribute HU_SET of I_Q0 is "I_Q0_1"
   FTCLEX_MXILINX_memfifo I_Q1 (.C(C), 
                                .CE(OR_CE_L), 
                                .CLR(CLR), 
                                .D(D[1]), 
                                .L(L), 
                                .T(Q_DUMMY[0]), 
                                .Q(Q_DUMMY[1]));
   // synthesis attribute HU_SET of I_Q1 is "I_Q1_2"
   FTCLEX_MXILINX_memfifo I_Q2 (.C(C), 
                                .CE(OR_CE_L), 
                                .CLR(CLR), 
                                .D(D[2]), 
                                .L(L), 
                                .T(T2), 
                                .Q(Q_DUMMY[2]));
   // synthesis attribute HU_SET of I_Q2 is "I_Q2_3"
   FTCLEX_MXILINX_memfifo I_Q3 (.C(C), 
                                .CE(OR_CE_L), 
                                .CLR(CLR), 
                                .D(D[3]), 
                                .L(L), 
                                .T(T3), 
                                .Q(Q_DUMMY[3]));
   // synthesis attribute HU_SET of I_Q3 is "I_Q3_4"
   FTCLEX_MXILINX_memfifo I_Q4 (.C(C), 
                                .CE(OR_CE_L), 
                                .CLR(CLR), 
                                .D(D[4]), 
                                .L(L), 
                                .T(T4), 
                                .Q(Q_DUMMY[4]));
   // synthesis attribute HU_SET of I_Q4 is "I_Q4_5"
   FTCLEX_MXILINX_memfifo I_Q5 (.C(C), 
                                .CE(OR_CE_L), 
                                .CLR(CLR), 
                                .D(D[5]), 
                                .L(L), 
                                .T(T5), 
                                .Q(Q_DUMMY[5]));
   // synthesis attribute HU_SET of I_Q5 is "I_Q5_6"
   FTCLEX_MXILINX_memfifo I_Q6 (.C(C), 
                                .CE(OR_CE_L), 
                                .CLR(CLR), 
                                .D(D[6]), 
                                .L(L), 
                                .T(T6), 
                                .Q(Q_DUMMY[6]));
   // synthesis attribute HU_SET of I_Q6 is "I_Q6_7"
   FTCLEX_MXILINX_memfifo I_Q7 (.C(C), 
                                .CE(OR_CE_L), 
                                .CLR(CLR), 
                                .D(D[7]), 
                                .L(L), 
                                .T(T7), 
                                .Q(Q_DUMMY[7]));
   // synthesis attribute HU_SET of I_Q7 is "I_Q7_8"
   AND3 I_36_8 (.I0(Q_DUMMY[5]), 
                .I1(Q_DUMMY[4]), 
                .I2(T4), 
                .O(T6));
   AND2 I_36_11 (.I0(Q_DUMMY[4]), 
                 .I1(T4), 
                 .O(T5));
   VCC I_36_12 (.P(XLXN_1));
   AND2 I_36_19 (.I0(Q_DUMMY[1]), 
                 .I1(Q_DUMMY[0]), 
                 .O(T2));
   AND3 I_36_21 (.I0(Q_DUMMY[2]), 
                 .I1(Q_DUMMY[1]), 
                 .I2(Q_DUMMY[0]), 
                 .O(T3));
   AND4 I_36_23 (.I0(Q_DUMMY[3]), 
                 .I1(Q_DUMMY[2]), 
                 .I2(Q_DUMMY[1]), 
                 .I3(Q_DUMMY[0]), 
                 .O(T4));
   AND4 I_36_25 (.I0(Q_DUMMY[6]), 
                 .I1(Q_DUMMY[5]), 
                 .I2(Q_DUMMY[4]), 
                 .I3(T4), 
                 .O(T7));
   AND5 I_36_29 (.I0(Q_DUMMY[7]), 
                 .I1(Q_DUMMY[6]), 
                 .I2(Q_DUMMY[5]), 
                 .I3(Q_DUMMY[4]), 
                 .I4(T4), 
                 .O(TC_DUMMY));
   AND2 I_36_33 (.I0(CE), 
                 .I1(TC_DUMMY), 
                 .O(CEO));
   OR2 I_36_49 (.I0(CE), 
                .I1(L), 
                .O(OR_CE_L));
endmodule
`timescale 1ns / 1ps

module FTCE_MXILINX_memfifo(C, 
                            CE, 
                            CLR, 
                            T, 
                            Q);

    input C;
    input CE;
    input CLR;
    input T;
   output Q;
   
   wire TQ;
   wire Q_DUMMY;
   
   assign Q = Q_DUMMY;
   XOR2 I_36_32 (.I0(T), 
                 .I1(Q_DUMMY), 
                 .O(TQ));
   FDCE I_36_35 (.C(C), 
                 .CE(CE), 
                 .CLR(CLR), 
                 .D(TQ), 
                 .Q(Q_DUMMY));
   // synthesis attribute RLOC of I_36_35 is "X0Y0"
   defparam I_36_35.INIT = 1'b0;
endmodule
`timescale 1ns / 1ps

module CB8CE_MXILINX_memfifo(C, 
                             CE, 
                             CLR, 
                             CEO, 
                             Q, 
                             TC);

    input C;
    input CE;
    input CLR;
   output CEO;
   output [7:0] Q;
   output TC;
   
   wire T2;
   wire T3;
   wire T4;
   wire T5;
   wire T6;
   wire T7;
   wire XLXN_1;
   wire [7:0] Q_DUMMY;
   wire TC_DUMMY;
   
   assign Q[7:0] = Q_DUMMY[7:0];
   assign TC = TC_DUMMY;
   FTCE_MXILINX_memfifo I_Q0 (.C(C), 
                              .CE(CE), 
                              .CLR(CLR), 
                              .T(XLXN_1), 
                              .Q(Q_DUMMY[0]));
   // synthesis attribute HU_SET of I_Q0 is "I_Q0_15"
   FTCE_MXILINX_memfifo I_Q1 (.C(C), 
                              .CE(CE), 
                              .CLR(CLR), 
                              .T(Q_DUMMY[0]), 
                              .Q(Q_DUMMY[1]));
   // synthesis attribute HU_SET of I_Q1 is "I_Q1_16"
   FTCE_MXILINX_memfifo I_Q2 (.C(C), 
                              .CE(CE), 
                              .CLR(CLR), 
                              .T(T2), 
                              .Q(Q_DUMMY[2]));
   // synthesis attribute HU_SET of I_Q2 is "I_Q2_12"
   FTCE_MXILINX_memfifo I_Q3 (.C(C), 
                              .CE(CE), 
                              .CLR(CLR), 
                              .T(T3), 
                              .Q(Q_DUMMY[3]));
   // synthesis attribute HU_SET of I_Q3 is "I_Q3_13"
   FTCE_MXILINX_memfifo I_Q4 (.C(C), 
                              .CE(CE), 
                              .CLR(CLR), 
                              .T(T4), 
                              .Q(Q_DUMMY[4]));
   // synthesis attribute HU_SET of I_Q4 is "I_Q4_14"
   FTCE_MXILINX_memfifo I_Q5 (.C(C), 
                              .CE(CE), 
                              .CLR(CLR), 
                              .T(T5), 
                              .Q(Q_DUMMY[5]));
   // synthesis attribute HU_SET of I_Q5 is "I_Q5_11"
   FTCE_MXILINX_memfifo I_Q6 (.C(C), 
                              .CE(CE), 
                              .CLR(CLR), 
                              .T(T6), 
                              .Q(Q_DUMMY[6]));
   // synthesis attribute HU_SET of I_Q6 is "I_Q6_10"
   FTCE_MXILINX_memfifo I_Q7 (.C(C), 
                              .CE(CE), 
                              .CLR(CLR), 
                              .T(T7), 
                              .Q(Q_DUMMY[7]));
   // synthesis attribute HU_SET of I_Q7 is "I_Q7_9"
   AND5 I_36_1 (.I0(Q_DUMMY[7]), 
                .I1(Q_DUMMY[6]), 
                .I2(Q_DUMMY[5]), 
                .I3(Q_DUMMY[4]), 
                .I4(T4), 
                .O(TC_DUMMY));
   AND2 I_36_2 (.I0(Q_DUMMY[4]), 
                .I1(T4), 
                .O(T5));
   AND3 I_36_11 (.I0(Q_DUMMY[5]), 
                 .I1(Q_DUMMY[4]), 
                 .I2(T4), 
                 .O(T6));
   AND4 I_36_15 (.I0(Q_DUMMY[3]), 
                 .I1(Q_DUMMY[2]), 
                 .I2(Q_DUMMY[1]), 
                 .I3(Q_DUMMY[0]), 
                 .O(T4));
   VCC I_36_16 (.P(XLXN_1));
   AND2 I_36_24 (.I0(Q_DUMMY[1]), 
                 .I1(Q_DUMMY[0]), 
                 .O(T2));
   AND3 I_36_26 (.I0(Q_DUMMY[2]), 
                 .I1(Q_DUMMY[1]), 
                 .I2(Q_DUMMY[0]), 
                 .O(T3));
   AND4 I_36_28 (.I0(Q_DUMMY[6]), 
                 .I1(Q_DUMMY[5]), 
                 .I2(Q_DUMMY[4]), 
                 .I3(T4), 
                 .O(T7));
   AND2 I_36_31 (.I0(CE), 
                 .I1(TC_DUMMY), 
                 .O(CEO));
endmodule
`timescale 1ns / 1ps

module COMP8_MXILINX_memfifo(A, 
                             B, 
                             EQ);

    input [7:0] A;
    input [7:0] B;
   output EQ;
   
   wire AB0;
   wire AB1;
   wire AB2;
   wire AB3;
   wire AB4;
   wire AB5;
   wire AB6;
   wire AB7;
   wire AB03;
   wire AB47;
   
   AND4 I_36_32 (.I0(AB7), 
                 .I1(AB6), 
                 .I2(AB5), 
                 .I3(AB4), 
                 .O(AB47));
   XNOR2 I_36_33 (.I0(B[6]), 
                  .I1(A[6]), 
                  .O(AB6));
   XNOR2 I_36_34 (.I0(B[7]), 
                  .I1(A[7]), 
                  .O(AB7));
   XNOR2 I_36_35 (.I0(B[5]), 
                  .I1(A[5]), 
                  .O(AB5));
   XNOR2 I_36_36 (.I0(B[4]), 
                  .I1(A[4]), 
                  .O(AB4));
   AND4 I_36_41 (.I0(AB3), 
                 .I1(AB2), 
                 .I2(AB1), 
                 .I3(AB0), 
                 .O(AB03));
   XNOR2 I_36_42 (.I0(B[2]), 
                  .I1(A[2]), 
                  .O(AB2));
   XNOR2 I_36_43 (.I0(B[3]), 
                  .I1(A[3]), 
                  .O(AB3));
   XNOR2 I_36_44 (.I0(B[1]), 
                  .I1(A[1]), 
                  .O(AB1));
   XNOR2 I_36_45 (.I0(B[0]), 
                  .I1(A[0]), 
                  .O(AB0));
   AND2 I_36_50 (.I0(AB47), 
                 .I1(AB03), 
                 .O(EQ));
endmodule
`timescale 1ns / 1ps

module FD8CE_MXILINX_memfifo(C, 
                             CE, 
                             CLR, 
                             D, 
                             Q);

    input C;
    input CE;
    input CLR;
    input [7:0] D;
   output [7:0] Q;
   
   
   FDCE I_Q0 (.C(C), 
              .CE(CE), 
              .CLR(CLR), 
              .D(D[0]), 
              .Q(Q[0]));
   defparam I_Q0.INIT = 1'b0;
   FDCE I_Q1 (.C(C), 
              .CE(CE), 
              .CLR(CLR), 
              .D(D[1]), 
              .Q(Q[1]));
   defparam I_Q1.INIT = 1'b0;
   FDCE I_Q2 (.C(C), 
              .CE(CE), 
              .CLR(CLR), 
              .D(D[2]), 
              .Q(Q[2]));
   defparam I_Q2.INIT = 1'b0;
   FDCE I_Q3 (.C(C), 
              .CE(CE), 
              .CLR(CLR), 
              .D(D[3]), 
              .Q(Q[3]));
   defparam I_Q3.INIT = 1'b0;
   FDCE I_Q4 (.C(C), 
              .CE(CE), 
              .CLR(CLR), 
              .D(D[4]), 
              .Q(Q[4]));
   defparam I_Q4.INIT = 1'b0;
   FDCE I_Q5 (.C(C), 
              .CE(CE), 
              .CLR(CLR), 
              .D(D[5]), 
              .Q(Q[5]));
   defparam I_Q5.INIT = 1'b0;
   FDCE I_Q6 (.C(C), 
              .CE(CE), 
              .CLR(CLR), 
              .D(D[6]), 
              .Q(Q[6]));
   defparam I_Q6.INIT = 1'b0;
   FDCE I_Q7 (.C(C), 
              .CE(CE), 
              .CLR(CLR), 
              .D(D[7]), 
              .Q(Q[7]));
   defparam I_Q7.INIT = 1'b0;
endmodule
`timescale 1ns / 1ps

module memfifo(clk, 
               fiforead, 
               fifowrite, 
               firstword, 
               in_fifo, 
               lastword, 
               processor_addr_in, 
               processor_control, 
               processor_data_in, 
               processor_wea, 
               rst, 
               fifo_empty, 
               out_fifo, 
               packet_head, 
               packet_tail, 
               valid_data);

    input clk;
    input fiforead;
    input fifowrite;
    input firstword;
    input [71:0] in_fifo;
    input lastword;
    input [7:0] processor_addr_in;
    input processor_control;
    input [71:0] processor_data_in;
    input processor_wea;
    input rst;
   output fifo_empty;
   output [71:0] out_fifo;
   output [7:0] packet_head;
   output [7:0] packet_tail;
   output valid_data;
   
   wire [7:0] dataMemAddrIn;
   wire [7:0] dataMemWrAddr;
   wire [71:0] dataMemWrData;
   wire dataMemWrEn;
   wire drop_pkt;
   wire [7:0] raddr;
   wire [7:0] waddr;
   wire XLXN_10;
   wire XLXN_11;
   wire XLXN_13;
   wire [7:0] XLXN_16;
   wire XLXN_21;
   wire XLXN_26;
   wire XLXN_37;
   wire XLXN_38;
   wire [71:0] XLXN_40;
   wire XLXN_71;
   wire XLXN_92;
   wire XLXN_94;
   
   FD XLXI_1 (.C(clk), 
              .D(firstword), 
              .Q(XLXN_10));
   defparam XLXI_1.INIT = 1'b0;
   FD XLXI_2 (.C(clk), 
              .D(lastword), 
              .Q(XLXN_11));
   defparam XLXI_2.INIT = 1'b0;
   FD XLXI_3 (.C(clk), 
              .D(fifowrite), 
              .Q(XLXN_92));
   defparam XLXI_3.INIT = 1'b0;
   reg9B XLXI_4 (.ce(XLXN_94), 
                 .clk(clk), 
                 .clr(rst), 
                 .d(in_fifo[71:0]), 
                 .q(XLXN_40[71:0]));
   FD8CE_MXILINX_memfifo XLXI_5 (.C(clk), 
                                 .CE(XLXN_38), 
                                 .CLR(rst), 
                                 .D(waddr[7:0]), 
                                 .Q(XLXN_16[7:0]));
   // synthesis attribute HU_SET of XLXI_5 is "XLXI_5_17"
   COMP8_MXILINX_memfifo XLXI_6 (.A(waddr[7:0]), 
                                 .B(raddr[7:0]), 
                                 .EQ(XLXN_71));
   // synthesis attribute HU_SET of XLXI_6 is "XLXI_6_18"
   COMP8_MXILINX_memfifo XLXI_7 (.A(raddr[7:0]), 
                                 .B(XLXN_16[7:0]), 
                                 .EQ(XLXN_21));
   // synthesis attribute HU_SET of XLXI_7 is "XLXI_7_19"
   FD XLXI_8 (.C(clk), 
              .D(drop_pkt), 
              .Q(XLXN_37));
   defparam XLXI_8.INIT = 1'b0;
   FDC XLXI_9 (.C(clk), 
               .CLR(rst), 
               .D(XLXN_26), 
               .Q(valid_data));
   defparam XLXI_9.INIT = 1'b0;
   CB8CE_MXILINX_memfifo XLXI_10 (.C(clk), 
                                  .CE(XLXN_26), 
                                  .CLR(rst), 
                                  .CEO(), 
                                  .Q(raddr[7:0]), 
                                  .TC());
   // synthesis attribute HU_SET of XLXI_10 is "XLXI_10_20"
   CB8CLE_MXILINX_memfifo XLXI_11 (.C(clk), 
                                   .CE(XLXN_92), 
                                   .CLR(rst), 
                                   .D(XLXN_16[7:0]), 
                                   .L(XLXN_37), 
                                   .CEO(), 
                                   .Q(waddr[7:0]), 
                                   .TC());
   // synthesis attribute HU_SET of XLXI_11 is "XLXI_11_21"
   OR2 XLXI_13 (.I0(XLXN_11), 
                .I1(XLXN_10), 
                .O(XLXN_13));
   AND2B1 XLXI_14 (.I0(XLXN_37), 
                   .I1(XLXN_13), 
                   .O(XLXN_38));
   VCC XLXI_15 (.P(XLXN_94));
   AND3B2 XLXI_17 (.I0(XLXN_21), 
                   .I1(XLXN_71), 
                   .I2(fiforead), 
                   .O(XLXN_26));
   GND XLXI_18 (.G(drop_pkt));
   M2_1_MXILINX_memfifo XLXI_21_0 (.D0(waddr[0]), 
                                   .D1(processor_addr_in[0]), 
                                   .S0(processor_control), 
                                   .O(dataMemWrAddr[0]));
   // synthesis attribute HU_SET of XLXI_21_0 is "XLXI_21_0_29"
   M2_1_MXILINX_memfifo XLXI_21_1 (.D0(waddr[1]), 
                                   .D1(processor_addr_in[1]), 
                                   .S0(processor_control), 
                                   .O(dataMemWrAddr[1]));
   // synthesis attribute HU_SET of XLXI_21_1 is "XLXI_21_1_28"
   M2_1_MXILINX_memfifo XLXI_21_2 (.D0(waddr[2]), 
                                   .D1(processor_addr_in[2]), 
                                   .S0(processor_control), 
                                   .O(dataMemWrAddr[2]));
   // synthesis attribute HU_SET of XLXI_21_2 is "XLXI_21_2_27"
   M2_1_MXILINX_memfifo XLXI_21_3 (.D0(waddr[3]), 
                                   .D1(processor_addr_in[3]), 
                                   .S0(processor_control), 
                                   .O(dataMemWrAddr[3]));
   // synthesis attribute HU_SET of XLXI_21_3 is "XLXI_21_3_26"
   M2_1_MXILINX_memfifo XLXI_21_4 (.D0(waddr[4]), 
                                   .D1(processor_addr_in[4]), 
                                   .S0(processor_control), 
                                   .O(dataMemWrAddr[4]));
   // synthesis attribute HU_SET of XLXI_21_4 is "XLXI_21_4_25"
   M2_1_MXILINX_memfifo XLXI_21_5 (.D0(waddr[5]), 
                                   .D1(processor_addr_in[5]), 
                                   .S0(processor_control), 
                                   .O(dataMemWrAddr[5]));
   // synthesis attribute HU_SET of XLXI_21_5 is "XLXI_21_5_24"
   M2_1_MXILINX_memfifo XLXI_21_6 (.D0(waddr[6]), 
                                   .D1(processor_addr_in[6]), 
                                   .S0(processor_control), 
                                   .O(dataMemWrAddr[6]));
   // synthesis attribute HU_SET of XLXI_21_6 is "XLXI_21_6_23"
   M2_1_MXILINX_memfifo XLXI_21_7 (.D0(waddr[7]), 
                                   .D1(processor_addr_in[7]), 
                                   .S0(processor_control), 
                                   .O(dataMemWrAddr[7]));
   // synthesis attribute HU_SET of XLXI_21_7 is "XLXI_21_7_22"
   M2_1_MXILINX_memfifo XLXI_22_0 (.D0(XLXN_40[0]), 
                                   .D1(processor_data_in[0]), 
                                   .S0(processor_control), 
                                   .O(dataMemWrData[0]));
   // synthesis attribute HU_SET of XLXI_22_0 is "XLXI_22_0_101"
   M2_1_MXILINX_memfifo XLXI_22_1 (.D0(XLXN_40[1]), 
                                   .D1(processor_data_in[1]), 
                                   .S0(processor_control), 
                                   .O(dataMemWrData[1]));
   // synthesis attribute HU_SET of XLXI_22_1 is "XLXI_22_1_100"
   M2_1_MXILINX_memfifo XLXI_22_2 (.D0(XLXN_40[2]), 
                                   .D1(processor_data_in[2]), 
                                   .S0(processor_control), 
                                   .O(dataMemWrData[2]));
   // synthesis attribute HU_SET of XLXI_22_2 is "XLXI_22_2_99"
   M2_1_MXILINX_memfifo XLXI_22_3 (.D0(XLXN_40[3]), 
                                   .D1(processor_data_in[3]), 
                                   .S0(processor_control), 
                                   .O(dataMemWrData[3]));
   // synthesis attribute HU_SET of XLXI_22_3 is "XLXI_22_3_98"
   M2_1_MXILINX_memfifo XLXI_22_4 (.D0(XLXN_40[4]), 
                                   .D1(processor_data_in[4]), 
                                   .S0(processor_control), 
                                   .O(dataMemWrData[4]));
   // synthesis attribute HU_SET of XLXI_22_4 is "XLXI_22_4_97"
   M2_1_MXILINX_memfifo XLXI_22_5 (.D0(XLXN_40[5]), 
                                   .D1(processor_data_in[5]), 
                                   .S0(processor_control), 
                                   .O(dataMemWrData[5]));
   // synthesis attribute HU_SET of XLXI_22_5 is "XLXI_22_5_96"
   M2_1_MXILINX_memfifo XLXI_22_6 (.D0(XLXN_40[6]), 
                                   .D1(processor_data_in[6]), 
                                   .S0(processor_control), 
                                   .O(dataMemWrData[6]));
   // synthesis attribute HU_SET of XLXI_22_6 is "XLXI_22_6_95"
   M2_1_MXILINX_memfifo XLXI_22_7 (.D0(XLXN_40[7]), 
                                   .D1(processor_data_in[7]), 
                                   .S0(processor_control), 
                                   .O(dataMemWrData[7]));
   // synthesis attribute HU_SET of XLXI_22_7 is "XLXI_22_7_94"
   M2_1_MXILINX_memfifo XLXI_22_8 (.D0(XLXN_40[8]), 
                                   .D1(processor_data_in[8]), 
                                   .S0(processor_control), 
                                   .O(dataMemWrData[8]));
   // synthesis attribute HU_SET of XLXI_22_8 is "XLXI_22_8_93"
   M2_1_MXILINX_memfifo XLXI_22_9 (.D0(XLXN_40[9]), 
                                   .D1(processor_data_in[9]), 
                                   .S0(processor_control), 
                                   .O(dataMemWrData[9]));
   // synthesis attribute HU_SET of XLXI_22_9 is "XLXI_22_9_92"
   M2_1_MXILINX_memfifo XLXI_22_10 (.D0(XLXN_40[10]), 
                                    .D1(processor_data_in[10]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[10]));
   // synthesis attribute HU_SET of XLXI_22_10 is "XLXI_22_10_91"
   M2_1_MXILINX_memfifo XLXI_22_11 (.D0(XLXN_40[11]), 
                                    .D1(processor_data_in[11]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[11]));
   // synthesis attribute HU_SET of XLXI_22_11 is "XLXI_22_11_90"
   M2_1_MXILINX_memfifo XLXI_22_12 (.D0(XLXN_40[12]), 
                                    .D1(processor_data_in[12]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[12]));
   // synthesis attribute HU_SET of XLXI_22_12 is "XLXI_22_12_89"
   M2_1_MXILINX_memfifo XLXI_22_13 (.D0(XLXN_40[13]), 
                                    .D1(processor_data_in[13]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[13]));
   // synthesis attribute HU_SET of XLXI_22_13 is "XLXI_22_13_88"
   M2_1_MXILINX_memfifo XLXI_22_14 (.D0(XLXN_40[14]), 
                                    .D1(processor_data_in[14]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[14]));
   // synthesis attribute HU_SET of XLXI_22_14 is "XLXI_22_14_87"
   M2_1_MXILINX_memfifo XLXI_22_15 (.D0(XLXN_40[15]), 
                                    .D1(processor_data_in[15]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[15]));
   // synthesis attribute HU_SET of XLXI_22_15 is "XLXI_22_15_86"
   M2_1_MXILINX_memfifo XLXI_22_16 (.D0(XLXN_40[16]), 
                                    .D1(processor_data_in[16]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[16]));
   // synthesis attribute HU_SET of XLXI_22_16 is "XLXI_22_16_85"
   M2_1_MXILINX_memfifo XLXI_22_17 (.D0(XLXN_40[17]), 
                                    .D1(processor_data_in[17]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[17]));
   // synthesis attribute HU_SET of XLXI_22_17 is "XLXI_22_17_84"
   M2_1_MXILINX_memfifo XLXI_22_18 (.D0(XLXN_40[18]), 
                                    .D1(processor_data_in[18]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[18]));
   // synthesis attribute HU_SET of XLXI_22_18 is "XLXI_22_18_83"
   M2_1_MXILINX_memfifo XLXI_22_19 (.D0(XLXN_40[19]), 
                                    .D1(processor_data_in[19]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[19]));
   // synthesis attribute HU_SET of XLXI_22_19 is "XLXI_22_19_82"
   M2_1_MXILINX_memfifo XLXI_22_20 (.D0(XLXN_40[20]), 
                                    .D1(processor_data_in[20]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[20]));
   // synthesis attribute HU_SET of XLXI_22_20 is "XLXI_22_20_81"
   M2_1_MXILINX_memfifo XLXI_22_21 (.D0(XLXN_40[21]), 
                                    .D1(processor_data_in[21]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[21]));
   // synthesis attribute HU_SET of XLXI_22_21 is "XLXI_22_21_80"
   M2_1_MXILINX_memfifo XLXI_22_22 (.D0(XLXN_40[22]), 
                                    .D1(processor_data_in[22]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[22]));
   // synthesis attribute HU_SET of XLXI_22_22 is "XLXI_22_22_79"
   M2_1_MXILINX_memfifo XLXI_22_23 (.D0(XLXN_40[23]), 
                                    .D1(processor_data_in[23]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[23]));
   // synthesis attribute HU_SET of XLXI_22_23 is "XLXI_22_23_78"
   M2_1_MXILINX_memfifo XLXI_22_24 (.D0(XLXN_40[24]), 
                                    .D1(processor_data_in[24]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[24]));
   // synthesis attribute HU_SET of XLXI_22_24 is "XLXI_22_24_77"
   M2_1_MXILINX_memfifo XLXI_22_25 (.D0(XLXN_40[25]), 
                                    .D1(processor_data_in[25]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[25]));
   // synthesis attribute HU_SET of XLXI_22_25 is "XLXI_22_25_76"
   M2_1_MXILINX_memfifo XLXI_22_26 (.D0(XLXN_40[26]), 
                                    .D1(processor_data_in[26]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[26]));
   // synthesis attribute HU_SET of XLXI_22_26 is "XLXI_22_26_75"
   M2_1_MXILINX_memfifo XLXI_22_27 (.D0(XLXN_40[27]), 
                                    .D1(processor_data_in[27]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[27]));
   // synthesis attribute HU_SET of XLXI_22_27 is "XLXI_22_27_74"
   M2_1_MXILINX_memfifo XLXI_22_28 (.D0(XLXN_40[28]), 
                                    .D1(processor_data_in[28]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[28]));
   // synthesis attribute HU_SET of XLXI_22_28 is "XLXI_22_28_73"
   M2_1_MXILINX_memfifo XLXI_22_29 (.D0(XLXN_40[29]), 
                                    .D1(processor_data_in[29]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[29]));
   // synthesis attribute HU_SET of XLXI_22_29 is "XLXI_22_29_72"
   M2_1_MXILINX_memfifo XLXI_22_30 (.D0(XLXN_40[30]), 
                                    .D1(processor_data_in[30]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[30]));
   // synthesis attribute HU_SET of XLXI_22_30 is "XLXI_22_30_71"
   M2_1_MXILINX_memfifo XLXI_22_31 (.D0(XLXN_40[31]), 
                                    .D1(processor_data_in[31]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[31]));
   // synthesis attribute HU_SET of XLXI_22_31 is "XLXI_22_31_70"
   M2_1_MXILINX_memfifo XLXI_22_32 (.D0(XLXN_40[32]), 
                                    .D1(processor_data_in[32]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[32]));
   // synthesis attribute HU_SET of XLXI_22_32 is "XLXI_22_32_69"
   M2_1_MXILINX_memfifo XLXI_22_33 (.D0(XLXN_40[33]), 
                                    .D1(processor_data_in[33]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[33]));
   // synthesis attribute HU_SET of XLXI_22_33 is "XLXI_22_33_68"
   M2_1_MXILINX_memfifo XLXI_22_34 (.D0(XLXN_40[34]), 
                                    .D1(processor_data_in[34]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[34]));
   // synthesis attribute HU_SET of XLXI_22_34 is "XLXI_22_34_67"
   M2_1_MXILINX_memfifo XLXI_22_35 (.D0(XLXN_40[35]), 
                                    .D1(processor_data_in[35]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[35]));
   // synthesis attribute HU_SET of XLXI_22_35 is "XLXI_22_35_66"
   M2_1_MXILINX_memfifo XLXI_22_36 (.D0(XLXN_40[36]), 
                                    .D1(processor_data_in[36]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[36]));
   // synthesis attribute HU_SET of XLXI_22_36 is "XLXI_22_36_65"
   M2_1_MXILINX_memfifo XLXI_22_37 (.D0(XLXN_40[37]), 
                                    .D1(processor_data_in[37]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[37]));
   // synthesis attribute HU_SET of XLXI_22_37 is "XLXI_22_37_64"
   M2_1_MXILINX_memfifo XLXI_22_38 (.D0(XLXN_40[38]), 
                                    .D1(processor_data_in[38]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[38]));
   // synthesis attribute HU_SET of XLXI_22_38 is "XLXI_22_38_63"
   M2_1_MXILINX_memfifo XLXI_22_39 (.D0(XLXN_40[39]), 
                                    .D1(processor_data_in[39]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[39]));
   // synthesis attribute HU_SET of XLXI_22_39 is "XLXI_22_39_62"
   M2_1_MXILINX_memfifo XLXI_22_40 (.D0(XLXN_40[40]), 
                                    .D1(processor_data_in[40]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[40]));
   // synthesis attribute HU_SET of XLXI_22_40 is "XLXI_22_40_61"
   M2_1_MXILINX_memfifo XLXI_22_41 (.D0(XLXN_40[41]), 
                                    .D1(processor_data_in[41]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[41]));
   // synthesis attribute HU_SET of XLXI_22_41 is "XLXI_22_41_60"
   M2_1_MXILINX_memfifo XLXI_22_42 (.D0(XLXN_40[42]), 
                                    .D1(processor_data_in[42]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[42]));
   // synthesis attribute HU_SET of XLXI_22_42 is "XLXI_22_42_59"
   M2_1_MXILINX_memfifo XLXI_22_43 (.D0(XLXN_40[43]), 
                                    .D1(processor_data_in[43]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[43]));
   // synthesis attribute HU_SET of XLXI_22_43 is "XLXI_22_43_58"
   M2_1_MXILINX_memfifo XLXI_22_44 (.D0(XLXN_40[44]), 
                                    .D1(processor_data_in[44]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[44]));
   // synthesis attribute HU_SET of XLXI_22_44 is "XLXI_22_44_57"
   M2_1_MXILINX_memfifo XLXI_22_45 (.D0(XLXN_40[45]), 
                                    .D1(processor_data_in[45]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[45]));
   // synthesis attribute HU_SET of XLXI_22_45 is "XLXI_22_45_56"
   M2_1_MXILINX_memfifo XLXI_22_46 (.D0(XLXN_40[46]), 
                                    .D1(processor_data_in[46]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[46]));
   // synthesis attribute HU_SET of XLXI_22_46 is "XLXI_22_46_55"
   M2_1_MXILINX_memfifo XLXI_22_47 (.D0(XLXN_40[47]), 
                                    .D1(processor_data_in[47]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[47]));
   // synthesis attribute HU_SET of XLXI_22_47 is "XLXI_22_47_54"
   M2_1_MXILINX_memfifo XLXI_22_48 (.D0(XLXN_40[48]), 
                                    .D1(processor_data_in[48]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[48]));
   // synthesis attribute HU_SET of XLXI_22_48 is "XLXI_22_48_53"
   M2_1_MXILINX_memfifo XLXI_22_49 (.D0(XLXN_40[49]), 
                                    .D1(processor_data_in[49]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[49]));
   // synthesis attribute HU_SET of XLXI_22_49 is "XLXI_22_49_52"
   M2_1_MXILINX_memfifo XLXI_22_50 (.D0(XLXN_40[50]), 
                                    .D1(processor_data_in[50]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[50]));
   // synthesis attribute HU_SET of XLXI_22_50 is "XLXI_22_50_51"
   M2_1_MXILINX_memfifo XLXI_22_51 (.D0(XLXN_40[51]), 
                                    .D1(processor_data_in[51]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[51]));
   // synthesis attribute HU_SET of XLXI_22_51 is "XLXI_22_51_50"
   M2_1_MXILINX_memfifo XLXI_22_52 (.D0(XLXN_40[52]), 
                                    .D1(processor_data_in[52]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[52]));
   // synthesis attribute HU_SET of XLXI_22_52 is "XLXI_22_52_49"
   M2_1_MXILINX_memfifo XLXI_22_53 (.D0(XLXN_40[53]), 
                                    .D1(processor_data_in[53]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[53]));
   // synthesis attribute HU_SET of XLXI_22_53 is "XLXI_22_53_48"
   M2_1_MXILINX_memfifo XLXI_22_54 (.D0(XLXN_40[54]), 
                                    .D1(processor_data_in[54]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[54]));
   // synthesis attribute HU_SET of XLXI_22_54 is "XLXI_22_54_47"
   M2_1_MXILINX_memfifo XLXI_22_55 (.D0(XLXN_40[55]), 
                                    .D1(processor_data_in[55]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[55]));
   // synthesis attribute HU_SET of XLXI_22_55 is "XLXI_22_55_46"
   M2_1_MXILINX_memfifo XLXI_22_56 (.D0(XLXN_40[56]), 
                                    .D1(processor_data_in[56]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[56]));
   // synthesis attribute HU_SET of XLXI_22_56 is "XLXI_22_56_45"
   M2_1_MXILINX_memfifo XLXI_22_57 (.D0(XLXN_40[57]), 
                                    .D1(processor_data_in[57]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[57]));
   // synthesis attribute HU_SET of XLXI_22_57 is "XLXI_22_57_44"
   M2_1_MXILINX_memfifo XLXI_22_58 (.D0(XLXN_40[58]), 
                                    .D1(processor_data_in[58]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[58]));
   // synthesis attribute HU_SET of XLXI_22_58 is "XLXI_22_58_43"
   M2_1_MXILINX_memfifo XLXI_22_59 (.D0(XLXN_40[59]), 
                                    .D1(processor_data_in[59]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[59]));
   // synthesis attribute HU_SET of XLXI_22_59 is "XLXI_22_59_42"
   M2_1_MXILINX_memfifo XLXI_22_60 (.D0(XLXN_40[60]), 
                                    .D1(processor_data_in[60]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[60]));
   // synthesis attribute HU_SET of XLXI_22_60 is "XLXI_22_60_41"
   M2_1_MXILINX_memfifo XLXI_22_61 (.D0(XLXN_40[61]), 
                                    .D1(processor_data_in[61]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[61]));
   // synthesis attribute HU_SET of XLXI_22_61 is "XLXI_22_61_40"
   M2_1_MXILINX_memfifo XLXI_22_62 (.D0(XLXN_40[62]), 
                                    .D1(processor_data_in[62]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[62]));
   // synthesis attribute HU_SET of XLXI_22_62 is "XLXI_22_62_39"
   M2_1_MXILINX_memfifo XLXI_22_63 (.D0(XLXN_40[63]), 
                                    .D1(processor_data_in[63]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[63]));
   // synthesis attribute HU_SET of XLXI_22_63 is "XLXI_22_63_38"
   M2_1_MXILINX_memfifo XLXI_22_64 (.D0(XLXN_40[64]), 
                                    .D1(processor_data_in[64]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[64]));
   // synthesis attribute HU_SET of XLXI_22_64 is "XLXI_22_64_37"
   M2_1_MXILINX_memfifo XLXI_22_65 (.D0(XLXN_40[65]), 
                                    .D1(processor_data_in[65]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[65]));
   // synthesis attribute HU_SET of XLXI_22_65 is "XLXI_22_65_36"
   M2_1_MXILINX_memfifo XLXI_22_66 (.D0(XLXN_40[66]), 
                                    .D1(processor_data_in[66]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[66]));
   // synthesis attribute HU_SET of XLXI_22_66 is "XLXI_22_66_35"
   M2_1_MXILINX_memfifo XLXI_22_67 (.D0(XLXN_40[67]), 
                                    .D1(processor_data_in[67]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[67]));
   // synthesis attribute HU_SET of XLXI_22_67 is "XLXI_22_67_34"
   M2_1_MXILINX_memfifo XLXI_22_68 (.D0(XLXN_40[68]), 
                                    .D1(processor_data_in[68]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[68]));
   // synthesis attribute HU_SET of XLXI_22_68 is "XLXI_22_68_33"
   M2_1_MXILINX_memfifo XLXI_22_69 (.D0(XLXN_40[69]), 
                                    .D1(processor_data_in[69]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[69]));
   // synthesis attribute HU_SET of XLXI_22_69 is "XLXI_22_69_32"
   M2_1_MXILINX_memfifo XLXI_22_70 (.D0(XLXN_40[70]), 
                                    .D1(processor_data_in[70]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[70]));
   // synthesis attribute HU_SET of XLXI_22_70 is "XLXI_22_70_31"
   M2_1_MXILINX_memfifo XLXI_22_71 (.D0(XLXN_40[71]), 
                                    .D1(processor_data_in[71]), 
                                    .S0(processor_control), 
                                    .O(dataMemWrData[71]));
   // synthesis attribute HU_SET of XLXI_22_71 is "XLXI_22_71_30"
   M2_1_MXILINX_memfifo XLXI_23 (.D0(XLXN_92), 
                                 .D1(processor_wea), 
                                 .S0(processor_control), 
                                 .O(dataMemWrEn));
   // synthesis attribute HU_SET of XLXI_23 is "XLXI_23_102"
   BUF XLXI_25_0 (.I(waddr[0]), 
                  .O(packet_tail[0]));
   BUF XLXI_25_1 (.I(waddr[1]), 
                  .O(packet_tail[1]));
   BUF XLXI_25_2 (.I(waddr[2]), 
                  .O(packet_tail[2]));
   BUF XLXI_25_3 (.I(waddr[3]), 
                  .O(packet_tail[3]));
   BUF XLXI_25_4 (.I(waddr[4]), 
                  .O(packet_tail[4]));
   BUF XLXI_25_5 (.I(waddr[5]), 
                  .O(packet_tail[5]));
   BUF XLXI_25_6 (.I(waddr[6]), 
                  .O(packet_tail[6]));
   BUF XLXI_25_7 (.I(waddr[7]), 
                  .O(packet_tail[7]));
   BUF XLXI_26_0 (.I(raddr[0]), 
                  .O(packet_head[0]));
   BUF XLXI_26_1 (.I(raddr[1]), 
                  .O(packet_head[1]));
   BUF XLXI_26_2 (.I(raddr[2]), 
                  .O(packet_head[2]));
   BUF XLXI_26_3 (.I(raddr[3]), 
                  .O(packet_head[3]));
   BUF XLXI_26_4 (.I(raddr[4]), 
                  .O(packet_head[4]));
   BUF XLXI_26_5 (.I(raddr[5]), 
                  .O(packet_head[5]));
   BUF XLXI_26_6 (.I(raddr[6]), 
                  .O(packet_head[6]));
   BUF XLXI_26_7 (.I(raddr[7]), 
                  .O(packet_head[7]));
   OR2 XLXI_27 (.I0(XLXN_21), 
                .I1(XLXN_71), 
                .O(fifo_empty));
   dataMem XLXI_29 (.addra(dataMemWrAddr[7:0]), 
                    .addrb(dataMemAddrIn[7:0]), 
                    .clka(clk), 
                    .clkb(clk), 
                    .dina(dataMemWrData[71:0]), 
                    .wea(dataMemWrEn), 
                    .doutb(out_fifo[71:0]));
   M2_1_MXILINX_memfifo XLXI_30_0 (.D0(raddr[0]), 
                                   .D1(processor_addr_in[0]), 
                                   .S0(processor_control), 
                                   .O(dataMemAddrIn[0]));
   // synthesis attribute HU_SET of XLXI_30_0 is "XLXI_30_0_110"
   M2_1_MXILINX_memfifo XLXI_30_1 (.D0(raddr[1]), 
                                   .D1(processor_addr_in[1]), 
                                   .S0(processor_control), 
                                   .O(dataMemAddrIn[1]));
   // synthesis attribute HU_SET of XLXI_30_1 is "XLXI_30_1_109"
   M2_1_MXILINX_memfifo XLXI_30_2 (.D0(raddr[2]), 
                                   .D1(processor_addr_in[2]), 
                                   .S0(processor_control), 
                                   .O(dataMemAddrIn[2]));
   // synthesis attribute HU_SET of XLXI_30_2 is "XLXI_30_2_108"
   M2_1_MXILINX_memfifo XLXI_30_3 (.D0(raddr[3]), 
                                   .D1(processor_addr_in[3]), 
                                   .S0(processor_control), 
                                   .O(dataMemAddrIn[3]));
   // synthesis attribute HU_SET of XLXI_30_3 is "XLXI_30_3_107"
   M2_1_MXILINX_memfifo XLXI_30_4 (.D0(raddr[4]), 
                                   .D1(processor_addr_in[4]), 
                                   .S0(processor_control), 
                                   .O(dataMemAddrIn[4]));
   // synthesis attribute HU_SET of XLXI_30_4 is "XLXI_30_4_106"
   M2_1_MXILINX_memfifo XLXI_30_5 (.D0(raddr[5]), 
                                   .D1(processor_addr_in[5]), 
                                   .S0(processor_control), 
                                   .O(dataMemAddrIn[5]));
   // synthesis attribute HU_SET of XLXI_30_5 is "XLXI_30_5_105"
   M2_1_MXILINX_memfifo XLXI_30_6 (.D0(raddr[6]), 
                                   .D1(processor_addr_in[6]), 
                                   .S0(processor_control), 
                                   .O(dataMemAddrIn[6]));
   // synthesis attribute HU_SET of XLXI_30_6 is "XLXI_30_6_104"
   M2_1_MXILINX_memfifo XLXI_30_7 (.D0(raddr[7]), 
                                   .D1(processor_addr_in[7]), 
                                   .S0(processor_control), 
                                   .O(dataMemAddrIn[7]));
   // synthesis attribute HU_SET of XLXI_30_7 is "XLXI_30_7_103"
endmodule
