//student's id: 0716325
//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      ?›¾æ­?è±?0716325
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
wire [31:0] pc_o, ins_mem_o, regrs_to_alu, reg_rt_o, sign_ext_o, mux_to_alu, alu_result, data_out, write_reg;
wire [31:0] sl2_o, adder1_o, adder2_o, pc_source, mux_beq_to_jump, mux_jump_to_jr,  jump_adress, sl2_jump_o;
wire [4:0]  mux_to_reg;
wire [3:0]  alu_ctrl;
wire [2:0]  aluop;
wire [1:0] regdst, MemtoReg;
wire  regwrite, branch, alusrc, zero, pc_source_beq_mux_sel, Jump, MemRead, MemWrite, jr;
assign pc_source_beq_mux_sel = zero & branch;
assign jump_adress = {adder1_o[31:28], sl2_jump_o[27:0]};
//Greate componentes
ProgramCounter PC(///vv
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(pc_source) ,   
	    .pc_out_o(pc_o) 
	    );
	
Adder Adder1(///vv
        .src1_i(32'd4),     
	    .src2_i(pc_o),     
	    .sum_o(adder1_o)    
	    );
	
Instr_Memory IM(///vv
        .pc_addr_i(pc_o),  
	    .instr_o(ins_mem_o)    
	    );


		
Reg_File Registers(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(ins_mem_o[25:21]) ,  
        .RTaddr_i(ins_mem_o[20:16]) ,  
        .RDaddr_i(mux_to_reg) ,  
        .RDdata_i(write_reg)  , 
        .RegWrite_i (regwrite),
        .RSdata_o(regrs_to_alu) ,  
        .RTdata_o(reg_rt_o)   
        );
	
Decoder Decoder(///vv
        .instr_op_i(ins_mem_o[31:26]), 
	    .RegWrite_o(regwrite), 
	    .ALU_op_o(aluop),   
	    .ALUSrc_o(alusrc),   
	    .RegDst_o(regdst),   
		.Branch_o(branch),
	    .Jump_o(jump),
        .MemRead_o(MemRead),
        .MemWriite_o(MemWrite),
        .MemtoReg_o(MemtoReg)
	    );

ALU_Ctrl AC(///vv
        .funct_i(ins_mem_o[5:0]),   
        .ALUOp_i(aluop),   
        .ALUCtrl_o(alu_ctrl),
        .jr_o(jr)
        );
	
Sign_Extend SE(///vv
        .data_i(ins_mem_o[15:0]),
        .data_o(sign_ext_o)
        );


		
ALU ALU(///vv
        .src1_i(regrs_to_alu),
	    .src2_i(mux_to_alu),
	    .ctrl_i(alu_ctrl),
	    .result_o(alu_result),
		.zero_o(zero)
	    );
		
Adder Adder2(///vv
        .src1_i(adder1_o),     
	    .src2_i(sl2_o),     
	    .sum_o(adder2_o)      
	    );
		
Shift_Left_Two_32 Shifter(///vv
        .data_i(sign_ext_o),
        .data_o(sl2_o)
        );
        
 Shift_Left_Two_32 Shifter_jump(///vv
        .data_i({6'b0, ins_mem_o[25:0]}),
        .data_o(sl2_jump_o)
        ); 	 		

MUX_2to1 #(.size(32)) Mux_ALUSrc(///vv
        .data0_i(reg_rt_o),
        .data1_i(sign_ext_o),
        .select_i(alusrc),
        .data_o(mux_to_alu)
        );	
		
MUX_2to1 #(.size(32)) Mux_PC_Source_beq(///vv
        .data0_i(adder1_o),
        .data1_i(adder2_o),
        .select_i(pc_source_beq_mux_sel),
        .data_o(mux_beq_to_jump)
        );
        
MUX_2to1 #(.size(32)) Mux_PC_Source_jump(///vv
        .data0_i(mux_beq_to_jump),
        .data1_i(jump_adress),
        .select_i(jump),
        .data_o(mux_jump_to_jr)
        );
MUX_2to1 #(.size(32)) Mux_PC_Source_jr(///vv
        .data0_i(mux_jump_to_jr),
        .data1_i(regrs_to_alu),
        .select_i(jr),
        .data_o(pc_source)
        );
        
 MUX_3to1 #(.size(32)) Mux_Mem_to_Reg(///vv
        .data0_i(alu_result),
        .data1_i(data_out),
        .data2_i(adder1_o),
        .select_i(MemtoReg),
        .data_o(write_reg)
        );	
        
 MUX_3to1 #(.size(5)) Mux_Write_Reg(///vv
        .data0_i(ins_mem_o[20:16]),
        .data1_i(ins_mem_o[15:11]),
        .data2_i(5'd31),
        .select_i(regdst),
        .data_o(mux_to_reg)
        );	
               
Data_Memory Data_Memory(
	.clk_i(clk_i),
	.addr_i(alu_result),
	.data_i(reg_rt_o),
	.MemRead_i(MemRead),
	.MemWrite_i(MemWrite),
	.data_o(data_out)
);

endmodule
		  


