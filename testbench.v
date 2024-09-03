`timescale 1ns / 1ps
`include "risc_processor.v"
module test_Risc_32_bit;

 // Inputs
 reg clk;

 // Instantiate the Unit Under Test (UUT)
 Risc_32_bit uut (
  .clk(clk)
 );

 initial 
  begin
   clk <=0;
   #140;
   $finish;
  end

 always 
  begin
   #5 clk = ~clk;
  end

endmodule
