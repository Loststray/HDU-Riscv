`timescale 1ns / 1ps
module encoder
    (
        input clk_T,
        input[31:0] F_out,
        output[3:0] which,
        output[7:0] seq
    );
    reg [2:0] cnt;
    reg [3:0] pos;
    initial begin
        cnt = 3'b111;
    end
    always @(negedge clk_T)
    begin
        case (cnt)
            3'b111: pos = F_out[3:0]; 
            3'b110: pos = F_out[7:4];
            3'b101: pos = F_out[11:8];
            3'b100: pos = F_out[15:12];
            3'b011: pos = F_out[19:16];
            3'b010: pos = F_out[23:20];
            3'b001: pos = F_out[27:24];
            3'b000: pos = F_out[31:28];
            default: pos = 4'b0000;
        endcase
        cnt = cnt + 1;
    end
    assign which = {1'b1,cnt};
    trans t(.in(pos),.out(seq));
endmodule
module trans
    (
        input [3:0] in,
        output [7:0] out
    );
    // the order is CA CB CC CD CE CF CG DP
    reg[7:0] seg;
    always@(*)
    begin
            case(in)
                4'h0:seg = 8'h03;	
                4'h1:seg = 8'h9f;
                4'h2:seg = 8'h25;
                4'h3:seg = 8'h0d;
                4'h4:seg = 8'h99;
                4'h5:seg = 8'h49;
                4'h6:seg = 8'h41;
                4'h7:seg = 8'h1f;
                4'h8:seg = 8'h01;
                4'h9:seg = 8'h09;
                4'ha:seg = 8'h11;
                4'hb:seg = 8'ha1;
                4'hc:seg = 8'h63;
                4'hd:seg = 8'h85;
                4'he:seg = 8'h61;
                4'hf:seg = 8'h71;
                default : seg = 8'hfe;
            endcase
    end
    assign out = seg;

endmodule