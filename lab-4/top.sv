`timescale 1ns / 1ps
module module_top
    (
        input Reg_Write,
        input clk_WB,
        input clk_RR,
        input clk_F,
        input rst_n,
        input [4:0] R_Addr_A,
        input [4:0] R_Addr_B,
        input [4:0] W_Addr,
        input [3:0] ALU_OP,
        output [31:0] F,
        output [3:0] FR
    );
    wire [31:0] temp_A;
    wire [31:0] temp_B;
    wire [31:0] temp_F;
    reg [31:0] reg_F;
    reg [31:0] A;
    reg [31:0] B;

    register_heap u_register_heap
    (
        .Reg_Write(Reg_Write),
        .clk_Regs(clk_WB),
        .rst_n(rst_n),
        .R_Addr_A(R_Addr_A),
        .R_Addr_B(R_Addr_B),
        .W_Addr(W_Addr),
        .W_Data(F),
        .R_Data_A(temp_A),
        .R_Data_B(temp_B)
    );
    
    always@(posedge clk_RR)
    begin
        A <= temp_A;
        B <= temp_B;
    end
    
    always@(posedge clk_F)
    begin
        reg_F <= temp_F;
    end
    assign F = reg_F;
    
    module_alu u_alu
    (
    .ALU_A(A),
    .ALU_B(B),
    .ALU_OP(ALU_OP),
    .F(temp_F),
    .ZF(FR[0]),
    .CF(FR[1]),
    .OF(FR[2]),
    .SF(FR[3])
    );
    
    
endmodule