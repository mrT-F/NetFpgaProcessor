`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//  
// 64-bit VERILOG ALU
// Functions include:    0000    add
//						 0001    subtract
//						 0010	 bitwise AND
//						 0011	 bitwise OR
//                       0100    bitwise XOR
//						 0101	 bitwise XNOR
//    				 	 0110    compare
//                       0111    greater than(GT)
//                       1000    equal or greater than(GE)
//                       1001    less than(LT)
//                       1010    equal or less than(LE)
//						       1011	   logical left shift <<   /*************Modified**************/ logical: add zeros
//                       1100    logical right shift >> /*************Modified**************/ 
//                       1101    substring comparison
//                       1110    shift-then-compare	 
//////////////////////////////////////////////////////////////////////////////////
module alu64(
    input  [63:0]  A,
    input  [63:0]  B,
	input  [5:0]   shamt,
//	input  [5:0]   high,      // used to set upper bound of string
//	input  [5:0]   low,       // used to set lower bound of string
    input  [3:0]   aluctrl,
	input          CLK,
    output reg [63:0]  Z
//    output reg     overflow // used to detect overflow
);
	 
reg [63:0] alu_out;
//reg alu_overflow;

//ALU COMBINATIONAL LOGIC
always @(*) begin
//	alu_overflow = 1'b0;      /**********Modified*********/
	alu_out = 64'b0;          /**********Modified*********/
	case(aluctrl)
		4'b0000:  begin //add operation
						alu_out = A + B; 
//						if( !A[63] && !B[63] && alu_out[63]) //two positive numbers became negative
//						begin
//							alu_overflow=1'b1;
//						end
//						else if ( A[63] && B[63] && !alu_out[63]) //two negative numbers became positive
//						begin
//							alu_overflow=1'b1;
//						end
				 end
		4'b0001:  begin //subtract operation (signed
						alu_out = A - B; 
//						if( A[63] && !B[63] && !alu_out[63]) //negative minus positive became positive /**********Modified*********/
//						begin
//							alu_overflow=1'b1;
//						end
//						else if ( !A[63] && B[63] && alu_out[63]) //positive minus negative became negative /**********Modified********/
//						begin
//							alu_overflow=1'b1;
//						end
				 end
		4'b0010:  begin //bitwise AND
						alu_out = A & B; 
				  end
		4'b0011:  begin //bitwise OR
						alu_out = A | B; 
				  end
		4'b0100:  begin //bitwise XOR
						alu_out= A ^ B;
				 end				  
//		4'b0101:  begin //bitwise XNOR
//						alu_out= A ^~ B;
//				 end
		4'b0110:  begin //Compare operation - alu_overflow goes high if equal
						if ( A == B ) 
						begin
							alu_out[0] = 1'b1;
						end
				  end
//		4'b0111: begin //greater than - alu_overflow goes high 
//				        if (A > B) begin
//						    alu_out[0] = 1'b1;
//						end
//				 end
//		4'b1000: begin //equal or greater than - alu_overflow goes high
//				        if (A >= B) begin
//						    alu_out[0] = 1'b1;
//						end
//				 end
		4'b1001: begin //less than - alu_overflow goes high 
				        if (A < B) begin
						    alu_out[0] = 1'b1;
						end
				 end
//		4'b1010: begin //equal or less than - alu_overflow goes high
//				        if (A <= B) begin
//						    alu_out[0] = 1'b1;
//						end
//				 end
//		4'b1011: begin //Left logical shift operation
//						alu_out = A << shamt;
//				 end
		4'b1100: begin //Right logical shift operation
                        alu_out = A >> shamt;				      
				 end
		4'b1101:    begin //Not equal
				        if (A != B) begin
						    alu_out[0] = 1'b1;
						  end
	    				end
//		4'b1110: begin // Bit Selection
//					alu_out[0] = A[B[5:0]];
//				 end
//		4'b1111: begin // Expand
//					alu_out = {66{A[B[5:0]]}};
//				 end
//		4'b1101:    begin //Substring comparison
//				        if ((A << (63-high)) >> (63+low-high) == (B << (63-high)) >> (63+low-high)) begin
//						    alu_overflow = 1'b1;
//						  end
//	    				end
//		4'b1110:    begin //left shift and compare
//				        //reg A_temp = A << shamt;
//						//reg B_temp = B << shamt;
//						if ((A << shamt) == (B << shamt)) begin   // not sure if this is best, or can we use just simple if ((A << shamt) == (B << shamt))
//						    alu_out[0] = 1'b1;   
//						end
//				 end
//		4'b1111:    begin //right shift and compare
//
//						if ((A >> shamt) == (B >> shamt)) begin
//						    alu_out[0] = 1'b1;
//						end
//				 end
		default: begin
					//Unspecified behavior
						alu_out = 64'bX;     /********Modified*********/
//						alu_overflow = 1'bX;
					end
	endcase
end
//REGISTERED OUTPUT OF ALU LOGIC
always @(posedge CLK) begin
	    Z <= alu_out;
//	    overflow <= alu_overflow;
end
	
endmodule
