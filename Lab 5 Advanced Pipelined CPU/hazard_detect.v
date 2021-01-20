`timescale 1ns / 1ps
//student's id: 0716325
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/27 13:33:24
// Design Name: 
// Module Name: 
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


module hazard_detect(
    ID_EX_memread,
    ID_EX_rt,
    IF_ID_rs,
    IF_ID_rt,
    pc_src,
    
    pc_write,
    IF_ID_write,
    IF_flush,
    ID_flush,
    EX_flush
    );

input           ID_EX_memread;
input    [4:0]  ID_EX_rd;
input    [4:0]  IF_ID_rs;
input    [4:0]  IF_ID_rt;
input           pc_src;
    
output reg      pc_write;
output reg      IF_ID_write;
output reg      IF_flush;
output reg      ID_flush;
output reg      EX_flush;

always@(*)begin
    if(ID_EX_memread && ((ID_EX_rd == IF_ID_rs) || (ID_EX_rd == IF_ID_rt)))///load_use_data_hazard
        pc_write = 0;
    else
        pc_write = 1;
end

always@(*)begin
    if(ID_EX_memread && ((ID_EX_rd == IF_ID_rs) || (ID_EX_rd == IF_ID_rt)))///load_use_data_hazard
        IF_ID_write = 0;
    else
        IF_ID_write = 1;
end

always@(*)begin
    if(pc_src == 1)///branch take(control hazard)
        IF_flush = 1;
    else
        IF_flush = 0;
end

always@(*)begin
    if(ID_EX_memread && ((ID_EX_rt == IF_ID_rs) || (ID_EX_rt == IF_ID_rt)))///load_use_data_hazard
        ID_flush = 1;
    else if(pc_src == 1)///branch take(control hazard)
        ID_flush = 1;
    else
        ID_flush = 0;
end

always@(*)begin
    if(pc_src == 1)///branch take(control hazard)
        EX_flush = 1;
    else
        EX_flush = 0;
end

endmodule
