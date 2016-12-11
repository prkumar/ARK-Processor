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
	// Out = 0;
	// CarryOut = 0;
	case(ALUOp)
    	 kPASS_A:       Out = A;
       kSHIFT_LEFT:   {CarryOut, Out} = {1'b0, A} << 1;
       kSHIFT_RIGHT:  {Out, CarryOut} = {A, 1'b0} >> 1;
       kKEEP_SMALLER: Out             = (A > B) ? B : A;
    	 kSHIFT_ON:     {CarryOut, Out} = ({1'b0, A} << 1) | (B & 8'b00000001);
    	 kADD:          {CarryOut, Out} = A + B;
    	 kA_IS_ZERO:    CarryOut        = (A == 8'b0) ? 1'b0 : 1'b1;
    	 kPASS_B:       Out             = B;
    	 kINC_A:        {CarryOut, Out} = A + 1;
    	 kDEC_A:        {CarryOut, Out} = A - 1;
    	 kCLEAR:        Out             = 8'b00000000;
    	 kSUB:          {CarryOut, Out} = A - B;
       kPARALLEL:     begin
           if (B[7:4] == A[3:0] || B[6:3] == A[3:0] || B[5:2] == A[3:0] || B[4:1] == A[3:0] || B[3:0] == A[3:0])
              CarryOut = 1;
           else 
              CarryOut = 0;
       end
    	 default: Out = 0;
	endcase
	 
    // TODO: What does this mean?
	//$display("ALU Out %d \n",Out);
  op_mnemonic = op_mne'(ALUOp);

  end

endmodule
