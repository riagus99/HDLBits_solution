module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire w1, w2;
    wire [31:0] b_xor;
    assign b_xor = b ^ {32{sub}};
    add16 mod1(a[15:0], b_xor[15:0], sub, sum[15:0], w1);
    add16 mod2(a[31:16], b_xor[31:16], w1, sum[31:16], w2);
endmodule