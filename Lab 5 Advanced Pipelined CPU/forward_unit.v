`timescale 1ns / 1ps
//student's id: 0716325
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/27 13:33:24
// Design Name: 
// Module Name: forward_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module forward_unit(
    EX_MEM_rd,
    MEM_WB_rd,
    ID_EX_rs,
    ID_EX_rt,
    EX_MEM_regwrite,
    MEM_WB_regwrite,
    
    forwardA,
    forwardB
    );
    
input   [4:0]   EX_MEM_rd;
input   [4:0]   MEM_WB_rd;
input   [4:0]   ID_EX_rs;
input   [4:0]   ID_EX_rt;
input           EX_MEM_regwrite;
input           MEM_WB_regwrite;

output reg [1:0]   forwardA;
output reg [1:0]   forwardB;
    
always@(*)begin
    if(EX_MEM_regwrite && (EX_MEM_rd != 0) && (EX_MEM_rd == ID_EX_rs))
        forwardA = 2'b01;
    else if(MEM_WB_regwrite && (MEM_WB_rd != 0) && (MEM_WB_rd == ID_EX_rs))
        forwardA = 2'b10;
    else
        forwardA = 2'b00;
end
    
always@(*)begin
    if(EX_MEM_regwrite && (EX_MEM_rd != 0) && (EX_MEM_rd == ID_EX_rt))
        forwardB = 2'b01;
    else if(MEM_WB_regwrite && (MEM_WB_rd != 0) && (MEM_WB_rd == ID_EX_rt))
        forwardB = 2'b10;
    else
        forwardB = 2'b00;
end
    
    
endmodule
