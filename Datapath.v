module Datapath_Unit(
 input clk,
 input jump,beq,mem_read,mem_write,alu_src,reg_dst,mem_to_reg,reg_write,bne,
 input[1:0] alu_op,
  output[5:0] opcode
);
  reg  [31:0] pc_current;
  wire [31:0] pc_next,pc2;
  wire [31:0] instr;
  wire [4:0] reg_write_dest;
  wire [31:0] reg_write_data;
  wire [4:0] reg_read_addr_1;
  wire [31:0] reg_read_data_1;
  wire [4:0] reg_read_addr_2;
  wire [31:0] reg_read_data_2;
  wire [31:0] ext_im,read_data2;
 wire [2:0] ALU_Control;
  wire [31:0] ALU_out;
 wire zero_flag;
  wire [31:0] PC_j, PC_beq, PC_2beq,PC_2bne,PC_bne;
 wire beq_control;
  wire [26:0] jump_shift;
  wire [31:0] mem_read_data;
 // PC 
 initial begin
  pc_current <= 32'd0;
 end
 always @(posedge clk)
 begin 
   pc_current <= pc_next;
 end
 assign pc2 = pc_current + 32'd2;
 // instruction memory
 Instruction_Memory im(.pr_c(pc_current),.instruction(instr));
 // jump shift left 2
  assign jump_shift = {instr[25:0],1'b0};
 // multiplexer regdest
  assign reg_write_dest = (reg_dst==1'b1) ? instr[15:11] :instr[20:16];
 // register file
  assign reg_read_addr_1 = instr[25:21];
  assign reg_read_addr_2 = instr[20:16];

 // GENERAL PURPOSE REGISTERs
 GPRs reg_file
 (
  .clk(clk),
  .reg_write_en(reg_write),
  .reg_wr_addr(reg_write_dest),
  .reg_wr_data(reg_write_data),
  .reg_rd_addr_1(reg_read_addr_1),
  .reg_rd_data_1(reg_read_data_1),
  .reg_rd_addr_2(reg_read_addr_2),
  .reg_rd_data_2(reg_read_data_2)
 );
 // immediate extend
  assign ext_im = {{16{instr[15]}},instr[15:0]};  
 // ALU control unit
  alu_control ALU_Control_unit(.ALUOp(alu_op),.Opcode(instr[31:26]),.ALU_Cnt(ALU_Control));
 // multiplexer alu_src
 assign read_data2 = (alu_src==1'b1) ? ext_im : reg_read_data_2;
 // ALU 
 ALU alu_unit(.a(reg_read_data_1),.b(read_data2),.alu_control(ALU_Control),.result(ALU_out),.zero(zero_flag));
 // PC beq add
  assign PC_beq = pc2 + {ext_im[30:0],1'b0};
  assign PC_bne = pc2 + {ext_im[30:0],1'b0};
 // beq control
 assign beq_control = beq & zero_flag;
 assign bne_control = bne & (~zero_flag);
 // PC_beq
 assign PC_2beq = (beq_control==1'b1) ? PC_beq : pc2;
 // PC_bne
 assign PC_2bne = (bne_control==1'b1) ? PC_bne : PC_2beq;
 // PC_j
  assign PC_j = {pc2[31:27],jump_shift};
 // PC_next
 assign pc_next = (jump == 1'b1) ? PC_j :  PC_2bne;

 /// Data memory
  Data_Memory dm
   (
    .clk(clk),
    .mem_access_addr(ALU_out),
    .mem_write_data(reg_read_data_2),
    .mem_write_en(mem_write),
    .mem_read(mem_read),
    .mem_read_data(mem_read_data)
   );
 
 // write back
 assign reg_write_data = (mem_to_reg == 1'b1)?  mem_read_data: ALU_out;
 // output to control unit
  assign opcode = instr[31:26];
endmodule
