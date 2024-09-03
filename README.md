# RISC_V-Processor-32-bit

Designed a 32-bit RISC-V Processor based on harvard acrhitecture. Simulation software used: Xilinx Vivado.
Modules used in the project-

1. ALU
2. ALU Control
3. Instruction Memory
4. Data Memory
5. Register file
6. Data path
7. Risc processor
8. Risc processor control unit
9. testbench

# Instruction Set

I have designed three types of instructions:

1. Memory access instruction
2. Data processing instruction
3. Control flow instruction

# Memory Access Instruction-

1. Load Word:

LD ws, offset(rs1) ws:=Mem16[rs1 + offset]

2.Store Word:

ST rs2, offset(rs1) Mem16[rs1 + offset]=rs2

# Data processing instruction-

1. Add:

ADD  ws, rs1, rs2       ws:=rs1 + rs2
   
2. Subtract:

SUB ws, rs1, rs2    ws:=rs1 – rs2

3. Invert (1's complement):

INV ws, rs1 ws:=!rs1

4. Logical shift left:

LSL ws, rs1, rs2 ws:=rs1 << rs2

5. Logical shift right:

LSR ws, rs1, rs2 ws:=rs1 >> rs2

6. Bitwise AND:

AND ws, rs1, rs2 ws:=rs1 • rs2

7. Bitwise OR:

OR ws, rs1, rs2 ws:=rs1 | rs2

8. Set on Less Than:

SLT ws, rs1, rs2 ws:=1 if rs1 < rs2; ws:=0 if rs1 ≥ rs2

# Control Flow Instruction-

1. Branch on equal:
   
BEQ rs1, rs2, offset

Branch to (PC + 2 + (offset << 1)) when rs1 = rs2

2. Branch on Not equal:

BNE rs1, rs2, offset

Branch to (PC + 2 + (offset << 1)) when rs1 != rs2

3. Jump

JMP offset Jump to {PC [31:27], (offset << 1)}

# Instruction Set-

![Screenshot (492)](https://github.com/amitkumarbakoliya/16_bit_Risc_processor/assets/138565461/7795e12a-efb2-4ff1-940c-4e54b33c1ed2)

![Screenshot (493)](https://github.com/amitkumarbakoliya/16_bit_Risc_processor/assets/138565461/9b8e613e-b93f-4103-ba52-13a494968b5a)

# Processor control design-

![Screenshot (488)](https://github.com/amitkumarbakoliya/16_bit_Risc_processor/assets/138565461/3a52b87e-8af4-498c-b999-69aa67662236)

# ALU Control design

![Screenshot (495)](https://github.com/amitkumarbakoliya/16_bit_Risc_processor/assets/138565461/af57d4b0-afd7-42d0-bb80-4ea4120fee37)
