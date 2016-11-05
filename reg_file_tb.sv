// Company: 
// Engineer:
//
// Create Date:   13:31:49 10/27/2011
// Design Name:   reg_file
// Module Name:   reg_file_tb.v
// Project Name:  lab_basics
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: reg_file
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////

module reg_file_tb;
	parameter DT = 3,
	          WT = 8;
// DUT Input Drivers
	bit           CLK;	      // bit can be only 0, 1 (no x or z)
	bit           AccRead;
   	bit [1:0]     RegWrite;    // bit self-initializes to 0, not x (handy)
	bit [ DT-1:0] srcA,
	              srcB;
	bit [ WT-1:0] writeValue;

// DUT Outputs
	wire [WT-1:0] ReadA,
                 ReadB;

// Instantiate the Unit Under Test (UUT)
	reg_file #(.W(WT),.D(DT)) uut(
	  .CLK(CLK),
	  .AccRead(AccRead),
	  .RegWrite(RegWrite)   , 
	  .srcA(srcA)       , 
	  .srcB(srcB)       , 
	  .writeValue(writeValue) , 
	  .ReadA(ReadA)      , 
	  .ReadB(ReadB)      
	);

	initial begin
// Initialize Inputs done for us by "bit"

// Wait 40 ns for global reset to finish
	  #100ns;

// Clear A and B
	  srcA       =  3'b000;
	  srcB       =  3'b010;
	  writeValue =  8'b00000000;
	  RegWrite   =  1;  // This should write to A
	  #20ns;
	  writeValue =  8'b00000000;
	  RegWrite   =  2;  // This should write to B
          #20ns;
		        
// Add stimulus here
// check if writing works
	  srcA       =  3'b000;
	  srcB       =  3'b010;
	  writeValue =  8'b10101010;
	  RegWrite   =  1;  // This should write to A
	  #20ns;
	  
//verify writing without RegWrite has no impact
	  RegWrite   =  2'b00;  // Values should stay the same
	  writeValue =  8'hABCD;
	  #20ns $stop;	
	end
always begin
  #10ns CLK = 1;
  #10ns CLK = 0;
end      
endmodule

