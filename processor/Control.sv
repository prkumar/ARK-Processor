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
    output logic       OverflowSwitch,
	output logic       HALT
    );

	always_comb	begin
	  Format     = 1;
	  AccRead    = 0;
	  RegWrite   = 0;    // 2 is 0 don't care
	  Branch     = 0; 
	  ALUSrcB    = 0;    // use mem read
	  ALUOp      = kPASS_A;
	  MemWrite   = 0;
	  MemtoReg   = 0;
    OverflowSwitch = 0;
	  HALT       = 0;
	
		if (Instruction[8:2] == 7'b1000000) begin // load
              Format     = 1;
              AccRead    = 0;
              RegWrite   = 1;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kPASS_A;
              MemWrite   = 0;
              MemtoReg   = 1;
              HALT       = 0;
              OverflowSwitch = 0;
          end
    else if (Instruction[8:2] == 7'b1000001) begin // store
              Format     = 1;
              AccRead    = 1;
              RegWrite   = 2;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kPASS_A;
              MemWrite   = 1;
              MemtoReg   = 0;
              HALT       = 0;
              OverflowSwitch = 0;
         end
    else if (Instruction[8:2] == 7'b0000000) begin  // parallel_comp
              Format     = 1;
              AccRead    = 0;
              RegWrite   = 1;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 1;    // use mem read
              ALUOp      = kKEEP_SMALLER;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
              OverflowSwitch = 0;
          end
    else if (Instruction[8:2] == 7'b0000010) begin  // addo
              Format     = 1;
              AccRead    = 0;
              RegWrite   = 1;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 2;    // use mem read
              ALUOp      = kADD;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
              OverflowSwitch = 0;
          end
    else if (Instruction[8:2] == 7'b0000011) begin  // is_zero
              Format     = 1;
              AccRead    = 0;
              RegWrite   = 0;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kA_IS_ZERO;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
              OverflowSwitch = 0;
          end
    else if (Instruction[8:3] == 6'b100010) begin  // copy
              Format     = 0;
              AccRead    = 1;
              RegWrite   = 2;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kPASS_A;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
              OverflowSwitch = 0;
          end
    else if (Instruction[8:3] == 6'b100011) begin  // paste
              Format     = 0;
              AccRead    = 1;
              RegWrite   = 1;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kPASS_B;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
              OverflowSwitch = 0;
          end
    else if (Instruction[8:3] == 6'b100100) begin  // inc
              Format     = 0;
              AccRead    = 0;
              RegWrite   = 1;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kINC_A;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
              OverflowSwitch = 0;
          end
    else if (Instruction[8:3] == 6'b100101) begin  // dec
              Format     = 0;
              AccRead    = 0;
              RegWrite   = 1;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kDEC_A;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
              OverflowSwitch = 0;
          end
    else if (Instruction[8:3] == 6'b100110) begin // clear
              Format     = 0;
              AccRead    = 0;
              RegWrite   = 1;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kCLEAR;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
              OverflowSwitch = 0;
          end
    else if (Instruction[8:3] == 6'b100111) begin  // sub
              Format     = 0;
              AccRead    = 1;
              RegWrite   = 0;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kSUB;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
              OverflowSwitch = 0;
          end
    else if (Instruction[8:3] == 6'b101000) begin  // shiftl
              Format     = 0;
              AccRead    = 0;
              RegWrite   = 1;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kSHIFT_LEFT;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
              OverflowSwitch = 0;
          end
    else if (Instruction[8:3] == 6'b101001) begin  // shiftr
              Format     = 0;
              AccRead    = 0;
              RegWrite   = 1;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kSHIFT_RIGHT;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
              OverflowSwitch = 0;
          end
    else if (Instruction[8:3] == 6'b101010) begin  // shifto
              Format     = 0;
              AccRead    = 0;
              RegWrite   = 1;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 2;    // use mem read
              ALUOp      = kSHIFT_ON;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
              OverflowSwitch = 0;
          end
    else if (Instruction[8:6] == 3'b001) begin  // add
              Format     = 0;
              AccRead    = 0;
              RegWrite   = 2;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kADD;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
              OverflowSwitch = 0;
          end
    else if (Instruction[8:4] == 5'b10111) begin  // str_match
              Format     = 1;
              AccRead    = 0;
              RegWrite   = 0;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kPARALLEL;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
              OverflowSwitch = 0;
          end
    else if (Instruction[8:4] == 5'b11000) begin  // high
              Format     = 0;
              AccRead    = 1;
              RegWrite   = 2;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kPASS_A;
              MemWrite   = 0;
              MemtoReg   = 3;
              HALT       = 0;
              OverflowSwitch = 0;
          end
    else if (Instruction[8:4] == 5'b11001) begin  // low
              Format     = 0;
              AccRead    = 1;
              RegWrite   = 2;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kPASS_A;
              MemWrite   = 0;
              MemtoReg   = 2;
              HALT       = 0;
              OverflowSwitch = 0;
          end
    else if (Instruction[8:7] == 2'b01) begin  // boz
              Format     = 0;
              AccRead    = 0;
              RegWrite   = 0;    // 2 is 0 don't care
              Branch     = 1; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kPASS_A;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
              OverflowSwitch = 1;
          end
		else 
      HALT = 1;

	end

endmodule
