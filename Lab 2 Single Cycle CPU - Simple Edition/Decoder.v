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
	Branch_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;

//Parameter
wire r_format, addi, slti, beq;

//Main function

assign r_format = (instr_op_i == 0) ? 1 : 0;
assign     addi = (instr_op_i == 8) ? 1 : 0;
assign     slti = (instr_op_i == 10) ? 1 : 0;
assign      beq = (instr_op_i == 4) ? 1 : 0;

always@(*)begin
	RegDst_o = r_format;
	ALUSrc_o = addi | slti;
	RegWrite_o = r_format | addi | slti;
	Branch_o = beq;
	ALU_op_o[2] = r_format;
	ALU_op_o[1] = addi | beq;
	ALU_op_o[0] = beq | slti;
end

endmodule





                    
                    