module top_module( 
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out );
    assign out = in[4*sel+:4];
endmodule
// in[4*sel+3:4*sel] is invalid, since synthesizer cannot prove that select width is constant
// instead, in verilog 2001 you can select the constant width with variable starting point