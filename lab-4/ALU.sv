`timescale 1ns / 1ps
module module_alu
    (
    input [31:0]ALU_A,
    input [31:0]ALU_B,
    input [3:0]ALU_OP,
    output [31:0]F,
    output ZF,
    output SF,
    output CF,
    output OF
    );
    typedef enum logic[3:0] { add=4'b0000,sll=4'b0001 ,slt=4'b0010,sltu=4'b0011,lxor=4'b0100,srl=4'b0101,lor=4'b0110,land=4'b0111,sub=4'b1000,sra=4'b1101 } states;
    reg C32;
    reg [31:0] ALU_F;
    reg Flags[3:0];
    states ops;

    always@(*)begin
    case(ALU_OP)
        add: begin {C32,ALU_F} = ALU_A + ALU_B;end
        sll: begin {C32,ALU_F} = ALU_A << ALU_B;end
        slt: begin {C32,ALU_F} = $signed(ALU_A) < $signed(ALU_B);end
        sltu:begin {C32,ALU_F} = ALU_A < ALU_B;end
        lxor:begin {C32,ALU_F} = ALU_A ^ ALU_B;end
        srl: begin {C32,ALU_F} = ALU_A >> ALU_B;end
        lor: begin {C32,ALU_F} = ALU_A | ALU_B;end
        land:begin {C32,ALU_F} = ALU_A & ALU_B;end
        sub: begin {C32,ALU_F} = ALU_A - ALU_B;end
        sra: begin {C32,ALU_F} = ALU_A >>> ALU_B;end
    endcase
    Flags[0] = ALU_F == 0; 
    Flags[1] = (~(ALU_OP == add) & C32) + ((ALU_OP == add) & C32);
    Flags[2] = ALU_A[31]^ALU_B[31]^C32^ALU_F[31];
    Flags[3] = ALU_F[31];
    end
    
    assign ZF = Flags[0];
    assign CF = Flags[1];
    assign OF = Flags[2];
    assign SF = Flags[3];
    assign F = ALU_F;
endmodule
