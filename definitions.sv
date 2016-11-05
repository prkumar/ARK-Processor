//This file defines the parameters used in the alu
package definitions;
    
// Instruction map
    const logic [3:0]kPASS_INPUTA  = 4'b0000;
    const logic [3:0]kSHIFT_LEFT  = 4'b0001;
    const logic [3:0]kSHIFT_RIGHT  = 4'b0010;
    const logic [3:0]kKEEP_SMALLER  = 4'b0011;
	 const logic [3:0]kSHIFT_ON  = 4'b0100;
	 const logic [3:0]kADD  = 4'b0101;
	 const logic [3:0]kINPUTA_IS_ZERO = 4'b0110;
	 const logic [3:0]kPASS_INPUTB = 4'b0111;
	 const logic [3:0]kINC_INPUTA = 4'b1000;
	 const logic [3:0]kDEC_INPUTA = 4'b1001;
	 const logic [3:0]kCLEAR = 4'b1010;
	 const logic [3:0]kSUB = 4'b1011;
	 const logic [3:0]kPARALLEL = 4'b1100;
    
    typedef enum logic[1:0] {
        ADDU    = 2'h0, 
        SUBU    = 2'h1, 
        AND     = 2'h2,
        XOR     = 2'h3
    } op_mne;
    
endpackage // defintions
