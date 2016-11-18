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
    input                CLK, 

    // control signals
                         AccRead,
	input  [1:0]         RegWrite,

    // register inputs
    input  [D-1:0]       ReadReg1,
                         ReadReg2,

    // register write
    input  [ W-1:0]      WriteValue,

    // register values
    output [W-1:0]       ReadData1,
    output logic [W-1:0] ReadData2,

    // smallest difference between registers $4, $5, and $6
    output logic [W-1:0] Compare,

    // We use the value of the $accumulator in other components of
    // the processor -- e.g., the data memory reads/write data to
    // the address pointed to by the $accumulator
    output logic [W-1:0] Accumulator
    );

// 8 bits wide [7:0] and 8 registers deep [0:8] or just [8]	 
logic [W-1:0] registers[2**D];
logic [W-1:0] compare45, compare46, compare56;

// combinational reads.
assign      Accumulator = registers[0];
assign      ReadData1   = registers[ReadReg1];

// if AccRead is set, we read from $accumulator, else act normally.
always_comb ReadData2   = (AccRead == 'b1) ? Accumulator : registers[ReadReg2];

// compare the designated registers and set Compare the smallest difference. 
always_comb begin
    compare45 = registers[4] - registers[5];
    compare46 = registers[4] - registers[6];
    compare56 = registers[5] - registers[6];
    if ((compare45 < compare46) &&  (compare45 < compare56))
        Compare = compare45;
    else if ((compare46 < compare45) && (compare46 < compare56))
        Compare = compare46;
    else
        Compare = compare56;
end

// sequential (clocked) writes
always_ff @ (posedge CLK)
  if (RegWrite == 'b01)  // Write to the first register
    registers[ReadReg1] <= WriteValue;
  else if (RegWrite == 'b10) // Write to second register
	registers[ReadReg2] <= WriteValue;
  
endmodule
