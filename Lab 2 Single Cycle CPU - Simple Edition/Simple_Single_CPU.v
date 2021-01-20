//student's id: 0716325
//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      曾正豪0716325
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire [31:0] pc_o, ins_mem_o, regrs_to_alu, reg_rt_o, sign_ext_o, mux_to_alu, alu_result;
wire [31:0] sl2_o, adder1_o, adder2_o, pc_source, four;
wire [4:0]  mux_to_reg;
wire [3:0]  alu_ctrl;
wire [2:0]  aluop;
wire regdst, regwrite, branch, alusrc, zero, pc_source_mux_sel;
assign pc_source_mux_sel = zero & branch;
//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(pc_source) ,   
	    .pc_out_o(pc_o) 
	    );
	
Adder Adder1(
        .src1_i(32'd4),     
	    .src2_i(pc_o),     
	    .sum_o(adder1_o)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(pc_o),  
	    .instr_o(ins_mem_o)    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(ins_mem_o[20:16]),
        .data1_i(ins_mem_o[15:11]),
        .select_i(regdst),
        .data_o(mux_to_reg)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(ins_mem_o[25:21]) ,  
        .RTaddr_i(ins_mem_o[20:16]) ,  
        .RDaddr_i(mux_to_reg) ,  
        .RDdata_i(alu_result)  , 
        .RegWrite_i (regwrite),
        .RSdata_o(regrs_to_alu) ,  
        .RTdata_o(reg_rt_o)   
        );
	
Decoder Decoder(
        .instr_op_i(ins_mem_o[31:26]), 
	    .RegWrite_o(regwrite), 
	    .ALU_op_o(aluop),   
	    .ALUSrc_o(alusrc),   
	    .RegDst_o(regdst),   
		.Branch_o(branch)   
	    );

ALU_Ctrl AC(
        .funct_i(ins_mem_o[5:0]),   
        .ALUOp_i(aluop),   
        .ALUCtrl_o(alu_ctrl) 
        );
	
Sign_Extend SE(
        .data_i(ins_mem_o[15:0]),
        .data_o(sign_ext_o)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(reg_rt_o),
        .data1_i(sign_ext_o),
        .select_i(alusrc),
        .data_o(mux_to_alu)
        );	
		
ALU ALU(
        .src1_i(regrs_to_alu),
	    .src2_i(mux_to_alu),
	    .ctrl_i(alu_ctrl),
	    .result_o(alu_result),
		.zero_o(zero)
	    );
		
Adder Adder2(
        .src1_i(adder1_o),     
	    .src2_i(sl2_o),     
	    .sum_o(adder2_o)      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(sign_ext_o),
        .data_o(sl2_o)
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(adder1_o),
        .data1_i(adder2_o),
        .select_i(pc_source_mux_sel),
        .data_o(pc_source)
        );	

endmodule
		  


