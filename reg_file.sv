// Company: 
// Engineer: 
// 
// Create Date:    13:24:09 10/27/2011 
// Design Name: 
// Module Name:    reg_file 
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

module reg_file #(parameter W=8, D=3)(
    input         CLK, 
					   AccRead,
	 input  [1:0] RegWrite,
    input  [D-1:0] srcA,
                    srcB,
    input  [ W-1:0] writeValue,
    output [ W-1:0] ReadA,
    output logic [W-1:0] ReadB
    );

// 8 bits wide [7:0] and 8 registers deep [0:8] or just [8]	 
logic [W-1:0] registers[2**D];

// combinational reads
assign      ReadA   = registers[srcA];
always_comb ReadB   = (AccRead == 'b1) ? registers[0] : registers[srcB];

// sequential (clocked) writes
always_ff @ (posedge CLK)
  if (RegWrite == 'b01)  // Write to srcA
    registers[srcA] <= writeValue;
  else if (RegWrite == 'b10) // Write to srcB
	 registers[srcB] <= writeValue;
  
endmodule
