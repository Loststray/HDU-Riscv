module module_register
    (
    input[31:0] in,
    input clk,
    input rst_n,
    output [31:0] out
    );
    reg [31:0] temp_reg;
    always@(negedge rst_n or posedge clk)
    begin
        if(!rst_n)
            temp_reg <= 32'b0;
        else
            temp_reg <= in;
    end
    assign out = temp_reg;
endmodule