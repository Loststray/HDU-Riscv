`timescale 1ns / 1ps

module simu();
    reg [7:2] DM_Addr;
    reg [1:0] MW_Data_s;
    reg Mem_Write;
    reg clk_dm;
    wire [31:0] M_R_Data;
    memory mem 
    (
        .DM_Addr(DM_Addr), 
        .MW_Data_s(MW_Data_s), 
        .Mem_Write(Mem_Write), 
        .clk_dm(clk_dm), 
        .M_R_Data(M_R_Data)
    );
    always #20 clk_dm = ~clk_dm;
    initial begin
        // Initialize Inputs
        DM_Addr = 0;
        MW_Data_s = 0;
        Mem_Write = 0;
        clk_dm = 0;
        #100;
        DM_Addr = 0;
        MW_Data_s = 0;
        Mem_Write = 0;
        #100;
        DM_Addr = 1;
        MW_Data_s = 0;
        Mem_Write = 0;
        #100;
        DM_Addr = 1;
        MW_Data_s = 1;
        Mem_Write = 1;
        #100;
        DM_Addr = 1;
        MW_Data_s = 0;
        Mem_Write = 0;
    end
endmodule