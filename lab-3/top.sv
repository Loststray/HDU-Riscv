`timescale 1ns / 1ps
module module_top
    (
        input clk_A,
        input clk_B,
        input clk_F,
        input [31:0]in,
        input rst_n,
        output [3:0] FR,
        output [31:0] F_out
    );
    wire [31:0] A;
    wire [31:0] B;
    wire [31:0] F;

    module_register regA(.clk(clk_A),.in(in),.rst_n(rst_n),.out(A));
    module_register regB(.clk(clk_B),.in(in),.rst_n(rst_n),.out(B));
    module_register regF(.clk(clk_F),.in(F),.rst_n(rst_n),.out(F_out));
    module_alu alu(A,B,in[3:0],F,FR[0],FR[1],FR[2],FR[3]);
    // trans t(pos,seq);
    // assign which = {1'b1,cnt};
endmodule

module wtf
    (
        input clk_A,
        input clk_B,
        input clk_F,
        input clk_T,
        input [31:0]in,
        input rst_n,
        output[3:0] which,
        output[7:0] seq
    );
    reg [3:0] FR;
    reg [31:0] F;
    module_top top(clk_A,clk_B,clk_F,in,rst_n,FR,F);
    encoder enc(clk_T,F,which,seq);
endmodule


