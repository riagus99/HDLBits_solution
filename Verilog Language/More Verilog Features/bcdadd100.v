module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    wire [99:0] w;
    bcd_fadd first (a[3:0], b[3:0], cin, w[0], sum[3:0]);
    genvar i;
    generate
        for (i = 1; i < 100; i = i + 1) begin : gen_inst
            bcd_fadd fadd(a[4*i+3: 4*i], b[4*i+3: 4*i], w[i-1], w[i], sum[4*i+3: 4*i]);
        end
    endgenerate
    assign cout = w[99];
endmodule
