//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:04:22 10/27/2011 
// Design Name: 
// Module Name:    ALU 
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
import definitions::*;
module ALU(
    // control signal
    input [3:0] ALUOp,

    // ALU inputs
    input [7:0] A,
    input [7:0] B,

    // ALU outputs
    output logic [7:0] Out,
    output logic CarryOut
    );
	 
  op_mne op_mnemonic;
	
  always_comb begin
    // TODO: Figure out how to do the carry-out logic
	
	case(OP)
    	 kPASS_A: Out = A;
         kSHIFT_LEFT: Out = A << 1;
         kSHIFT_RIGHT: Out = A >> 1;
         kKEEP_SMALLER: Out = (A > B) ? A : B;
    	 kSHIFT_ON: Out = (A << 1) | (B & 8'b00000001);
    	 kADD: Out = A + B;
    	 kA_IS_ZERO: CarryOut = (A == 'b0) ? 'b1 : 'b0;
    	 kPASS_B: Out = B;
    	 kINC_A: Out = A + 1;
    	 kDEC_A: Out = A - 1;
    	 kCLEAR: Out = 'b00000000;
    	 kSUB: Out = A - B;
    	 default: Out = 0;
	endcase
	 
    // TODO: What does this mean?
	//$display("ALU Out %d \n",Out);
    op_mnemonic = op_mne'(ALUOp);

  end

endmodule
