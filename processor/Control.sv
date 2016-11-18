//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:08:46 02/16/2012 
// Design Name: 
// Module Name:    Control 
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
module Control(
    input        [8:0] Instruction,
    output logic       Format,
    output logic       AccRead,
    output logic [1:0] RegWrite,
    output logic       Branch,
    output logic [1:0] ALUSrcB,
    output logic       MemWrite,
    output logic [1:0] MemtoReg,
    output logic [3:0] ALUOp,
	output logic       HALT
    );

	// TODO: Add each instruction to the case switch and 
	//       set the control wires to the appropriate values.
	always_comb	begin
		case(Instruction)
		  default: HALT = 1;
		endcase
	end

endmodule
