module top_module(
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] sum
);
    wire s;
    wire [15:0] w1, w2;
    wire dummy1, dummy2;
    add16 mod1 (a[15:0], b[15:0], 0, sum[15:0], s);
    add16 mod2 (a[31:16], b[31:16], 0, w1, dummy1);
    add16 mod3 (a[31:16], b[31:16], 1, w2, dummy2);
    always @(*) begin
        case(s)
            1'b0 : sum[31:16] = w1;
            1'b1 : sum[31:16] = w2;
        endcase
    end
endmodule