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
	// We use 2**3, 8-bit registers.
	parameter DT = 3,
	          WT = 8;

	// Register file inputs
	bit           CLK;	      
	bit           AccRead;
   	bit [1:0]     RegWrite; 
	bit [DT-1:0]  ReadReg1,
	              ReadReg2;
	bit [WT-1:0]  WriteValue;

	// Register file outputs
	wire [WT-1:0] ReadData1,
                  ReadData2,
                  Compare,
                  Accumulator;


	// Instantiate the Unit Under Test (UUT)
	reg_file #(.W(WT),.D(DT)) uut(
	  .CLK(CLK)                ,
	  .AccRead(AccRead)        ,
	  .RegWrite(RegWrite)      , 
	  .ReadReg1(ReadReg1)      , 
	  .ReadReg2(ReadReg2)      , 
	  .WriteValue(WriteValue)  , 
	  .ReadData1(ReadData1)    , 
	  .ReadData2(ReadData2)    ,
	  .Compare(Compare)        ,
	  .Accumulator(Accumulator)
	);

	initial begin
		// Initialize Inputs done for us by "bit"

		// Wait 100 ns for global reset to finish
		// TODO: implement the global reset...
		#100ns;
			        
		// Add stimulus here
		// check if writing works
		ReadReg1   =  3'b000;  // $accumulator
		ReadReg2   =  3'b010;  // $t1
		WriteValue =  100;
		RegWrite   =  1;  // This should write to A
		#20ns;
		  
		// Verify writing without RegWrite has no impact
		RegWrite   =  2'b00;  // Values should stay the same
		WriteValue =  44;
		#20ns $stop;	
	end

	always begin
	  #10ns CLK = 1;
	  #10ns CLK = 0;
	end      

endmodule

