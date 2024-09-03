module GPRs(
 input    clk,
 // write port
 input    reg_write_en,
  input  [4:0] reg_wr_addr,
  input  [31:0] reg_wr_data,
 //read port 1
  input  [4:0]  reg_rd_addr_1,
  output  [31:0]  reg_rd_data_1,
 //read port 2
  input  [4:0] reg_rd_addr_2,
  output  [31:0]  reg_rd_data_2
);
  reg [31:0] reg_array [7:0];
 integer i;
 // write port
 //reg [2:0] i;
 initial begin
  for(i=0;i<8;i=i+1)
    reg_array[i] <= 32'd0;
 end
 always @ (posedge clk ) begin
   if(reg_write_en) begin
    reg_array[reg_wr_addr] <= reg_wr_data;
   end
 end
 

 assign reg_rd_data_1 = reg_array[reg_rd_addr_1];
 assign reg_rd_data_2 = reg_array[reg_rd_addr_2];


endmodule
