//student's id: 0716325
//Subject:     CO project 2 - Sign extend
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      ������0716325
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Sign_Extend(
    data_i,
    data_o
    );
               
//I/O ports
input   [16-1:0] data_i;
output  [32-1:0] data_o;

//Internal Signals
reg     [32-1:0] data_o;
integer i;
//Sign extended

always@(*) begin
    for(i = 0; i < 32; i = i + 1)begin
        if(i >= 16)
            data_o[i] = data_i[15];
        else
            data_o[i] = data_i[i];
    end
end

endmodule      
     