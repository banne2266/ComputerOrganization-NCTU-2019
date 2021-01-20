`timescale 1ns/1ps
//student id:0716325
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:15:11 08/18/2013
// Design Name:
// Module Name:    alu
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module alu(
           clk,           // system clock              (input)
           rst_n,         // negative reset            (input)
           src1,          // 32 bits source 1          (input)
           src2,          // 32 bits source 2          (input)
           ALU_control,   // 4 bits ALU control input  (input)
			  //bonus_control, // 3 bits bonus control input(input) 
           result,        // 32 bits result            (output)
           zero,          // 1 bit when the output is 0, zero must be set (output)
           cout,          // 1 bit carry out           (output)
           overflow       // 1 bit overflow            (output)
           );

input           clk;
input           rst_n;
input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4-1:0] ALU_control;
//input   [3-1:0] bonus_control; 

output reg[32-1:0] result;
output             zero;
output reg         cout;
output reg         overflow;


wire    [31:0]  carry;
wire            set;
wire            sub;
wire   [32-1:0] result_k;
wire            cout_k;
wire            overflow_k;

genvar i;
generate
  for(i=0;i<31;i=i+1)begin
    if(i == 0) begin
        alu_top 
        alu(
            .src1(src1[i]),       //1 bit source 1 (input)
            .src2(src2[i]),       //1 bit source 2 (input)
            .less(set),       //1 bit less     (input)
            .A_invert(ALU_control[3]),   //1 bit A_invert (input)
            .B_invert(ALU_control[2]),   //1 bit B_invert (input)
            .cin(ALU_control[2]),        //1 bit carry in (input)
            .operation(ALU_control[1:0]),  //operation      (input)
            .result(result_k[i]),     //1 bit result   (output)
            .cout(carry[i])       //1 bit carry out(output)
       );
    end
    else begin
        alu_top 
        alu(
            .src1(src1[i]),       //1 bit source 1 (input)
            .src2(src2[i]),       //1 bit source 2 (input)
            .less(0),       //1 bit less     (input)
            .A_invert(ALU_control[3]),   //1 bit A_invert (input)
            .B_invert(ALU_control[2]),   //1 bit B_invert (input)
            .cin(carry[i-1]),        //1 bit carry in (input)
            .operation(ALU_control[1:0]),  //operation      (input)
            .result(result_k[i]),     //1 bit result   (output)
            .cout(carry[i])       //1 bit carry out(output)
       );
     end
  end
endgenerate

alu_top_31
        alu_31(
            .src1(src1[31]),       //1 bit source 1 (input)
            .src2(src2[31]),       //1 bit source 2 (input)
            .less(0),       //1 bit less     (input)
            .A_invert(ALU_control[3]),   //1 bit A_invert (input)
            .B_invert(ALU_control[2]),   //1 bit B_invert (input)
            .cin(carry[30]),        //1 bit carry in (input)
            .operation(ALU_control[1:0]),  //operation      (input)
            .result(result_k[31]),     //1 bit result   (output)
            .cout(cout_k),       //1 bit carry out(output)
            .set(set),
            .overflow(overflow_k)
       );

assign zero = !result;

always@( posedge clk or negedge rst_n ) 
begin
	if(!rst_n) begin
        result <= 0;
        overflow <= 0;
        cout <= 0;
	end
	else begin
        result <= result_k;
        overflow <= overflow_k;
        cout <= cout_k;
	end
end

endmodule
