`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:06:07 02/23/2016 
// Design Name: 
// Module Name:    controller 
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
module controller(
    input [5:0] opcode,
	 input clk,
    output reg [3:0] aluctrl,
    output reg alusrc,
    output reg memtoreg,
    output reg memWrite,
    output reg regWrite,
	 output reg branch,
	 output reg jump,
	 
	 // New Update: 3/9/2016
	 output reg jal
    );

reg [3:0] ctrl;
reg src;
reg M2R;
reg memW;
reg regW;
reg j;
reg br;
// New Update: 3/9/2016
reg jAndLink;

// Functions include:    0000    add
//						 0001    subtract
//						 0010	 bitwise AND
//						 0011	 bitwise OR
//                       0100    bitwise XOR
//						 0101	 bitwise XNOR
//    				 	 0110    compare
//                       0111    greater than(GT)
//                       1000    equal or greater than(GE)
//						 1001	 logical left shift <<   /*************Modified**************/ logical: add zeros
//                       1010    logical right shift >> /*************Modified**************/ 
//                       1011    substring comparison
//                       1100    shift-then-compare	
always @(*) begin
    ctrl = 4'b0000;
	 src = 1'b0;
	 memW = 1'b0;
	 regW = 1'b0;
	 M2R = 1'b0;
	 j = 1'b0;
	 br = 1'b0;
	 // New Update: 3/9/2016
	 jAndLink = 1'b0;
	 case(opcode)
	     6'b00_0000: begin    //0. NOOP (add R0 R0 R0)
				regW = 1'b1;
		  end
//		  6'b00_0001: begin   //1.  STORE Rb, (Ra)
//				src = 1'b1;
//				memW = 1'b1;
//				M2R = 1'bX;
//		  end
//		  6'b00_0010: begin   //2.  STORE Rb, #i
//				src = 1'b1;
//				memW = 1'b1;
//				M2R = 1'bX;
//		  end
        6'b00_0011: begin   //3.  STORE Rb, #i(Ra)
				src = 1'b1;
				memW = 1'b1;
				M2R = 1'bX;
		  end
//		  6'b00_0100: begin   //4.  LOAD Rd, (Ra)
//				src = 1'b1;
//				regW = 1'b1;
//				M2R = 1'b1;
//		  end
//		  6'b00_0101: begin   //5.  LOAD Rd, #i
//				src = 1'b1;
//				regW = 1'b1;
//				M2R = 1'b1;
//		  end
		  6'b00_0110: begin   //6.  LOAD Rd, #i(Ra)
				src = 1'b1;
				regW = 1'b1;
				M2R = 1'b1;
		  end
//		  6'b00_0111: begin   //7.  CMP Ra, Rb
//            
//		  end
		  6'b00_1000: begin   //8.  JMP Rb
            ctrl = 4'bXXXX;
				j = 1;
				br = 1'bX;
				//need to add other signals
				src = 1'bX;
				M2R = 1'bX;
		  end
		  6'b00_1001: begin   //9.  JC  Ra (I type)
            ctrl = 4'bXXXX;
				src = 1'bX;
				br = 1;
				M2R = 1'bX;
		  end
//		  6'b00_1010: begin   //10. JNE Ra
//        
//		  end
//		  6'b00_1011: begin   //11. JMP #i
 //       
//		  end
//		  6'b00_1100: begin   //12. JE  #i
 //       
//		  end
//		  6'b00_1101: begin   //13. JNE #i
 //       
//		  end
		  6'b00_1110: begin   //14. ADD Rd, Ra, Rb
				regW = 1'b1;
		  end
		  6'b00_1111: begin   //15. ADD Rd, Ra, #i
  				src = 1'b1;
				regW = 1'b1;
		  end
//		  6'b01_0000: begin   //16. MOVE Rd, Ra(ADD Rd, Ra, R0)
//				regW = 1'b1;
//		  end
		  6'b01_0001: begin   //17. SUB Rd, Ra, Rb
            ctrl = 4'b0001;
				regW = 1'b1;
		  end
		  6'b01_0010: begin   //18. SUB Rd, Ra, #i
            ctrl = 4'b0001;
				src = 1'b1;
				regW = 1'b1;
		  end
		  6'b01_0011: begin   //19. AND Rd, Ra, Rb
           ctrl = 4'b0010;
				regW = 1'b1;
		  end
		  6'b01_0100: begin   //20. OR Rd, Ra, Rb
            ctrl = 4'b0011;
				regW = 1'b1;
		  end
		  6'b01_0101: begin   //21. XOR Rd, Ra, Rb
	            ctrl = 4'b0100;
				regW = 1'b1;
		  end
//		  6'b01_0110: begin   //22. XNOR Rd, Ra, Rb
//            ctrl = 4'b0101;
//				regW = 1'b1;
//		  end
//		  6'b01_0111: begin   //23. LShift Rd, Ra, #shift
//            ctrl = 4'b1011;
//				src = 1'bX;
//				regW = 1'b1;
//		  end
		  6'b01_1000: begin   //24. RShift Rd, Ra, #shift
            ctrl = 4'b1100;
				src = 1'bX;
				regW = 1'b1;
		  end
		  6'b01_1001: begin   //25. AND Rd, Ra, #i
            ctrl = 4'b0010;
				src = 1'b1;
				regW = 1'b1;
		  end
		  6'b01_1010: begin   //26. OR Rd, Ra, #i
            ctrl = 4'b0011;
				src = 1'b1;
				regW = 1'b1;
		  end
		  6'b01_1011: begin   //27. XOR Rd, Ra, #i
            ctrl = 4'b0100;
				src = 1'b1;
				regW = 1'b1;
		  end
//		  6'b01_1100: begin   //28. XNOR Rd, Ra, #i
 ///           ctrl = 4'b0101;
//				src = 1'b1;
//				regW = 1'b1;
//		  end
		  6'b01_1101: begin   //29. SLT Rd, Ra, Rb
            ctrl = 4'b1001;
				regW = 1'b1;
		  end
//		  6'b01_1110: begin   //30. SLE Rd, Ra, Rb
 //           ctrl = 4'b1010;
//				regW = 1'b1;
//		  end
//		  6'b01_1111: begin   //31. SGT Rd, Ra, Rb
 //           ctrl = 4'b0111;
//				regW = 1'b1;
//		  end
//		  6'b10_0000: begin   //32. SGE Rd, Ra, Rb
 //           ctrl = 4'b1000;
//				regW = 1'b1;
//		  end
		  6'b10_0001: begin   //33. SEQ Rd, Ra, Rb
            ctrl = 4'b0110;
				regW = 1'b1;
		  end
		  6'b10_0010: begin   //34. SNE Rd, Ra, Rb
            ctrl = 4'b1101;
			regW = 1'b1;
		  end
		  
//		  6'b11_1010: begin   // BIT Rd, Ra, Rb; Usage: Rd = Ra[Rb];
//		    ctrl = 4'b1110;
//			regW = 1'b1;
//		  end
//		  6'b11_1001: begin   // EXPAND Rd, Ra, Rb; Usage: Rd = 64{Ra[Rb]};
//		    ctrl = 4'b1111;
//			regW = 1'b1;
//		  end
		  
		  6'b11_1011: begin   // JAL Ra (Rd should always be 14)
		    j = 1'b1;
		    jAndLink = 1'b1;
			regW = 1'b1;
			br = 1'bX;
			src = 1'bX;
			M2R = 1'bX;
		  end
		  
		  default: begin
		      ctrl = 4'bXXXX;
			  src = 1'bX;
			  memW = 1'bX;
			  regW = 1'bX;
			  M2R = 1'bX;
			  // New Update: 3/9/2016
			  j = 1'b0;
			  jAndLink = 1'b0;
			  br = 1'b0;
		  end
    endcase
end

always @(posedge clk) begin
	     aluctrl <= ctrl;
	     alusrc <= src;
	     memtoreg <= M2R;
	     memWrite <= memW;
	     regWrite <= regW;
		 jump <= j;
		 branch <= br;
		 
		 jal <= jAndLink;

end

endmodule
