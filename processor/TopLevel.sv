//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:37:58 02/16/2012 
// Design Name: 
// Module Name:    TopLevel 
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
module TopLevel(
    input     start,
	 input     CLK,
    output    halt
    );

	// Control Signals
	wire Format, Branch, AccRead, MemWrite;
	wire [3:0] ALUOp;
	wire [1:0] ALUSrcB, RegWrite, MemtoReg;

	// PC
	wire [7:0] PC;

	// Overflow
	// TODO: Make this a register?
	wire Overflow;

	// Instruction and Instruction Counter
	wire  [9:0]  Instruction;
	logic [15:0] InstCounter;

	// ===== OUTPUTS ===== //

	// Register file output
	wire [7:0] Accumulator;
	wire [7:0] ReadData1;
	wire [7:0] ReadData2;
	wire [7:0] Compare;

	// ALU outputs
	wire [7:0] ALUOut;
	wire CarryOut;

	// Data Memory outputs
	wire [7:0] MemOut;

	// IF module inputs
	// this target is relative to the current PC
	wire [7:0] RelativeTarget;

	// ===== INPUTS ===== //

	// Register file inputs
	wire [3:0] ReadReg1, ReadReg2;
	wire [7:0] WriteValue;

	// ALU wires
	wire [7:0] ALUInputB;

	// Data Memory
	wire [7:0] WriteData;

	assign Overflow = Branch ^ CarryOut;
	assign ReadReg1 = (Format == 'b1) ? {1'b0, Instruction[1:0]} + 3'b100 : Instruction[2:0];
	assign ReadReg2 = (Format == 'b1) ? {1'b0, Instruction[3:2]} + 3'b100 : Instruction[5:3];

	always_comb begin
		// Manage ALU second source
		case(ALUSrcB)
			2'b00 : ALUInputB  = ReadData2;
			2'b01 : ALUInputB  = Compare;
			2'b10 : ALUInputB  = {7'b0000000, Overflow};
		endcase

		// Manage write value to register
		case(MemtoReg)
			2'b00 : WriteValue = ALUOut;
			2'b01 : WriteValue = MemOut;
			// replace the high 4-bits of the accumulator
			2'b10 : WriteValue = (8'b11110000 && Accumulator) || {4'b0000, Instruction[3:0]};
			// replace the low 4-bits of the accumulator
			2'b11 : WriteValue = (8'b00001111 && Accumulator) || {Instruction[3:0], 4'b0000};
		endcase
	end

	 // Fetch Module
	 IF if_module (
		.Branch (Branch && (~Overflow)), 
		.Target({2'b00,Instruction[6:0]}), 
		.Init(start), 
		.Halt(halt), 
		.CLK(CLK), 
		.PC(PC)
	);

	// instruction ROM
	InstROM inst_module(
		.Address(PC), 
		.Instruction(Instruction)
	);

	// Control module
	Control control_module (
		.Instruction(Instruction), 
		.Format(Format),
		.AccRead(AccRead),
		.RegWrite(RegWrite),
		.Branch(Branch),
		.ALUSrcB(AluSrcB),
		.MemWrite(MemWrite),
		.MemtoReg(MemtoReg),
		.ALUOp(ALUOp),
		.HALT(halt)
	);

	reg_file register_module (
		.CLK(CLK), 
		.AccRead(AccRead),
		.RegWrite(RegWrite),
		.ReadReg1(ReadReg1),
		.ReadReg2(ReadReg2),
		.WriteValue(WriteValue),
		.ReadData1(ReadData1),
		.ReadData2(ReadData2),
		.Compare(Compare),
		.Accumulator(Accumulator)
	);
	
	ALU ALU_Module (
		.ALUOp(ALUOp) , 
		.A(ReadData1), 
		.B(ALUInputB),
		.Out(ALUOut), 
		.CarryOut(CarryOut)
	);

	DataRAM Data_Module(
		.Address(Accumulator), 
		.MemWrite(MemWrite), 
		.WriteData(WriteData), 
		.MemOut(MemOut), 
		.CLK(CLK) 
	);
	
	always@(posedge CLK)
	if (start == 1)
		InstCounter <= 0;
	else if(halt == 0)
		InstCounter <= InstCounter + 1;



endmodule
