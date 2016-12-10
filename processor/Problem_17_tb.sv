module Problem_17_tb.sv;

    // Inputs
    bit start;
    bit CLK;

    // Outputs
    wire halt;

    // Instantiate the Unit Under Test (UUT)
    TopLevel uut (
        .start    (start)       , 
        .CLK      (CLK)       , 
        .halt             
    );

    initial begin
        // Initialize Inputs
      $readmemb("Instructions17.txt", uut.IR1.ROM_core);
      $readmemb("Reg_File_17.txt",   uut.IR1. .reg_file);
      $readmemb("Data_Mem_17.txt",IR1. .core);
        // Wait 100 ns for global reset to finish
        #100ns;
      start = 1; 
        #10ns;
        start = 0;
        // Add stimulus here
        #550ns ;
        wait(halt) $stop;
    end

  always begin
     #5ns  CLK = 1;
     #5ns  CLK = 0 ; // Toggle clock every 5 ticks
  end
      
endmodule