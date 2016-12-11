//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	Leo Porter
// 
// Create Date:    15:50:22 11/02/2007 
// Design Name: 
// Module Name:    InstROM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: This is a basic verilog module to behave as an instruction ROM
// 				 template.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module InstROM(
    input [7:0] Address,
    output logic[8:0] Instruction
    );

    logic [8:0] ROM_core[2**8];

    initial
        $readmemb("instructions_17.txt", ROM_core);

    always_comb begin//  always_comb
        Instruction = ROM_core[Address];  
        case (Address)
            1022 : Instruction = 9'b000001111;  // override for address 1022  
            1023 : Instruction = 9'b000000001; // override for address 1023    
        endcase
    end
endmodule
