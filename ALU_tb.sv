////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:12:37 10/27/2011
// Design Name:   ALU
// Module Name:   /department/home/leporter/Xilinx/lab_basics/ALU_tb.v
// Project Name:  lab_basics
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
import definitions::*;
module ALU_tb;

// Inputs
  bit [ 1:0] OP;
  bit [15:0] INPUTA;
  bit [15:0] INPUTB;

// Outputs
  wire [15:0] OUT;
  wire        OVERFLOW;

	// Instantiate the Unit Under Test (UUT)
  ALU uut (
		.OP(OP), 
		.INPUTA(INPUTA), 
		.INPUTB(INPUTB), 
		.OUT(OUT), 
		.OVERFLOW(OVERFLOW)
	);

initial begin
// Wait 100 ns for global reset to finish
  #100ns;
        
// Add stimulus here
  INPUTA = 8'h44;
  INPUTB = 8'h44;
  #20ns  OP = kSUB;
  #20ns	 OP = kADD;
  #20ns	 INPUTB = 8'h22;
  OP = kPASS_INPUTB;
end

endmodule

