module Data_Memory(
 input clk,
  input [31:0]   mem_access_addr,
 
 // write port
  input [31:0]   mem_write_data,
 input     mem_write_en,
 input mem_read,
 // read port
  output [31:0]   mem_read_data
);

  reg [31:0] memory [7:0];
  wire [4:0] ram_addr=mem_access_addr[4:0];
initial
 begin
   memory [0] = 32'b00000000000000000000000000000001;
   memory [1] = 32'b00000000000000000000000000000010;
   memory [2] = 32'b00000000000000000000000000000001;
   memory [3] = 32'b00000000000000000000000000000001;
   memory [4] = 32'b00000000000000000000000000000100;
   memory [5] = 32'b00000000000000000000000000000010;
   memory [6] = 32'b00000000000000000000000000000100;
   memory [7] = 32'b00000000000000000000000000000010;
 end
 
 always @(posedge clk) begin
  if (mem_write_en)
   memory[ram_addr] <= mem_write_data;
 end
  assign mem_read_data = (mem_read==1'b1) ? memory[ram_addr]: 32'd0; 

endmodule
