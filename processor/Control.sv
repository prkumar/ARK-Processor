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

	always_comb	begin
		case(Instruction)
         7'b1000000 : begin // load
              Format     = 1;
              AccRead    = 0;
              RegWrite   = 1;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kPASS_A;
              MemWrite   = 0;
              MemtoReg   = 1;
              HALT       = 0;
         end
         7'b1000001 : begin // store
              Format     = 1;
              AccRead    = 1;
              RegWrite   = 2;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kPASS_A;
              MemWrite   = 1;
              MemtoReg   = 0;
              HALT       = 0;
         end
         7'b0000000 : begin  // parallel_comp
              Format     = 1;
              AccRead    = 0;
              RegWrite   = 1;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 1;    // use mem read
              ALUOp      = kKEEP_SMALLER;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
          end
          7'b0000010 : begin  // addo
              Format     = 1;
              AccRead    = 0;
              RegWrite   = 1;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 2;    // use mem read
              ALUOp      = kADD;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
          end
          7'b0000011 : begin  // is_zero
              Format     = 1;
              AccRead    = 0;
              RegWrite   = 0;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kA_IS_ZERO;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
          end
          7'b100010x : begin  // copy
              Format     = 0;
              AccRead    = 1;
              RegWrite   = 2;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kPASS_A;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
          end
          7'b100011x : begin  // paste
              Format     = 0;
              AccRead    = 1;
              RegWrite   = 1;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kPASS_B;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
          end
          7'b100100x : begin  // inc
              Format     = 0;
              AccRead    = 0;
              RegWrite   = 1;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kINC_A;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
          end
          7'b100101x : begin  // dec
              Format     = 0;
              AccRead    = 0;
              RegWrite   = 1;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kDEC_A;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
          end
          7'b100110x : begin // clear
              Format     = 0;
              AccRead    = 0;
              RegWrite   = 1;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kCLEAR;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
          end
          7'b100111x : begin  // sub
              Format     = 0;
              AccRead    = 1;
              RegWrite   = 1;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kSUB;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
          end
          7'b101000x : begin  // shiftl
              Format     = 1;
              AccRead    = 0;
              RegWrite   = 1;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kSHIFT_LEFT;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
          end
          7'b101001x : begin  // shiftr
              Format     = 1;
              AccRead    = 0;
              RegWrite   = 1;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kSHIFT_RIGHT;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
          end
          7'b101010x : begin  // shifto
              Format     = 1;
              AccRead    = 0;
              RegWrite   = 1;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 2;    // use mem read
              ALUOp      = kSHIFT_ON;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
          end
          7'b001xxxx : begin  // add
              Format     = 0;
              AccRead    = 0;
              RegWrite   = 2;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kADD;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
          end
          7'b10111xx : begin  // str_match
              Format     = 1;
              AccRead    = 0;
              RegWrite   = 0;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kPARALLEL;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
          end
          7'b11000xx : begin  // high
              Format     = 0;
              AccRead    = 1;
              RegWrite   = 2;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kPASS_A;
              MemWrite   = 0;
              MemtoReg   = 3;
              HALT       = 0;
          end
          7'b11001xx : begin  // low
              Format     = 0;
              AccRead    = 1;
              RegWrite   = 2;    // 2 is 0 don't care
              Branch     = 0; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kPASS_A;
              MemWrite   = 0;
              MemtoReg   = 2;
              HALT       = 0;
          end
          7'b01xxxxx : begin  // boz
              Format     = 0;
              AccRead    = 0;
              RegWrite   = 0;    // 2 is 0 don't care
              Branch     = 1; 
              ALUSrcB    = 0;    // use mem read
              ALUOp      = kPASS_B;
              MemWrite   = 0;
              MemtoReg   = 0;
              HALT       = 0;
          end
		  default: HALT = 1;
		endcase
	end

endmodule
