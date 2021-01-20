//student's id: 0716325
//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      ´¿¥¿»¨0716325
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
    MemRead_o,
    MemWriite_o,
    MemtoReg_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
output         MemRead_o;
output         MemWriite_o;
output         MemtoReg_o;



 
//Internal Signals
reg         RegWrite_o;
reg [3-1:0] ALU_op_o;
reg         ALUSrc_o;
reg         RegDst_o;
reg         Branch_o;
reg         MemRead_o;
reg         MemWriite_o;
reg         MemtoReg_o;

//Parameter
wire r_format, addi, slti, beq,lw,sw,jump,jal;

//Main function

assign r_format = (instr_op_i == 0)  ? 1 : 0;
assign     addi = (instr_op_i == 8)  ? 1 : 0;
assign     slti = (instr_op_i == 10) ? 1 : 0;
assign      beq = (instr_op_i == 4)  ? 1 : 0;
assign      lw =  (instr_op_i == 35) ? 1 : 0;
assign      sw =  (instr_op_i == 43) ? 1 : 0;


always@(*)begin
	if(r_format)
	   ALU_op_o = 1;
	else if(addi)
	   ALU_op_o = 2;
	else if(slti)
	   ALU_op_o = 3;
	else if(beq)
	   ALU_op_o = 4;
	else if(lw)
	   ALU_op_o = 5;
	else if(sw)
	   ALU_op_o = 6;
    else
       ALU_op_o = 0;
end


always@(*)begin
	if(r_format | addi | slti | lw | jal)
	    RegWrite_o = 1;
    else
        RegWrite_o = 0;
end

always@(*)begin
	if(addi | slti | lw | sw)
	    ALUSrc_o = 1;
    else
        ALUSrc_o = 0;
end

always@(*)begin
    if(r_format)
	    RegDst_o = 1;
    else
        RegDst_o = 0;
end

always@(*)begin
	if(beq)
	    Branch_o = 1;
    else
        Branch_o = 0;
end

always@(*)begin
	if(lw)
	    MemRead_o = 1;
    else
        MemRead_o = 0;
end

always@(*)begin
	if(sw)
	    MemWriite_o = 1;
    else
        MemWriite_o = 0;
end

always@(*)begin
    if(lw)
	    MemtoReg_o = 0;
    else
        MemtoReg_o = 1;
end

endmodule





                    
                    