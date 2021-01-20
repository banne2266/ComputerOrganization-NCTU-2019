//student's id: 0716325
//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      ´¿¥¿»¨0716325
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU_Control(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
localparam[5:0] add = 6'b100000, sub = 6'b100010, andd = 6'b100100, orr = 6'b100101, slt = 6'b101010;
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
//Internal Signals
reg        [4-1:0] ALUCtrl_o;
//Parameter
always@(*)begin
	if(ALUOp_i == 1) begin///r-format
	   ALUCtrl_o[0] = (funct_i == orr) || (funct_i == slt);
	   ALUCtrl_o[1] = (funct_i == add) || (funct_i == sub) || (funct_i == slt);
	   ALUCtrl_o[2] = (funct_i == sub) || (funct_i == slt);
	end 
	else if(ALUOp_i == 4)begin///beq
	   ALUCtrl_o[2:0] = 3'b110;
	end 
	else if(ALUOp_i == 2)begin///addi
	   ALUCtrl_o[2:0] = 3'b010;
	end 
	else if(ALUOp_i == 3)begin///slti
	   ALUCtrl_o[2:0] = 3'b111;
	end
	else if(ALUOp_i == 5)begin///lw
	   ALUCtrl_o[2:0] = 3'b010;
	end
	else if(ALUOp_i == 6)begin///sw
	   ALUCtrl_o[2:0] = 3'b010;
	end
	ALUCtrl_o[3] = 0;
end

//Select exact operation

endmodule     





                    
                    