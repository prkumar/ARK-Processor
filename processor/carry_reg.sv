module carry_reg(
  input   clk,
          switch,
          reset,
          d_in,
  output logic d_out);

always_ff @(posedge clk)
  if(reset)
    d_out <= 1'b0;
  else if (switch)
    d_out <= ~d_out;
  else
    d_out <= d_in;

endmodule 