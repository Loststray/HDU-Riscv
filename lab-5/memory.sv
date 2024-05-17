`timescale 1ns / 1ps
module RAM_B
    (
        input clka,
        input wea,
        input[5:0] addra,
        input[31:0] dina,
        output[31:0] douta
    );
endmodule
module memory
    (
        input Mem_Write,
        input clk_dm,
        input [7:2] DM_Addr,
        input [1:0] MW_Data_s,
        output reg [31:0] M_R_Data
    );
    
    parameter [7:0] data1 = 8'h12;
    reg [31:0] M_W_Data;
    wire [31:0] temp_R_Data;
    RAM_B ram 
    (
      .clka(clk_dm),    // input wire clka
      .wea(Mem_Write),      // input wire [0 : 0] wea
      .addra(DM_Addr[7:2]),  // input wire [5 : 0] addra
      .dina(M_W_Data),    // input wire [31 : 0] dina
      .douta(temp_R_Data)  // output wire [31 : 0] douta
    );
    always@(*)
    begin
        if(Mem_Write)
        begin
            case(MW_Data_s)
                2'b00: M_W_Data[7:0] = data1;
                2'b01: M_W_Data[15:8] = data1;
                2'b10: M_W_Data[23:16] = data1;
                2'b11: M_W_Data[31:24] = data1;
                // 2'b00: M_W_Data = {24'b0,data1};
                // 2'b01: M_W_Data = {16'b0,data1,8'b0};
                // 2'b10: M_W_Data = {8'b0,data1,16'b0};
                // 3'b11: M_W_Data = {data1,24'b0};                
            endcase
        end
        else 
        begin
           M_W_Data = M_R_Data;
           M_R_Data = temp_R_Data;
        end
    end
    
endmodule