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
  bit [3:0]  ALUOp;
  bit [7:0]  InputA;
  bit [7:0]  InputB;

// Outputs
  wire [7:0] Out;
  wire       CarryOut;

	// Instantiate the Unit Under Test (UUT)
  ALU uut (
		.ALUOp,
		.A(A), 
		.B(B), 
		.Out(Out), 
		.CarryOut(CarryOut)
	);

initial begin
// Wait 30 ns for global reset to finish
  #30ns;
		  
  // Add stimulus here
  ALUOp = kPASS_INPUTB;
  A     = 8'b00000000;
  B     = 8'b00000001;
  #20ns	 OP = kADD;
  #20ns	 INPUTB = 8'h22;
  ALUOp = kPASS_INPUTA;
end

endmodule

