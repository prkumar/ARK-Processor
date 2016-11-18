//////////////////////////////////////////////////////////////////////////////////
// Engineer:
//
// Create Date:    19:25:24 11/16/2006
// Design Name:
// Module Name:    DataRAM
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
module DataRAM(Address, MemWrite, WriteData, MemOut, CLK);
    input CLK;

    // control signal
    input MemWrite;

    // other inputs
    input  [7:0] Address;
    input  [7:0] WriteData;
    output [7:0] MemOut;

    logic  [7:0] my_memory [0:255];

    // initial 
    // $readmemh("dataram_init.list", my_memory);

    assign MemOut = my_memory[Address];

    always @ (posedge CLK)
        if(MemWrite) begin
            my_memory[Address] = WriteData;
			$display("Memory write M[%d] = %d", Address, WriteData);
        end

endmodule
