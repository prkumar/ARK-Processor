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
	Out = 0;
	CarryOut = 0;
	case(ALUOp)
    	 kPASS_A:       {CarryOut, Out} = A;
       kSHIFT_LEFT:   {CarryOut, Out} = A << 1;
       kSHIFT_RIGHT:  {Out, CarryOut} = A >> 1;
       kKEEP_SMALLER: Out             = (A > B) ? A : B;
    	 kSHIFT_ON:     {CarryOut, Out} = (A << 1) | (B & 8'b00000001);
    	 kADD:          {CarryOut, Out} = A + B;
    	 kA_IS_ZERO:    CarryOut        = (A == 'b0) ? 'b1 : 'b0;
    	 kPASS_B:       Out             = B;
    	 kINC_A:        {CarryOut, Out} = A + 1;
    	 kDEC_A:        {CarryOut, Out} = A - 1;
    	 kCLEAR:        Out             = 'b00000000;
    	 kSUB:          {CarryOut, Out} = A - B;
       kPARALLEL:     CarryOut        = (A & 8'b11110000 == ((B && 8'b00001111) << 4)) || (A & 8'b01111000 == ((B && 8'b00001111) << 3)) || (A & 8'b00111100 == ((B && 8'b00001111) << 2)) || (A & 8'b00011110 == ((B && 8'b00001111) << 1)) || (A & 8'b00111100 == ((B && 8'b00001111) << 2)) || (A & 8'b00001111 == (B && 8'b00001111))
    	 default: Out = 0;
	endcase
	 
    // TODO: What does this mean?
	//$display("ALU Out %d \n",Out);
  op_mnemonic = op_mne'(ALUOp);

  end

endmodule
