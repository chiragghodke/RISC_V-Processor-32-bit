module alu_control( ALU_Cnt, ALUOp, Opcode);
  output reg[2:0] ALU_Cnt;
  input [1:0] ALUOp;
  input [5:0] Opcode;
  wire [7:0] ALUControlIn;
  assign ALUControlIn = {ALUOp,Opcode};
  always @(ALUControlIn)
  casex (ALUControlIn)
   8'b10xxxxxx: ALU_Cnt=3'b000;
   8'b01xxxxxx: ALU_Cnt=3'b001;
   8'b00000010: ALU_Cnt=3'b000;
   8'b00000011: ALU_Cnt=3'b001;
   8'b00000100: ALU_Cnt=3'b010;
   8'b00000101: ALU_Cnt=3'b011;
   8'b00000110: ALU_Cnt=3'b100;
   8'b00000111: ALU_Cnt=3'b101;
   8'b00001000: ALU_Cnt=3'b110;
   8'b00001001: ALU_Cnt=3'b111;
  default: ALU_Cnt=3'b000;
  endcase
endmodule
