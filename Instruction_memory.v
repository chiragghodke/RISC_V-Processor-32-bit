module Instruction_Memory(
  input[31:0] pr_c,
  output[31:0] instruction
);

  reg [31:0] memory [14:0];
  wire [5 : 0] mem_addr = pr_c[6:1];
 initial
 begin
     
   memory[0] =32'b00000000010000000000000000000000 ;// load R0 <- Mem(R2 + 0)
   memory[1] =32'b00000000010000010000000000000001 ;// load R1 <- Mem(R2 + 1)
   memory[2] =32'b00001000000000010001000000000000 ;// Add R2 <- R0 + R1
   memory[3] =32'b00000100001000100000000000000000 ;// Store Mem(R1 + 0) <- R2
   memory[4] =32'b00001100000000010001000000000000 ; // sub R2 <- R0 - R1
   memory[5] =32'b00010000000000000001000000000000 ;// invert R2 <- !R0 
   memory[6] =32'b00010100000000010001000000000000 ;// logical shift left R2 <- R0<<R1 
   memory[7] =32'b00011000000000010001000000000000 ; // logical shift right R2 <- R0>>R1 
   memory[8] =32'b00011100000000010001000000000000 ; // AND R2<- R0 AND R1 
   memory[9] =32'b00100000000000010001000000000000 ; // OR R2<- R0 OR R1 
   memory[10]=32'b00100100000000010001000000000000 ; // SLT R2 <- 1 if R0 < R1 
   memory[11]=32'b00001000000000000000000000000000 ; // Add R0 <- R0 + R0
   memory[12]=32'b00101100000000010000000000000001 ; // BEQ branch to jump if R0=R1, PCnew=PC+2+offset<<1 = 28 => offset = 1
   memory[13] =32'b00110000000001000000000000000000 ; // BNE branch to jump if R0!=R1, PCnew=PC+2+offset<<1 = 28 => offset = 0
   memory[14] =32'b00110100000000000000000000000000 ; // J jump to the beginning address
  
 end
 assign instruction =  memory[mem_addr]; 

endmodule
