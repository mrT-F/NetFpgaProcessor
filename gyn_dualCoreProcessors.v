///////////////////////////////////////////////////////////////////////////////
// vim:set shiftwidth=3 softtabstop=3 expandtab:
// $Id: module_template 2008-03-13 gac1 $
//
// Module: gyn.v
// Project: NF2.1
// Description: This is a work in progress. Eventually will contain a multi
// threaded network processor.
//
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps

module gyn_processor 
   #(
      parameter DATA_WIDTH = 64,
      parameter CTRL_WIDTH = DATA_WIDTH/8,
      parameter UDP_REG_SRC_WIDTH = 2
   )
   (      
      // --- Packet Data interface
      input  [DATA_WIDTH-1:0]             in_data,
      input  [CTRL_WIDTH-1:0]             in_ctrl,
      input                               in_wr,
      output                              in_rdy,

      output [DATA_WIDTH-1:0]             out_data,
      output [CTRL_WIDTH-1:0]             out_ctrl,
      output                              out_wr,
      input                               out_rdy,

      // --- Register interface
      input                               reg_req_in,
      input                               reg_ack_in,
      input                               reg_rd_wr_L_in,
      input  [`UDP_REG_ADDR_WIDTH-1:0]    reg_addr_in,
      input  [`CPCI_NF2_DATA_WIDTH-1:0]   reg_data_in,
      input  [UDP_REG_SRC_WIDTH-1:0]      reg_src_in,

      output                              reg_req_out,
      output                              reg_ack_out,
      output                              reg_rd_wr_L_out,
      output  [`UDP_REG_ADDR_WIDTH-1:0]   reg_addr_out,
      output  [`CPCI_NF2_DATA_WIDTH-1:0]  reg_data_out,
      output  [UDP_REG_SRC_WIDTH-1:0]     reg_src_out,

      // misc
      input                                reset,
      input                                clk
   );


   //------------------------- Signals-------------------------------
   /*REGISTER INTERFACE*/
   // software registers 
    wire [31:0]                   instr_addr;
    wire [31:0]                   instr_data;
    wire [31:0]                   data_addr;
    wire [31:0]                   data_dataLow;
    wire [31:0]                   data_dataHigh;
    wire [31:0]                   datapath_cmd;
    wire [31:0]                   mode;//i-read 0, i-write 1, d-read 2, d-write 3, execute 4
   
    // hardware registers
    reg [31:0]                    data_low0;
    reg [31:0]                    data_high0;
    reg [31:0]                    data_low1;
    reg [31:0]                    data_high1;
 
    //Top-level Instruction memory signals
	wire out_wr0;
	wire out_wr1;
	wire in_rdy0;
	wire in_rdy1;
	
    // Since we have four threads, we need four PCs
	// **********For one core0
	reg [6:0] instructionCounter0_core0;  // Starting from 0-127   (7 bits)
	reg [7:0] instructionCounter1_core0;  // Starting from 128-255 (8 bits)
	reg [8:0] instructionCounter2_core0;  // Starting from 256-383 (9 bits)
	reg [8:0] instructionCounter3_core0;  // Starting from 384-511 (9 bits)
	wire [8:0] programCounter_core0; // This is the one which actually goes into our gyn_datapath
    wire [8:0] instrAddrIn_core0;
	// **********For the other core1
	reg [6:0] instructionCounter0_core1;  // Starting from 0-127   (7 bits)
	reg [7:0] instructionCounter1_core1;  // Starting from 128-255 (8 bits)
	reg [8:0] instructionCounter2_core1;  // Starting from 256-383 (9 bits)
	reg [8:0] instructionCounter3_core1;  // Starting from 384-511 (9 bits)
	wire [8:0] programCounter_core1; // This is the one which actually goes into our gyn_datapath
    wire [8:0] instrAddrIn_core1;
	// Since we use round robin, we need 2-bit counter to keep track of which thread we are executing
	reg [1:0] thread_num0; //we have four threads: thread0, thread1, thread2, thread3 for core0
	reg [1:0] thread_num1; //we have four threads: thread0, thread1, thread2, thread3 for core1
	
    wire [31:0] instrDataIn;
    wire instrWeaIn;
	wire PCsel_core0;
	wire PCsel_core1;
	wire [8:0]  jump_address_core0;
	wire [8:0]  jump_address_core1;
    wire [31:0] instrDataOut_core0;
	wire [31:0] instrDataOut_core1;
    //Top level data memory signals
    wire [31:0] dataDataOut_hi0;
    wire [31:0] dataDataOut_lo0;
    wire [31:0] dataDataOut_hi1;
    wire [31:0] dataDataOut_lo1;
    //Packet Data and Control Signals
    wire processor_control0;
	wire processor_control1;
	wire thread_can_inc0;
	wire thread_can_inc1;
	wire gnt0;
	wire gnt1;
	wire gnt0_output;
	wire gnt1_output;
	wire output_req0;
	wire output_req1;
    wire [DATA_WIDTH-1:0] out_data0;
    wire [CTRL_WIDTH-1:0] out_ctrl0;
    wire [DATA_WIDTH-1:0] out_data1;
    wire [CTRL_WIDTH-1:0] out_ctrl1;
   //------------------------- Local assignments---------------------------
//   assign out_wr = out_wr0 || out_wr1;
   
   //INSTRUCTION INTERFACE MODULE CONTROL LOGIC
   assign programCounter_core0 = thread_num0[1] ? (thread_num0[0] ? instructionCounter3_core0 : instructionCounter2_core0) : (thread_num0[0] ? {1'b0, instructionCounter1_core0} : {2'b0, instructionCounter0_core0});
   // assign instrAddrIn = mode[2] ? instructionCounter : (mode[1] ? 7'bZ : instr_addr[6:0]);
   // so instead of using instructionCounter to assign instrAddrIn, we should use programCounter
   assign instrAddrIn_core0 = mode[2] ? programCounter_core0 : (mode[1] ? 9'bX : instr_addr[8:0]);
   // For core1
   assign programCounter_core1 = thread_num1[1] ? (thread_num1[0] ? instructionCounter3_core1 : instructionCounter2_core1) : (thread_num1[0] ? {1'b0, instructionCounter1_core1} : {2'b0, instructionCounter0_core1});
   // assign instrAddrIn = mode[2] ? instructionCounter : (mode[1] ? 7'bZ : instr_addr[6:0]);
   // so instead of using instructionCounter to assign instrAddrIn, we should use programCounter
   assign instrAddrIn_core1 = mode[2] ? programCounter_core1 : (mode[1] ? 9'bX : instr_addr[8:0]);

   assign instrDataIn = mode[2] ? 32'bX : (mode[1] ? 32'bX : ( mode[0] ? instr_data : 32'bX ));
   assign instrWeaIn = mode[2] ? 1'b0 : (mode[1] ? 1'b0 : ( mode[0] ? 1'b1 : 1'b0));

   //------------------------- Modules-------------------------------
	
   bus_arbiter input_bus_arbiter (
      //EDIT 4/12 TO CHANGE REQUEST SIGNALS
      .req0(in_rdy0),
	  .req1(in_rdy1),
	  .clk(clk), 
	  .rst(reset),
//	  .enable(),
	  .gnt0(gnt0),
	  .gnt1(gnt1)
   );

   gyn_datapath dp0 (
      .clk (clk),
      .reset (reset),
	  .thread_num (thread_num0),
      .instrMem_addr  (instrAddrIn_core0),
      .instrMem_data  (instrDataIn),
      .instrMem_wea (instrWeaIn),
      .dMem_addrTopLevel  (data_addr[7:0]),
      .dMem_dataTopLevel  ({data_dataHigh, data_dataLow}),
      .modeTopLevel  (mode[2:0]),  
	  //EDIT 4/12 FOR OUTPUT GRANT SIGNAL
	  .input_grant(gnt0),
	  .output_grant(gnt0_output),
	  .in_data (in_data),
	  .in_ctrl (in_ctrl),
      .in_wr (in_wr),
	  .in_rdy (in_rdy0),
	  .out_data (out_data0),
	  .out_ctrl (out_ctrl0),
  	  .out_wr (out_wr0),
  	  .out_rdy (out_rdy),
	  .thread_can_inc (thread_can_inc0),  // used for incrementing thread_num
      .processor_control_out(processor_control0),
      .output_req(output_req0),
  	  .PCsel(PCsel_core0),
  	  .jump_address(jump_address_core0),
      .dMem_outHiTopLevel (dataDataOut_hi0),
      .dMem_outLoTopLevel (dataDataOut_lo0),
      .iMem_outTopLevel (instrDataOut_core0)
   );
   
   gyn_datapath dp1 (
      .clk (clk),
      .reset (reset),
	  .thread_num (thread_num1),
      .instrMem_addr  (instrAddrIn_core1),
      .instrMem_data  (instrDataIn),
      .instrMem_wea (instrWeaIn),
      .dMem_addrTopLevel  (data_addr[7:0]),
      .dMem_dataTopLevel  ({data_dataHigh,data_dataLow}),
	  //EDIT 4/12 FOR OUTPUT GRANT SIGNAL
	  .input_grant(gnt1),
	  .output_grant(gnt1_output),
      .modeTopLevel  (mode[2:0]),  
	  .in_data (in_data),
	  .in_ctrl (in_ctrl),
      .in_wr (in_wr),
	  .in_rdy (in_rdy1),
	  .thread_can_inc (thread_can_inc1),
	  .out_data (out_data1),
	  .out_ctrl (out_ctrl1),
  	  .out_wr (out_wr1),
  	  .out_rdy (out_rdy),
      .processor_control_out(processor_control1),
      .output_req (output_req1),
  	  .PCsel(PCsel_core1),
  	  .jump_address(jump_address_core1),
      .dMem_outHiTopLevel (dataDataOut_hi1),
      .dMem_outLoTopLevel (dataDataOut_lo1),
      .iMem_outTopLevel (instrDataOut_core1)
   );
   
   bus_arbiter output_bus_arbiter (
      //EDIT 4/12 TO INCLUDE OUTPUT REQUESTS
      .req0(output_req0),
	  .req1(output_req1),
	  .clk(clk), 
	  .rst(reset),
//	  .enable(),
	  .gnt0(gnt0_output),
	  .gnt1(gnt1_output)
   );
   
   assign out_wr = gnt0_output ? out_wr0 : out_wr1;
   assign out_data = gnt0_output ? out_data0 : out_data1;
   assign out_ctrl = gnt0_output ? out_ctrl0 : out_ctrl1;
	// Modified: 4/10/2016
   assign in_rdy = gnt0_output ? in_rdy0 : in_rdy1;
   
   generic_regs
   #( 
      .UDP_REG_SRC_WIDTH   (UDP_REG_SRC_WIDTH),
      .TAG                 (`GYN_BLOCK_ADDR),          // Tag -- eg. MODULE_TAG
      .REG_ADDR_WIDTH      (`GYN_REG_ADDR_WIDTH),     // Width of block addresses -- eg. MODULE_REG_ADDR_WIDTH
      .NUM_COUNTERS        (0),                 // Number of counters
      .NUM_SOFTWARE_REGS   (7),                 // Number of sw regs
      .NUM_HARDWARE_REGS   (4)                  // Number of hw regs
   ) module_regs (
      .reg_req_in       (reg_req_in),
      .reg_ack_in       (reg_ack_in),
      .reg_rd_wr_L_in   (reg_rd_wr_L_in),
      .reg_addr_in      (reg_addr_in),
      .reg_data_in      (reg_data_in),
      .reg_src_in       (reg_src_in),

      .reg_req_out      (reg_req_out),
      .reg_ack_out      (reg_ack_out),
      .reg_rd_wr_L_out  (reg_rd_wr_L_out),
      .reg_addr_out     (reg_addr_out),
      .reg_data_out     (reg_data_out),
      .reg_src_out      (reg_src_out),

      // --- counters interface
      .counter_updates  (),
      .counter_decrement(),

      // --- SW regs interface
      .software_regs    ({mode, datapath_cmd, data_dataHigh, data_dataLow, data_addr, instr_data, instr_addr}),

      // --- HW regs interface
      .hardware_regs    ({data_low1, data_high1, data_low0, data_high0}),

      .clk              (clk),
      .reset            (reset)
    );

   //------------------------- Logic-------------------------------   
   
   always @(posedge clk) begin
      if(reset) begin
        instructionCounter0_core0 <= 7'b0;
		instructionCounter1_core0 <= 8'h80;   //128
		instructionCounter2_core0 <= 9'h100;  //256
		instructionCounter3_core0 <= 9'h180;  //384
        instructionCounter0_core1 <= 7'b0;
		instructionCounter1_core1 <= 8'h80;   //128
		instructionCounter2_core1 <= 9'h100;  //256
		instructionCounter3_core1 <= 9'h180;  //384
		thread_num0 <= 2'b0;
		thread_num1 <= 2'b0;
        data_low0 <= 32'b0;
        data_high0 <= 32'b0;
        data_low1 <= 32'b0;
        data_high1 <= 32'b0;
      end
      else begin
        if (datapath_cmd[0]) begin
			data_low0 <= 32'b0;
			data_high0 <= 32'b0;
			data_low1 <= 32'b0;
			data_high1 <= 32'b0;
        end 
        else begin
            if((!mode[2]) && (mode[1]) && (!mode[0]) ) begin //in data read mode
                data_low0 <= dataDataOut_lo0;  
				data_high0 <= dataDataOut_hi0;
                data_low1 <= dataDataOut_lo1;  
				data_high1 <= dataDataOut_hi1;
				instructionCounter0_core0 <= 7'b0;
				instructionCounter1_core0 <= 8'h80;   //128
				instructionCounter2_core0 <= 9'h100;  //256
				instructionCounter3_core0 <= 9'h180;  //384
		        instructionCounter0_core1 <= 7'b0;
				instructionCounter1_core1 <= 8'h80;   //128
				instructionCounter2_core1 <= 9'h100;  //256
				instructionCounter3_core1 <= 9'h180;  //384
				thread_num0 <= 2'b0;
				thread_num1 <= 2'b0;
            end
            else if ((!mode[2]) && (!mode[1]) && (!mode[0])) begin //instr read mode
                data_high0 <= instrDataOut_core0;
				data_low0 <= 32'b0;
                data_high1 <= instrDataOut_core1;
				data_low1 <= 32'b0;
				instructionCounter0_core0 <= 7'b0;
				instructionCounter1_core0 <= 8'h80;   //128
				instructionCounter2_core0 <= 9'h100;  //256
				instructionCounter3_core0 <= 9'h180;  //384
			    instructionCounter0_core1 <= 7'b0;
				instructionCounter1_core1 <= 8'h80;   //128
				instructionCounter2_core1 <= 9'h100;  //256
				instructionCounter3_core1 <= 9'h180;  //384
				thread_num0 <= 2'b0;
				thread_num1 <= 2'b0;
            end     
            else if(mode[2]) begin //execution mode
			    if(!processor_control0) begin // when fifo is just buffering data, don't advance PC
					thread_num0 <= 2'b0;
					instructionCounter0_core0 <= 7'b0;
					instructionCounter1_core0 <= 8'h80;   //128
					instructionCounter2_core0 <= 9'h100;  //256
					instructionCounter3_core0 <= 9'h180;  //384
				end 
				else if (PCsel_core0) begin
					if (thread_num0[1] && thread_num0[0]) begin  //11, thread3
						instructionCounter3_core0 <= jump_address_core0;
					end else if (thread_num0[1] && (!thread_num0[0])) begin  //10, thread2
						instructionCounter2_core0 <= jump_address_core0;
					end else if ((!thread_num0[1]) && thread_num0[0]) begin  //01, thread1
						instructionCounter1_core0 <= jump_address_core0[7:0];
					end else begin  //00, thread0
						instructionCounter0_core0 <= jump_address_core0[6:0];
					end	
					// do not need to increase thread number again since we have already increased it.
					// thread_num <= thread_num + 1'b1;
				end
				else begin
					// since we use round robin, we need to increase thread_num by 1.
					if (thread_can_inc0) begin
						thread_num0 <= thread_num0 + 1'b1;
					end
					// we need to increase instructionCounter by 1 according to thread_num.
					//core0
					if (thread_num0[1] && thread_num0[0]) begin  //11, thread3
					    // if instructionCounter is pointing at the end of thread, we need to reset it
						if (instructionCounter3_core0 == 9'h1ff) begin
							instructionCounter3_core0 <= 9'h180;
						end else begin
						    instructionCounter3_core0 <= instructionCounter3_core0 + 1'b1;
						end
					end else if (thread_num0[1] && (!thread_num0[0])) begin  //10, thread2
						if (instructionCounter2_core0 == 9'h17f) begin
							instructionCounter2_core0 <= 9'h100;
						end else begin
						    instructionCounter2_core0 <= instructionCounter2_core0 + 1'b1;
						end
					end else if ((!thread_num0[1]) && thread_num0[0]) begin  //01, thread1
						if (instructionCounter1_core0 == 8'hff) begin
							instructionCounter1_core0 <= 8'h80;
						end else begin
						    instructionCounter1_core0 <= instructionCounter1_core0 + 1'b1;
						end
					end else begin  //00, thread0
						if (instructionCounter0_core0 == 7'h7f) begin
							instructionCounter0_core0 <= 7'b0;
						end else begin
						    instructionCounter0_core0 <= instructionCounter0_core0 + 1'b1;
						end
					end
				end

				if (!processor_control1) begin 
					thread_num1 <= 2'b0;
					instructionCounter0_core1 <= 7'b0;
					instructionCounter1_core1 <= 8'h80;   //128
					instructionCounter2_core1 <= 9'h100;  //256
					instructionCounter3_core1 <= 9'h180;  //384
				end 
				else if (PCsel_core1) begin
					if (thread_num1[1] && thread_num1[0]) begin  //11, thread3
						instructionCounter3_core1 <= jump_address_core1;
					end else if (thread_num1[1] && (!thread_num1[0])) begin  //10, thread2
						instructionCounter2_core1 <= jump_address_core1;
					end else if ((!thread_num1[1]) && thread_num1[0]) begin  //01, thread1
						instructionCounter1_core1 <= jump_address_core1[7:0];
					end else begin  //00, thread0
						instructionCounter0_core1 <= jump_address_core1[6:0];
					end	
			    end 
			    else begin
			    	if (thread_can_inc1) begin
						thread_num1 <= thread_num1 + 1'b1;
					end
					// core1
					if (thread_num1[1] && thread_num1[0]) begin  //11, thread3
					    // if instructionCounter is pointing at the end of thread, we need to reset it
						if (instructionCounter3_core1 == 9'h1ff) begin
							instructionCounter3_core1 <= 9'h180;
						end else begin
						    instructionCounter3_core1 <= instructionCounter3_core1 + 1'b1;
						end
					end else if (thread_num1[1] && (!thread_num1[0])) begin  //10, thread2
						if (instructionCounter2_core1 == 9'h17f) begin
							instructionCounter2_core1 <= 9'h100;
						end else begin
						    instructionCounter2_core1 <= instructionCounter2_core1 + 1'b1;
						end
					end else if ((!thread_num1[1]) && thread_num1[0]) begin  //01, thread1
						if (instructionCounter1_core1 == 8'hff) begin
							instructionCounter1_core1 <= 8'h80;
						end else begin
						    instructionCounter1_core1 <= instructionCounter1_core1 + 1'b1;
						end
					end else begin  //00, thread0
						if (instructionCounter0_core1 == 7'h7f) begin
							instructionCounter0_core1 <= 7'b0;
						end else begin
						    instructionCounter0_core1 <= instructionCounter0_core1 + 1'b1;
						end
					end
			    end
            end
        end
     end // else: !if(reset)
  end // always @ (posedge clk)   



endmodule 
