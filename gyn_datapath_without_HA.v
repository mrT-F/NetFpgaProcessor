`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Date: 3/31/2016
// Notice: 1. I don't know if reducing the number of registers in registerFile to 8 
//         is good since encryption needs all 16 registers. Or we could just keep
//         1 registerFile with 16 registers and the remaining 3 registerFiles with
//         8 registers.
//         2. I moved DFFs from outputs of registerFile to output of 74bit muxes
//         in order to save some slices and timing since alu needs a lot more time.
//         we cannot squeeze muxes into EXE stage. 
//         3. In this version, we have 3 regFiles with 8 registers and 1 regFile with 16 registers 
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
// Date: 3/23/2016
// Notice: Make registerFile 74 bits and ALU 66 bits so that we don't have 
//         overflow when calculating modulus. 
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
// Date: 3/20/2016
// Notice: Remove hardware acceleration
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
// Date: 3/14/2016
// Notice: Implement jal and jr. jr is basically jump with R14(Ra). 
//         Rd of jal should always be R14. 
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
// Date: 3/13/2016
// Notice: Core of modular exponentiation is working in hardware.
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
// Date: 3/10/2016
//
// Notice1: Something might go wrong with signals control_stage2 and control_stage3.
//          If we find anything strange, I need to first double check those sigals. 
//          But right now I cannot remember why I wrote in this way.......:(
//
// Notice2: Originally output of Mont mont_A_out should be 65 bits in this example,
//          But to be compatible with our design, I made mont_A_out 64 bits.
//          If encryption doesn't work, chances are we need to make mont_A_out 65 bits.
//          If that happens, I will change the design.
//
////////////////////////////////////////////////////////////////////////////////// 

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:15:46 02/19/2016 
// Design Name: 
// Module Name:    gyn_datapath 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module gyn_datapath(
	input clk,
	input reset,
	//Instruction memory inputs, allows us to set i-mem
	input [1:0] thread_num,
	// Update: 4/11/2016
	input input_grant,
    input output_grant,
	input [8:0] instrMem_addr,
	input [31:0] instrMem_data,
	input instrMem_wea,
	//Data memory input signals, allows us to set d-mem
	input [7:0] dMem_addrTopLevel,
	input [63:0] dMem_dataTopLevel,
	input [2:0] modeTopLevel,
	input [63:0] in_data,
	input [7:0] in_ctrl,
	input in_wr,
	output in_rdy,
	output [63:0] out_data,
	output [7:0] out_ctrl,
	output out_wr,
	input out_rdy,
	// Update: 4/8/2016
	output reg thread_can_inc,
	
	output processor_control_out,
	output output_req,
	output PCsel,
	output [8:0]  jump_address,
	//Outputs to read imem and dmem
	output [31:0] dMem_outHiTopLevel,
	output [31:0] dMem_outLoTopLevel,
	output [31:0] iMem_outTopLevel
);
	/*INTERNAL SIGNALS AND REGISTERS*/
	
	//Internal Pipeline State 'Registers'
	//upper part is link_addr for jal and thread_num
	wire [42:0] pipe1; //Just contains the instruction
// for controller
//	-------------------------------------------------------------------------------------------------
//	|9  branch  9|8  jump  8|7  aluctrl  4|3  alusrc  3|2  memtoreg  2|1  memWrite  1|0  regWrite  0| 
// -------------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------------------------------------------
// 243 thread_num 242|241 MSB_B 240|239 MSB_A 238|237  jal  237|236  link_addr  228|227  r2Out_ctrl  220|219  r1Out_ctrl  212|211  controller  202|201  r1Out  138|137  r2Out  74|73  shamt  68|67  sign extended  4|3  destinationID  0|
// -------------------------------------------------------------------------------------------------------------------------------
	wire [243:0] pipe2;//contains 2 64 bit data results, 1 64 bit sign extended value, 
	                   //and 10 bit controller, 6 bit shamt, 4 bit destination ID, 8 bit control1 and control2.
// for controller
//	----------------------------------------------------------------------
//	|4  branch  4|3  jump  3|2  memtoreg  2|1  memWrite  1|0  regWrite  0|
// ----------------------------------------------------------------------
//	---------------------------------------------------------------------------------------------------------
//	230 thread_num 229|228 MSB_ALU 227|226  jal  226|225  link_addr  217|216  r2Out_ctrl  209|208  r1Out_ctrl  201|200  r1Out  137|136  controller  132|131  aluOut  68|67  r2Out  4|3  destinationID  0|
// ----------------------------------------------------------------------------------------------------------
	wire [230:0] pipe3;//Contains 3 64-bit data results, 4 bit destination ID, 5 bit controller, 8 bit control1
// for controller
//	-------------------------------
//	|1  memtoreg  1|0  regWrite  0|
//  -------------------------------
//	------------------------------------------------------------------------------------------
//	163 thread_num 162|161 MSB_ALU 160|159  jal  159|158  link_addr  150|149  memOut_ctrl  142|141  r1Out_ctrl  134|133  controller  132|131  aluOut  68|67  memOut  4|3  destinationID  0|
//  -------------------------------------------------------------------------------------------
	wire [163:0] pipe4;//Contains 2 64-bit data result, 4 bit destination ID, 2 bit controller, 8 bit control1
	
	//Actual Registers to hold items except data
	reg [1:0] thread_num_stage1;
	reg [1:0] thread_num_stage2;
	reg [1:0] thread_num_stage3;
	reg [1:0] thread_num_stage4;
	// since we remove output dffs of registerFile, so we need 2 74bit dffs instead of original 8 dffs.
	reg [71:0] r1Out_stage2;
	reg [71:0] r2Out_stage2;
	
	reg jal_stage3;
	reg jal_stage4;
	reg [8:0] link_addr_stage1;
	reg [8:0] link_addr_stage2;
	reg [8:0] link_addr_stage3;
	reg [8:0] link_addr_stage4;
	
	reg [7:0] control_stage2;
    reg [7:0] control_stage3;
    reg [7:0] r2Out_ctrl_stage3;
	reg [7:0] r1Out_ctrl_stage3;
	reg [7:0] r1Out_ctrl_stage4;
	reg [3:0] destinationID_stage2;
	reg [3:0] destinationID_stage3;
	reg [3:0] destinationID_stage4;
	reg memtoreg_stage3;
	reg memWrite_stage3;
	reg regWrite_stage3;
	reg branch_stage3;
	reg jump_stage3;
	reg memtoreg_stage4;
	reg regWrite_stage4;
	//Registers to hold non-delayed data
	reg [5:0]  shamt_stage2;
	reg [63:0] extended_data_stage2;
	reg [63:0] Rb_stage3;
	reg [63:0] Ra_stage3;
	reg [63:0] ALU_stage4;
	
    
	//Intermediate signals for i-mem
	wire [31:0] instrMemOut;
	
	//intermediate signals for register file
	wire [71:0] r1Out_thread0;
	wire [71:0] r2Out_thread0;
	wire [71:0] r1Out_thread1;
	wire [71:0] r2Out_thread1;
	wire [71:0] r1Out_thread2;
	wire [71:0] r2Out_thread2;
	wire [71:0] r1Out_thread3;
	wire [71:0] r2Out_thread3;
	// output of two 4to1 74-bit muxes
	wire [71:0] r1Out;
	wire [71:0] r2Out;
	
	wire [3:0] r1Addr;
	wire [3:0] r2Addr;
	wire [71:0] regfile_wdata;
	wire [3:0] regfile_waddr;
	
	wire regfile_wena0;
	wire regfile_wena1;
	wire regfile_wena2;
	wire regfile_wena3;
	
	wire [63:0] extended_data;
	//intermediate signals for controller
	wire [5:0] opcode;
	wire [3:0] aluctrl_c;
	wire alusrc;
	wire memtoreg;
	wire memWrite;
	wire regWrite;
	wire branch;
	wire jump;
	
	wire jal;
	
	//intermediate signals for alu
	wire [63:0] aluOut;
	wire [63:0] aluA;
	wire [63:0] aluB;
	wire [5:0] shamt;
	wire [3:0] aluctrl;  //driven by controller
	
	//intermediate signals for dmem
	wire [71:0] dMemOut;
	wire dMem_wena;
	wire [71:0] dMemIn;
	wire [7:0] dMemAddr;

	// intermediate signals for jal
	wire [8:0] jal_addr; 
	//intermediate signals for netfpga datapath
	wire valid_data;
	wire fifo_empty;
	wire fifo_read;
	reg [2:0]                     state, state_next;
   	reg                           in_pkt_body, in_pkt_body_next;
   	reg                           end_of_pkt, end_of_pkt_next;
   	reg                           begin_pkt, begin_pkt_next;
   	reg [2:0]                     header_counter, header_counter_next;
	reg [2:0]                     num_of_halt, num_of_halt_next;
	reg							  processor_control, processor_control_next;
	reg							  processor_done, processor_done_next;
	reg							  fifo_ready, fifo_ready_next;
	reg							  mem_pointer_reset, mem_pointer_reset_next;
   	parameter                     START = 3'b000;
   	parameter                     HEADER = 3'b001;
   	parameter                     PAYLOAD = 3'b010;
	parameter					  PROCESS = 3'b011;
	parameter					  FORWARD = 3'b100;
	//EDIT 4/20
	parameter					  REGISTER = 3'b101;
	parameter					  RESET = 3'b110;
		
	//ASSIGNS FOR INTERMEDIATE SIGNALS
	//assigns for regfile
	assign r1Addr = pipe1[21:18];// Ra
	assign r2Addr = pipe1[17:14];// Rb
	assign jal_addr = pipe4[158:150] + 1'b1;
	assign regfile_wdata = pipe4[159] ? {63'b0, jal_addr} : (pipe4[133] ? {pipe4[149:142], pipe4[67:4]} : {pipe4[141:134], pipe4[131:68]});//output of last stage
	
	assign regfile_wena0 = pipe4[132] && (!pipe4[163]) && (!pipe4[162]);//wr_reg after last pipeline stage
	assign regfile_wena1 = pipe4[132] && (!pipe4[163]) && (pipe4[162]);//wr_reg after last pipeline stage
	assign regfile_wena2 = pipe4[132] && (pipe4[163])  && (!pipe4[162]);//wr_reg after last pipeline stage
	assign regfile_wena3 = pipe4[132] && (pipe4[163])  && (pipe4[162]);//wr_reg after last pipeline stage
	assign r1Out = pipe1[42] ? (pipe1[41] ? r1Out_thread3 : r1Out_thread2) : (pipe1[41] ? r1Out_thread1 : r1Out_thread0);
	assign r2Out = pipe1[42] ? (pipe1[41] ? r2Out_thread3 : r2Out_thread2) : (pipe1[41] ? r2Out_thread1 : r2Out_thread0);
	
	assign regfile_waddr = pipe4[3:0]; //wreg1 after last pipeline stage
	//ASSIGN FOR CONTROLLER
	assign opcode = pipe1[31:26];
	//ASSIGN FOR SIGN 
   	assign extended_data = {{50{pipe1[13]}}, pipe1[13:0]}; //sign extension
	assign PCsel = (pipe3[136] && pipe3[4]) || pipe3[135];
	assign jump_address = pipe3[145:137];
	
	//ASSIGNS FOR ALU
	assign aluA = pipe2[201:138];
	assign aluB = pipe2[205] ? pipe2[67:4] : pipe2[137:74];
	assign shamt = pipe2[73:68];
	assign aluctrl = pipe2[209:206];
	
	//ASSIGNS FOR DMEM - DEPENDS ON MODE
	assign dMem_wena = modeTopLevel[2] ? pipe3[133] : (modeTopLevel[1] ? (modeTopLevel[0] ? 1'b1 : 1'b0) : 1'b0);
	assign dMemIn = modeTopLevel[2] ? {pipe3[216:209], pipe3[67:4]} : (modeTopLevel[1] ? (modeTopLevel[0] ? {8'b0,dMem_dataTopLevel} : 72'bX ) : 72'bX);//output of R2 after additional pipeline stage
	assign dMemAddr = modeTopLevel[2] ? pipe3[75:68] : (modeTopLevel[1] ? dMem_addrTopLevel : 8'bX); //lower 8 bits of r1 after additional pipeline stage
	
	//ASSIGNS FOR PIPES
	assign pipe1[42:41] = thread_num_stage1;
	assign pipe1[40:32] = link_addr_stage1;
	assign pipe1[31:0] = instrMemOut;//Already delayed by one clock through memory
	
	assign pipe2[243:242] = thread_num_stage2;
//	assign pipe2[241] = r2Out[73]; 
//	assign pipe2[240] = r2Out[72];
//	assign pipe2[239] = r1Out[73];
//	assign pipe2[238] = r1Out[72];
//	assign pipe2[241] = r2Out_stage2[73]; 
//	assign pipe2[240] = r2Out_stage2[72];
//	assign pipe2[239] = r1Out_stage2[73];
//	assign pipe2[238] = r1Out_stage2[72];
	assign pipe2[237] = jal;
	assign pipe2[236:228] = link_addr_stage2;
//	assign pipe2[227:220] = r2Out[71:64];
//    assign pipe2[219:212] = r1Out[71:64];
	assign pipe2[227:220] = r2Out_stage2[71:64];
    assign pipe2[219:212] = r1Out_stage2[71:64];
	assign pipe2[211:202] = {branch, jump, aluctrl_c, alusrc, memtoreg, memWrite, regWrite};
//	assign pipe2[201:138] = r1Out[63:0];
//	assign pipe2[137:74] = r2Out[63:0];     
	assign pipe2[201:138] = r1Out_stage2[63:0];
	assign pipe2[137:74] = r2Out_stage2[63:0]; 	
	assign pipe2[73:68] = shamt_stage2;
	assign pipe2[67:4] = extended_data_stage2;
	assign pipe2[3:0] = destinationID_stage2;

	assign pipe3[230:229] = thread_num_stage3;
//	assign pipe3[228] = aluOut[65];
//	assign pipe3[227] = aluOut[64];
	assign pipe3[226] = jal_stage3;
	assign pipe3[225:217] = link_addr_stage3;
	assign pipe3[216:209] = r2Out_ctrl_stage3;
	assign pipe3[208:201] = r1Out_ctrl_stage3;
   	assign pipe3[200:137] = Ra_stage3;
   	assign pipe3[136] = branch_stage3;
   	assign pipe3[135] = jump_stage3;
   	assign pipe3[134] = memtoreg_stage3;
	assign pipe3[133] = memWrite_stage3;
	assign pipe3[132] = regWrite_stage3;
	assign pipe3[131:68] = aluOut;
	assign pipe3[67:4] = Rb_stage3;
	assign pipe3[3:0] = destinationID_stage3;

	assign pipe4[163:162] = thread_num_stage4;
//	assign pipe4[161] = ALU_stage4[65];
//	assign pipe4[160] = ALU_stage4[64];
	assign pipe4[159] = jal_stage4;
	assign pipe4[158:150] = link_addr_stage4;
	assign pipe4[149:142] = dMemOut[71:64];
	assign pipe4[141:134] = r1Out_ctrl_stage4;
   	assign pipe4[133] = memtoreg_stage4;
	assign pipe4[132] = regWrite_stage4;
	assign pipe4[131:68] = ALU_stage4;
	assign pipe4[67:4] = dMemOut[63:0];
	assign pipe4[3:0] = destinationID_stage4;
	
	//Assigns for outputs
	assign iMem_outTopLevel = instrMemOut;
	assign dMem_outHiTopLevel = dMemOut[63:32];
	assign dMem_outLoTopLevel = dMemOut[31:0];
	//EDIT 4/12 
	assign output_req = processor_done;

	//Assigns for NetFPGA datapath
	assign out_data = dMemOut[63:0]; //always dMemOut, whether or not it is valid data yet
	assign out_ctrl = dMemOut[71:64];//always dMemOut, whether or not it is valid data yet
	assign out_wr = valid_data;//wait until we have valid data in memory, and processor is done
	assign in_rdy = fifo_ready;
	//EDIT 4/12 SO WE DON'T FORWARD UNTIL GRANTED
	assign fifo_read = out_rdy && output_grant;
	assign processor_control_out = processor_control;
	
	/*DATA PATH CONNECTIONS*/
	instrMem instructionMemory(
		.clka	(clk),
		.dina	(instrMem_data),//comes from top level
		.addra	(instrMem_addr),//comes from top level
		.wea	(instrMem_wea),//comes from top level
		.douta	(instrMemOut)
	);
	
	controller ctrller(
	   .opcode(opcode),
		.clk(clk),
		.aluctrl(aluctrl_c),
		.alusrc(alusrc),
		.memtoreg(memtoreg),
		.memWrite(memWrite),
		.regWrite(regWrite),
		.branch(branch),
		.jump(jump),
		.jal(jal)
    );
	//****************need four registerFiles********************
	gyn_regfile8 registerFile0(
		.r0addr(r1Addr), 
		.r1addr(r2Addr), 
		.wdata(regfile_wdata), 
		.read_en((!pipe1[42]) && (!pipe1[41])),
		.wena(regfile_wena0), 
		.waddr(regfile_waddr), 
		.CLK(clk), 
		.reset(reset), 
		.r0data(r1Out_thread0), 
		.r1data(r2Out_thread0)
	);
	gyn_regfile8 registerFile1(
		.r0addr(r1Addr), 
		.r1addr(r2Addr), 
		.wdata(regfile_wdata), 
		.read_en((!pipe1[42]) && (pipe1[41])),
		.wena(regfile_wena1), 
		.waddr(regfile_waddr), 
		.CLK(clk), 
		.reset(reset), 
		.r0data(r1Out_thread1), 
		.r1data(r2Out_thread1)
	);
	gyn_regfile8 registerFile2(
		.r0addr(r1Addr), 
		.r1addr(r2Addr), 
		.wdata(regfile_wdata), 
		.read_en((pipe1[42]) && (!pipe1[41])),
		.wena(regfile_wena2), 
		.waddr(regfile_waddr), 
		.CLK(clk), 
		.reset(reset), 
		.r0data(r1Out_thread2), 
		.r1data(r2Out_thread2)
	);
	gyn_regfile8 registerFile3(  
		.r0addr(r1Addr), 
		.r1addr(r2Addr), 
		.wdata(regfile_wdata), 
		.read_en((pipe1[42]) && (pipe1[41])),
		.wena(regfile_wena3), 
		.waddr(regfile_waddr), 
		.CLK(clk), 
		.reset(reset), 
		.r0data(r1Out_thread3), 
		.r1data(r2Out_thread3)
	);
	//********************************************************
	
	alu64 alu(
	    .A(aluA),
		.B(aluB),
		.shamt(shamt),
		.aluctrl(aluctrl),
		.CLK(clk),   
		.Z(aluOut)        // output port
//		.overflow()  // we are not using it right now
	);
	
	memfifo dataMemory(
		.clk(clk), 
        .fiforead(fifo_read), 
        .fifowrite(in_wr && input_grant), 
        .firstword(begin_pkt),
        .in_fifo({in_ctrl, in_data}), //netfpga packet data 
        .lastword(end_of_pkt), 
        .processor_addr_in(dMemAddr), 
        .processor_control(processor_control), //1 for processor control, 0 for netfpga - just FIFO buffering now, no processing 
        .processor_data_in(dMemIn), 
        .processor_wea(dMem_wena), 
        .rst((reset || mem_pointer_reset)),//reset head and tail to zero every packet 
        .out_fifo(dMemOut), //mem data out
        .packet_head(), //OUTPUT: beginning addr of packet 
        .packet_tail(), //OUTPUT: end addr of packet 
        .valid_data(valid_data),   //OUTPUT
        .fifo_empty(fifo_empty)//Output, tells when our fifo is ready for a new packet
	);
	//PIPE LOGIC
	
	//pipelogic with additional registered delay added
	always @ (posedge clk) begin
	if(reset)
	begin
		thread_num_stage1 <= 0;
		thread_num_stage2 <= 0;
		thread_num_stage3 <= 0;
		thread_num_stage4 <= 0;
		r1Out_stage2 <= 0;
		r2Out_stage2 <= 0;
	
	    destinationID_stage2 <= 0;
		destinationID_stage3 <= 0;
		destinationID_stage4 <= 0;
		memtoreg_stage3 <= 0;
		memWrite_stage3 <= 0;
		regWrite_stage3 <= 0;
		branch_stage3 <= 0;
		jump_stage3 <= 0;
		memtoreg_stage4 <= 0;
		regWrite_stage4 <= 0;
		shamt_stage2 <= 0;
		extended_data_stage2 <= 0;
		Rb_stage3 <= 0;
		Ra_stage3 <= 0;
		ALU_stage4 <= 0;
		control_stage2 <= 0;
		control_stage3 <= 0;
		
		r2Out_ctrl_stage3 <= 0;
		r1Out_ctrl_stage3 <= 0;
		r1Out_ctrl_stage4 <= 0;
		
	    jal_stage3 <= 0;
	    jal_stage4 <= 0;
	    link_addr_stage1 <= 0;
	    link_addr_stage2 <= 0;
	    link_addr_stage3 <= 0;
	    link_addr_stage4 <= 0;
	end
	
	else begin	
		thread_num_stage1 <= thread_num;
		thread_num_stage2 <= pipe1[42:41];
		thread_num_stage3 <= pipe2[243:242];
		thread_num_stage4 <= pipe3[230:229];
		r1Out_stage2 <= r1Out;
		r2Out_stage2 <= r2Out;
	
		destinationID_stage2 <= pipe1[25:22];
		destinationID_stage3 <= pipe2[3:0];
		destinationID_stage4 <= pipe3[3:0];
		memtoreg_stage3 <= pipe2[204];
		memWrite_stage3 <= pipe2[203];
		regWrite_stage3 <= pipe2[202];
		memtoreg_stage4 <= pipe3[134];
		regWrite_stage4 <= pipe3[132];
		shamt_stage2 <= pipe1[13:8];
		extended_data_stage2 <= extended_data;
		Rb_stage3 <= pipe2[137:74];
		ALU_stage4 <= pipe3[131:68];
		
		branch_stage3 <= pipe2[211];
		jump_stage3 <= pipe2[210];
		Ra_stage3 <= pipe2[201:138];
		
		control_stage2 <= pipe4[141:134];
		control_stage3 <= pipe2[219:212];
		
		r2Out_ctrl_stage3 <= pipe2[227:220];
		r1Out_ctrl_stage3 <= pipe2[219:212];
		r1Out_ctrl_stage4 <= pipe3[208:201];
		
	    jal_stage3 <= pipe2[237];
	    jal_stage4 <= pipe3[226];
	    link_addr_stage1 <= instrMem_addr;
	    link_addr_stage2 <= pipe1[40:32];
	    link_addr_stage3 <= pipe2[236:228];
	    link_addr_stage4 <= pipe3[225:217];
		
	end
	
	end
	
	//FSM
	always @(*) begin
        state_next = state;
	    header_counter_next = header_counter;
		num_of_halt_next = num_of_halt;
	    end_of_pkt_next = end_of_pkt;    // Maybe this can be FIFO FULL signal. If end_of_pkt = 1, then FIFO IS full. Otherwise, it is not full.
	    in_pkt_body_next = in_pkt_body;  // Maybe this is the signal we can send to processor telling the data is ready to be processed.
	                                     // DON'T ingore header since we want to change information like TTL in the header
	    begin_pkt_next = begin_pkt;  // We can use this signal. In original ids.v the design for FIFO is circular, which means that
		processor_control_next = processor_control; // after we finish processing the first packet and the second packet is about to come, we do not reset the tailPtr.
		processor_done_next = processor_done;
		fifo_ready_next = fifo_ready;
		mem_pointer_reset_next = mem_pointer_reset;
		// Update:4/8/2016
		case(state)
			START: begin
				thread_can_inc = 1'b0;
				if ((in_ctrl != 1'b0) && input_grant) begin // If control bits are not 0, then we have new coming packet.
					state_next = HEADER;
					begin_pkt_next = 1'b1;
					end_of_pkt_next = 1'b0;
				end
				else if (!modeTopLevel[2]) begin
					state_next = REGISTER;
					fifo_ready_next = 1'b0;
					begin_pkt_next = 1'b0;
					end_of_pkt_next = 1'b1;
				end
			end
			HEADER: begin
				begin_pkt_next = 1'b0;
				if (in_ctrl == 1'b0) begin
					 header_counter_next = header_counter + 1'b1;
					if (header_counter_next == 2'b11) begin
						 state_next = PAYLOAD;
					end
				end
				//EDIT 4/20: drop packet and listen to reg interface
				if (!modeTopLevel[2]) begin
					state_next = REGISTER;
					state_next = REGISTER;
					header_counter_next = 1'b0;
					end_of_pkt_next = 1'b1;
					fifo_ready_next = 1'b0;
				end
			end
			PAYLOAD: begin
				if (in_ctrl != 1'b0) begin
					state_next = PROCESS;
					header_counter_next = 1'b0;
					end_of_pkt_next = 1'b1;
					fifo_ready_next = 1'b0;
				end 
				//EDIT 4/20
				//Stop receiving packet and listen to reg interface
				if(!modeTopLevel[2]) begin
					state_next = REGISTER;
					header_counter_next = 1'b0;
					end_of_pkt_next = 1'b1;
					fifo_ready_next = 1'b0;
				end
			end
			PROCESS: begin
				processor_control_next = 1'b1;
				if(modeTopLevel[2]) begin //Can only leave state if we are in execute mode
					thread_can_inc = 1'b1;
					if(opcode == 6'b111111) begin
						num_of_halt_next = num_of_halt + 1'b1;
					end
					if(num_of_halt_next == 3'b100) begin
						processor_done_next = 1'b1;
						thread_can_inc = 1'b0;
						processor_control_next = 1'b0;
						state_next = FORWARD;
					end
				end
				//EDIT 4/20: Pause if not in execute mode
				else begin
					thread_can_inc = 1'b0;
				end
			end
			FORWARD: begin
				thread_can_inc = 1'b0;
				if(fifo_empty) begin //once we are done sending packet out, then ask for next
					mem_pointer_reset_next = 1'b1;
					//wait until we finish forwarding so we don't stall pipeline
					if(!modeTopLevel[2]) begin
						state_next = REGISTER;
					end
					else begin
						state_next = RESET;
					end
					processor_done_next = 1'b0; //processor not done again
				end

			end
			REGISTER: begin
				//EDIT 4/20
				processor_control_next=1'b1;
				thread_can_inc = 1'b0;
				if(modeTopLevel[2]) begin
					//Back to execute mode, so go back to reset then start state
					state_next = RESET;
					mem_pointer_reset_next=1'b1;
					processor_control_next = 1'b0;

				end
			end
			RESET: begin //this is just a dummy one clock state to reset packet pointers, and we can use it for other things later if we want
				num_of_halt_next = 3'b0;
				mem_pointer_reset_next = 1'b0;
				fifo_ready_next = 1'b1;
				// Update:4/8/2016
				state_next = START;
				//EDIT 4/20
				if(!modeTopLevel[2]) begin
					fifo_ready_next = 1'b0;
					state_next = REGISTER;
				end
			end
		endcase			
	end
	
	always @(posedge clk) begin
        if(reset) begin
            header_counter <= 0;
			num_of_halt <= 0;
            state <= START;
            begin_pkt <= 0;
            end_of_pkt <= 0;
			processor_control <= 0;
			processor_done <= 0;
			fifo_ready <= 1'b1;
			mem_pointer_reset <=0;
        end else begin
            header_counter <= header_counter_next;
			num_of_halt <= num_of_halt_next;
            state <= state_next;
            begin_pkt <= begin_pkt_next;
            end_of_pkt <= end_of_pkt_next;
			processor_control <= processor_control_next;
			processor_done <= processor_done_next;
			fifo_ready <= fifo_ready_next;
			mem_pointer_reset <= mem_pointer_reset_next;
        end // else: !if(reset)
    end // always @ (posedge clk)   

endmodule
