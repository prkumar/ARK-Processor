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
  input [3:0] OP,
  input [7:0] INPUTA,
  input [7:0] INPUTB,
  output logic [7:0] OUT,
  output logic OVERFLOW
    );
	 
  op_mne op_mnemonic;
	
  always_comb begin
	
	case(OP)
	 kPASS_INPUTA: OUT = INPUTA;
    kSHIFT_LEFT: OUT = INPUTA << 1;
    kSHIFT_RIGHT: OUT = INPUTA >> 1;
    kKEEP_SMALLER: OUT = (INPUTA > INPUTB) ? INPUTA : INPUTB;
	 kSHIFT_ON: OUT = (INPUTA << 1) | (INPUTB & 8'b00000001);
	 kADD: OUT = INPUTA+INPUTB;
	 kINPUTA_IS_ZERO: OVERFLOW = (INPUTA == 'b0) ? 'b1 : 'b0;
	 kPASS_INPUTB: OUT = INPUTB;
	 kINC_INPUTA: OUT = INPUTA + 1;
	 kDEC_INPUTA: OUT = INPUTA - 1;
	 kCLEAR: OUT = 'b00000000;
	 kSUB: OUT = INPUTA - INPUTB;
	 default: OUT = 0;
	endcase
	 
	//$display("ALU Out %d \n",OUT);
    op_mnemonic = op_mne'(OP);

  end

endmodule
